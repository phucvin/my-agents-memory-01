#include "lexer.h"
#include <map>
#include <cctype>

Lexer::Lexer(const std::string& src) : source(src), pos(0), line(1), col(1) {}

char Lexer::peek(int offset) {
    if (pos + offset >= source.length()) return '\0';
    return source[pos + offset];
}

char Lexer::advance() {
    char current = peek();
    pos++;
    if (current == '\n') {
        line++;
        col = 1;
    } else {
        col++;
    }
    return current;
}

bool Lexer::match(char expected) {
    if (peek() == expected) {
        advance();
        return true;
    }
    return false;
}

void Lexer::skipWhitespace() {
    while (true) {
        char c = peek();
        if (std::isspace(c)) {
            advance();
        } else if (c == '/' && peek(1) == '/') {
            // Comment
            while (peek() != '\n' && peek() != '\0') advance();
        } else {
            break;
        }
    }
}

Token Lexer::string() {
    std::string text = "";
    advance(); // Skip opening quote
    while (peek() != '"' && peek() != '\0') {
        text += advance();
    }
    if (peek() == '"') advance();
    return {TokenType::STRING_LIT, text, line, col};
}

Token Lexer::number() {
    std::string text = "";
    while (std::isdigit(peek())) {
        text += advance();
    }
    return {TokenType::NUMBER, text, line, col};
}

Token Lexer::identifier() {
    std::string text = "";
    while (std::isalnum(peek()) || peek() == '_') {
        text += advance();
    }

    static std::map<std::string, TokenType> keywords = {
        {"func", TokenType::FUNC},
        {"return", TokenType::RETURN},
        {"var", TokenType::VAR},
        {"if", TokenType::IF},
        {"else", TokenType::ELSE},
        {"while", TokenType::WHILE},
        {"struct", TokenType::STRUCT},
        {"interface", TokenType::INTERFACE},
        {"true", TokenType::TRUE},
        {"false", TokenType::FALSE},
        {"new", TokenType::NEW}
    };

    if (keywords.count(text)) {
        return {keywords[text], text, line, col};
    }
    return {TokenType::IDENTIFIER, text, line, col};
}

std::vector<Token> Lexer::tokenize() {
    std::vector<Token> tokens;
    while (peek() != '\0') {
        skipWhitespace();
        if (peek() == '\0') break;

        char c = peek();
        if (std::isdigit(c)) {
            tokens.push_back(number());
        } else if (std::isalpha(c) || c == '_') {
            tokens.push_back(identifier());
        } else if (c == '"') {
            tokens.push_back(string());
        } else {
            int startLine = line;
            int startCol = col;
            TokenType type = TokenType::UNKNOWN;
            std::string text(1, c);
            advance();

            switch (c) {
                case '+': type = TokenType::PLUS; break;
                case '-': type = TokenType::MINUS; break;
                case '*': type = TokenType::STAR; break;
                case '/': type = TokenType::SLASH; break;
                case '%': type = TokenType::PERCENT; break;
                case '(': type = TokenType::LPAREN; break;
                case ')': type = TokenType::RPAREN; break;
                case '{': type = TokenType::LBRACE; break;
                case '}': type = TokenType::RBRACE; break;
                case '[': type = TokenType::LBRACKET; break;
                case ']': type = TokenType::RBRACKET; break;
                case ',': type = TokenType::COMMA; break;
                case '.': type = TokenType::DOT; break;
                case ';': type = TokenType::SEMICOLON; break;
                case ':': type = TokenType::COLON; break;
                case '=':
                    type = match('=') ? TokenType::EQUAL_EQUAL : TokenType::EQUAL;
                    if (type == TokenType::EQUAL_EQUAL) text = "==";
                    break;
                case '!':
                    type = match('=') ? TokenType::BANG_EQUAL : TokenType::UNKNOWN;
                    if (type == TokenType::BANG_EQUAL) text = "!=";
                    break;
                case '<':
                    type = match('=') ? TokenType::LESS_EQUAL : TokenType::LESS;
                    if (type == TokenType::LESS_EQUAL) text = "<=";
                    break;
                case '>':
                    type = match('=') ? TokenType::GREATER_EQUAL : TokenType::GREATER;
                    if (type == TokenType::GREATER_EQUAL) text = ">=";
                    break;
            }
            tokens.push_back({type, text, startLine, startCol});
        }
    }
    tokens.push_back({TokenType::EOF_TOKEN, "", line, col});
    return tokens;
}

std::string tokenTypeToString(TokenType type) {
    switch (type) {
        case TokenType::FUNC: return "FUNC";
        case TokenType::IDENTIFIER: return "IDENTIFIER";
        case TokenType::NUMBER: return "NUMBER";
        case TokenType::STRING_LIT: return "STRING";
        case TokenType::EOF_TOKEN: return "EOF";
        // ... add others if needed for debugging
        default: return "TOKEN";
    }
}
