#include "type_checker.h"

TypeChecker::TypeChecker(std::shared_ptr<Program> prog) : program(prog) {}

void TypeChecker::check() {
    enterScope(); // Global scope

    // Add native functions
    // print, read_file, len, char_at, string_slice, make_array, array_push, to_int, char_code_at, to_string
    auto voidType = std::make_shared<Type>(); voidType->kind = TypeKind::VOID;
    auto intType = std::make_shared<Type>(); intType->kind = TypeKind::INT;
    auto stringType = std::make_shared<Type>(); stringType->kind = TypeKind::STRING;
    auto anyType = std::make_shared<Type>(); anyType->kind = TypeKind::ANY;

    auto funcAny = std::make_shared<Type>(); funcAny->kind = TypeKind::FUNCTION; funcAny->returnType = anyType;
    define("print", funcAny);
    define("read_file", funcAny);
    define("len", funcAny);
    define("char_at", funcAny);
    define("string_slice", funcAny);
    define("make_array", funcAny);
    define("array_push", funcAny);
    define("to_int", funcAny);
    define("char_code_at", funcAny);
    define("to_string", funcAny);

    // First pass: Register structs and interfaces
    for (auto stmt : program->statements) {
        if (stmt->type == NodeType::STRUCT_DECL) {
            auto s = std::static_pointer_cast<StructDecl>(stmt);
            auto type = std::make_shared<Type>();
            type->kind = TypeKind::STRUCT;
            type->name = s->name;
            for (auto& f : s->fields) {
                type->fields[f.first] = f.second;
            }
            structDefs[s->name] = type;
            // Also add to symbol table if needed? No, separate table.
        } else if (stmt->type == NodeType::INTERFACE_DECL) {
            auto i = std::static_pointer_cast<InterfaceDecl>(stmt);
            auto type = std::make_shared<Type>();
            type->kind = TypeKind::INTERFACE;
            type->name = i->name;
            for (auto& m : i->methods) {
                type->methods[m.first] = m.second;
            }
            interfaceDefs[i->name] = type;
        }
    }

    for (auto stmt : program->statements) {
        // Collect methods
        if (stmt->type == NodeType::FUNC_DECL) {
            auto f = std::static_pointer_cast<FunctionDecl>(stmt);
            if (f->isMethod) {
                // Add to struct definition if found
                if (f->receiver.second->kind == TypeKind::STRUCT) {
                    std::string structName = f->receiver.second->name;
                    if (structDefs.count(structName)) {
                        auto funcType = std::make_shared<Type>();
                        funcType->kind = TypeKind::FUNCTION;
                        funcType->returnType = f->returnType; // simplified
                        structDefs[structName]->methods[f->name] = funcType;
                    }
                }
            }
        }
    }

    for (auto stmt : program->statements) {
        checkNode(stmt);
    }

    exitScope();
}

void TypeChecker::enterScope() {
    scopes.push_back({});
}

void TypeChecker::exitScope() {
    scopes.pop_back();
}

void TypeChecker::define(std::string name, std::shared_ptr<Type> type) {
    scopes.back()[name] = type;
}

std::shared_ptr<Type> TypeChecker::resolve(std::string name) {
    for (int i = scopes.size() - 1; i >= 0; i--) {
        if (scopes[i].count(name)) return scopes[i][name];
    }
    return nullptr;
}

