// Implementation of Map using Arrays in Shlang
// Since we don't have generics, we'll use 'any' equivalent or specific MapStructs.
// But Shlang has structural typing.
// The user said: "implement map in shlang".
// This likely implies a generic-ish map or a map for the self-interpreter's use (Symbol Table).
// The symbol table needs to map String -> Value.

struct Entry {
    key string;
    // value Value; // Value struct needs to be defined in self-interpreter
    // For now let's make it generic-ish by using interfaces?
    // Shlang interface "Any" { } (empty interface matches all structs?)
    // No, empty interface only matches structs. Primitives (int, string) are not structs.
    // So we need a wrapper struct for values if we use interfaces.
    // OR we just define specific maps: MapStringInt, MapStringValue.

    // Let's assume we are building the self-interpreter.
    // It needs `MapStringValue`.
}

// We need to define `Value` struct for the self-interpreter first.
// But let's verify map logic with Int first.

struct IntEntry {
    key string;
    val int;
    next IntEntry; // Linked list
}

struct IntMap {
    buckets []IntEntry;
    size int;
}

func createIntMap(capacity) {
    var m = new IntMap;
    m.size = capacity;
    m.buckets = make_array(capacity); // Array of IntEntry (which are structs, so pointers/references?)
    // In Host C++ interpreter, ArrayInstance holds Values.
    // new Struct returns a reference (shared_ptr).
    // So elements are initialized to VOID/null?
    // Arrays init to {TypeKind::INT, 0}.
    // We need to check if we can store structs in array.
    // Yes, Value variant has StructInstance.
    return m;
}

func hash(s) {
    var h = 0;
    var i = 0;
    var l = len(s);
    while (i < l) {
        var c = char_code_at(s, i);
        h = (h * 31) + c;
        i = i + 1;
    }
    if (h < 0) { h = 0 - h; }
    return h;
}

func mapPut(m, key, val) {
    var h = hash(key);
    var bucketIdx = h % m.size;

    var head = m.buckets[bucketIdx];

    // Simple prepend without check for now (allow duplicates for speed/lazy)
    // Or check?
    // If head is 0 (int), it's empty.
    // Host treats non-struct as false?
    // Wait, `var head = ...`. If it's 0, it's false?
    // I added `if (cond.type == TypeKind::INT) isTrue = std::get<int>(cond.data) != 0;`

    var entry = new IntEntry;
    entry.key = key;
    entry.val = val;
    // entry.next = head; // This fails if head is 0 (int) and next expects IntEntry struct?
    // Structural typing: next is `IntEntry`.
    // If head is INT 0, and we assign to next (IntEntry), what happens?
    // Interpreter doesn't check type on assignment rigidly in `eval` (Host).
    // It just copies Value.
    // So `next` becomes INT 0.
    // When we read `next`, we get INT 0.
    // Loop `while(curr)`: checks if curr is true. INT 0 is false.
    // So it works!

    entry.next = head;
    m.buckets[bucketIdx] = entry;
}

func mapGet(m, key) {
    var h = hash(key);
    var bucketIdx = h % m.size;
    var curr = m.buckets[bucketIdx];

    while (curr) {
        if (curr.key == key) {
            return curr.val;
        }
        curr = curr.next;
    }
    return -1; // Not found
}

func main() {
    var m = createIntMap(10);
    mapPut(m, "foo", 42);
    mapPut(m, "bar", 100);

    print(mapGet(m, "foo"));
    print(mapGet(m, "bar"));
    print(mapGet(m, "baz"));
    print("End");
}
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
// Lexer in Shlang

