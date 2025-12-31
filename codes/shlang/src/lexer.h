#ifndef LEXER_H
#define LEXER_H

#include <string>
#include <vector>
#include <iostream>

enum class TokenType {
    // Keywords
    FUNC, RETURN, VAR, IF, ELSE, WHILE, STRUCT, INTERFACE, NEW,

    // Literals
    IDENTIFIER, NUMBER, STRING_LIT, TRUE, FALSE,

    // Operators
    PLUS, MINUS, STAR, SLASH, PERCENT, EQUAL, EQUAL_EQUAL, BANG_EQUAL,
    LESS, LESS_EQUAL, GREATER, GREATER_EQUAL,
    DOT, COMMA, SEMICOLON, COLON,

    // Brackets
    LPAREN, RPAREN, LBRACE, RBRACE, LBRACKET, RBRACKET,

    // End of File
    EOF_TOKEN,

    // Unknown
    UNKNOWN
};

struct Token {
    TokenType type;
    std::string text;
    int line;
    int col;
};

class Lexer {
public:
    Lexer(const std::string& source);
    std::vector<Token> tokenize();

private:
    std::string source;
    size_t pos;
    int line;
    int col;

    char peek(int offset = 0);
    char advance();
    bool match(char expected);
    void skipWhitespace();

    Token string();
    Token number();
    Token identifier();
};

std::string tokenTypeToString(TokenType type);

#endif
