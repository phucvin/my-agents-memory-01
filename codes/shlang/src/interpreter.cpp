#include "interpreter.h"
#include <iostream>
#include <fstream>
#include <sstream>
#include <functional>

// Extend Value to hold function
struct FunctionValue {
    std::shared_ptr<FunctionDecl> decl;
    // Closure support if needed
};

// We need a way to store FunctionValue in Value variant.
// Updating Value struct in interpreter.h is better, but here I can use a hack or just `std::any`?
// Let's modify `interpreter.h` first to include Function support properly.
// But for now, I'll assume Value has it or I keep a separate function table.
// Global function table is easier for this level.

std::map<std::string, std::shared_ptr<FunctionDecl>> functions;

Interpreter::Interpreter(std::shared_ptr<Program> prog) : program(prog) {}

void Interpreter::enterScope() {
    environment.push_back({});
}

void Interpreter::exitScope() {
    environment.pop_back();
}

void Interpreter::define(std::string name, Value val) {
    environment.back()[name] = val;
}

void Interpreter::assign(std::string name, Value val) {
    for (int i = environment.size() - 1; i >= 0; i--) {
        if (environment[i].count(name)) {
            environment[i][name] = val;
            return;
        }
    }
    // If not found, create in current? No, error.
    std::cerr << "Undefined variable assignment: " << name << std::endl;
    exit(1);
}

Value Interpreter::lookup(std::string name) {
    for (int i = environment.size() - 1; i >= 0; i--) {
        if (environment[i].count(name)) return environment[i][name];
    }
    std::cerr << "Undefined variable: " << name << std::endl;
    exit(1);
}

void Interpreter::run() {
    environment.push_back({}); // Global scope

    // Scan for functions
    for (auto stmt : program->statements) {
        if (stmt->type == NodeType::FUNC_DECL) {
            auto func = std::static_pointer_cast<FunctionDecl>(stmt);
            functions[func->name] = func;
        }
    }

    if (functions.count("main")) {
        // Execute main
        executeBlock(functions["main"]->body);
    } else {
        // Execute top-level statements
        for (auto stmt : program->statements) {
             if (stmt->type != NodeType::FUNC_DECL &&
                 stmt->type != NodeType::STRUCT_DECL &&
                 stmt->type != NodeType::INTERFACE_DECL) {
                 execute(stmt);
             }
        }
    }
}

void Interpreter::execute(std::shared_ptr<ASTNode> stmt) {
    if (!stmt) return;
    switch (stmt->type) {
        case NodeType::VAR_DECL: {
            auto var = std::static_pointer_cast<VarDecl>(stmt);
            Value val = {TypeKind::INT, 0}; // Default
            if (var->initializer) {
                val = eval(var->initializer);
            }
            define(var->name, val);
            break;
        }
        case NodeType::BLOCK:
            enterScope();
            executeBlock(std::static_pointer_cast<Block>(stmt));
            exitScope();
            break;
        case NodeType::IF_STMT: {
            auto ifStmt = std::static_pointer_cast<IfStmt>(stmt);
            Value cond = eval(ifStmt->condition);
            bool isTrue = false;
            if (cond.type == TypeKind::BOOL) isTrue = std::get<bool>(cond.data);
            else if (cond.type == TypeKind::INT) isTrue = std::get<int>(cond.data) != 0;
            else if (cond.type == TypeKind::STRUCT) isTrue = true; // Struct pointer is always true (not null logic yet)
            else if (cond.type == TypeKind::ARRAY) isTrue = true;
            // In Shlang, unitialized variables/array slots are INT 0 (false).
            // A valid struct is non-zero.

            if (isTrue) executeBlock(ifStmt->thenBranch);
            else if (ifStmt->elseBranch) executeBlock(ifStmt->elseBranch);
            break;
        }
        case NodeType::WHILE_STMT: {
            auto loop = std::static_pointer_cast<WhileStmt>(stmt);
            while (true) {
                Value cond = eval(loop->condition);
                bool isTrue = false;
                if (cond.type == TypeKind::BOOL) isTrue = std::get<bool>(cond.data);
                else if (cond.type == TypeKind::INT) isTrue = std::get<int>(cond.data) != 0;
                else if (cond.type == TypeKind::STRUCT) isTrue = true;
                else if (cond.type == TypeKind::ARRAY) isTrue = true;

                if (!isTrue) break;
                executeBlock(loop->body);
            }
            break;
        }
        case NodeType::EXPR_STMT: // Not defined in AST explicitly but generic expr
        case NodeType::ASSIGNMENT:
        case NodeType::CALL_EXPR: {
            // Evaluated in eval(), just call it to ignore result if it's a statement
            eval(stmt);
            break;
        }
        case NodeType::RETURN_STMT:
            throw eval(std::static_pointer_cast<ReturnStmt>(stmt)->value);
            break;
        default:
            break;
    }
}