// Token Types (Constants)
var TOKEN_EOF = 0;
var TOKEN_IDENTIFIER = 1;
var TOKEN_NUMBER = 2;
var TOKEN_STRING = 3;
var TOKEN_LPAREN = 4;
var TOKEN_RPAREN = 5;
var TOKEN_LBRACE = 6;
var TOKEN_RBRACE = 7;
var TOKEN_PLUS = 8;
var TOKEN_MINUS = 9;
var TOKEN_STAR = 10;
var TOKEN_SLASH = 11;
var TOKEN_PERCENT = 12;
var TOKEN_EQUAL = 13;
var TOKEN_SEMICOLON = 14;
var TOKEN_IF = 15;
var TOKEN_ELSE = 16;
var TOKEN_WHILE = 17;
var TOKEN_FUNC = 18;
var TOKEN_VAR = 19;
var TOKEN_RETURN = 20;
var TOKEN_COMMA = 21;
var TOKEN_LESS = 22;
var TOKEN_STRUCT = 23;
var TOKEN_NEW = 24;
var TOKEN_DOT = 25;

struct Token {
    type int;
    text string;
    line int;
    col int;
}

struct Lexer {
    source string;
    pos int;
    line int;
    col int;
    tokens []Token;
}

func createLexer(src) {
    var l = new Lexer;
    l.source = src;
    l.pos = 0;
    l.line = 1;
    l.col = 1;
    l.tokens = make_array(0);
    return l;
}

func isDigit(c) {
    if (c >= 48) {
        if (c <= 57) {
            return 1; // true
        }
    }
    return 0; // false
}

func isAlpha(c) {
    // Simplified logic because Host lacks && / || operators in BinaryExpr!
    // Wait, Host has no boolean operators implemented in BinaryExpr?
    // Let's check interpreter.cpp
    // Ops: +, -, *, /, %, <, >, <=, >=, ==, !=
    // NO && or || implemented in Host!
    // I need to implement them in Host or use nested ifs in Shlang.

    if (c >= 65) { if (c <= 90) { return 1; } }
    if (c >= 97) { if (c <= 122) { return 1; } }
    if (c == 95) { return 1; }
    return 0;
}

