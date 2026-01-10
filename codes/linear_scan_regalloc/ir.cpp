#include "ir.h"

namespace ir {

std::string OpCodeToString(OpCode op) {
    switch(op) {
        case OpCode::Const: return "Const";
        case OpCode::Add: return "Add";
        case OpCode::Sub: return "Sub";
        case OpCode::Lt: return "Lt";
        case OpCode::Mul: return "Mul";
        case OpCode::Phi: return "Phi";
        case OpCode::Jump: return "Jump";
        case OpCode::Branch: return "Branch";
        case OpCode::Return: return "Return";
        default: return "Unknown";
    }
}

void Function::Print(std::ostream& os) const {
    for (int bid : block_order) {
        const auto& block = blocks.at(bid);
        os << "Block " << block->id << " [" << block->from_id << ", " << block->to_id << "):\n";
        for (const auto& instr : block->instructions) {
            os << "  " << instr.id << ": ";
            if (instr.result_id != -1) {
                os << "%" << instr.result_id << " = ";
            }
            os << OpCodeToString(instr.op) << "(";
            for (size_t i = 0; i < instr.args.size(); ++i) {
                if (instr.args[i].type == Operand::VirtReg) os << "%" << instr.args[i].value;
                else if (instr.args[i].type == Operand::Constant) os << instr.args[i].value;
                else os << "B" << instr.args[i].value;
                if (i < instr.args.size() - 1) os << ", ";
            }
            os << ")\n";
        }
        os << "\n";
    }
}

}