void TypeChecker::checkNode(std::shared_ptr<ASTNode> node) {
    if (!node) return;
    switch (node->type) {
        case NodeType::VAR_DECL: {
            auto var = std::static_pointer_cast<VarDecl>(node);
            std::shared_ptr<Type> type = var->typeHint;
            if (var->initializer) {
                auto initType = inferType(var->initializer);
                if (type && !isAssignable(type, initType)) {
                    std::cerr << "Type mismatch in var " << var->name << std::endl;
                    exit(1);
                }
                if (!type) type = initType;
            }
            if (!type) {
                // If uninitialized and untyped, assume ANY or error?
                // Let's assume ANY for now to allow flexible code in self-interpreter
                type = std::make_shared<Type>();
                type->kind = TypeKind::ANY;
            }
            define(var->name, type);
            break;
        }
        case NodeType::FUNC_DECL: {
            auto func = std::static_pointer_cast<FunctionDecl>(node);
            auto funcType = std::make_shared<Type>();
            funcType->kind = TypeKind::FUNCTION;
            funcType->returnType = func->returnType;
            for (auto& p : func->params) {
                // Add params types to funcType? Not storing them in Type struct yet fully
                // But we need to enter scope for body
            }
            define(func->name, funcType);

            enterScope();
            for (auto& p : func->params) {
                if (p.second) define(p.first, p.second);
                else {
                    auto any = std::make_shared<Type>();
                    any->kind = TypeKind::ANY;
                    define(p.first, any);
                }
            }
            checkNode(func->body);
            exitScope();
            break;
        }
        case NodeType::BLOCK: {
            auto blk = std::static_pointer_cast<Block>(node);
            enterScope(); // Should blocks have scopes? Yes.
            for (auto s : blk->statements) checkNode(s);
            exitScope();
            break;
        }
        case NodeType::IF_STMT: {
            auto stmt = std::static_pointer_cast<IfStmt>(node);
            auto condType = inferType(stmt->condition);
            // if (condType->kind != TypeKind::BOOL) Warning?
            checkNode(stmt->thenBranch);
            checkNode(stmt->elseBranch);
            break;
        }
        case NodeType::EXPR_STMT: {
            // Check expr?
            break;
        }
        // ... others
        default:
            // recursively check children if needed
            break;
    }
}

std::shared_ptr<Type> TypeChecker::inferType(std::shared_ptr<ASTNode> node) {
    if (!node) return nullptr;
    switch (node->type) {
        case NodeType::LITERAL: {
            auto lit = std::static_pointer_cast<Literal>(node);
            auto t = std::make_shared<Type>();
            t->kind = lit->valueType;
            return t;
        }
        case NodeType::IDENTIFIER: {
            auto id = std::static_pointer_cast<Identifier>(node);
            auto t = resolve(id->name);
            if (!t) {
                 std::cerr << "Undefined variable: " << id->name << std::endl;
                 exit(1);
            }
            return t;
        }
        case NodeType::BINARY_EXPR: {
            auto bin = std::static_pointer_cast<BinaryExpr>(node);
            auto l = inferType(bin->left);
            auto r = inferType(bin->right);
            // Check compatibility
            return l; // Simplify
        }
        case NodeType::NEW_STRUCT: {
            auto ns = std::static_pointer_cast<NewStruct>(node);
            if (structDefs.count(ns->name)) {
                return structDefs[ns->name];
            }
            std::cerr << "Unknown struct: " << ns->name << std::endl;
            exit(1);
        }
        case NodeType::MEMBER_ACCESS: {
             auto ma = std::static_pointer_cast<MemberAccess>(node);
             auto objType = inferType(ma->object);
             if (objType->kind == TypeKind::STRUCT) {
                 if (objType->fields.count(ma->member)) {
                     return objType->fields[ma->member];
                 }
                 std::cerr << "Struct " << objType->name << " has no member " << ma->member << std::endl;
                 exit(1);
             }
             // Handle interface methods?
             auto any = std::make_shared<Type>(); any->kind = TypeKind::ANY; return any;
        }
        // ...
    }
    auto any = std::make_shared<Type>(); any->kind = TypeKind::ANY; return any;
}

bool TypeChecker::isAssignable(std::shared_ptr<Type> target, std::shared_ptr<Type> source) {
    if (target->kind == TypeKind::ANY || source->kind == TypeKind::ANY) return true;
    if (target->kind == TypeKind::INTERFACE) {
        // Structural check
        if (source->kind == TypeKind::STRUCT) {
            return implementsInterface(source, target);
        }
    }
    return target->kind == source->kind; // Simplify
}

bool TypeChecker::implementsInterface(std::shared_ptr<Type> structType, std::shared_ptr<Type> interfaceType) {
    // Check if struct has all methods of interface
    for (auto& im : interfaceType->methods) {
        std::string methodName = im.first;
        if (structType->methods.find(methodName) == structType->methods.end()) {
            return false;
        }
        // Check signatures? simplified to yes
    }
    return true;
}
