#include "Interpreter.h"
#include <iostream>

namespace silang {

// Builtins
ValuePtr builtinPrint(std::vector<ValuePtr> args) {
    for (size_t i = 0; i < args.size(); ++i) {
        std::cout << args[i]->toString();
        if (i < args.size() - 1) std::cout << " ";
    }
    std::cout << std::endl;
    return std::make_shared<VoidValue>();
}

// Array methods
ValuePtr builtinPush(std::vector<ValuePtr> args) {
    // Expects: array, element
    if (args.size() != 2) throw std::runtime_error("push expects 2 arguments: array, element");
    auto arr = std::dynamic_pointer_cast<ArrayValue>(args[0]);
    if (!arr) throw std::runtime_error("push first argument must be array");
    arr->elements.push_back(args[1]);
    return std::make_shared<VoidValue>();
}

ValuePtr builtinLen(std::vector<ValuePtr> args) {
    if (args.size() != 1) throw std::runtime_error("len expects 1 argument");
    if (auto arr = std::dynamic_pointer_cast<ArrayValue>(args[0])) {
        return std::make_shared<IntValue>((int)arr->elements.size());
    }
    if (auto s = std::dynamic_pointer_cast<StringValue>(args[0])) {
        return std::make_shared<IntValue>((int)s->value.length());
    }
    throw std::runtime_error("len supports array or string");
}

Interpreter::Interpreter() {
    globals = std::make_shared<Environment>();
    environment = globals;
    setupBuiltins();
}

void Interpreter::setupBuiltins() {
    globals->define("print", std::make_shared<BuiltinValue>("print", builtinPrint));
    globals->define("len", std::make_shared<BuiltinValue>("len", builtinLen));
    // Push is usually a method, but without classes, we can make it a function or handle method call specially.
    // For "arr.push(x)", visitCall will handle it if we treat it right.
}

void Interpreter::interpret(std::shared_ptr<Program> program) {
    try {
        for (auto stmt : program->statements) {
            execute(stmt);
        }

        // Auto-run main if exists?
        if (globals->values.count("main")) {
            auto mainVal = globals->values["main"];
            if (mainVal->type == ValueType::FUNCTION) {
                // Call main
                 auto func = std::dynamic_pointer_cast<FunctionValue>(mainVal);
                 // Setup environment
                 auto prevEnv = this->environment;
                 auto newEnv = std::make_shared<Environment>(globals);
                 this->environment = newEnv;
                 try {
                     execute(func->body);
                 } catch (ReturnException& e) {
                     // Main returned
                 }
                 this->environment = prevEnv;
            }
        }
    } catch (std::exception& e) {
        std::cerr << "Runtime Error: " << e.what() << std::endl;
    }
}

void Interpreter::execute(std::shared_ptr<Stmt> stmt) {
    if (auto s = std::dynamic_pointer_cast<VarDeclStmt>(stmt)) visitVarDecl(s);
    else if (auto s = std::dynamic_pointer_cast<FuncDeclStmt>(stmt)) visitFuncDecl(s);
    else if (auto s = std::dynamic_pointer_cast<StructDeclStmt>(stmt)) visitStructDecl(s);
    else if (auto s = std::dynamic_pointer_cast<BlockStmt>(stmt)) visitBlock(s);
    else if (auto s = std::dynamic_pointer_cast<IfStmt>(stmt)) visitIf(s);
    else if (auto s = std::dynamic_pointer_cast<WhileStmt>(stmt)) visitWhile(s);
    else if (auto s = std::dynamic_pointer_cast<ReturnStmt>(stmt)) visitReturn(s);
    else if (auto s = std::dynamic_pointer_cast<ExprStmt>(stmt)) visitExprStmt(s);
    else throw std::runtime_error("Unknown statement type");
}

ValuePtr Interpreter::evaluate(std::shared_ptr<Expr> expr) {
    if (auto e = std::dynamic_pointer_cast<LiteralExpr>(expr)) return visitLiteral(e);
    else if (auto e = std::dynamic_pointer_cast<VariableExpr>(expr)) return visitVariable(e);
    else if (auto e = std::dynamic_pointer_cast<BinaryExpr>(expr)) return visitBinary(e);
    else if (auto e = std::dynamic_pointer_cast<UnaryExpr>(expr)) return visitUnary(e);
    else if (auto e = std::dynamic_pointer_cast<CallExpr>(expr)) return visitCall(e);
    else if (auto e = std::dynamic_pointer_cast<MemberAccessExpr>(expr)) return visitMemberAccess(e);
    else if (auto e = std::dynamic_pointer_cast<IndexExpr>(expr)) return visitIndex(e);
    else if (auto e = std::dynamic_pointer_cast<ArrayLiteralExpr>(expr)) return visitArrayLiteral(e);
    else throw std::runtime_error("Unknown expression type");
}

ValuePtr Interpreter::visitLiteral(std::shared_ptr<LiteralExpr> expr) {
    if (std::holds_alternative<int>(expr->value)) return std::make_shared<IntValue>(std::get<int>(expr->value));
    if (std::holds_alternative<bool>(expr->value)) return std::make_shared<BoolValue>(std::get<bool>(expr->value));
    if (std::holds_alternative<std::string>(expr->value)) return std::make_shared<StringValue>(std::get<std::string>(expr->value));
    return std::make_shared<VoidValue>();
}

ValuePtr Interpreter::visitVariable(std::shared_ptr<VariableExpr> expr) {
    return environment->get(expr->name);
}

ValuePtr Interpreter::visitBinary(std::shared_ptr<BinaryExpr> expr) {
    if (expr->op == Op::ASSIGN) {
        // Special case for assignment
        ValuePtr right = evaluate(expr->right);
        if (auto v = std::dynamic_pointer_cast<VariableExpr>(expr->left)) {
            environment->assign(v->name, right);
            return right;
        } else if (auto m = std::dynamic_pointer_cast<MemberAccessExpr>(expr->left)) {
             ValuePtr obj = evaluate(m->object);
             if (auto s = std::dynamic_pointer_cast<StructValue>(obj)) {
                 s->fields[m->member] = right;
                 return right;
             } else if (auto map = std::dynamic_pointer_cast<MapValue>(obj)) {
                 // map.set(key, val) is preferred, but map.key = val works if key is identifier?
                 // But member access assumes key is the identifier string.
                 map->entries[m->member] = right;
                 return right;
             }
             throw std::runtime_error("Cannot assign property of non-struct/map");
        } else if (auto idx = std::dynamic_pointer_cast<IndexExpr>(expr->left)) {
             ValuePtr obj = evaluate(idx->object);
             ValuePtr index = evaluate(idx->index);
             if (auto arr = std::dynamic_pointer_cast<ArrayValue>(obj)) {
                 if (auto i = std::dynamic_pointer_cast<IntValue>(index)) {
                     if (i->value < 0 || i->value >= arr->elements.size()) throw std::runtime_error("Array index out of bounds");
                     arr->elements[i->value] = right;
                     return right;
                 }
             } else if (auto map = std::dynamic_pointer_cast<MapValue>(obj)) {
                 map->entries[index->toString()] = right;
                 return right;
             }
             throw std::runtime_error("Cannot assign index");
        }
        throw std::runtime_error("Invalid assignment target");
    }

    ValuePtr left = evaluate(expr->left);
    ValuePtr right = evaluate(expr->right);

    if (auto l = std::dynamic_pointer_cast<IntValue>(left)) {
        if (auto r = std::dynamic_pointer_cast<IntValue>(right)) {
            switch (expr->op) {
                case Op::ADD: return std::make_shared<IntValue>(l->value + r->value);
                case Op::SUB: return std::make_shared<IntValue>(l->value - r->value);
                case Op::MUL: return std::make_shared<IntValue>(l->value * r->value);
                case Op::DIV: return std::make_shared<IntValue>(l->value / r->value);
                case Op::MOD: return std::make_shared<IntValue>(l->value % r->value);
                case Op::EQ: return std::make_shared<BoolValue>(l->value == r->value);
                case Op::NEQ: return std::make_shared<BoolValue>(l->value != r->value);
                case Op::LT: return std::make_shared<BoolValue>(l->value < r->value);
                case Op::GT: return std::make_shared<BoolValue>(l->value > r->value);
                case Op::LE: return std::make_shared<BoolValue>(l->value <= r->value);
                case Op::GE: return std::make_shared<BoolValue>(l->value >= r->value);
                default: break;
            }
        }
    }

    // Strings
    if (auto l = std::dynamic_pointer_cast<StringValue>(left)) {
        if (auto r = std::dynamic_pointer_cast<StringValue>(right)) {
            if (expr->op == Op::ADD) return std::make_shared<StringValue>(l->value + r->value);
            if (expr->op == Op::EQ) return std::make_shared<BoolValue>(l->value == r->value);
            if (expr->op == Op::NEQ) return std::make_shared<BoolValue>(l->value != r->value);
        }
    }

    // Bools
    if (auto l = std::dynamic_pointer_cast<BoolValue>(left)) {
        if (auto r = std::dynamic_pointer_cast<BoolValue>(right)) {
            if (expr->op == Op::EQ) return std::make_shared<BoolValue>(l->value == r->value);
            if (expr->op == Op::NEQ) return std::make_shared<BoolValue>(l->value != r->value);
        }
    }

    throw std::runtime_error("Invalid operands for binary operator");
}

ValuePtr Interpreter::visitUnary(std::shared_ptr<UnaryExpr> expr) {
    ValuePtr right = evaluate(expr->right);
    if (expr->op == Op::SUB) {
        if (auto r = std::dynamic_pointer_cast<IntValue>(right)) {
            return std::make_shared<IntValue>(-r->value);
        }
    } else if (expr->op == Op::NOT) {
        if (auto r = std::dynamic_pointer_cast<BoolValue>(right)) {
            return std::make_shared<BoolValue>(!r->value);
        }
    }
    throw std::runtime_error("Invalid operand for unary operator");
}

ValuePtr Interpreter::visitCall(std::shared_ptr<CallExpr> expr) {
    std::vector<ValuePtr> args;
    for (auto arg : expr->args) {
        args.push_back(evaluate(arg));
    }

    // Check for MemberAccessExpr to handle methods on primitives/builtins without evaluating callee first
    if (auto m = std::dynamic_pointer_cast<MemberAccessExpr>(expr->callee)) {
        ValuePtr obj = evaluate(m->object);

        if (m->member == "push" && obj->type == ValueType::ARRAY) {
             args.insert(args.begin(), obj);
             return builtinPush(args);
        }
        if (m->member == "get" && obj->type == ValueType::MAP) {
             auto map = std::dynamic_pointer_cast<MapValue>(obj);
             if (args.size() != 1) throw std::runtime_error("Map.get expects 1 arg");
             std::string key = args[0]->toString();
             if (map->entries.count(key)) return map->entries[key];
             throw std::runtime_error("Key not found in map: " + key);
        }
        if (m->member == "set" && obj->type == ValueType::MAP) {
             auto map = std::dynamic_pointer_cast<MapValue>(obj);
             if (args.size() != 2) throw std::runtime_error("Map.set expects 2 args");
             std::string key = args[0]->toString();
             map->entries[key] = args[1];
             return std::make_shared<VoidValue>();
        }
    }

    // Standard call
    ValuePtr callee = evaluate(expr->callee);

    if (auto fn = std::dynamic_pointer_cast<FunctionValue>(callee)) {
        if (args.size() != fn->params.size()) throw std::runtime_error("Incorrect argument count");

        auto newEnv = std::make_shared<Environment>(fn->closure);
        for (size_t i = 0; i < args.size(); ++i) {
            // Type check!
            // fn->params[i] is pair<string, Type>
            // We should check if args[i] matches Type.
            // Simplified check:
            // if Type is int, args[i] must be IntValue.
            // if Type is array, args[i] must be ArrayValue.
            // ...
            // Ignoring deep check for now (Map<K,V>).
            ValuePtr val = args[i];
            Type expected = fn->params[i].second;

            if (expected.name == "int" && val->type != ValueType::INT) throw std::runtime_error("Type mismatch for param " + fn->params[i].first + ": expected int");
            if (expected.name == "bool" && val->type != ValueType::BOOL) throw std::runtime_error("Type mismatch for param " + fn->params[i].first + ": expected bool");
            if (expected.name == "string" && val->type != ValueType::STRING) throw std::runtime_error("Type mismatch for param " + fn->params[i].first + ": expected string");
            if (expected.is_array && val->type != ValueType::ARRAY) throw std::runtime_error("Type mismatch for param " + fn->params[i].first + ": expected Array");
            if (expected.is_map && val->type != ValueType::MAP) throw std::runtime_error("Type mismatch for param " + fn->params[i].first + ": expected Map");

            newEnv->define(fn->params[i].first, val);
        }

        auto prevEnv = this->environment;
        this->environment = newEnv;

        try {
            execute(fn->body);
        } catch (ReturnException& e) {
            this->environment = prevEnv;
            return e.value;
        }

        this->environment = prevEnv;
        return std::make_shared<VoidValue>();
    } else if (auto fn = std::dynamic_pointer_cast<BuiltinValue>(callee)) {
        return fn->func(args);
    }

    throw std::runtime_error("Can only call functions or classes.");
}

ValuePtr Interpreter::visitMemberAccess(std::shared_ptr<MemberAccessExpr> expr) {
    ValuePtr obj = evaluate(expr->object);
    if (auto s = std::dynamic_pointer_cast<StructValue>(obj)) {
        if (s->fields.find(expr->member) != s->fields.end()) {
            return s->fields[expr->member];
        }
        // If field not set, return default or error?
        // Let's return Void for now, or error.
        throw std::runtime_error("Struct " + s->name + " has no field " + expr->member);
    }
    // Could also be method access, but that's usually caught by CallExpr logic if called.
    // If just accessing "obj.method", we might want to return a bound method?
    // For now, assume it's data access.
    throw std::runtime_error("Only structs have members.");
}

ValuePtr Interpreter::visitIndex(std::shared_ptr<IndexExpr> expr) {
    ValuePtr obj = evaluate(expr->object);
    ValuePtr index = evaluate(expr->index);

    if (auto arr = std::dynamic_pointer_cast<ArrayValue>(obj)) {
        if (auto i = std::dynamic_pointer_cast<IntValue>(index)) {
            if (i->value < 0 || i->value >= arr->elements.size()) throw std::runtime_error("Index out of bounds");
            return arr->elements[i->value];
        }
    } else if (auto map = std::dynamic_pointer_cast<MapValue>(obj)) {
        std::string key = index->toString();
        if (map->entries.count(key)) return map->entries[key];
        throw std::runtime_error("Key not found");
    }
    throw std::runtime_error("Indexing not supported on this type");
}

ValuePtr Interpreter::visitArrayLiteral(std::shared_ptr<ArrayLiteralExpr> expr) {
    std::vector<ValuePtr> elements;
    for (auto e : expr->elements) {
        elements.push_back(evaluate(e));
    }
    return std::make_shared<ArrayValue>(elements);
}

void Interpreter::visitVarDecl(std::shared_ptr<VarDeclStmt> stmt) {
    ValuePtr val = std::make_shared<VoidValue>();
    if (stmt->initializer) {
        val = evaluate(stmt->initializer);
    } else {
        // Default init
        if (stmt->type.is_array) val = std::make_shared<ArrayValue>();
        else if (stmt->type.is_map) val = std::make_shared<MapValue>();
        else if (stmt->type.name == "int") val = std::make_shared<IntValue>(0);
        else if (stmt->type.name == "bool") val = std::make_shared<BoolValue>(false);
        else if (stmt->type.name == "string") val = std::make_shared<StringValue>("");
        else {
             // Struct? Check if name is known struct?
             // Need a registry of StructDecls to instantiate defaults.
             // For now, instantiate raw StructValue with name.
             // But we don't know fields here unless we looked them up.
             // For now: lazy init or just StructValue empty.
             // The user should likely provide initializer "new Struct()" or "Struct{}"?
             // My syntax example: "Token t;" -> "t.type = ..."
             // So we need default struct.
             // Since I don't keep Struct types in environment, I can't know fields.
             // I'll make a StructValue with no fields, and allow setting any field (dynamic struct) for now?
             // OR: I should store Struct Decls.
             // Let's allow dynamic structs for simplicity of implementation.
             val = std::make_shared<StructValue>(stmt->type.name);
        }
    }
    environment->define(stmt->name, val);
}

void Interpreter::visitFuncDecl(std::shared_ptr<FuncDeclStmt> stmt) {
    auto func = std::make_shared<FunctionValue>(stmt->name, stmt->params, stmt->body, environment);
    environment->define(stmt->name, func);
}

void Interpreter::visitStructDecl(std::shared_ptr<StructDeclStmt> stmt) {
    // Just register type existence?
    // Not using it yet.
}

void Interpreter::visitBlock(std::shared_ptr<BlockStmt> stmt) {
    auto prevEnv = this->environment;
    this->environment = std::make_shared<Environment>(prevEnv);

    try {
        for (auto s : stmt->statements) {
            execute(s);
        }
    } catch (...) {
        this->environment = prevEnv;
        throw;
    }
    this->environment = prevEnv;
}

void Interpreter::visitIf(std::shared_ptr<IfStmt> stmt) {
    ValuePtr cond = evaluate(stmt->condition);
    bool isTrue = false;
    if (auto b = std::dynamic_pointer_cast<BoolValue>(cond)) isTrue = b->value;

    if (isTrue) {
        execute(stmt->thenBranch);
    } else if (stmt->elseBranch) {
        execute(stmt->elseBranch);
    }
}

void Interpreter::visitWhile(std::shared_ptr<WhileStmt> stmt) {
    while (true) {
        ValuePtr cond = evaluate(stmt->condition);
        bool isTrue = false;
        if (auto b = std::dynamic_pointer_cast<BoolValue>(cond)) isTrue = b->value;
        if (!isTrue) break;
        execute(stmt->body);
    }
}

void Interpreter::visitReturn(std::shared_ptr<ReturnStmt> stmt) {
    ValuePtr val = std::make_shared<VoidValue>();
    if (stmt->value) val = evaluate(stmt->value);
    throw ReturnException(val);
}

void Interpreter::visitExprStmt(std::shared_ptr<ExprStmt> stmt) {
    evaluate(stmt->expr);
}

}