func lex(l) {
    var lenSrc = len(l.source);
    while (l.pos < lenSrc) {
        var c = char_code_at(l.source, l.pos);
        var charStr = char_at(l.source, l.pos);

        // Check whitespace manually (no ||)
        var isSpace = 0;
        if (c == 32) { isSpace = 1; }
        if (c == 10) { isSpace = 1; }
        if (c == 9) { isSpace = 1; }
        if (c == 13) { isSpace = 1; }

        if (isSpace == 1) {
            if (c == 10) {
                l.line = l.line + 1;
                l.col = 1;
            } else {
                l.col = l.col + 1;
            }
            l.pos = l.pos + 1;
        } else if (isDigit(c)) {
             // Number
             var start = l.pos;
             var loopD = 1;
             while (loopD) {
                 if (l.pos >= lenSrc) { loopD = 0; }
                 else {
                     if (isDigit(char_code_at(l.source, l.pos))) {
                         l.pos = l.pos + 1;
                         l.col = l.col + 1;
                     } else {
                         loopD = 0;
                     }
                 }
             }
             var txt = string_slice(l.source, start, l.pos);
             var t = new Token;
             t.type = 2; t.text = txt; t.line = l.line; t.col = l.col;
             array_push(l.tokens, t);
        } else if (isAlpha(c)) {
             // Identifier or Keyword
             var start = l.pos;
             var loop = 1;
             while (loop) {
                 if (l.pos >= lenSrc) { loop = 0; }
                 else {
                     var cc = char_code_at(l.source, l.pos);
                     if (isAlpha(cc)) {
                         l.pos = l.pos + 1;
                         l.col = l.col + 1;
                     } else if (isDigit(cc)) {
                         l.pos = l.pos + 1;
                         l.col = l.col + 1;
                     } else {
                         loop = 0;
                     }
                 }
             }
             var txt = string_slice(l.source, start, l.pos);
             var type = 1; // TOKEN_IDENTIFIER
             // Use hardcoded values because global constants are not in scope?
             // Host interpreter lookup checks global scope?
             // "Undefined variable: TOKEN_IDENTIFIER" suggests scoping issue or lookup bug.
             // I'm in `lex(l)`. Globals are defined at top level.
             // Interpreter: `environment.push_back({}); // Global scope`
             // `define` puts in `environment.back()`.
             // `run` executes statements.
             // `functions` are handled separately?
             // `execute` defines globals.
             // If `lex` is called, we are in a new scope (Function Body).
             // `lookup` checks `i = environment.size() - 1` down to 0.
             // It should find globals.
             // Maybe `TOKEN_IDENTIFIER` wasn't defined properly?
             // `var TOKEN_IDENTIFIER = 1;`
             // Let's debug `interpreter.cpp` lookup?
             // Or maybe `main` runs before globals are defined?
             // No, standard execution order.
             // Wait, `test_map.sh` worked with functions.

             // Ah, `TOKEN_IDENTIFIER` error happened inside `lex`.
             // Why?
             // Maybe `TOKEN_FUNC` error confirms it.
             // I suspect globals are not being set correctly or overwritten?

             if (txt == "if") { type = 15; }
             else if (txt == "else") { type = 16; }
             else if (txt == "while") { type = 17; }
             else if (txt == "func") { type = 18; }
             else if (txt == "var") { type = 19; }
             else if (txt == "return") { type = 20; }
             else if (txt == "struct") { type = 23; }
             else if (txt == "new") { type = 24; }

             var t = new Token;
             t.type = type; t.text = txt; t.line = l.line; t.col = l.col;
             array_push(l.tokens, t);
        } else {
             var t = new Token;
             t.line = l.line; t.col = l.col;
             t.text = charStr;

             if (charStr == "+") { t.type = 8; }
             else if (charStr == "-") { t.type = 9; }
             else if (charStr == "*") { t.type = 10; }
             else if (charStr == "/") { t.type = 11; }
             else if (charStr == "(") { t.type = 4; }
             else if (charStr == ")") { t.type = 5; }
             else if (charStr == "{") { t.type = 6; }
             else if (charStr == "}") { t.type = 7; }
             else if (charStr == ";") { t.type = 14; }
             else if (charStr == "=") { t.type = 13; }
             else if (charStr == ",") { t.type = 21; }
             else if (charStr == "<") { t.type = 22; }
             else if (charStr == ".") { t.type = 25; }

             array_push(l.tokens, t);
             l.pos = l.pos + 1;
             l.col = l.col + 1;
        }
    }

    var eof = new Token;
    eof.type = 0;
    array_push(l.tokens, eof);
}

func main() {
    var src = "func main() { var x = 10; }";
    var l = createLexer(src);
    lex(l);

    var i = 0;
    while (i < len(l.tokens)) {
        var t = l.tokens[i];
        print(t.type, t.text);
        i = i + 1;
    }
}
// Parser in Shlang

struct Parser {
    tokens []Token;
    pos int;
    len int;
}

func createParser(tokens) {
    var p = new Parser;
    p.tokens = tokens;
    p.pos = 0;
    p.len = len(tokens);
    return p;
}

func peek(p) {
    if (p.pos >= p.len) {
        var t = new Token; t.type = 0; // EOF
        return t;
    }
    return p.tokens[p.pos];
}

func advance(p) {
    var t = peek(p);
    p.pos = p.pos + 1;
    return t;
}

func match(p, type) {
    var t = peek(p);
    if (t.type == type) {
        advance(p);
        return 1;
    }
    return 0;
}

func consume(p, type, msg) {
    if (match(p, type)) {
        return p.tokens[p.pos - 1];
    }
    print("Error:", msg);
    // exit? Host doesn't support exit.
    // Just return null/void and likely crash later or infinite loop.
    return p.tokens[p.pos]; // Fail
}

// Forward declarations? Shlang functions are hoisted?
// Host Interpreter: "Scan for functions ... functions[func->name] = func;"
// Yes, functions are hoisted.

func parseProgram(p) {
    var prog = new Program;
    prog.type = 0; // NODE_PROGRAM
    prog.statements = make_array(0);

    while (peek(p).type != 0) { // EOF
        var stmt = parseDeclaration(p);
        array_push(prog.statements, stmt);
    }
    return prog;
}

