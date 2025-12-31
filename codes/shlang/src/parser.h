#ifndef PARSER_H
#define PARSER_H

#include "lexer.h"
#include "ast.h"
#include <vector>
#include <memory>
#include <string>

class Parser {
public:
    Parser(const std::vector<Token>& tokens);
    std::shared_ptr<Program> parse();

private:
    std::vector<Token> tokens;
    size_t pos;

    Token peek(int offset = 0);
    Token advance();
    bool match(TokenType type);
    Token consume(TokenType type, std::string errorMsg);

    std::shared_ptr<ASTNode> declaration();
    std::shared_ptr<ASTNode> funcDeclaration();
    std::shared_ptr<ASTNode> varDeclaration();
    std::shared_ptr<ASTNode> structDeclaration();
    std::shared_ptr<ASTNode> interfaceDeclaration();

    std::shared_ptr<Type> parseType();

    std::shared_ptr<ASTNode> statement();
    std::shared_ptr<Block> block();
    std::shared_ptr<ASTNode> ifStatement();
    std::shared_ptr<ASTNode> whileStatement();
    std::shared_ptr<ASTNode> returnStatement();

    std::shared_ptr<ASTNode> expression();
    std::shared_ptr<ASTNode> assignment();
    std::shared_ptr<ASTNode> equality();
    std::shared_ptr<ASTNode> comparison();
    std::shared_ptr<ASTNode> term();
    std::shared_ptr<ASTNode> factor();
    std::shared_ptr<ASTNode> unary();
    std::shared_ptr<ASTNode> call();
    std::shared_ptr<ASTNode> primary();
};

#endif
