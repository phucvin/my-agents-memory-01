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