func parseDeclaration(p) {
    if (match(p, 18)) { // FUNC
        return parseFuncDecl(p);
    }
    if (match(p, 19)) { // VAR
        return parseVarDecl(p);
    }
    if (match(p, 23)) { // STRUCT
        return parseStructDecl(p);
    }
    return parseStatement(p);
}

func parseFuncDecl(p) {
    var f = new FuncDecl;
    f.type = 2;
    var id = consume(p, 1, "Expected func name");
    f.name = id.text;
    consume(p, 4, "Expected (");
    f.params = make_array(0);
    if (peek(p).type != 5) { // )
        var loop = 1;
        while (loop) {
            var param = consume(p, 1, "Expected param name");
            array_push(f.params, param.text);
            if (match(p, 21)) { } // comma
            else { loop = 0; }
        }
    }
    consume(p, 5, "Expected )");
    consume(p, 6, "Expected {");
    f.body = parseBlock(p);
    return f;
}

func parseVarDecl(p) {
    var v = new VarDecl;
    v.type = 1;
    var id = consume(p, 1, "Expected var name");
    v.name = id.text;
    if (match(p, 13)) { // =
        v.initializer = parseExpression(p);
    }
    match(p, 14); // ;
    return v;
}

func parseStructDecl(p) {
    var s = new StructDecl;
    s.type = 12; // NODE_STRUCT_DECL
    var id = consume(p, 1, "Expected struct name");
    s.name = id.text;
    consume(p, 6, "Expected {");
    s.fields = make_array(0);

    var loop = 1;
    while (loop) {
        if (peek(p).type == 7) { loop = 0; } // }
        else if (peek(p).type == 0) { loop = 0; }
        else {
            var fieldId = consume(p, 1, "Expected field name");
            array_push(s.fields, fieldId.text);

            // Type?
            // "x int;" or just "x;"?
            // "field type;"
            if (peek(p).type == 1) { // Type name (Identifier)
                consume(p, 1, "Expected Type");
            } else if (peek(p).type == 23) { // struct keyword as type?
                 // ignore
            }

            match(p, 14); // ; optional?
        }
    }
    consume(p, 7, "Expected }");
    return s;
}

func parseBlock(p) {
    var b = new Block;
    b.type = 3;
    b.statements = make_array(0);
    var loop = 1;
    while (loop) {
        if (peek(p).type == 7) { loop = 0; }
        else if (peek(p).type == 0) { loop = 0; }
        else {
            array_push(b.statements, parseDeclaration(p));
        }
    }
    consume(p, 7, "Expected }");
    return b;
}

func parseStatement(p) {
    if (match(p, 15)) { // IF
        return parseIf(p);
    }
    if (match(p, 17)) { // WHILE
        return parseWhile(p);
    }
    if (match(p, 20)) { // RETURN
        return parseReturn(p);
    }
    if (peek(p).type == 6) { // {
        consume(p, 6, "{");
        return parseBlock(p);
    }
    var expr = parseExpression(p);
    match(p, 14); // ;
    return expr;
}

func parseIf(p) {
    var s = new IfStmt;
    s.type = 4;
    consume(p, 4, "(");
    s.condition = parseExpression(p);
    consume(p, 5, ")");
    consume(p, 6, "{");
    s.thenBranch = parseBlock(p);
    if (match(p, 16)) { // ELSE
        if (peek(p).type == 15) { // IF
            // Else If -> Block wrapping if
            // For simplicity, just parseStatement (which parses If)
            // But Block expects list of statements.
            // Let's create a block
            var b = new Block; b.type = 3; b.statements = make_array(0);
            array_push(b.statements, parseStatement(p)); // recurses
            s.elseBranch = b;
        } else {
            consume(p, 6, "{");
            s.elseBranch = parseBlock(p);
        }
    }
    return s;
}

