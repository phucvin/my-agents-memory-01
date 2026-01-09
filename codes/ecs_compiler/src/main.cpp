#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <sstream>
#include <cctype>
#include <map>
#include <cassert>
#include <algorithm>
#include <cstdlib>

// --- Data Oriented Design / ECS Components ---

// Types of nodes in our AST (and tokens)
enum class NodeType {
    UNKNOWN,
    // Tokens
    TOKEN_IDENTIFIER,
    TOKEN_KEYWORD,
    TOKEN_LITERAL_INT,
    TOKEN_SYMBOL,
    TOKEN_EOF,

    // AST Nodes
    PROGRAM,
    FUNC_DEF,
    BLOCK,
    VAR_DECL,
    ASSIGNMENT,
    RETURN_STMT,
    IF_STMT,
    WHILE_STMT,
    FUNC_CALL,
    BINARY_OP,
    LITERAL_INT_NODE,
    VAR_REF,
    PRINT_STMT
};

enum class DataType {
    VOID,
    INT,
    BOOL,
    UNKNOWN
};

// Component Arrays (Structure of Arrays)
struct CompilerState {
    // Entities are just indices into these arrays.
    std::vector<NodeType> node_types;

    // Components (not all entities have all components)
    std::vector<std::string> names;          // For identifiers, function names
    std::vector<int> int_values;             // For integer literals
    std::vector<std::string> string_values;  // For generic string data (keywords, symbols)

    // Tree structure components (Adjacency list / pointers)
    std::vector<int> parents;
    std::vector<std::vector<int>> children;  // Using vector of vector for simplicity in prototype
                                            // In pure DOD, this might be a flattened array with range indices.

    // Type system components
    std::vector<DataType> data_types;

    // Source location
    std::vector<int> lines;

    // Helper to create a new entity
    int create_entity(NodeType type) {
        int id = node_types.size();
        node_types.push_back(type);
        names.push_back("");
        int_values.push_back(0);
        string_values.push_back("");
        parents.push_back(-1);
        children.push_back({});
        data_types.push_back(DataType::UNKNOWN);
        lines.push_back(0);
        return id;
    }
};

// --- Systems ---

