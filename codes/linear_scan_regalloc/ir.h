#ifndef IR_H
#define IR_H

#include <string>
#include <vector>
#include <map>
#include <memory>
#include <iostream>
#include <set>

namespace ir {

enum class OpCode {
    Const,
    Add,
    Sub,
    Lt,
    Mul,
    Phi,
    Jump,
    Branch,
    Return,
    Unknown
};

struct Operand {
    enum Type { VirtReg, Constant, Label } type;
    int value; // ID for VirtReg, value for Constant, block ID for Label

    static Operand Reg(int id) { return {VirtReg, id}; }
    static Operand Const(int val) { return {Constant, val}; }
    static Operand Block(int id) { return {Label, id}; }

    bool operator<(const Operand& other) const {
        if (type != other.type) return type < other.type;
        return value < other.value;
    }
    bool operator==(const Operand& other) const {
        return type == other.type && value == other.value;
    }
};

struct Instruction {
    int id = -1; // Instruction number (linearized)
    int result_id = -1; // -1 if no result
    OpCode op;
    std::vector<Operand> args;

    // Original string representation for debugging
    std::string text;

    bool has_output() const { return result_id != -1; }
};

struct Block {
    int id;
    std::vector<Instruction> instructions;
    std::vector<int> preds;
    std::vector<int> succs;

    // For liveness analysis
    std::set<int> live_in;
    std::set<int> live_out; // Not strictly needed to store, but useful
    std::set<int> gen;
    std::set<int> kill;

    int from_id = -1; // Range start (inclusive)
    int to_id = -1;   // Range end (exclusive or inclusive depending on convention)
};

struct Function {
    std::map<int, std::unique_ptr<Block>> blocks;
    std::vector<int> block_order; // RPO or similar linear order
    int max_vreg = 0;

    void Print(std::ostream& os) const;
};

std::string OpCodeToString(OpCode op);

}

#endif
