#ifndef SILANG_AST_H
#define SILANG_AST_H

#include <string>
#include <vector>
#include <memory>
#include <variant>

namespace silang {

enum class Op {
    ADD, SUB, MUL, DIV, MOD,
    EQ, NEQ, LT, GT, LE, GE,
    AND, OR, NOT,
    ASSIGN
};

struct Type {
    std::string name;
    bool is_array = false;
    bool is_map = false;
    std::shared_ptr<Type> inner;
    std::shared_ptr<Type> key_type;
    std::shared_ptr<Type> value_type;

    bool operator==(const Type& other) const {
        return name == other.name && is_array == other.is_array && is_map == other.is_map;
    }
};

struct Stmt;

struct Expr {
    virtual ~Expr() = default;
};

struct Stmt {
    virtual ~Stmt() = default;
};

struct Program {
    std::vector<std::shared_ptr<Stmt>> statements;
};

// Expressions

struct LiteralExpr : Expr {
    std::variant<int, bool, std::string> value;
    LiteralExpr(int v) : value(v) {}
    LiteralExpr(bool v) : value(v) {}
    LiteralExpr(std::string v) : value(v) {}
};

struct VariableExpr : Expr {
    std::string name;
    VariableExpr(std::string n) : name(n) {}
};

struct BinaryExpr : Expr {
    std::shared_ptr<Expr> left;
    Op op;
    std::shared_ptr<Expr> right;
    BinaryExpr(std::shared_ptr<Expr> l, Op o, std::shared_ptr<Expr> r) : left(l), op(o), right(r) {}
};

struct UnaryExpr : Expr {
    Op op;
    std::shared_ptr<Expr> right;
    UnaryExpr(Op o, std::shared_ptr<Expr> r) : op(o), right(r) {}
};

struct CallExpr : Expr {
    std::shared_ptr<Expr> callee;
    std::vector<std::shared_ptr<Expr>> args;
    CallExpr(std::shared_ptr<Expr> c, std::vector<std::shared_ptr<Expr>> a) : callee(c), args(a) {}
};

struct MemberAccessExpr : Expr {
    std::shared_ptr<Expr> object;
    std::string member;
    MemberAccessExpr(std::shared_ptr<Expr> o, std::string m) : object(o), member(m) {}
};

struct IndexExpr : Expr {
    std::shared_ptr<Expr> object;
    std::shared_ptr<Expr> index;
    IndexExpr(std::shared_ptr<Expr> o, std::shared_ptr<Expr> i) : object(o), index(i) {}
};

struct ArrayLiteralExpr : Expr {
    std::vector<std::shared_ptr<Expr>> elements;
    ArrayLiteralExpr(std::vector<std::shared_ptr<Expr>> e) : elements(e) {}
};

// Statements

struct VarDeclStmt : Stmt {
    std::string name;
    Type type;
    std::shared_ptr<Expr> initializer;
    VarDeclStmt(std::string n, Type t, std::shared_ptr<Expr> i = nullptr) : name(n), type(t), initializer(i) {}
};

struct FuncDeclStmt : Stmt {
    std::string name;
    std::vector<std::pair<std::string, Type>> params;
    Type returnType;
    std::shared_ptr<Stmt> body;
    FuncDeclStmt(std::string n, std::vector<std::pair<std::string, Type>> p, Type r, std::shared_ptr<Stmt> b)
        : name(n), params(p), returnType(r), body(b) {}
};

struct StructDeclStmt : Stmt {
    std::string name;
    std::vector<std::pair<std::string, Type>> fields;
    StructDeclStmt(std::string n, std::vector<std::pair<std::string, Type>> f) : name(n), fields(f) {}
};

struct BlockStmt : Stmt {
    std::vector<std::shared_ptr<Stmt>> statements;
    BlockStmt(std::vector<std::shared_ptr<Stmt>> s) : statements(s) {}
};

struct IfStmt : Stmt {
    std::shared_ptr<Expr> condition;
    std::shared_ptr<Stmt> thenBranch;
    std::shared_ptr<Stmt> elseBranch;
    IfStmt(std::shared_ptr<Expr> c, std::shared_ptr<Stmt> t, std::shared_ptr<Stmt> e = nullptr)
        : condition(c), thenBranch(t), elseBranch(e) {}
};

struct ReturnStmt : Stmt {
    std::shared_ptr<Expr> value;
    ReturnStmt(std::shared_ptr<Expr> v = nullptr) : value(v) {}
};

struct ExprStmt : Stmt {
    std::shared_ptr<Expr> expr;
    ExprStmt(std::shared_ptr<Expr> e) : expr(e) {}
};

struct WhileStmt : Stmt {
    std::shared_ptr<Expr> condition;
    std::shared_ptr<Stmt> body;
    WhileStmt(std::shared_ptr<Expr> c, std::shared_ptr<Stmt> b) : condition(c), body(b) {}
};

} // namespace silang

#endif