// 1. Lexer System: Reads source code and populates Token entities
void lexer_system(const std::string& source, CompilerState& state, std::vector<int>& token_entities) {
    int pos = 0;
    int line = 1;
    int len = source.length();

    auto is_space = [](char c) { return c == ' ' || c == '\t' || c == '\r' || c == '\n'; };
    auto is_alpha = [](char c) { return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_'; };
    auto is_digit = [](char c) { return c >= '0' && c <= '9'; };

    while (pos < len) {
        if (is_space(source[pos])) {
            if (source[pos] == '\n') line++;
            pos++;
            continue;
        }

        // Comments
        if (source[pos] == '/' && pos + 1 < len && source[pos+1] == '/') {
            while (pos < len && source[pos] != '\n') pos++;
            continue;
        }

        int id = -1;

        if (is_alpha(source[pos])) {
            std::string ident;
            while (pos < len && (is_alpha(source[pos]) || is_digit(source[pos]))) {
                ident += source[pos++];
            }
            // Check keywords
            if (ident == "fn" || ident == "var" || ident == "return" || ident == "if" ||
                ident == "else" || ident == "while" || ident == "int" || ident == "void" || ident == "print") {
                id = state.create_entity(NodeType::TOKEN_KEYWORD);
                state.string_values[id] = ident;
            } else {
                id = state.create_entity(NodeType::TOKEN_IDENTIFIER);
                state.names[id] = ident;
            }
        } else if (is_digit(source[pos])) {
            std::string num;
            while (pos < len && is_digit(source[pos])) {
                num += source[pos++];
            }
            id = state.create_entity(NodeType::TOKEN_LITERAL_INT);
            state.int_values[id] = std::stoi(num);
        } else {
            // Symbols
            std::string sym;
            sym += source[pos++];
            // Check for multi-char symbols (e.g., ==, <=) - skipping for simplicity of this prototype except maybe ->
            if (sym == "-" && pos < len && source[pos] == '>') {
                sym += source[pos++];
            }
            if ((sym == "=" || sym == "!" || sym == "<" || sym == ">") && pos < len && source[pos] == '=') {
                sym += source[pos++];
            }

            id = state.create_entity(NodeType::TOKEN_SYMBOL);
            state.string_values[id] = sym;
        }

        if (id != -1) {
            state.lines[id] = line;
            token_entities.push_back(id);
        }
    }
    int eof = state.create_entity(NodeType::TOKEN_EOF);
    token_entities.push_back(eof);
}

// 2. Parser System: Consumes Token entities and builds AST entities
class ParserSystem {
    CompilerState& state;
    const std::vector<int>& tokens;
    int current = 0;

public:
    ParserSystem(CompilerState& s, const std::vector<int>& t) : state(s), tokens(t) {}

    int peek() { return tokens[current]; }

    int advance() {
        if (state.node_types[tokens[current]] != NodeType::TOKEN_EOF) current++;
        return tokens[current - 1];
    }

    bool match(const std::string& val) {
        int t = peek();
        if (state.node_types[t] == NodeType::TOKEN_SYMBOL || state.node_types[t] == NodeType::TOKEN_KEYWORD) {
            if (state.string_values[t] == val) {
                advance();
                return true;
            }
        }
        return false;
    }

    void expect(const std::string& val) {
        if (!match(val)) {
            int t = peek();
            std::cerr << "Syntax Error: Expected '" << val << "' but got '"
                      << state.string_values[t] << "' at line " << state.lines[t] << std::endl;
            exit(1);
        }
    }

    std::string expect_ident() {
        int t = peek();
        if (state.node_types[t] == NodeType::TOKEN_IDENTIFIER) {
            advance();
            return state.names[t];
        }
        std::cerr << "Syntax Error: Expected identifier at line " << state.lines[t] << std::endl;
        exit(1);
        return "";
    }

    DataType parse_type() {
        if (match("int")) return DataType::INT;
        if (match("void")) return DataType::VOID;
        std::cerr << "Syntax Error: Expected type at line " << state.lines[peek()] << std::endl;
        exit(1);
        return DataType::UNKNOWN;
    }

    // Grammar:
    // Program -> Decl*
    // Decl -> FnDef
    // FnDef -> 'fn' IDENT '(' Params ')' '->' Type Block

    int parse_program() {
        int prog = state.create_entity(NodeType::PROGRAM);
        while (state.node_types[peek()] != NodeType::TOKEN_EOF) {
            int decl = parse_decl();
            if (decl != -1) {
                state.children[prog].push_back(decl);
            }
        }
        return prog;
    }

    int parse_decl() {
        // Only functions supported at top level for now
        if (match("fn")) {
            return parse_fn();
        }
        // If we are at EOF, we should stop
        if (state.node_types[peek()] == NodeType::TOKEN_EOF) {
            return -1;
        }

        std::cerr << "Syntax Error: Expected 'fn' at top level but got '" << state.string_values[peek()] << "' (type " << (int)state.node_types[peek()] << ") at line " << state.lines[peek()] << std::endl;
        exit(1);
        return -1;
    }

    int parse_fn() {
        int fn = state.create_entity(NodeType::FUNC_DEF);
        state.names[fn] = expect_ident();
        expect("(");
        // Params
        while (state.node_types[peek()] != NodeType::TOKEN_SYMBOL || state.string_values[peek()] != ")") {
            int var = state.create_entity(NodeType::VAR_DECL);
            state.names[var] = expect_ident();
            expect(":");
            state.data_types[var] = parse_type();
            state.children[fn].push_back(var); // Store params as first children

            if (!match(",")) break;
        }
        expect(")");
        expect("->");
        state.data_types[fn] = parse_type(); // Return type

        int block = parse_block();
        state.children[fn].push_back(block);

        return fn;
    }

    int parse_block() {
        expect("{");
        int block = state.create_entity(NodeType::BLOCK);
        while (!match("}")) {
            int stmt = parse_stmt();
            state.children[block].push_back(stmt);
        }
        return block;
    }

    int parse_stmt() {
        if (match("var")) {
            int decl = state.create_entity(NodeType::VAR_DECL);
            state.names[decl] = expect_ident();
            expect(":");
            state.data_types[decl] = parse_type();
            expect("=");
            int expr = parse_expr();
            state.children[decl].push_back(expr);
            expect(";");
            return decl;
        }
        if (match("return")) {
            int ret = state.create_entity(NodeType::RETURN_STMT);
            if (state.string_values[peek()] != ";") {
                int expr = parse_expr();
                state.children[ret].push_back(expr);
            }
            expect(";");
            return ret;
        }
        if (match("if")) {
            int if_stmt = state.create_entity(NodeType::IF_STMT);
            int cond = parse_expr();
            state.children[if_stmt].push_back(cond); // Condition
            int then_block = parse_block();
            state.children[if_stmt].push_back(then_block); // Then
            if (match("else")) {
                int else_block = parse_block();
                state.children[if_stmt].push_back(else_block); // Else
            }
            return if_stmt;
        }
        if (match("while")) {
            int w = state.create_entity(NodeType::WHILE_STMT);
            int cond = parse_expr();
            state.children[w].push_back(cond);
            int block = parse_block();
            state.children[w].push_back(block);
            return w;
        }
        if (match("print")) {
            int p = state.create_entity(NodeType::PRINT_STMT);
            expect("(");
            int expr = parse_expr();
            state.children[p].push_back(expr);
            expect(")");
            expect(";");
            return p;
        }

        // Expression statement or Assignment
        // Need backtracking or lookahead, but for simple C-like,
        // IDENT = EXPR is assignment, IDENT(...) is call (which is expr).
        // Let's parse expression first.

        // Quick hack: peek two tokens to see if it's assignment
        int t1 = peek();
        if (state.node_types[t1] == NodeType::TOKEN_IDENTIFIER) {
            // save current pos
            int saved = current;
            advance();
            if (match("=")) {
                // Assignment
                int assign = state.create_entity(NodeType::ASSIGNMENT);
                state.names[assign] = state.names[t1];
                int expr = parse_expr();
                state.children[assign].push_back(expr);
                expect(";");
                return assign;
            }
            // Restore
            current = saved;
        }

        int expr = parse_expr();
        expect(";");
        return expr;
    }

    int parse_expr() {
        return parse_equality();
    }

    int parse_equality() {
        int left = parse_additive();
        while (true) {
            int t = peek();
            if (state.string_values[t] == "==" || state.string_values[t] == "!=" ||
                state.string_values[t] == "<" || state.string_values[t] == ">" ||
                state.string_values[t] == "<=" || state.string_values[t] == ">=") {
                std::string op = state.string_values[t];
                advance();
                int right = parse_additive();
                int bin = state.create_entity(NodeType::BINARY_OP);
                state.string_values[bin] = op;
                state.children[bin].push_back(left);
                state.children[bin].push_back(right);
                left = bin;
            } else {
                break;
            }
        }
        return left;
    }

    int parse_additive() {
        int left = parse_multiplicative();
        while (match("+") || match("-")) {
            std::string op = state.string_values[tokens[current-1]]; // match advanced it
            int right = parse_multiplicative();
            int bin = state.create_entity(NodeType::BINARY_OP);
            state.string_values[bin] = op;
            state.children[bin].push_back(left);
            state.children[bin].push_back(right);
            left = bin;
        }
        return left;
    }

    int parse_multiplicative() {
        int left = parse_primary();
        while (match("*") || match("/")) {
            std::string op = state.string_values[tokens[current-1]];
            int right = parse_primary();
            int bin = state.create_entity(NodeType::BINARY_OP);
            state.string_values[bin] = op;
            state.children[bin].push_back(left);
            state.children[bin].push_back(right);
            left = bin;
        }
        return left;
    }

    int parse_primary() {
        int t = peek();
        if (state.node_types[t] == NodeType::TOKEN_LITERAL_INT) {
            advance();
            int lit = state.create_entity(NodeType::LITERAL_INT_NODE);
            state.int_values[lit] = state.int_values[t];
            return lit;
        }
        if (state.node_types[t] == NodeType::TOKEN_IDENTIFIER) {
            advance();
            // Check for call
            if (match("(")) {
                int call = state.create_entity(NodeType::FUNC_CALL);
                state.names[call] = state.names[t];
                if (!match(")")) {
                    do {
                        int arg = parse_expr();
                        state.children[call].push_back(arg);
                    } while (match(","));
                    expect(")");
                }
                return call;
            }
            // Just variable ref
            int var = state.create_entity(NodeType::VAR_REF);
            state.names[var] = state.names[t];
            return var;
        }
        if (match("(")) {
            int e = parse_expr();
            expect(")");
            return e;
        }
        std::cerr << "Syntax Error: Unexpected token '" << state.string_values[t] << "' at line " << state.lines[t] << std::endl;
        exit(1);
        return -1;
    }
};

// 3. Type Checker System
// In a real DOD system, this might iterate over arrays, but tree traversal is necessary for AST.
// We can linearize the AST into a "Frame" based structure if we really want to go hard DOD, but recursion is fine for now.
class TypeCheckerSystem {
    CompilerState& state;
    // Symbol table: vector of maps? Or just a map for prototype.
    // For ECS, scopes could be entities too.
    std::vector<std::map<std::string, DataType>> scopes;
    std::map<std::string, std::pair<DataType, std::vector<DataType>>> functions; // Name -> {Ret, Args}

public:
    TypeCheckerSystem(CompilerState& s) : state(s) {
        scopes.push_back({}); // Global scope
    }

    void check(int node) {
        switch (state.node_types[node]) {
            case NodeType::PROGRAM:
                // std::cerr << "DEBUG: Program has " << state.children[node].size() << " children." << std::endl;
                for (int child : state.children[node]) {
                    // First pass: register functions
                    if (state.node_types[child] == NodeType::FUNC_DEF) {
                        std::vector<DataType> arg_types;
                        // Params are all children except last one (block)
                        for (size_t i=0; i<state.children[child].size()-1; ++i) {
                            arg_types.push_back(state.data_types[state.children[child][i]]);
                        }
                        functions[state.names[child]] = {state.data_types[child], arg_types};
                        // std::cerr << "DEBUG: Registered function '" << state.names[child] << "'" << std::endl;
                    }
                }
                for (int child : state.children[node]) {
                    check(child);
                }
                break;

            case NodeType::FUNC_DEF:
                scopes.push_back({}); // New scope
                // Add params to scope
                for (size_t i=0; i<state.children[node].size()-1; ++i) {
                    int param = state.children[node][i];
                    scopes.back()[state.names[param]] = state.data_types[param];
                }
                check(state.children[node].back()); // Check block
                scopes.pop_back();
                break;

            case NodeType::BLOCK:
                for (int child : state.children[node]) check(child);
                break;

            case NodeType::VAR_DECL: {
                check(state.children[node][0]); // Init expr
                DataType exprType = state.data_types[state.children[node][0]];
                if (exprType != state.data_types[node]) {
                    std::cerr << "Type Error: Variable '" << state.names[node] << "' expects "
                              << (int)state.data_types[node] << " but got " << (int)exprType << std::endl;
                    exit(1);
                }
                scopes.back()[state.names[node]] = state.data_types[node];
                break;
            }

            case NodeType::ASSIGNMENT: {
                check(state.children[node][0]);
                DataType exprType = state.data_types[state.children[node][0]];
                DataType varType = resolve_var(state.names[node]);
                if (varType != exprType) {
                    std::cerr << "Type Error: Assignment to '" << state.names[node] << "' mismatch." << std::endl;
                    exit(1);
                }
                state.data_types[node] = varType;
                break;
            }

            case NodeType::RETURN_STMT:
                if (!state.children[node].empty()) {
                    check(state.children[node][0]);
                    state.data_types[node] = state.data_types[state.children[node][0]];
                } else {
                    state.data_types[node] = DataType::VOID;
                }
                break;

            case NodeType::IF_STMT:
            case NodeType::WHILE_STMT:
                check(state.children[node][0]); // Condition
                if (state.data_types[state.children[node][0]] != DataType::INT &&
                    state.data_types[state.children[node][0]] != DataType::BOOL) {
                     // In C, int is bool, so we are lenient
                }
                check(state.children[node][1]); // Block
                if (state.children[node].size() > 2) check(state.children[node][2]); // Else
                break;

            case NodeType::PRINT_STMT:
                check(state.children[node][0]);
                break;

            case NodeType::BINARY_OP: {
                check(state.children[node][0]);
                check(state.children[node][1]);
                DataType l = state.data_types[state.children[node][0]];
                DataType r = state.data_types[state.children[node][1]];
                if (l != r) {
                    std::cerr << "Type Error: Binary op mismatch." << std::endl;
                    exit(1);
                }
                // Comparisons return bool (int), others return same type
                std::string op = state.string_values[node];
                if (op == "==" || op == "!=" || op == "<" || op == ">" || op == "<=" || op == ">=")
                    state.data_types[node] = DataType::INT; // Bool represented as int
                else
                    state.data_types[node] = l;
                break;
            }

            case NodeType::LITERAL_INT_NODE:
                state.data_types[node] = DataType::INT;
                break;

            case NodeType::VAR_REF:
                state.data_types[node] = resolve_var(state.names[node]);
                break;

            case NodeType::FUNC_CALL: {
                // std::cerr << "DEBUG: Checking call to '" << state.names[node] << "'" << std::endl;
                if (functions.find(state.names[node]) == functions.end()) {
                    std::cerr << "Type Error: Undefined function '" << state.names[node] << "'" << std::endl;
                    // std::cerr << "Available functions: " << std::endl;
                    // for (auto const& [name, sig] : functions) {
                    //     std::cerr << " - " << name << std::endl;
                    // }
                    exit(1);
                }
                auto& sig = functions[state.names[node]];
                if (state.children[node].size() != sig.second.size()) {
                     std::cerr << "Type Error: Argument count mismatch for '" << state.names[node] << "'" << std::endl;
                     exit(1);
                }
                for (size_t i=0; i<state.children[node].size(); ++i) {
                    check(state.children[node][i]);
                    if (state.data_types[state.children[node][i]] != sig.second[i]) {
                        std::cerr << "Type Error: Argument " << i << " type mismatch in call to '" << state.names[node] << "'" << std::endl;
                        exit(1);
                    }
                }
                state.data_types[node] = sig.first;
                break;
            }

            default:
                break;
        }
    }

    DataType resolve_var(const std::string& name) {
        for (auto it = scopes.rbegin(); it != scopes.rend(); ++it) {
            if (it->find(name) != it->end()) return (*it)[name];
        }
        std::cerr << "Type Error: Undefined variable '" << name << "'" << std::endl;
        exit(1);
        return DataType::UNKNOWN;
    }
};

// 4. Code Generator System: Emits C code
class CodeGenSystem {
    CompilerState& state;
    std::ostream& out;

public:
    CodeGenSystem(CompilerState& s, std::ostream& o) : state(s), out(o) {}

    void generate(int node) {
        out << "#include <stdio.h>\n";
        out << "void print(int x) { printf(\"%d\\n\", x); }\n\n";

        // Forward declarations
        for (int child : state.children[node]) {
            if (state.node_types[child] == NodeType::FUNC_DEF) {
                emit_type(state.data_types[child]);
                out << " " << state.names[child] << "(";
                for (size_t i=0; i<state.children[child].size()-1; ++i) {
                    if (i > 0) out << ", ";
                    int param = state.children[child][i];
                    emit_type(state.data_types[param]);
                }
                out << ");\n";
            }
        }
        out << "\n";

        for (int child : state.children[node]) {
            gen_node(child);
        }
    }

    void emit_type(DataType dt) {
        if (dt == DataType::INT) out << "int";
        else if (dt == DataType::VOID) out << "void";
        else if (dt == DataType::BOOL) out << "int";
        else out << "void"; // fallback
    }

    void gen_node(int node) {
        switch (state.node_types[node]) {
            case NodeType::FUNC_DEF: {
                emit_type(state.data_types[node]);
                out << " " << state.names[node] << "(";
                for (size_t i=0; i<state.children[node].size()-1; ++i) {
                    if (i > 0) out << ", ";
                    int param = state.children[node][i];
                    emit_type(state.data_types[param]);
                    out << " " << state.names[param];
                }
                out << ") ";
                gen_node(state.children[node].back()); // Block
                out << "\n";
                break;
            }
            case NodeType::BLOCK: {
                out << "{\n";
                for (int child : state.children[node]) {
                    gen_node(child);
                    // Add semicolon if stmt doesn't have block or isn't if/while
                    NodeType t = state.node_types[child];
                    if (t == NodeType::VAR_DECL || t == NodeType::ASSIGNMENT ||
                        t == NodeType::RETURN_STMT || t == NodeType::PRINT_STMT ||
                        t == NodeType::FUNC_CALL) {
                        out << ";\n";
                    } else if (t == NodeType::BINARY_OP || t == NodeType::LITERAL_INT_NODE || t == NodeType::VAR_REF) {
                        // Expression statement
                         out << ";\n";
                    }
                }
                out << "}\n";
                break;
            }
            case NodeType::VAR_DECL:
                emit_type(state.data_types[node]);
                out << " " << state.names[node] << " = ";
                gen_node(state.children[node][0]);
                break;

            case NodeType::ASSIGNMENT:
                out << state.names[node] << " = ";
                gen_node(state.children[node][0]);
                break;

            case NodeType::RETURN_STMT:
                out << "return";
                if (!state.children[node].empty()) {
                    out << " ";
                    gen_node(state.children[node][0]);
                }
                break;

            case NodeType::IF_STMT:
                out << "if (";
                gen_node(state.children[node][0]);
                out << ") ";
                gen_node(state.children[node][1]);
                if (state.children[node].size() > 2) {
                    out << " else ";
                    gen_node(state.children[node][2]);
                }
                out << "\n";
                break;

            case NodeType::WHILE_STMT:
                out << "while (";
                gen_node(state.children[node][0]);
                out << ") ";
                gen_node(state.children[node][1]);
                out << "\n";
                break;

            case NodeType::PRINT_STMT:
                out << "print(";
                gen_node(state.children[node][0]);
                out << ")";
                break;

            case NodeType::BINARY_OP:
                out << "(";
                gen_node(state.children[node][0]);
                out << " " << state.string_values[node] << " ";
                gen_node(state.children[node][1]);
                out << ")";
                break;

            case NodeType::LITERAL_INT_NODE:
                out << state.int_values[node];
                break;

            case NodeType::VAR_REF:
                out << state.names[node];
                break;

            case NodeType::FUNC_CALL:
                out << state.names[node] << "(";
                for (size_t i=0; i<state.children[node].size(); ++i) {
                    if (i > 0) out << ", ";
                    gen_node(state.children[node][i]);
                }
                out << ")";
                break;

            default:
                break;
        }
    }
};

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <source_file>" << std::endl;
        return 1;
    }

    std::ifstream f(argv[1]);
    if (!f.is_open()) {
        std::cerr << "Could not open file." << std::endl;
        return 1;
    }
    std::stringstream buffer;
    buffer << f.rdbuf();
    std::string source = buffer.str();

    CompilerState state;
    std::vector<int> token_entities;

    // Run Systems
    lexer_system(source, state, token_entities);

    ParserSystem parser(state, token_entities);
    int program_root = parser.parse_program();

    TypeCheckerSystem type_checker(state);
    type_checker.check(program_root);

    CodeGenSystem codegen(state, std::cout);
    codegen.generate(program_root);

    return 0;
}
