// AST Nodes
var NODE_PROGRAM = 0;
var NODE_VAR_DECL = 1;
var NODE_FUNC_DECL = 2;
var NODE_BLOCK = 3;
var NODE_IF = 4;
var NODE_WHILE = 5;
var NODE_RETURN = 6;
var NODE_ASSIGNMENT = 7;
var NODE_BINARY = 8;
var NODE_CALL = 9;
var NODE_LITERAL = 10;
var NODE_IDENTIFIER = 11;
var NODE_STRUCT_DECL = 12;
// ...

struct Program {
    type int;
    statements []any; // Array of nodes
}

struct VarDecl {
    type int;
    name string;
    initializer any;
}

struct FuncDecl {
    type int;
    name string;
    params []string; // Names
    body any; // Block
}

struct Block {
    type int;
    statements []any;
}

struct IfStmt {
    type int;
    condition any;
    thenBranch any;
    elseBranch any;
}

struct WhileStmt {
    type int;
    condition any;
    body any;
}

struct ReturnStmt {
    type int;
    value any;
}

struct Assignment {
    type int;
    target any; // Identifier
    value any;
}

struct BinaryExpr {
    type int;
    op string;
    left any;
    right any;
}

struct CallExpr {
    type int;
    callee any;
    args []any;
}

struct Literal {
    type int;
    value any; // int, string, bool
}

struct Identifier {
    type int;
    name string;
}

struct StructDecl {
    type int;
    name string;
    fields []string; // Names
    // Types ignored in dynamic self-interpreter or stored?
    // Storing types as strings
    fieldTypes []string;
}
