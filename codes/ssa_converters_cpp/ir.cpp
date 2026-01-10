#include "ir.h"
#include <sstream>

namespace ssa {

std::string Operand::ToString() const {
    if (type == Variable) return name;
    if (type == Value) return "%" + std::to_string(value_id);
    if (type == Literal) return std::to_string(literal_value);
    return "?";
}

std::string Instruction::ToString() const {
    std::stringstream ss;
    if (id != -1) {
        ss << "%" << id << " = ";
    } else if (!output_var.empty() && opcode != Opcode::Upsilon) {
        // In non-SSA, we might print "x = ..."
        ss << output_var << " = ";
    }

    switch (opcode) {
        case Opcode::Const: ss << "Const"; break;
        case Opcode::Add: ss << "Add"; break;
        case Opcode::Sub: ss << "Sub"; break;
        case Opcode::Mul: ss << "Mul"; break;
        case Opcode::Lt: ss << "Lt"; break;
        case Opcode::Branch: ss << "Branch"; break;
        case Opcode::Jump: ss << "Jump"; break;
        case Opcode::Return: ss << "Return"; break;
        case Opcode::Phi: ss << "Phi"; break;
        case Opcode::Upsilon: ss << "Upsilon"; break;
        case Opcode::Print: ss << "Print"; break;
    }

    ss << "(";
    for (size_t i = 0; i < args.size(); ++i) {
        if (i > 0) ss << ", ";
        ss << args[i].ToString();
    }
    // For Pizlo Upsilon: Upsilon(val, ^shadow)
    // We store ^shadow in output_var usually? No, Upsilon doesn't output.
    // Let's assume output_var stores the shadow name for Upsilon if set.
    if (opcode == Opcode::Upsilon && !output_var.empty()) {
        if (!args.empty()) ss << ", ";
        ss << "^" << output_var;
    }
    ss << ")";

    // For Pizlo Phi: %1 = Phi() // reads ^output_var
    if (opcode == Opcode::Phi && args.empty() && !output_var.empty()) {
         ss << " [reads ^" << output_var << "]";
    }

    return ss.str();
}

void BasicBlock::AddInstruction(Instruction inst) {
    instructions.push_back(inst);
}

BasicBlock* Function::GetBlock(int id) {
    for (auto& b : blocks) {
        if (b->id == id) return b.get();
    }
    return nullptr;
}

int Function::NewValueId() {
    return ++value_counter;
}

void Function::AddEdge(int from, int to) {
    GetBlock(from)->succs.push_back(to);
    GetBlock(to)->preds.push_back(from);
}

std::string Function::ToString() const {
    std::stringstream ss;
    for (auto& b : blocks) {
        ss << "Block " << b->id;
        if (!b->params.empty()) {
            ss << "(";
            for (size_t i = 0; i < b->params.size(); ++i) {
                if (i > 0) ss << ", ";
                ss << "%" << b->params[i];
                if (i < b->param_original_names.size()) {
                    ss << ":" << b->param_original_names[i];
                }
            }
            ss << ")";
        }
        ss << ":\n";

        // Preds
        ss << "  Preds: ";
        for (int p : b->preds) ss << p << " ";
        ss << "\n";

        for (auto& inst : b->instructions) {
            ss << "  " << inst.ToString() << "\n";
        }

        // Succs
        ss << "  Succs: ";
        for (int s : b->succs) ss << s << " ";
        ss << "\n\n";
    }
    return ss.str();
}

void Function::BuildTestProgram() {
    // Example:
    // x = 0;
    // i = 0;
    // while (i < 10) {
    //   if (i % 2 == 0) { // simplified to i < 5 for test
    //     x = x + i;
    //   } else {
    //     x = x - 1;
    //   }
    //   i = i + 1;
    // }
    // return x;

    // Block 0: Entry
    // Block 1: Header (i < 10)
    // Block 2: Body Start (check condition)
    // Block 3: Then
    // Block 4: Else
    // Block 5: Body End (i = i + 1, Jump Header)
    // Block 6: Exit

    auto mk = [&](int id) {
        blocks.push_back(std::make_shared<BasicBlock>(id));
    };
    for(int i=0; i<=6; ++i) mk(i);

    // Edges
    AddEdge(0, 1);
    AddEdge(1, 2); // Loop body
    AddEdge(1, 6); // Exit
    AddEdge(2, 3);
    AddEdge(2, 4);
    AddEdge(3, 5);
    AddEdge(4, 5);
    AddEdge(5, 1); // Back edge

    // Block 0
    BasicBlock* b0 = GetBlock(0);
    b0->AddInstruction({-1, Opcode::Const, {Operand::Lit(0)}, "x"});
    b0->AddInstruction({-1, Opcode::Const, {Operand::Lit(0)}, "i"});
    b0->AddInstruction({-1, Opcode::Jump, {Operand::Lit(1)}, ""}); // Target is block ID 1

    // Block 1: i < 10
    BasicBlock* b1 = GetBlock(1);
    b1->AddInstruction({-1, Opcode::Lt, {Operand::Var("i"), Operand::Lit(10)}, "tmp1"});
    b1->AddInstruction({-1, Opcode::Branch, {Operand::Var("tmp1"), Operand::Lit(2), Operand::Lit(6)}, ""});

    // Block 2: if (i < 5) (Simulating condition)
    BasicBlock* b2 = GetBlock(2);
    b2->AddInstruction({-1, Opcode::Lt, {Operand::Var("i"), Operand::Lit(5)}, "tmp2"});
    b2->AddInstruction({-1, Opcode::Branch, {Operand::Var("tmp2"), Operand::Lit(3), Operand::Lit(4)}, ""});

    // Block 3: Then (x = x + i)
    BasicBlock* b3 = GetBlock(3);
    b3->AddInstruction({-1, Opcode::Add, {Operand::Var("x"), Operand::Var("i")}, "x"});
    b3->AddInstruction({-1, Opcode::Jump, {Operand::Lit(5)}, ""});

    // Block 4: Else (x = x - 1)
    BasicBlock* b4 = GetBlock(4);
    b4->AddInstruction({-1, Opcode::Sub, {Operand::Var("x"), Operand::Lit(1)}, "x"});
    b4->AddInstruction({-1, Opcode::Jump, {Operand::Lit(5)}, ""});

    // Block 5: Join and increment (i = i + 1)
    BasicBlock* b5 = GetBlock(5);
    b5->AddInstruction({-1, Opcode::Add, {Operand::Var("i"), Operand::Lit(1)}, "i"});
    b5->AddInstruction({-1, Opcode::Jump, {Operand::Lit(1)}, ""});

    // Block 6: Return x
    BasicBlock* b6 = GetBlock(6);
    b6->AddInstruction({-1, Opcode::Return, {Operand::Var("x")}, ""});
}

}
