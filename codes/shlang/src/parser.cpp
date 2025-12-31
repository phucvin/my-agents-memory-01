#include "parser.h"
#include <iostream>

Parser::Parser(const std::vector<Token>& toks) : tokens(toks), pos(0) {}

Token Parser::peek(int offset) {
    if (pos + offset >= tokens.size()) return tokens.back(); // EOF
    return tokens[pos + offset];
}

Token Parser::advance() {
    if (pos < tokens.size()) pos++;
    return tokens[pos - 1];
}

bool Parser::match(TokenType type) {
    if (peek().type == type) {
        advance();
        return true;
    }
    return false;
}

Token Parser::consume(TokenType type, std::string errorMsg) {
    if (peek().type == type) return advance();
    std::cerr << "Error at line " << peek().line << ": " << errorMsg << " Found: " << peek().text << std::endl;
    exit(1);
}

std::shared_ptr<Program> Parser::parse() {
    auto program = std::make_shared<Program>();
    while (peek().type != TokenType::EOF_TOKEN) {
        program->statements.push_back(declaration());
    }
    return program;
}

std::shared_ptr<ASTNode> Parser::declaration() {
    if (match(TokenType::FUNC)) return funcDeclaration();
    if (match(TokenType::VAR)) return varDeclaration();
    if (match(TokenType::STRUCT)) return structDeclaration();
    if (match(TokenType::INTERFACE)) return interfaceDeclaration();
    return statement();
}

std::shared_ptr<Type> Parser::parseType() {
    if (match(TokenType::LBRACKET)) {
        consume(TokenType::RBRACKET, "Expected ']'");
        auto elemType = parseType();
        auto type = std::make_shared<Type>();
        type->kind = TypeKind::ARRAY;
        type->params.push_back(elemType);
        return type;
    }

    Token typeName = consume(TokenType::IDENTIFIER, "Expected type name");
    auto type = std::make_shared<Type>();

    if (typeName.text == "int") type->kind = TypeKind::INT;
    else if (typeName.text == "string") type->kind = TypeKind::STRING;
    else if (typeName.text == "bool") type->kind = TypeKind::BOOL;
    else {
        type->kind = TypeKind::STRUCT; // Assume struct or interface for now
        type->name = typeName.text;
    }
    return type;
}

// Need to handle Arrays in Parser?
// User used `buckets []IntEntry;`
// My `parseType` expects Identifier. `[` is not identifier.
// I need to update `parseType`.

std::shared_ptr<ASTNode> Parser::funcDeclaration() {
    auto func = std::make_shared<FunctionDecl>();

    if (peek().type == TokenType::LPAREN) {
        // Method receiver: func (r Receiver) Name(...)
        consume(TokenType::LPAREN, "Expected '(' for receiver");
        std::string recvName = consume(TokenType::IDENTIFIER, "Expected receiver name").text;
        std::shared_ptr<Type> recvType = parseType();
        func->receiver = {recvName, recvType};
        func->isMethod = true;
        consume(TokenType::RPAREN, "Expected ')' after receiver");
    }

    func->name = consume(TokenType::IDENTIFIER, "Expected function name").text;
    consume(TokenType::LPAREN, "Expected '('");

    if (!match(TokenType::RPAREN)) {
        do {
            std::string paramName = consume(TokenType::IDENTIFIER, "Expected param name").text;
            // Type is optional? User said "type infer and only require annotation when really needed".
            // But usually function args need types or they are generic.
            // Let's allow optional type.
            std::shared_ptr<Type> type = nullptr;
            if (peek().type == TokenType::IDENTIFIER) {
                // Peek to see if next is comma or paren, if so, no type?
                // Actually standard Go is `name type`.
                type = parseType();
            } else {
                // Any type
                type = std::make_shared<Type>();
                type->kind = TypeKind::ANY;
            }
            func->params.push_back({paramName, type});
        } while (match(TokenType::COMMA));
        consume(TokenType::RPAREN, "Expected ')'");
    }

    // Return type
    if (peek().type != TokenType::LBRACE) {
         func->returnType = parseType();
    } else {
        auto voidType = std::make_shared<Type>();
        voidType->kind = TypeKind::VOID;
        func->returnType = voidType;
    }

    consume(TokenType::LBRACE, "Expected '{'");
    func->body = block();
    return func;
}

