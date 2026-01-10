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

    std::string output_path = "assembly.txt";
    if (argc > 2) output_path = argv[2];

    std::string input = ReadFile(input_path);
    if (input.empty()) {
        std::cerr << "Could not read input or empty file: " << input_path << "\n";
        return 1;
    }

    auto func = parser::Parse(input);
    liveness::NumberInstructions(func);
    auto intervals = liveness::BuildIntervals(func);

    std::ofstream out_file(output_path);
    if (!out_file.is_open()) {
        std::cerr << "Could not open output file: " << output_path << "\n";
        return 1;
    }
    std::ostream& out = out_file;

    out << "Intervals:\n";
    for (auto& p : intervals) {
        out << p.second.ToString() << "\n";
    }
    out << "\n";

    // Try with limited registers to force spills
    int num_regs = 3;
    out << "Allocating with " << num_regs << " registers...\n";
    auto alloc = regalloc::LinearScan(intervals, num_regs);

    out << "Allocation:\n";
    for (auto& p : alloc.reg_mapping) {
        out << "%" << p.first << " -> R" << p.second << "\n";
    }
    for (auto& p : alloc.stack_mapping) {
        out << "%" << p.first << " -> Stack[" << p.second << "]\n";
    }

    out << "\nRewritten Code (Pseudo-Assembly):\n";
    for (int bid : func.block_order) {
        auto& block = func.blocks[bid];
        out << "Block " << bid << ":\n";
        for (auto& instr : block->instructions) {
             if (instr.op == ir::OpCode::Phi) continue; // Phis usually resolved to moves

             out << "  ";
             if (instr.has_output()) {
                 int reg = instr.result_id;
                 if (alloc.reg_mapping.count(reg)) out << "R" << alloc.reg_mapping[reg];
                 else if (alloc.stack_mapping.count(reg)) out << "Stack[" << alloc.stack_mapping[reg] << "]";
                 else out << "%" << reg << "(?)";
                 out << " = ";
             }
             out << ir::OpCodeToString(instr.op) << " ";
             for (size_t i = 0; i < instr.args.size(); ++i) {
                 auto& arg = instr.args[i];
                 if (arg.type == ir::Operand::VirtReg) {
                     if (alloc.reg_mapping.count(arg.value)) out << "R" << alloc.reg_mapping[arg.value];
                     else if (alloc.stack_mapping.count(arg.value)) out << "Stack[" << alloc.stack_mapping[arg.value] << "]";
                     else out << "%" << arg.value << "(?)";
                 } else if (arg.type == ir::Operand::Constant) {
                     out << arg.value;
                 } else {
                     out << "B" << arg.value;
                 }
                 if (i < instr.args.size() - 1) out << ", ";
             }
             out << "\n";
        }
    }

    std::cout << "Output saved to " << output_path << "\n";

    return 0;
}