func parseWhile(p) {
    var s = new WhileStmt;
    s.type = 5;
    consume(p, 4, "(");
    s.condition = parseExpression(p);
    consume(p, 5, ")");
    consume(p, 6, "{");
    s.body = parseBlock(p);
    return s;
}

func parseReturn(p) {
    var s = new ReturnStmt;
    s.type = 6;
    if (peek(p).type != 14) { // ;
        s.value = parseExpression(p);
    }
    match(p, 14);
    return s;
}

func parseExpression(p) {
    return parseAssignment(p);
}

func parseAssignment(p) {
    var expr = parseTerm(p); // Skip equality for now to avoid complexity in test
    if (match(p, 13)) { // =
        var a = new Assignment;
        a.type = 7;
        a.target = expr; // check if identifier?
        a.value = parseAssignment(p);
        return a;
    }
    return expr;
}

func parseEquality(p) {
    var expr = parseComparison(p);
    // ... loop
    return expr;
}

func parseComparison(p) {
    var expr = parseTerm(p);
    // < > ...
    return expr;
}

func parseTerm(p) {
    var expr = parseFactor(p);
    // + -
    var loop = 1;
    while (loop) {
        var pt = peek(p).type;
        if (pt == 8) { // +
            var op = advance(p).text;
            var right = parseFactor(p);
            var b = new BinaryExpr;
            b.type = 8;
            b.op = op;
            b.left = expr;
            b.right = right;
            expr = b;
        } else if (pt == 9) { // -
            var op = advance(p).text;
            var right = parseFactor(p);
            var b = new BinaryExpr;
            b.type = 8;
            b.op = op;
            b.left = expr;
            b.right = right;
            expr = b;
        } else { loop = 0; }
    }
    return expr;
}

func parseFactor(p) {
    var expr = parseUnary(p);
    // * /
    return expr;
}

func parseUnary(p) {
    return parseCall(p);
}

func parseCall(p) {
    var expr = parsePrimary(p);
    var loop = 1;
    while (loop) {
        if (match(p, 4)) { // (
             var c = new CallExpr;
             c.type = 9;
             c.callee = expr;
             c.args = make_array(0);
             if (peek(p).type != 5) { // )
                 var loopArgs = 1;
                 while (loopArgs) {
                     array_push(c.args, parseExpression(p));
                     if (match(p, 21)) {
                        // comma
                     } else { loopArgs = 0; }
                 }
             }
             consume(p, 5, ")");
             expr = c;
        } else { loop = 0; }
    }
    return expr;
}

func parsePrimary(p) {
    if (peek(p).type == 2) { // Number
        var l = new Literal;
        l.type = 10;
        l.value = to_int(advance(p).text);
        return l;
    }
    if (peek(p).type == 1) { // Identifier
        var id = new Identifier;
        id.type = 11;
        id.name = advance(p).text;
        return id;
    }
    if (peek(p).type == 24) { // NEW
        advance(p); // eat new
        var structName = consume(p, 1, "Expected struct name").text;
        // Should return a NewStruct node?
        // We reused CallExpr in Host parser for `new Struct`? No, Host has NewStruct node.
        // But Host parser logic for `new` returns `NewStruct`.
        // I need `NODE_NEW_STRUCT`. I don't have it in `ast.sh`.
        // I'll add it to AST logic later.
        // For now, I'll return a "Call" with special name "$new$Name"?
        // Or just `CallExpr` with `callee = Identifier(structName)`.
        // In interpreter, if `callee` is struct type, treat as new?
        // Let's add NODE_NEW_STRUCT (13).

        // Wait, AST.sh: `var NODE_STRUCT_DECL = 12;`.
        // Let's use 13 for NEW_STRUCT.
        var ns = new Identifier; // Reuse identifier struct? No, need struct name.
        // Actually NewStruct node just needs name. Identifier struct has name.
        ns.type = 13;
        ns.name = structName;
        return ns;
    }
    // ...
    return 0; // Error
}
// Interpreter in Shlang