std::shared_ptr<ASTNode> Parser::varDeclaration() {
    auto var = std::make_shared<VarDecl>();
    var->name = consume(TokenType::IDENTIFIER, "Expected variable name").text;

    if (match(TokenType::EQUAL)) {
        var->initializer = expression();
    }
    // Semicolon optional?
    match(TokenType::SEMICOLON);
    return var;
}

std::shared_ptr<ASTNode> Parser::structDeclaration() {
    auto st = std::make_shared<StructDecl>();
    st->name = consume(TokenType::IDENTIFIER, "Expected struct name").text;
    consume(TokenType::LBRACE, "Expected '{'");
    while (!match(TokenType::RBRACE)) {
        std::string fieldName = consume(TokenType::IDENTIFIER, "Expected field name").text;
        auto type = parseType();
        st->fields.push_back({fieldName, type});
        match(TokenType::SEMICOLON); // Optional semicolon
    }
    return st;
}

std::shared_ptr<ASTNode> Parser::interfaceDeclaration() {
    auto inf = std::make_shared<InterfaceDecl>();
    inf->name = consume(TokenType::IDENTIFIER, "Expected interface name").text;
    consume(TokenType::LBRACE, "Expected '{'");
    while (!match(TokenType::RBRACE)) {
        std::string methodName = consume(TokenType::IDENTIFIER, "Expected method name").text;
        consume(TokenType::LPAREN, "Expected '('");
        // Simplified method sig parsing
        while (!match(TokenType::RPAREN)) advance();
        // Return type...
        parseType();
        inf->methods.push_back({methodName, nullptr}); // simplified
        match(TokenType::SEMICOLON);
    }
    return inf;
}

std::shared_ptr<ASTNode> Parser::statement() {
    if (match(TokenType::IF)) return ifStatement();
    if (match(TokenType::WHILE)) return whileStatement();
    if (match(TokenType::RETURN)) return returnStatement();
    if (peek().type == TokenType::LBRACE) {
        consume(TokenType::LBRACE, "{");
        return block();
    }

    auto expr = expression();
    match(TokenType::SEMICOLON);
    return expr;
}

std::shared_ptr<Block> Parser::block() {
    auto blk = std::make_shared<Block>();
    while (peek().type != TokenType::RBRACE && peek().type != TokenType::EOF_TOKEN) {
        blk->statements.push_back(declaration());
    }
    consume(TokenType::RBRACE, "Expected '}'");
    return blk;
}

std::shared_ptr<ASTNode> Parser::ifStatement() {
    auto stmt = std::make_shared<IfStmt>();
    consume(TokenType::LPAREN, "Expected '('");
    stmt->condition = expression();
    consume(TokenType::RPAREN, "Expected ')'");

    consume(TokenType::LBRACE, "Expected '{' for if block");
    stmt->thenBranch = block();

    if (match(TokenType::ELSE)) {
        if (peek().type == TokenType::IF) {
             // else if
             stmt->elseBranch = std::make_shared<Block>();
             stmt->elseBranch->statements.push_back(statement());
        } else {
             consume(TokenType::LBRACE, "Expected '{' for else block");
             stmt->elseBranch = block();
        }
    }
    return stmt;
}

std::shared_ptr<ASTNode> Parser::whileStatement() {
    auto stmt = std::make_shared<WhileStmt>();
    consume(TokenType::LPAREN, "Expected '(' after while");
    stmt->condition = expression();
    consume(TokenType::RPAREN, "Expected ')'");
    consume(TokenType::LBRACE, "Expected '{'");
    stmt->body = block();
    return stmt;
}

std::shared_ptr<ASTNode> Parser::returnStatement() {
    auto stmt = std::make_shared<ReturnStmt>();
    if (peek().type != TokenType::SEMICOLON) {
        stmt->value = expression();
    }
    match(TokenType::SEMICOLON);
    return stmt;
}

std::shared_ptr<ASTNode> Parser::expression() {
    return assignment();
}

