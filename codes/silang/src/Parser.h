#ifndef SILANG_PARSER_H
#define SILANG_PARSER_H

#include "Lexer.h"
#include "AST.h"
#include <vector>
#include <memory>

namespace silang {

class Parser {
public:
    Parser(const std::vector<Token>& tokens);
    std::shared_ptr<Program> parse();

private:
    const std::vector<Token>& tokens;
    int current = 0;

    std::shared_ptr<Stmt> declaration();
    std::shared_ptr<Stmt> funcDecl();
    std::shared_ptr<Stmt> structDecl();
    std::shared_ptr<Stmt> varDecl();
    std::shared_ptr<Stmt> statement();
    std::shared_ptr<Stmt> block();
    std::shared_ptr<Stmt> ifStmt();
    std::shared_ptr<Stmt> whileStmt();
    std::shared_ptr<Stmt> returnStmt();
    std::shared_ptr<Stmt> exprStmt();

    std::shared_ptr<Expr> expression();
    std::shared_ptr<Expr> equality();
    std::shared_ptr<Expr> comparison();
    std::shared_ptr<Expr> term();
    std::shared_ptr<Expr> factor();
    std::shared_ptr<Expr> unary();
    std::shared_ptr<Expr> call();
    std::shared_ptr<Expr> primary();

    bool match(TokenType type);
    bool check(TokenType type);
    Token advance();
    Token peek();
    Token previous();
    bool isAtEnd();
    Type parseType();
};

}

#endif
