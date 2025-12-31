#ifndef SILANG_INTERPRETER_H
#define SILANG_INTERPRETER_H

#include "AST.h"
#include "Value.h"
#include <map>
#include <string>
#include <vector>
#include <memory>
#include <stdexcept>

namespace silang {

class Environment : public std::enable_shared_from_this<Environment> {
public:
    std::shared_ptr<Environment> enclosing;
    std::map<std::string, ValuePtr> values;

    Environment(std::shared_ptr<Environment> enclosing = nullptr) : enclosing(enclosing) {}

    void define(std::string name, ValuePtr value) {
        values[name] = value;
    }

    ValuePtr get(std::string name) {
        if (values.find(name) != values.end()) {
            return values[name];
        }
        if (enclosing) return enclosing->get(name);
        throw std::runtime_error("Undefined variable '" + name + "'.");
    }

    void assign(std::string name, ValuePtr value) {
        if (values.find(name) != values.end()) {
            values[name] = value;
            return;
        }
        if (enclosing) {
            enclosing->assign(name, value);
            return;
        }
        throw std::runtime_error("Undefined variable '" + name + "'.");
    }
};

class ReturnException : public std::exception {
public:
    ValuePtr value;
    ReturnException(ValuePtr v) : value(v) {}
};

class Interpreter {
public:
    Interpreter();
    void interpret(std::shared_ptr<Program> program);

    // Helpers need to be public or friend if we split files,
    // but here we might implement visit methods inside Interpreter class or use dynamic_cast dispatch.
    // Given the AST structure uses inheritance but not Visitor pattern (virtual accept),
    // we use dynamic_cast or type switching.

    ValuePtr evaluate(std::shared_ptr<Expr> expr);
    void execute(std::shared_ptr<Stmt> stmt);

private:
    std::shared_ptr<Environment> globals;
    std::shared_ptr<Environment> environment;

    // Builtins
    void setupBuiltins();

    // Dispatchers
    ValuePtr visitLiteral(std::shared_ptr<LiteralExpr> expr);
    ValuePtr visitVariable(std::shared_ptr<VariableExpr> expr);
    ValuePtr visitBinary(std::shared_ptr<BinaryExpr> expr);
    ValuePtr visitUnary(std::shared_ptr<UnaryExpr> expr);
    ValuePtr visitCall(std::shared_ptr<CallExpr> expr);
    ValuePtr visitMemberAccess(std::shared_ptr<MemberAccessExpr> expr);
    ValuePtr visitIndex(std::shared_ptr<IndexExpr> expr);
    ValuePtr visitArrayLiteral(std::shared_ptr<ArrayLiteralExpr> expr);

    void visitVarDecl(std::shared_ptr<VarDeclStmt> stmt);
    void visitFuncDecl(std::shared_ptr<FuncDeclStmt> stmt);
    void visitStructDecl(std::shared_ptr<StructDeclStmt> stmt);
    void visitBlock(std::shared_ptr<BlockStmt> stmt);
    void visitIf(std::shared_ptr<IfStmt> stmt);
    void visitWhile(std::shared_ptr<WhileStmt> stmt);
    void visitReturn(std::shared_ptr<ReturnStmt> stmt);
    void visitExprStmt(std::shared_ptr<ExprStmt> stmt);
};

}

#endif
