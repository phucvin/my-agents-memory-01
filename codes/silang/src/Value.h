#ifndef SILANG_VALUE_H
#define SILANG_VALUE_H

#include <string>
#include <variant>
#include <vector>
#include <map>
#include <memory>
#include <iostream>
#include "AST.h"

namespace silang {

struct Value;
struct StructValue;
struct FunctionValue;

using ValuePtr = std::shared_ptr<Value>;

enum class ValueType {
    INT, BOOL, STRING, VOID, STRUCT, ARRAY, MAP, FUNCTION, BUILTIN
};

struct Value {
    ValueType type;
    virtual ~Value() = default;

    virtual std::string toString() const = 0;
};

struct IntValue : Value {
    int value;
    IntValue(int v) : value(v) { type = ValueType::INT; }
    std::string toString() const override { return std::to_string(value); }
};

struct BoolValue : Value {
    bool value;
    BoolValue(bool v) : value(v) { type = ValueType::BOOL; }
    std::string toString() const override { return value ? "true" : "false"; }
};

struct StringValue : Value {
    std::string value;
    StringValue(std::string v) : value(v) { type = ValueType::STRING; }
    std::string toString() const override { return value; }
};

struct VoidValue : Value {
    VoidValue() { type = ValueType::VOID; }
    std::string toString() const override { return "void"; }
};

struct StructValue : Value {
    std::string name;
    std::map<std::string, ValuePtr> fields;
    StructValue(std::string n) : name(n) { type = ValueType::STRUCT; }
    std::string toString() const override { return "struct " + name; }
};

struct ArrayValue : Value {
    std::vector<ValuePtr> elements;
    ArrayValue(std::vector<ValuePtr> e = {}) : elements(e) { type = ValueType::ARRAY; }
    std::string toString() const override { return "Array[" + std::to_string(elements.size()) + "]"; }
};

struct MapValue : Value {
    std::map<std::string, ValuePtr> entries;
    MapValue() { type = ValueType::MAP; }
    std::string toString() const override { return "Map"; }
};

struct FunctionValue : Value {
    std::string name;
    std::vector<std::pair<std::string, Type>> params; // Name and Type
    std::shared_ptr<Stmt> body;
    std::shared_ptr<class Environment> closure;

    FunctionValue(std::string n, std::vector<std::pair<std::string, Type>> p, std::shared_ptr<Stmt> b, std::shared_ptr<class Environment> c)
        : name(n), params(p), body(b), closure(c) { type = ValueType::FUNCTION; }

    std::string toString() const override { return "func " + name; }
};

typedef ValuePtr (*BuiltinFunc)(std::vector<ValuePtr>);

struct BuiltinValue : Value {
    std::string name;
    BuiltinFunc func;
    BuiltinValue(std::string n, BuiltinFunc f) : name(n), func(f) { type = ValueType::BUILTIN; }
    std::string toString() const override { return "builtin " + name; }
};

}

#endif
