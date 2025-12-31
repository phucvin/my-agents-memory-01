#ifndef SILANG_LEXER_H
#define SILANG_LEXER_H

#include <string>
#include <vector>
#include <iostream>

namespace silang {

enum class TokenType {
    // Keywords
    STRUCT, FUNC, INT, BOOL, STRING, VOID, IF, ELSE, WHILE, RETURN,
    TRUE, FALSE, NEW,

    // Identifiers and Literals
    IDENTIFIER, NUMBER, STRING_LITERAL,

    // Operators
    PLUS, MINUS, STAR, SLASH, PERCENT,
    EQUAL, EQUAL_EQUAL, BANG, BANG_EQUAL,
    LESS, LESS_EQUAL, GREATER, GREATER_EQUAL,
    AMP_AMP, PIPE_PIPE,

    // Delimiters
    LPAREN, RPAREN, LBRACE, RBRACE, LBRACKET, RBRACKET,
    COMMA, SEMICOLON, DOT, COLON,

    // Special
    END_OF_FILE, UNKNOWN
};

struct Token {
    TokenType type;
    std::string text;
    int line;
};

class Lexer {
public:
    Lexer(const std::string& source);
    std::vector<Token> scanTokens();

private:
    std::string source;
    std::vector<Token> tokens;
    int start = 0;
    int current = 0;
    int line = 1;

    bool isAtEnd();
    char advance();
    bool match(char expected);
    char peek();
    char peekNext();
    void addToken(TokenType type);
    void addToken(TokenType type, std::string text);
    void string();
    void number();
    void identifier();
    bool isAlpha(char c);
    bool isAlphaNumeric(char c);
};

}

#endif
