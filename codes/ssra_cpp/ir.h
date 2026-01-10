#pragma once
#include <vector>
#include <string>
#include <variant>
#include <iostream>

struct SsaVariable {
    int id;
    static const int INVALID = -1;
    bool operator==(const SsaVariable& other) const { return id == other.id; }
    bool operator!=(const SsaVariable& other) const { return id != other.id; }
};

struct Register {
    int id;
    bool operator==(const Register& other) const { return id == other.id; }
};

struct Memory {
    int id;
    bool operator==(const Memory& other) const { return id == other.id; }
};

enum class AllocationType {
    Register,
    Memory,
    Unassigned
};

struct Allocation {
    AllocationType type;
    int index; // register index or memory index

    static Allocation make_register(int r) {
        return {AllocationType::Register, r};
    }
    static Allocation make_memory(int m) {
        return {AllocationType::Memory, m};
    }
    static Allocation make_unassigned() {
        return {AllocationType::Unassigned, -1};
    }
};

enum class Opcode {
    VAR_X,
    VAR_Y,
    ADD,
    SUB,
    DIV,
    BAR,
    FOO,
    // ...
};

struct Op {
    Opcode op;
    SsaVariable out;
    std::vector<SsaVariable> args;
    std::string name;
};

struct Program {
    std::vector<Op> ops;
};

// Output Assembly Ops
enum class AsmOpType {
    Unary, // Or binary, but focusing on simple ones for now. The blog uses Unary/Binary distinction but structure handles both.
    Binary,
    Load,
    Store
};

struct AsmOp {
    AsmOpType type;
    int out; // Register
    int lhs; // Register
    int rhs; // Register (for binary)
    int mem; // Memory index (for load/store)
    std::string name;
};