struct Context {
    env any; // Map of vars
    funcs any; // Map of funcs
    structs any; // Map of structs
}

func interpret(node, ctx) {
    if (node.type == 0) { // Program
         var i = 0;
         while (i < len(node.statements)) {
             var stmt = node.statements[i];
             interpret(stmt, ctx);
             i = i + 1;
         }
    } else if (node.type == 1) { // VarDecl
         var val = 0;
         if (node.initializer) {
             val = interpret(node.initializer, ctx);
         }
         mapPut(ctx.env, node.name, val);
    } else if (node.type == 2) { // FuncDecl
         mapPut(ctx.funcs, node.name, node);
    } else if (node.type == 12) { // StructDecl
         mapPut(ctx.structs, node.name, node);
    } else if (node.type == 3) { // Block
         var i = 0;
         while (i < len(node.statements)) {
             interpret(node.statements[i], ctx);
             i = i + 1;
         }
    } else if (node.type == 9) { // Call
         // Check native
         var name = node.callee.name;
         if (name == "print") {
             var val = interpret(node.args[0], ctx);
             print(val);
         } else {
             // User func
             var decl = mapGet(ctx.funcs, name);
             if (decl) {
                 // New scope?
                 // For simplified self-interpreter, assume global scope or pass new ctx
                 // Need to bind args
                 interpret(decl.body, ctx);
             }
         }
    } else if (node.type == 10) { // Literal
         return node.value;
    } else if (node.type == 11) { // Identifier
         return mapGet(ctx.env, node.name);
    } else if (node.type == 13) { // New Struct
         // Look up struct decl?
         // var decl = mapGet(ctx.structs, node.name);
         // For dynamic interpreter, we just need to return an instance.
         // In Shlang, how do we represent an "Instance"?
         // A Map? `MapStringAny`.
         // Or just a Host Struct?
         // `new Struct` in Host returns `StructInstance`.
         // In Self-Interpreter (Shlang), `new Struct` is executed.
         // We can return a Map (representing fields).
         var instance = createIntMap(10); // Using IntMap but storing Any
         return instance;
    }
    // ...
}

func main() {
    print("Starting Self-Interpreter...");
    var src = "func main() { var x = 42; print(x); }";
    var l = createLexer(src);
    lex(l);

    // Debug token output
    // var i = 0; while (i < len(l.tokens)) { print(l.tokens[i].text); i = i + 1; }

    var p = createParser(l.tokens);
    var prog = parseProgram(p);
    print("Parsed Program.");

    var ctx = new Context;
    ctx.env = createIntMap(10);
    ctx.funcs = createIntMap(10);
    ctx.structs = createIntMap(10);
    // My Map implementation `IntMap` uses `int` for value.
    // I need `AnyMap` or `ValueMap`.
    // Structural typing: `interpret` expects `mapPut` to take `val`.
    // `IntEntry` expects `int`.
    // `Prog` is a struct (pointer). `int` can hold pointer?
    // In Host, `Value` is variant. `int` is `TypeKind::INT`. `shared_ptr` is `TypeKind::STRUCT`.
    // `IntEntry.val` is declared as `int`.
    // If I assign a Struct to it?
    // Host Interpreter `define`: `val` is Value.
    // `struct IntEntry { val int; }`.
    // `eval` of `entry.val = val`:
    // `val` (RHS) is Struct (FuncDecl).
    // `entry.val` (LHS) is Int.
    // Host doesn't enforce types on assignment (except my `checkNode` in TypeChecker which is not running during `eval`).
    // `Interpreter::eval` ASSIGNMENT just copies.
    // `ptr->fields[ma->member] = val;`
    // It updates the field in the map.
    // So `IntEntry` effectively becomes dynamic!
    // So `createIntMap` works for Any!

    interpret(prog, ctx);

    // Run main
    var mainFunc = mapGet(ctx.funcs, "main");
    if (mainFunc) {
        print("Running main...");
        interpret(mainFunc.body, ctx);
    } else {
        print("Main not found!");
    }
}
