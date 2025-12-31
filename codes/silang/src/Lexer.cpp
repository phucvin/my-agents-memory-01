#include "Lexer.h"
#include <map>

namespace silang {

Lexer::Lexer(const std::string& source) : source(source) {}

std::vector<Token> Lexer::scanTokens() {
    while (!isAtEnd()) {
        start = current;
        char c = advance();
        switch (c) {
            case '(': addToken(TokenType::LPAREN); break;
            case ')': addToken(TokenType::RPAREN); break;
            case '{': addToken(TokenType::LBRACE); break;
            case '}': addToken(TokenType::RBRACE); break;
            case '[': addToken(TokenType::LBRACKET); break;
            case ']': addToken(TokenType::RBRACKET); break;
            case ',': addToken(TokenType::COMMA); break;
            case '.': addToken(TokenType::DOT); break;
            case ';': addToken(TokenType::SEMICOLON); break;
            case ':': addToken(TokenType::COLON); break;
            case '+': addToken(TokenType::PLUS); break;
            case '-': addToken(TokenType::MINUS); break;
            case '*': addToken(TokenType::STAR); break;
            case '%': addToken(TokenType::PERCENT); break;
            case '!': addToken(match('=') ? TokenType::BANG_EQUAL : TokenType::BANG); break;
            case '=': addToken(match('=') ? TokenType::EQUAL_EQUAL : TokenType::EQUAL); break;
            case '<': addToken(match('=') ? TokenType::LESS_EQUAL : TokenType::LESS); break;
            case '>': addToken(match('=') ? TokenType::GREATER_EQUAL : TokenType::GREATER); break;
            case '&': if (match('&')) addToken(TokenType::AMP_AMP); break;
            case '|': if (match('|')) addToken(TokenType::PIPE_PIPE); break;
            case '/':
                if (match('/')) {
                    while (peek() != '\n' && !isAtEnd()) advance();
                } else {
                    addToken(TokenType::SLASH);
                }
                break;
            case ' ':
            case '\r':
            case '\t':
                break;
            case '\n':
                line++;
                break;
            case '"': string(); break;
            default:
                if (isdigit(c)) {
                    number();
                } else if (isAlpha(c)) {
                    identifier();
                } else {
                   // Error or ignore
                }
                break;
        }
    }
    tokens.push_back({TokenType::END_OF_FILE, "", line});
    return tokens;
}

bool Lexer::isAtEnd() {
    return current >= source.length();
}

char Lexer::advance() {
    return source[current++];
}

bool Lexer::match(char expected) {
    if (isAtEnd()) return false;
    if (source[current] != expected) return false;
    current++;
    return true;
}

char Lexer::peek() {
    if (isAtEnd()) return '\0';
    return source[current];
}

char Lexer::peekNext() {
    if (current + 1 >= source.length()) return '\0';
    return source[current + 1];
}

void Lexer::addToken(TokenType type) {
    addToken(type, source.substr(start, current - start));
}

void Lexer::addToken(TokenType type, std::string text) {
    tokens.push_back({type, text, line});
}

void Lexer::string() {
    while (peek() != '"' && !isAtEnd()) {
        if (peek() == '\n') line++;
        advance();
    }

    if (isAtEnd()) {
        // Unterminated string
        return;
    }

    advance(); // Closing "
    std::string value = source.substr(start + 1, current - start - 2);
    addToken(TokenType::STRING_LITERAL, value);
}

void Lexer::number() {
    while (isdigit(peek())) advance();
    addToken(TokenType::NUMBER);
}

void Lexer::identifier() {
    while (isAlphaNumeric(peek())) advance();

    std::string text = source.substr(start, current - start);
    TokenType type = TokenType::IDENTIFIER;

    static const std::map<std::string, TokenType> keywords = {
        {"struct", TokenType::STRUCT},
        {"func", TokenType::FUNC},
        {"int", TokenType::INT},
        {"bool", TokenType::BOOL},
        {"string", TokenType::STRING},
        {"void", TokenType::VOID},
        {"if", TokenType::IF},
        {"else", TokenType::ELSE},
        {"while", TokenType::WHILE},
        {"return", TokenType::RETURN},
        {"true", TokenType::TRUE},
        {"false", TokenType::FALSE},
        {"new", TokenType::NEW}
    };

    if (keywords.find(text) != keywords.end()) {
        type = keywords.at(text);
    }

    addToken(type);
}

bool Lexer::isAlpha(char c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_';
}

bool Lexer::isAlphaNumeric(char c) {
    return isAlpha(c) || isdigit(c);
}

}