std::shared_ptr<ASTNode> Parser::assignment() {
    auto expr = equality();
    if (match(TokenType::EQUAL)) {
        auto assign = std::make_shared<Assignment>();
        assign->target = expr;
        assign->value = assignment();
        return assign;
    }
    return expr;
}

std::shared_ptr<ASTNode> Parser::equality() {
    auto expr = comparison();
    while (peek().type == TokenType::EQUAL_EQUAL || peek().type == TokenType::BANG_EQUAL) {
        auto binary = std::make_shared<BinaryExpr>();
        binary->left = expr;
        binary->op = advance().text;
        binary->right = comparison();
        expr = binary;
    }
    return expr;
}

std::shared_ptr<ASTNode> Parser::comparison() {
    auto expr = term();
    while (peek().type == TokenType::LESS || peek().type == TokenType::LESS_EQUAL ||
           peek().type == TokenType::GREATER || peek().type == TokenType::GREATER_EQUAL) {
        auto binary = std::make_shared<BinaryExpr>();
        binary->left = expr;
        binary->op = advance().text;
        binary->right = term();
        expr = binary;
    }
    return expr;
}

std::shared_ptr<ASTNode> Parser::term() {
    auto expr = factor();
    while (peek().type == TokenType::PLUS || peek().type == TokenType::MINUS) {
        auto binary = std::make_shared<BinaryExpr>();
        binary->left = expr;
        binary->op = advance().text;
        binary->right = factor();
        expr = binary;
    }
    return expr;
}

std::shared_ptr<ASTNode> Parser::factor() {
    auto expr = unary();
    while (peek().type == TokenType::STAR || peek().type == TokenType::SLASH || peek().type == TokenType::PERCENT) {
        auto binary = std::make_shared<BinaryExpr>();
        binary->left = expr;
        binary->op = advance().text;
        binary->right = unary();
        expr = binary;
    }
    return expr;
}

std::shared_ptr<ASTNode> Parser::unary() {
    if (peek().type == TokenType::MINUS || peek().type == TokenType::BANG_EQUAL) {
        Token op = advance();
        auto u = std::make_shared<UnaryExpr>();
        u->op = op.text;
        u->right = unary();
        return u;
    }
    return call();
}

std::shared_ptr<ASTNode> Parser::call() {
    auto expr = primary();
    while (true) {
        if (match(TokenType::LPAREN)) {
            auto call = std::make_shared<CallExpr>();
            call->callee = expr;
            if (peek().type != TokenType::RPAREN) {
                do {
                    call->args.push_back(expression());
                } while (match(TokenType::COMMA));
            }
            consume(TokenType::RPAREN, "Expected ')' after arguments");
            expr = call;
        } else if (match(TokenType::DOT)) {
            auto member = std::make_shared<MemberAccess>();
            member->object = expr;
            member->member = consume(TokenType::IDENTIFIER, "Expected member name").text;
            expr = member;
        } else if (match(TokenType::LBRACKET)) {
            auto index = std::make_shared<IndexAccess>();
            index->object = expr;
            index->index = expression();
            consume(TokenType::RBRACKET, "Expected ']'");
            expr = index;
        } else {
            break;
        }
    }
    return expr;
}

std::shared_ptr<ASTNode> Parser::primary() {
    if (match(TokenType::FALSE)) return std::make_shared<Literal>(false);
    if (match(TokenType::TRUE)) return std::make_shared<Literal>(true);

    if (peek().type == TokenType::NUMBER) {
        return std::make_shared<Literal>(std::stoi(advance().text));
    }
    if (peek().type == TokenType::STRING_LIT) {
        return std::make_shared<Literal>(advance().text);
    }
    if (peek().type == TokenType::IDENTIFIER) {
        return std::make_shared<Identifier>(advance().text);
    }
    if (match(TokenType::NEW)) {
        std::string structName = consume(TokenType::IDENTIFIER, "Expected struct name after new").text;
        auto ns = std::make_shared<NewStruct>();
        ns->name = structName;
        return ns;
    }
    if (match(TokenType::LPAREN)) {
        auto expr = expression();
        consume(TokenType::RPAREN, "Expected ')'");
        return expr;
    }

    std::cout << "Unexpected token: " << peek().text << " type " << (int)peek().type << std::endl;
    exit(1);
    return nullptr;
}
