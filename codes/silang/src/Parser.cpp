#include "Parser.h"
#include <iostream>

namespace silang {

Parser::Parser(const std::vector<Token>& tokens) : tokens(tokens) {}

std::shared_ptr<Program> Parser::parse() {
    auto program = std::make_shared<Program>();
    try {
        while (!check(TokenType::END_OF_FILE)) {
            program->statements.push_back(declaration());
        }
    } catch (std::exception& e) {
        std::cerr << "Parse Error: " << e.what() << " at line " << peek().line << std::endl;
        return nullptr;
    }
    return program;
}

std::shared_ptr<Stmt> Parser::declaration() {
    if (match(TokenType::STRUCT)) return structDecl();

    // Check for "func" keyword if we want that syntax, but README uses C-style.
    // "int add(...)"
    // We need to parse a type, then see what follows.
    // But we can't easily peek a whole type (generics).
    // So we parse type, then check next token.

    // Backtracking or lookahead is needed.
    // Let's implement a simple backtracking: save current index.

    int saved = current;
    try {
        Type t = parseType();
        if (check(TokenType::IDENTIFIER)) {
            // Need to consume identifier to be consistent with varDecl/funcDecl expectation if we passed control?
            // Actually funcDecl expects Type and Name to be consumed or passed?
            // Existing funcDecl implementation:
            // Type returnType = parseType();
            // Token name = advance();
            // So if we call it, we must ensure we are at start.
            // But we already parsed Type.

            // We need to implement logic here or Refactor funcDecl/varDecl to take Type and Name.
            // Let's refactor funcDecl/varDecl to take Type.
            // But varDecl also parses name.

            Token nameToken = advance();
            std::string name = nameToken.text;

            if (check(TokenType::LPAREN)) {
                // Function
                match(TokenType::LPAREN);
                std::vector<std::pair<std::string, Type>> params;
                if (!check(TokenType::RPAREN)) {
                    do {
                        Type pt = parseType();
                        Token pn = advance();
                        if (pn.type != TokenType::IDENTIFIER) throw std::runtime_error("Expected param name");
                        params.push_back({pn.text, pt});
                    } while (match(TokenType::COMMA));
                }
                match(TokenType::RPAREN);
                if (!match(TokenType::LBRACE)) throw std::runtime_error("Expected { before func body");
                std::shared_ptr<Stmt> body = block();
                return std::make_shared<FuncDeclStmt>(name, params, t, body);
            } else if (check(TokenType::EQUAL) || check(TokenType::SEMICOLON)) {
                // It's a variable!
                current = saved;
                return varDecl();
            } else if (check(TokenType::DOT)) {
                // Could be identifier starting a statement? "x.y = 1;" where x is a type? No.
                // If it was just an identifier used as type "MyStruct s;", it falls into varDecl.
                // If "x = 1;" where x is existing var, it's a statement.
                // But "x" matches parseType() if it's an identifier.
                // So "x = 1;" -> Type(x) Name(=) -> Fail.
                // If parseType succeeded, and next is =, it expects identifier name.
            }
        }
    } catch (...) {
        // Not a type declaration start, maybe a statement?
    }

    current = saved;
    return statement();
}

// Helper to handle the already parsed parts?
// Easier to just rewrite logic.

// Special logic for declaration:
// Top level elements are FuncDecl, StructDecl, VarDecl, or Stmt (though usually C doesn't allow random stmts at global scope, script langs do).
// Let's allow statements.

std::shared_ptr<Stmt> Parser::structDecl() {
    Token name = advance();
    if (name.type != TokenType::IDENTIFIER) throw std::runtime_error("Expected struct name");
    if (!match(TokenType::LBRACE)) throw std::runtime_error("Expected {");

    std::vector<std::pair<std::string, Type>> fields;
    while (!check(TokenType::RBRACE) && !isAtEnd()) {
        Type t = parseType();
        Token n = advance();
        if (n.type != TokenType::IDENTIFIER) throw std::runtime_error("Expected field name");
        if (!match(TokenType::SEMICOLON)) throw std::runtime_error("Expected ; after field");
        fields.push_back({n.text, t});
    }
    match(TokenType::RBRACE);
    return std::make_shared<StructDeclStmt>(name.text, fields);
}

std::shared_ptr<Stmt> Parser::funcDecl() {
    // We are called from declaration(). We need to re-parse or use saved.
    // Let's assume declaration called us with `current` reset.
    Type returnType = parseType();
    Token name = advance(); // Validated in declaration
    match(TokenType::LPAREN);

    std::vector<std::pair<std::string, Type>> params;
    if (!check(TokenType::RPAREN)) {
        do {
            Type t = parseType();
            Token n = advance();
            if (n.type != TokenType::IDENTIFIER) throw std::runtime_error("Expected param name");
            params.push_back({n.text, t});
        } while (match(TokenType::COMMA));
    }
    match(TokenType::RPAREN);

    if (!match(TokenType::LBRACE)) throw std::runtime_error("Expected { before func body");
    std::shared_ptr<Stmt> body = block();

    return std::make_shared<FuncDeclStmt>(name.text, params, returnType, body);
}

std::shared_ptr<Stmt> Parser::varDecl() {
    Type type = parseType();
    Token name = advance();
    std::shared_ptr<Expr> init = nullptr;
    if (match(TokenType::EQUAL)) {
        init = expression();
    }
    match(TokenType::SEMICOLON);
    return std::make_shared<VarDeclStmt>(name.text, type, init);
}

std::shared_ptr<Stmt> Parser::statement() {
    if (match(TokenType::IF)) return ifStmt();
    if (match(TokenType::WHILE)) return whileStmt();
    if (match(TokenType::RETURN)) return returnStmt();
    if (match(TokenType::LBRACE)) return block();

    // Try VarDecl here too? (Local variables)
    int saved = current;
    try {
        Type t = parseType();
        if (check(TokenType::IDENTIFIER)) {
            // Check if it looks like a declaration "Type id;" or "Type id ="
            Token next = peek(); // Identifier
             // We need to look ahead of the identifier.
             if (current + 1 < tokens.size()) {
                 TokenType afterId = tokens[current+1].type;
                 if (afterId == TokenType::SEMICOLON || afterId == TokenType::EQUAL) {
                     current = saved;
                     return varDecl();
                 }
             }
        }
    } catch (...) {}
    current = saved;

    return exprStmt();
}

std::shared_ptr<Stmt> Parser::block() {
    std::vector<std::shared_ptr<Stmt>> statements;
    while (!check(TokenType::RBRACE) && !isAtEnd()) {
        statements.push_back(statement());
    }
    match(TokenType::RBRACE);
    return std::make_shared<BlockStmt>(statements);
}

std::shared_ptr<Stmt> Parser::ifStmt() {
    match(TokenType::LPAREN);
    std::shared_ptr<Expr> condition = expression();
    match(TokenType::RPAREN);
    std::shared_ptr<Stmt> thenBranch = statement();
    std::shared_ptr<Stmt> elseBranch = nullptr;
    if (match(TokenType::ELSE)) {
        elseBranch = statement();
    }
    return std::make_shared<IfStmt>(condition, thenBranch, elseBranch);
}

std::shared_ptr<Stmt> Parser::whileStmt() {
    match(TokenType::LPAREN);
    std::shared_ptr<Expr> condition = expression();
    match(TokenType::RPAREN);
    std::shared_ptr<Stmt> body = statement();
    return std::make_shared<WhileStmt>(condition, body);
}

std::shared_ptr<Stmt> Parser::returnStmt() {
    std::shared_ptr<Expr> value = nullptr;
    if (!check(TokenType::SEMICOLON)) {
        value = expression();
    }
    match(TokenType::SEMICOLON);
    return std::make_shared<ReturnStmt>(value);
}

std::shared_ptr<Stmt> Parser::exprStmt() {
    std::shared_ptr<Expr> expr = expression();
    match(TokenType::SEMICOLON);
    return std::make_shared<ExprStmt>(expr);
}

std::shared_ptr<Expr> Parser::expression() {
    return assignment();
}

std::shared_ptr<Expr> Parser::assignment() {
    std::shared_ptr<Expr> expr = logicOr();

    if (match(TokenType::EQUAL)) {
        std::shared_ptr<Expr> value = assignment();
        return std::make_shared<BinaryExpr>(expr, Op::ASSIGN, value);
    }
    return expr;
}

std::shared_ptr<Expr> Parser::logicOr() {
    std::shared_ptr<Expr> expr = logicAnd();
    while (match(TokenType::PIPE_PIPE)) {
        std::shared_ptr<Expr> right = logicAnd();
        expr = std::make_shared<BinaryExpr>(expr, Op::OR, right);
    }
    return expr;
}

std::shared_ptr<Expr> Parser::logicAnd() {
    std::shared_ptr<Expr> expr = equality();
    while (match(TokenType::AMP_AMP)) {
        std::shared_ptr<Expr> right = equality();
        expr = std::make_shared<BinaryExpr>(expr, Op::AND, right);
    }
    return expr;
}

std::shared_ptr<Expr> Parser::equality() {
    std::shared_ptr<Expr> expr = comparison();
    while (match(TokenType::EQUAL_EQUAL) || match(TokenType::BANG_EQUAL)) {
        Op op = previous().type == TokenType::EQUAL_EQUAL ? Op::EQ : Op::NEQ;
        std::shared_ptr<Expr> right = comparison();
        expr = std::make_shared<BinaryExpr>(expr, op, right);
    }
    return expr;
}

std::shared_ptr<Expr> Parser::comparison() {
    std::shared_ptr<Expr> expr = term();
    while (match(TokenType::GREATER) || match(TokenType::GREATER_EQUAL) ||
           match(TokenType::LESS) || match(TokenType::LESS_EQUAL)) {
        Op op;
        TokenType t = previous().type;
        if (t == TokenType::GREATER) op = Op::GT;
        else if (t == TokenType::GREATER_EQUAL) op = Op::GE;
        else if (t == TokenType::LESS) op = Op::LT;
        else op = Op::LE;
        std::shared_ptr<Expr> right = term();
        expr = std::make_shared<BinaryExpr>(expr, op, right);
    }
    return expr;
}

std::shared_ptr<Expr> Parser::term() {
    std::shared_ptr<Expr> expr = factor();
    while (match(TokenType::MINUS) || match(TokenType::PLUS)) {
        Op op = previous().type == TokenType::MINUS ? Op::SUB : Op::ADD;
        std::shared_ptr<Expr> right = factor();
        expr = std::make_shared<BinaryExpr>(expr, op, right);
    }
    return expr;
}

std::shared_ptr<Expr> Parser::factor() {
    std::shared_ptr<Expr> expr = unary();
    while (match(TokenType::SLASH) || match(TokenType::STAR) || match(TokenType::PERCENT)) {
        Op op;
        TokenType t = previous().type;
        if (t == TokenType::SLASH) op = Op::DIV;
        else if (t == TokenType::STAR) op = Op::MUL;
        else op = Op::MOD;
        std::shared_ptr<Expr> right = unary();
        expr = std::make_shared<BinaryExpr>(expr, op, right);
    }
    return expr;
}

std::shared_ptr<Expr> Parser::unary() {
    if (match(TokenType::BANG) || match(TokenType::MINUS)) {
        Op op = previous().type == TokenType::BANG ? Op::NOT : Op::SUB;
        std::shared_ptr<Expr> right = unary();
        return std::make_shared<UnaryExpr>(op, right);
    }
    return call(); // Call handles primary and suffixes (call, dot, index)
}

std::shared_ptr<Expr> Parser::call() {
    std::shared_ptr<Expr> expr = primary();

    while (true) {
        if (match(TokenType::LPAREN)) {
            std::vector<std::shared_ptr<Expr>> args;
            if (!check(TokenType::RPAREN)) {
                do {
                    args.push_back(expression());
                } while (match(TokenType::COMMA));
            }
            match(TokenType::RPAREN);
            expr = std::make_shared<CallExpr>(expr, args);
        } else if (match(TokenType::DOT)) {
            Token name = advance();
            if (name.type != TokenType::IDENTIFIER) throw std::runtime_error("Expected property name after .");
            expr = std::make_shared<MemberAccessExpr>(expr, name.text);
        } else if (match(TokenType::LBRACKET)) {
            std::shared_ptr<Expr> index = expression();
            match(TokenType::RBRACKET);
            expr = std::make_shared<IndexExpr>(expr, index);
        } else {
            break;
        }
    }
    return expr;
}

std::shared_ptr<Expr> Parser::primary() {
    if (match(TokenType::FALSE)) return std::make_shared<LiteralExpr>(false);
    if (match(TokenType::TRUE)) return std::make_shared<LiteralExpr>(true);
    if (match(TokenType::NUMBER)) {
        return std::make_shared<LiteralExpr>(std::stoi(previous().text));
    }
    if (match(TokenType::STRING_LITERAL)) {
        return std::make_shared<LiteralExpr>(previous().text);
    }
    if (match(TokenType::IDENTIFIER)) {
        return std::make_shared<VariableExpr>(previous().text);
    }
    if (match(TokenType::LBRACKET)) {
        // Array literal [1, 2]
        std::vector<std::shared_ptr<Expr>> elements;
        if (!check(TokenType::RBRACKET)) {
            do {
                elements.push_back(expression());
            } while (match(TokenType::COMMA));
        }
        match(TokenType::RBRACKET);
        return std::make_shared<ArrayLiteralExpr>(elements);
    }
    if (match(TokenType::LPAREN)) {
        std::shared_ptr<Expr> expr = expression();
        match(TokenType::RPAREN);
        return expr;
    }

    throw std::runtime_error("Expect expression.");
}

Type Parser::parseType() {
    Type t;
    if (match(TokenType::INT)) t.name = "int";
    else if (match(TokenType::BOOL)) t.name = "bool";
    else if (match(TokenType::STRING)) t.name = "string";
    else if (match(TokenType::VOID)) t.name = "void";
    else if (match(TokenType::IDENTIFIER)) {
        t.name = previous().text;
        // Check for generics: Map<K, V> or Array<T>
        if (t.name == "Array" && match(TokenType::LESS)) {
            t.is_array = true;
            t.inner = std::make_shared<Type>(parseType());
            if (!match(TokenType::GREATER)) throw std::runtime_error("Expected > after array type");
        } else if (t.name == "Map" && match(TokenType::LESS)) {
            t.is_map = true;
            t.key_type = std::make_shared<Type>(parseType());
            if (!match(TokenType::COMMA)) throw std::runtime_error("Expected , in map type");
            t.value_type = std::make_shared<Type>(parseType());
            if (!match(TokenType::GREATER)) throw std::runtime_error("Expected > after map type");
        }
    } else {
        throw std::runtime_error("Expected type");
    }
    return t;
}

bool Parser::match(TokenType type) {
    if (check(type)) {
        advance();
        return true;
    }
    return false;
}

bool Parser::check(TokenType type) {
    if (isAtEnd()) return type == TokenType::END_OF_FILE;
    return peek().type == type;
}

Token Parser::advance() {
    if (!isAtEnd()) current++;
    return previous();
}

bool Parser::isAtEnd() {
    return peek().type == TokenType::END_OF_FILE;
}

Token Parser::peek() {
    return tokens[current];
}

Token Parser::previous() {
    return tokens[current - 1];
}

}
