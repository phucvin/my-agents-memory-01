#include "ir.h"
#include "allocator.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <string>

// Test case from blog
// $0 = BAR()
// $1 = BAR()
// $2 = FOO($0, $1)
// $3 = FOO($2, $1)
// $4 = FOO($0, $3)

int main() {
    Program prog;

    // Construct SSA program
    // Vars: 0, 1, 2, 3, 4

    prog.ops.push_back({Opcode::BAR, {0}, {}, "BAR"});
    prog.ops.push_back({Opcode::BAR, {1}, {}, "BAR"});
    prog.ops.push_back({Opcode::FOO, {2}, {{0}, {1}}, "FOO"});
    prog.ops.push_back({Opcode::FOO, {3}, {{2}, {1}}, "FOO"});
    prog.ops.push_back({Opcode::FOO, {4}, {{0}, {3}}, "FOO"});

    // Allocator with 2 registers
    RegisterAllocator<2> allocator(5); // 5 variables

    // Initial state: Final output ($4) must be in a register (r0)
    // "This means that we start by assigning the final output variable to a register, typically r0"
    allocator.allocations[4] = Allocation::make_register(0);
    allocator.registers[0] = {4};
    allocator.register_lru.poke(0);

    // Process in reverse
    for (int i = prog.ops.size() - 1; i >= 0; --i) {
        Op& op = prog.ops[i];
        if (op.args.size() == 0) {
            allocator.op_nullary(op.out, op.name);
        } else if (op.args.size() == 1) {
            allocator.op_unary(op.out, op.args[0], op.name);
        } else if (op.args.size() == 2) {
            allocator.op_binary(op.out, op.args[0], op.args[1], op.op, op.name);
        }
    }

    // Output to file
    std::ofstream outfile("out.txt");
    if (!outfile.is_open()) {
        std::cerr << "Error opening out.txt for writing" << std::endl;
        return 1;
    }

    // Print result (forward)
    // Allocator output is in reverse order.
    std::cout << "Writing generated assembly to out.txt..." << std::endl;
    for (int i = allocator.out.size() - 1; i >= 0; --i) {
        AsmOp& asm_op = allocator.out[i];
        if (asm_op.type == AsmOpType::Unary) {
            if (asm_op.lhs == -1) // Nullary
                 outfile << "r" << asm_op.out << " = " << asm_op.name << "()" << std::endl;
            else if (asm_op.lhs == asm_op.out) // In-place or simple unary
                 outfile << "r" << asm_op.out << " = " << asm_op.name << "(r" << asm_op.lhs << ")" << std::endl;
            else
                 outfile << "r" << asm_op.out << " = " << asm_op.name << "(r" << asm_op.lhs << ")" << std::endl; // Should be move?
        } else if (asm_op.type == AsmOpType::Binary) {
             outfile << "r" << asm_op.out << " = " << asm_op.name << "(r" << asm_op.lhs << ", r" << asm_op.rhs << ")" << std::endl;
        } else if (asm_op.type == AsmOpType::Load) {
             outfile << "r" << asm_op.out << " = LOAD(mem[" << asm_op.mem << "])" << std::endl;
        } else if (asm_op.type == AsmOpType::Store) {
             outfile << "STORE(r" << asm_op.out << ", mem[" << asm_op.mem << "])" << std::endl;
        }
    }
    outfile.close();
    std::cout << "Done." << std::endl;

    return 0;
}
