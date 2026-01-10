#ifndef REGEX_VM_H
#define REGEX_VM_H

#include <vector>
#include <string>
#include <iostream>

namespace RegexVM {

enum OpCode {
    OP_CHAR,
    OP_ANY,
    OP_MATCH,
    OP_JMP,
    OP_SPLIT,
    OP_SAVE
};

struct Instruction {
    OpCode op;
    char c;       // For OP_CHAR
    int x;        // For JMP, SPLIT
    int y;        // For SPLIT
    int slot;     // For SAVE
};

struct Thread {
    int pc;
    std::vector<int> saved; // Saved capture positions

    Thread(int pc, const std::vector<int>& saved) : pc(pc), saved(saved) {}
};

class VM {
public:
    VM(const std::vector<Instruction>& prog);
    bool match(const std::string& input, std::vector<std::string>& captured_groups);

private:
    std::vector<Instruction> prog_;
    int gen_; // Generation counter to avoid duplicate threads in one step
};

} // namespace RegexVM

#endif // REGEX_VM_H
