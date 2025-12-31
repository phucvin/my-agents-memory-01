#ifndef AST_H
#define AST_H

#include <string>
#include <vector>
#include <memory>
#include <variant>
#include <map>

// Type Definitions
enum class TypeKind {
    VOID,
    INT,
    STRING,
    BOOL,
    STRUCT,
    INTERFACE,
    FUNCTION,
    ANY, // For inference
    MAP,
    ARRAY
};

struct Type;

struct Type {
    TypeKind kind;
    std::string name; // For structs/interfaces
    std::vector<std::shared_ptr<Type>> params; // For generics or function args
    std::shared_ptr<Type> returnType; // For functions

    // For structural typing
    std::map<std::string, std::shared_ptr<Type>> fields; // Struct fields
    std::map<std::string, std::shared_ptr<Type>> methods; // Interface methods

    bool operator==(const Type& other) const {
        if (kind != other.kind) return false;
        if (name != other.name) return false;
        return true;
    }
};

// AST Nodes
enum class NodeType {
    PROGRAM,
    VAR_DECL,
    FUNC_DECL,
    STRUCT_DECL,
    INTERFACE_DECL,
    BLOCK,
    IF_STMT,
    WHILE_STMT,
    RETURN_STMT,
    EXPR_STMT,
    ASSIGNMENT,
    BINARY_EXPR,
    UNARY_EXPR,
    CALL_EXPR,
    LITERAL,
    IDENTIFIER,
    MEMBER_ACCESS,
    INDEX_ACCESS,
    NEW_STRUCT,
    MAKE_MAP
};

struct ASTNode {
    NodeType type;
    virtual ~ASTNode() = default;
};

struct Program : ASTNode {
    std::vector<std::shared_ptr<ASTNode>> statements;
    Program() { type = NodeType::PROGRAM; }
};

struct Identifier : ASTNode {
    std::string name;
    Identifier(std::string n) : name(n) { type = NodeType::IDENTIFIER; }
};

struct Literal : ASTNode {
    std::variant<int, std::string, bool> value;
    TypeKind valueType;
    Literal(int v) : value(v), valueType(TypeKind::INT) { type = NodeType::LITERAL; }
    Literal(std::string v) : value(v), valueType(TypeKind::STRING) { type = NodeType::LITERAL; }
    Literal(bool v) : value(v), valueType(TypeKind::BOOL) { type = NodeType::LITERAL; }
};

struct BinaryExpr : ASTNode {
    std::string op;
    std::shared_ptr<ASTNode> left;
    std::shared_ptr<ASTNode> right;
    BinaryExpr() { type = NodeType::BINARY_EXPR; }
};

struct UnaryExpr : ASTNode {
    std::string op;
    std::shared_ptr<ASTNode> right;
    UnaryExpr() { type = NodeType::UNARY_EXPR; }
};

struct CallExpr : ASTNode {
    std::shared_ptr<ASTNode> callee;
    std::vector<std::shared_ptr<ASTNode>> args;
    CallExpr() { type = NodeType::CALL_EXPR; }
};

struct Block : ASTNode {
    std::vector<std::shared_ptr<ASTNode>> statements;
    Block() { type = NodeType::BLOCK; }
};

struct FunctionDecl : ASTNode {
    std::string name;
    std::vector<std::pair<std::string, std::shared_ptr<Type>>> params; // Name, Type
    std::shared_ptr<Type> returnType;
    std::shared_ptr<Block> body;

    // Receiver for methods
    std::pair<std::string, std::shared_ptr<Type>> receiver; // Name, Type (Struct)
    bool isMethod = false;

    FunctionDecl() { type = NodeType::FUNC_DECL; }
};

struct VarDecl : ASTNode {
    std::string name;
    std::shared_ptr<Type> typeHint; // Can be null
    std::shared_ptr<ASTNode> initializer;
    VarDecl() { type = NodeType::VAR_DECL; }
};

struct ReturnStmt : ASTNode {
    std::shared_ptr<ASTNode> value;
    ReturnStmt() { type = NodeType::RETURN_STMT; }
};

struct IfStmt : ASTNode {
    std::shared_ptr<ASTNode> condition;
    std::shared_ptr<Block> thenBranch;
    std::shared_ptr<Block> elseBranch;
    IfStmt() { type = NodeType::IF_STMT; }
};

struct WhileStmt : ASTNode {
    std::shared_ptr<ASTNode> condition;
    std::shared_ptr<Block> body;
    WhileStmt() { type = NodeType::WHILE_STMT; }
};

struct StructDecl : ASTNode {
    std::string name;
    std::vector<std::pair<std::string, std::shared_ptr<Type>>> fields;
    StructDecl() { type = NodeType::STRUCT_DECL; }
};

struct InterfaceDecl : ASTNode {
    std::string name;
    std::vector<std::pair<std::string, std::shared_ptr<Type>>> methods;
    InterfaceDecl() { type = NodeType::INTERFACE_DECL; }
};

struct MemberAccess : ASTNode {
    std::shared_ptr<ASTNode> object;
    std::string member;
    MemberAccess() { type = NodeType::MEMBER_ACCESS; }
};

struct Assignment : ASTNode {
    std::shared_ptr<ASTNode> target;
    std::shared_ptr<ASTNode> value;
    Assignment() { type = NodeType::ASSIGNMENT; }
};

struct NewStruct : ASTNode {
    std::string name;
    NewStruct() { type = NodeType::NEW_STRUCT; }
};

struct IndexAccess : ASTNode {
    std::shared_ptr<ASTNode> object;
    std::shared_ptr<ASTNode> index;
    IndexAccess() { type = NodeType::INDEX_ACCESS; }
};

struct MakeArray : ASTNode {
    std::shared_ptr<Type> elementType; // optional
    std::shared_ptr<ASTNode> size;
    MakeArray() { type = NodeType::CALL_EXPR; } // Reuse call or new node? Let's use specific
    // Wait, let's use CallExpr "make_array(size)" for simplicity in parser
};

#endif