void Interpreter::executeBlock(std::shared_ptr<Block> block) {
    for (auto stmt : block->statements) {
        execute(stmt);
    }
}

Value Interpreter::callNative(std::string name, const std::vector<Value>& args) {
    if (name == "print") {
        for (auto& arg : args) {
            if (arg.type == TypeKind::INT) std::cout << std::get<int>(arg.data);
            else if (arg.type == TypeKind::STRING) std::cout << std::get<std::string>(arg.data);
            else if (arg.type == TypeKind::BOOL) std::cout << (std::get<bool>(arg.data) ? "true" : "false");
            else std::cout << "<obj(type=" << (int)arg.type << ")>";
            std::cout << " ";
        }
        std::cout << std::endl;
        return {TypeKind::VOID, 0};
    } else if (name == "read_file") {
        if (args.empty() || args[0].type != TypeKind::STRING) return {TypeKind::STRING, std::string("")};
        std::ifstream f(std::get<std::string>(args[0].data));
        if (!f.is_open()) return {TypeKind::STRING, std::string("")};
        std::stringstream buf;
        buf << f.rdbuf();
        return {TypeKind::STRING, buf.str()};
    } else if (name == "len") {
        if (args.empty()) return {TypeKind::INT, 0};
        if (args[0].type == TypeKind::STRING) return {TypeKind::INT, (int)std::get<std::string>(args[0].data).length()};
        if (args[0].type == TypeKind::ARRAY) return {TypeKind::INT, (int)std::get<std::shared_ptr<ArrayInstance>>(args[0].data)->elements.size()};
        return {TypeKind::INT, 0};
    } else if (name == "char_at") {
        if (args.size() < 2) return {TypeKind::STRING, std::string("")};
        std::string s = std::get<std::string>(args[0].data);
        int idx = std::get<int>(args[1].data);
        if (idx < 0 || idx >= s.length()) return {TypeKind::STRING, std::string("")};
        return {TypeKind::STRING, std::string(1, s[idx])};
    } else if (name == "string_slice") {
        // string_slice(str, start, end)
        std::string s = std::get<std::string>(args[0].data);
        int start = std::get<int>(args[1].data);
        int end = std::get<int>(args[2].data);
        return {TypeKind::STRING, s.substr(start, end - start)};
    } else if (name == "make_array") {
        // make_array(size)
        int size = std::get<int>(args[0].data);
        auto arr = std::make_shared<ArrayInstance>();
        arr->elements.resize(size, {TypeKind::INT, 0});
        Value v; v.type = TypeKind::ARRAY; v.data = arr;
        return v;
    } else if (name == "array_push") {
        if (args[0].type == TypeKind::ARRAY) {
            auto arr = std::get<std::shared_ptr<ArrayInstance>>(args[0].data);
            arr->elements.push_back(args[1]);
        }
        return {TypeKind::VOID, 0};
    } else if (name == "to_int") {
        std::string s = std::get<std::string>(args[0].data);
        try {
            return {TypeKind::INT, std::stoi(s)};
        } catch(...) { return {TypeKind::INT, 0}; }
    } else if (name == "char_code_at") {
        std::string s = std::get<std::string>(args[0].data);
        int idx = std::get<int>(args[1].data);
        if (idx < 0 || idx >= s.length()) return {TypeKind::INT, 0};
        return {TypeKind::INT, (int)s[idx]};
    } else if (name == "to_string") {
         if (args[0].type == TypeKind::INT) return {TypeKind::STRING, std::to_string(std::get<int>(args[0].data))};
         // ...
         return {TypeKind::STRING, std::string("?")};
    }
    return {TypeKind::VOID, 0};
}

