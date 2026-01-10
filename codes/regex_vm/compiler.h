#ifndef COMPILER_H
#define COMPILER_H

#include "vm.h"
#include <string>
#include <vector>

namespace RegexVM {

struct Node; // Forward declaration

class Compiler {
public:
    Compiler(const std::string& pattern);
    ~Compiler();
    std::vector<Instruction> compile();

    // Helper for AST nodes
    void emit(OpCode op, int x = 0, int y = 0, int slot = 0, char c = 0);
    int current_pc();
    void patch(int pc, int target);
    std::vector<Instruction>& prog_access() { return prog_; }

private:
    std::string pattern_;
    int pos_;
    std::vector<Instruction> prog_;
    int capture_count_;

    Node* parse_expr();
    Node* parse_term();
    Node* parse_factor();
    Node* parse_atom();

    char peek();
    char consume();
    bool match_char(char c);
};

} // namespace RegexVM

#endif // COMPILER_H
