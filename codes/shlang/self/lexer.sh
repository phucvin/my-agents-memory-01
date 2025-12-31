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