Value Interpreter::eval(std::shared_ptr<ASTNode> node) {
    if (!node) return {TypeKind::VOID, 0};

    switch (node->type) {
        case NodeType::LITERAL: {
            auto lit = std::static_pointer_cast<Literal>(node);
            Value v;
            v.type = lit->valueType;
            if (v.type == TypeKind::INT) v.data = std::get<int>(lit->value);
            else if (v.type == TypeKind::STRING) v.data = std::get<std::string>(lit->value);
            else if (v.type == TypeKind::BOOL) v.data = std::get<bool>(lit->value);
            return v;
        }
        case NodeType::IDENTIFIER: {
            return lookup(std::static_pointer_cast<Identifier>(node)->name);
        }
        case NodeType::UNARY_EXPR: {
             auto un = std::static_pointer_cast<UnaryExpr>(node);
             Value r = eval(un->right);
             if (un->op == "-") {
                 if (r.type == TypeKind::INT) return {TypeKind::INT, -std::get<int>(r.data)};
             }
             return {TypeKind::VOID, 0};
        }
        case NodeType::BINARY_EXPR: {
            auto bin = std::static_pointer_cast<BinaryExpr>(node);
            Value l = eval(bin->left);
            Value r = eval(bin->right);
            Value res; res.type = TypeKind::VOID; // Default

            if (l.type == TypeKind::INT && r.type == TypeKind::INT) {
                int lv = std::get<int>(l.data);
                int rv = std::get<int>(r.data);
                if (bin->op == "+") { res.type = TypeKind::INT; res.data = lv + rv; }
                else if (bin->op == "-") { res.type = TypeKind::INT; res.data = lv - rv; }
                else if (bin->op == "*") { res.type = TypeKind::INT; res.data = lv * rv; }
                else if (bin->op == "/") { res.type = TypeKind::INT; res.data = lv / rv; }
                else if (bin->op == "%") { res.type = TypeKind::INT; res.data = lv % rv; }
                else if (bin->op == "<") { res.type = TypeKind::BOOL; res.data = lv < rv; }
                else if (bin->op == ">") { res.type = TypeKind::BOOL; res.data = lv > rv; }
                else if (bin->op == "<=") { res.type = TypeKind::BOOL; res.data = lv <= rv; }
                else if (bin->op == ">=") { res.type = TypeKind::BOOL; res.data = lv >= rv; }
                else if (bin->op == "==") { res.type = TypeKind::BOOL; res.data = lv == rv; }
                else if (bin->op == "!=") { res.type = TypeKind::BOOL; res.data = lv != rv; }
            } else if (l.type == TypeKind::STRING && r.type == TypeKind::STRING) {
                std::string ls = std::get<std::string>(l.data);
                std::string rs = std::get<std::string>(r.data);
                if (bin->op == "+") { res.type = TypeKind::STRING; res.data = ls + rs; }
                else if (bin->op == "==") { res.type = TypeKind::BOOL; res.data = ls == rs; }
                else if (bin->op == "!=") { res.type = TypeKind::BOOL; res.data = ls != rs; }
            } else {
                 // Mixed types
                 if (bin->op == "==") { res.type = TypeKind::BOOL; res.data = false; }
                 else if (bin->op == "!=") { res.type = TypeKind::BOOL; res.data = true; }
            }
            return res;
        }
        case NodeType::ASSIGNMENT: {
            auto assign = std::static_pointer_cast<Assignment>(node);
            Value val = eval(assign->value);
            // Handle member assignment?
            if (assign->target->type == NodeType::IDENTIFIER) {
                this->assign(std::static_pointer_cast<Identifier>(assign->target)->name, val);
            } else if (assign->target->type == NodeType::MEMBER_ACCESS) {
                auto ma = std::static_pointer_cast<MemberAccess>(assign->target);
                Value obj = eval(ma->object);
                if (obj.type == TypeKind::STRUCT) {
                     auto ptr = std::get<std::shared_ptr<StructInstance>>(obj.data);
                     ptr->fields[ma->member] = val;
                }
            } else if (assign->target->type == NodeType::INDEX_ACCESS) {
                auto ia = std::static_pointer_cast<IndexAccess>(assign->target);
                Value obj = eval(ia->object);
                Value idx = eval(ia->index);
                if (obj.type == TypeKind::ARRAY && idx.type == TypeKind::INT) {
                     auto ptr = std::get<std::shared_ptr<ArrayInstance>>(obj.data);
                     int i = std::get<int>(idx.data);
                     if (i >= 0 && i < ptr->elements.size()) ptr->elements[i] = val;
                }
            }
            return val;
        }
        case NodeType::NEW_STRUCT: {
            auto ns = std::static_pointer_cast<NewStruct>(node);
            Value v;
            v.type = TypeKind::STRUCT;
            auto inst = std::make_shared<StructInstance>();
            inst->name = ns->name;
            v.data = inst;
            return v;
        }
        case NodeType::MEMBER_ACCESS: {
            auto ma = std::static_pointer_cast<MemberAccess>(node);
            Value obj = eval(ma->object);
            if (obj.type == TypeKind::STRUCT) {
                auto ptr = std::get<std::shared_ptr<StructInstance>>(obj.data);
                return ptr->fields[ma->member];
            } else if (obj.type == TypeKind::ARRAY) {
                 if (ma->member == "length") {
                     return {TypeKind::INT, (int)std::get<std::shared_ptr<ArrayInstance>>(obj.data)->elements.size()};
                 }
            }
            // Interface method call?
            return {TypeKind::VOID, 0};
        }
        case NodeType::INDEX_ACCESS: {
            auto ia = std::static_pointer_cast<IndexAccess>(node);
            Value obj = eval(ia->object);
            Value idx = eval(ia->index);
            if (obj.type == TypeKind::ARRAY && idx.type == TypeKind::INT) {
                auto ptr = std::get<std::shared_ptr<ArrayInstance>>(obj.data);
                int i = std::get<int>(idx.data);
                if (i >= 0 && i < ptr->elements.size()) return ptr->elements[i];
            }
             // Support string indexing?
            if (obj.type == TypeKind::STRING && idx.type == TypeKind::INT) {
                std::string s = std::get<std::string>(obj.data);
                int i = std::get<int>(idx.data);
                if (i >= 0 && i < s.length()) return {TypeKind::STRING, std::string(1, s[i])};
            }
            return {TypeKind::VOID, 0};
        }
        case NodeType::CALL_EXPR: {
            auto call = std::static_pointer_cast<CallExpr>(node);

            // Method call?
            if (call->callee->type == NodeType::MEMBER_ACCESS) {
                auto ma = std::static_pointer_cast<MemberAccess>(call->callee);
                // Evaluate object
                Value obj = eval(ma->object);
                if (obj.type == TypeKind::STRUCT) {
                    // Look for method "greet" on struct type?
                    // We need to find function with matching receiver.
                    // Loop through functions?
                    // "func (p Person) greet"
                    // I stored `isMethod` and `receiver` in FunctionDecl.
                    // But I need to search global `functions`.
                    // Optimally I'd map them.
                    // Linear search for now.
                    auto objPtr = std::get<std::shared_ptr<StructInstance>>(obj.data);
                    std::string structName = objPtr->name;
                    std::string methodName = ma->member;

                    for (auto const& [name, func] : functions) {
                        if (func->isMethod && func->name == methodName && func->receiver.second->name == structName) {
                             // Found method
                             enterScope();
                             // Bind receiver
                             define(func->receiver.first, obj);
                             // Bind args
                             for (size_t i = 0; i < func->params.size(); ++i) {
                                if (i < call->args.size()) {
                                    Value argVal = eval(call->args[i]);
                                    define(func->params[i].first, argVal);
                                }
                             }
                             Value result = {TypeKind::VOID, 0};
                             try {
                                executeBlock(func->body);
                             } catch (Value returnValue) {
                                result = returnValue;
                             }
                             exitScope();
                             return result;
                        }
                    }
                }
            }

            if (call->callee->type == NodeType::IDENTIFIER) {
                std::string name = std::static_pointer_cast<Identifier>(call->callee)->name;
                // List of natives
                if (name == "print" || name == "read_file" || name == "len" || name == "char_at" || name == "char_code_at" || name == "string_slice" || name == "make_array" || name == "array_push" || name == "to_int" || name == "to_string") {
                     std::vector<Value> args;
                     for (auto a : call->args) args.push_back(eval(a));
                     return callNative(name, args);
                }
            }
            // User function call
            std::string funcName;
            if (call->callee->type == NodeType::IDENTIFIER) {
                funcName = std::static_pointer_cast<Identifier>(call->callee)->name;
            } else {
                return {TypeKind::VOID, 0};
            }

            if (functions.count(funcName)) {
                auto func = functions[funcName];

                enterScope();
                for (size_t i = 0; i < func->params.size(); ++i) {
                    if (i < call->args.size()) {
                        Value argVal = eval(call->args[i]);
                        define(func->params[i].first, argVal);
                    }
                }

                Value result = {TypeKind::VOID, 0};
                try {
                    executeBlock(func->body);
                } catch (Value returnValue) {
                    result = returnValue;
                }

                exitScope();
                return result;
            } else {
                std::cerr << "Undefined function: " << funcName << std::endl;
                exit(1);
            }
        }
    }
    return {TypeKind::VOID, 0};
}
