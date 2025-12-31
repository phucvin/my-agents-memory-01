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
