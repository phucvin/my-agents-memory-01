#include "codegen.h"
#include <sstream>
#include <set>
#include <algorithm>
#include <vector>

namespace ssa {

// Helpers from regalloc (should be shared ideally, but duplicating for decoupled prototype)
// RPO helps printing blocks in a logical flow
static void PostOrderDFS(Function* func, int block_id, std::set<int>& visited, std::vector<BasicBlock*>& order) {
    visited.insert(block_id);
    BasicBlock* block = func->GetBlock(block_id);
    if (!block) return;
    for (int succ : block->succs) {
        if (visited.find(succ) == visited.end()) {
            PostOrderDFS(func, succ, visited, order);
        }
    }
    order.push_back(block);
}

std::string CodeGenerator::GenerateAssembly(Function* func, const std::map<int, int>& allocation, int num_regs) {
    std::stringstream ss;

    // 1. Assign Stack Slots for Spilled Values
    std::map<int, int> stack_slots;
    int stack_offset = 0;
    for (auto const& [val_id, reg] : allocation) {
        if (reg == -1) {
            stack_slots[val_id] = stack_offset;
            stack_offset += 4; // Assume 4-byte values
        }
    }

    // 2. Identify Scratch Registers
    // In a real allocator, we reserve registers. Here, let's assume we have extra registers
    // or we overload the output to show "Virtual Registers" R0..RN.
    // However, user asked for "reload that to a register".
    // Let's use specific names for scratch like "TMP1", "TMP2".

    auto get_op_str = [&](const Operand& op) -> std::string {
        if (op.type == Operand::Literal) return "#" + std::to_string(op.literal_value);
        if (op.type == Operand::Variable) return op.name; // Should not happen in pure SSA usually, but maybe params?
        if (op.type == Operand::Value) {
            if (allocation.count(op.value_id)) {
                int reg = allocation.at(op.value_id);
                if (reg != -1) return "R" + std::to_string(reg);
                // It is spilled. Caller must handle reload.
                return "SPILLED:" + std::to_string(op.value_id);
            }
        }
        return "UNKNOWN";
    };

    auto is_spilled = [&](const Operand& op) {
        return op.type == Operand::Value && allocation.count(op.value_id) && allocation.at(op.value_id) == -1;
    };

    // Linearize blocks
    std::vector<BasicBlock*> blocks;
    std::set<int> visited;
    PostOrderDFS(func, 0, visited, blocks);
    std::reverse(blocks.begin(), blocks.end());

    ss << "; Assembly Generation with Spill Code\n";
    ss << "; Num Registers: " << num_regs << "\n";
    ss << "; Stack Frame Size: " << stack_offset << " bytes\n\n";

    // Helper to emit phi moves for a target block from a given predecessor block
    auto emit_phi_moves = [&](int block_id, int target_id) {
         BasicBlock* target = func->GetBlock(target_id);
         if (!target) return;

         // Find which predecessor index 'block_id' is in 'target->preds'
         int pred_idx = -1;
         for(size_t i=0; i<target->preds.size(); ++i) {
             if (target->preds[i] == block_id) {
                 pred_idx = i;
                 break;
             }
         }
         if (pred_idx == -1) return;

         for(auto& phi : target->instructions) {
             if (phi.opcode != Opcode::Phi) continue;
             // The value coming from this block is phi.args[pred_idx]
             if (pred_idx < (int)phi.args.size()) {
                 Operand src = phi.args[pred_idx];
                 // Dest is phi.id
                 // Emit Move: Dest <- Src
                 // Need to handle register/spill for both.

                 std::string src_str, dest_str;

                 // Resolve Src
                 bool src_is_mem = false;
                 if (src.type == Operand::Literal) src_str = "#" + std::to_string(src.literal_value);
                 else if (is_spilled(src)) {
                     src_str = "[SP+" + std::to_string(stack_slots[src.value_id]) + "]";
                     src_is_mem = true;
                 } else {
                     src_str = "R" + std::to_string(allocation.at(src.value_id));
                 }

                 // Resolve Dest (the Phi def)
                 bool dest_is_mem = false;
                 if (allocation.at(phi.id) == -1) {
                     dest_str = "[SP+" + std::to_string(stack_slots[phi.id]) + "]";
                     dest_is_mem = true;
                 } else {
                     dest_str = "R" + std::to_string(allocation.at(phi.id));
                 }

                 ss << "  ; Phi Resolution for L" << target_id << "\n";
                 if (src_is_mem && dest_is_mem) {
                     ss << "  LOAD TMP1, " << src_str << "\n";
                     ss << "  STORE " << dest_str << ", TMP1\n";
                 } else if (src_is_mem) {
                     ss << "  LOAD " << dest_str << ", " << src_str << "\n";
                 } else if (dest_is_mem) {
                     ss << "  STORE " << dest_str << ", " << src_str << "\n";
                 } else {
                     if (src_str != dest_str)
                         ss << "  MOV " << dest_str << ", " << src_str << "\n";
                 }
             }
         }
    };

    for (auto* block : blocks) {
        ss << "L" << block->id << ":\n";

        // Resolve Phis if we are the unique predecessor for this block (Edge Handling)
        // Note: Ideally edge moves happen on edges.
        // If this block has 1 predecessor, we can emit the moves at the START of this block.
        if (block->preds.size() == 1 && !block->instructions.empty() && block->instructions.front().opcode == Opcode::Phi) {
             // Resolve Phis here using predecessor
             int pred_id = block->preds[0];
             emit_phi_moves(pred_id, block->id);
        }

        // Instruction Loop
        for (const auto& inst : block->instructions) {
            if (inst.opcode == Opcode::Phi) continue; // Phis are not real instructions in flow

            // Note: Jump handling for Phis is done *at the instruction* (before it technically)
            if (inst.opcode == Opcode::Jump) {
                 emit_phi_moves(block->id, inst.args[0].literal_value);
            }

            // Now emit the instruction itself
            std::string op_name;
            switch(inst.opcode) {
                case Opcode::Const: op_name = "MOV"; break; // Const is basically Move Immediate
                case Opcode::Add: op_name = "ADD"; break;
                case Opcode::Sub: op_name = "SUB"; break;
                case Opcode::Mul: op_name = "MUL"; break;
                case Opcode::Lt:  op_name = "CMP_LT"; break; // Produces boolean?
                case Opcode::Branch: op_name = "BRANCH"; break;
                case Opcode::Jump: op_name = "JMP"; break;
                case Opcode::Return: op_name = "RET"; break;
                case Opcode::Print: op_name = "PRINT"; break;
                default: op_name = "UNKNOWN"; break;
            }

            // Operands
            std::vector<std::string> arg_strs;
            // Pre-load spilled args
            int tmp_idx = 1;
            for (const auto& arg : inst.args) {
                if (is_spilled(arg)) {
                    ss << "  LOAD TMP" << tmp_idx << ", [SP+" << stack_slots[arg.value_id] << "]\n";
                    arg_strs.push_back("TMP" + std::to_string(tmp_idx));
                    tmp_idx++;
                } else {
                    arg_strs.push_back(get_op_str(arg));
                }
            }

            // Output Dest
            std::string dest_str;
            bool dest_is_spilled = false;
            if (inst.id != -1) { // Has output SSA value
                if (allocation.at(inst.id) == -1) {
                    dest_is_spilled = true;
                    dest_str = "TMP" + std::to_string(tmp_idx); // Use next tmp for result
                } else {
                    dest_str = "R" + std::to_string(allocation.at(inst.id));
                }
            } else if (!inst.output_var.empty() && inst.opcode != Opcode::Branch && inst.opcode != Opcode::Jump && inst.opcode != Opcode::Return) {
                 // Variable output? Not in SSA usually.
                 dest_str = inst.output_var;
            }

            // Print Op
            ss << "  " << op_name;
            if (!dest_str.empty()) ss << " " << dest_str;
            for (const auto& s : arg_strs) {
                ss << (dest_str.empty() && s == arg_strs[0] ? " " : ", ") << s;
            }
            ss << "\n";

            // Post-store spilled dest
            if (dest_is_spilled) {
                ss << "  STORE [SP+" << stack_slots[inst.id] << "], " << dest_str << "\n";
            }
        }

        ss << "\n";
    }

    return ss.str();
}

}
