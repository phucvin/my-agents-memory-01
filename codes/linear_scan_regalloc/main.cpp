#include "parser.h"
#include "liveness.h"
#include "regalloc.h"
#include <iostream>
#include <fstream>
#include <sstream>

std::string ReadFile(const std::string& path) {
    std::ifstream t(path);
    std::stringstream buffer;
    buffer << t.rdbuf();
    return buffer.str();
}

int main(int argc, char** argv) {
    std::string input_path = "input.txt";
    if (argc > 1) input_path = argv[1];

    std::string input = ReadFile(input_path);
    if (input.empty()) {
        std::cerr << "Could not read input or empty file: " << input_path << "\n";
        return 1;
    }

    auto func = parser::Parse(input);
    liveness::NumberInstructions(func);
    auto intervals = liveness::BuildIntervals(func);

    std::cout << "Intervals:\n";
    for (auto& p : intervals) {
        std::cout << p.second.ToString() << "\n";
    }
    std::cout << "\n";

    // Try with limited registers to force spills
    int num_regs = 3;
    std::cout << "Allocating with " << num_regs << " registers...\n";
    auto alloc = regalloc::LinearScan(intervals, num_regs);

    std::cout << "Allocation:\n";
    for (auto& p : alloc.reg_mapping) {
        std::cout << "%" << p.first << " -> R" << p.second << "\n";
    }
    for (auto& p : alloc.stack_mapping) {
        std::cout << "%" << p.first << " -> Stack[" << p.second << "]\n";
    }

    std::cout << "\nRewritten Code (Pseudo-Assembly):\n";
    for (int bid : func.block_order) {
        auto& block = func.blocks[bid];
        std::cout << "Block " << bid << ":\n";
        for (auto& instr : block->instructions) {
             if (instr.op == ir::OpCode::Phi) continue; // Phis usually resolved to moves

             std::cout << "  ";
             if (instr.has_output()) {
                 int reg = instr.result_id;
                 if (alloc.reg_mapping.count(reg)) std::cout << "R" << alloc.reg_mapping[reg];
                 else if (alloc.stack_mapping.count(reg)) std::cout << "Stack[" << alloc.stack_mapping[reg] << "]";
                 else std::cout << "%" << reg << "(?)";
                 std::cout << " = ";
             }
             std::cout << ir::OpCodeToString(instr.op) << " ";
             for (size_t i = 0; i < instr.args.size(); ++i) {
                 auto& arg = instr.args[i];
                 if (arg.type == ir::Operand::VirtReg) {
                     if (alloc.reg_mapping.count(arg.value)) std::cout << "R" << alloc.reg_mapping[arg.value];
                     else if (alloc.stack_mapping.count(arg.value)) std::cout << "Stack[" << alloc.stack_mapping[arg.value] << "]";
                     else std::cout << "%" << arg.value << "(?)";
                 } else if (arg.type == ir::Operand::Constant) {
                     std::cout << arg.value;
                 } else {
                     std::cout << "B" << arg.value;
                 }
                 if (i < instr.args.size() - 1) std::cout << ", ";
             }
             std::cout << "\n";
        }
    }

    return 0;
}
