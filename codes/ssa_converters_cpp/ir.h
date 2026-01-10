#pragma once

#include <string>
#include <vector>
#include <memory>
#include <iostream>
#include <map>
#include <optional>

namespace ssa {

enum class Opcode {
    // Arithmetic/Logic
    Const,
    Add,
    Sub,
    Mul,
    Lt,

    // Control Flow
    Branch,
    Jump,
    Return,

    // Standard SSA
    Phi,

    // Pizlo SSA
    Upsilon, // writes to shadow variable

    // Misc
    Print
};

struct Operand {
    enum Type { Variable, Value, Literal };
    Type type;
    std::string name; // For Variable or Pizlo Shadow Variable
    int value_id = -1; // For Value (SSA definition)
    int literal_value = 0; // For Literal

    static Operand Var(std::string n) { return {Variable, n, -1, 0}; }
    static Operand Val(int id) { return {Value, "", id, 0}; }
    static Operand Lit(int v) { return {Literal, "", -1, v}; }

    std::string ToString() const;
};

struct Instruction {
    int id = -1; // Unique ID for SSA values
    Opcode opcode;
    std::vector<Operand> args;
    std::string output_var; // Name of variable defined (pre-SSA) or Pizlo Shadow Variable (for Phi)

    // Functional SSA support: Jumps pass arguments

    std::string ToString() const;
};

struct BasicBlock {
    int id;
    std::vector<Instruction> instructions;
    std::vector<int> preds;
    std::vector<int> succs;

    // Functional SSA: Block parameters
    std::vector<int> params; // IDs of parameters
    std::vector<std::string> param_original_names; // Debug info

    BasicBlock(int i) : id(i) {}

    void AddInstruction(Instruction inst);
};

struct Function {
    std::vector<std::shared_ptr<BasicBlock>> blocks;
    int value_counter = 0; // For generating unique SSA value IDs

    BasicBlock* GetBlock(int id);
    int NewValueId();

    void AddEdge(int from, int to);

    // Helpers to build example
    void BuildTestProgram(); // non-SSA

    std::string ToString() const;
};

}
