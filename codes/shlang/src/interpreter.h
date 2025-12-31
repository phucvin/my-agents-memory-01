#ifndef INTERPRETER_H
#define INTERPRETER_H

#include "ast.h"
#include <map>
#include <string>
#include <vector>
#include <memory>
#include <variant>

// Value definition
struct Value {
    TypeKind type;
    std::variant<int, std::string, bool, std::shared_ptr<struct StructInstance>, std::shared_ptr<struct MapInstance>, std::shared_ptr<struct ArrayInstance>> data;
};

struct StructInstance {
    std::string name;
    std::map<std::string, Value> fields;
};

struct ArrayInstance {
    std::vector<Value> elements;
};

struct MapInstance {
    std::map<std::string, Value> items; // Keys are strings for simplicity
};

class Interpreter {
public:
    Interpreter(std::shared_ptr<Program> program);
    void run();

private:
    std::shared_ptr<Program> program;
    std::vector<std::map<std::string, Value>> environment;

    void enterScope();
    void exitScope();
    void define(std::string name, Value val);
    void assign(std::string name, Value val);
    Value lookup(std::string name);

    Value eval(std::shared_ptr<ASTNode> node);
    void execute(std::shared_ptr<ASTNode> stmt);
    void executeBlock(std::shared_ptr<Block> block);
    Value callNative(std::string name, const std::vector<Value>& args);
};

#endif
