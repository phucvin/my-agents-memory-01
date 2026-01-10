#include "liveness.h"
#include <algorithm>
#include <sstream>

namespace liveness {

std::string Interval::ToString() const {
    std::stringstream ss;
    ss << "%" << reg_id << " [" << start << ", " << end << ")";
    return ss.str();
}

void NumberInstructions(ir::Function& func) {
    int pc = 0;
    // We assume func.block_order is already a valid linearization (like RPO)
    // The parser just pushed them in order of appearance in file, which corresponds to RPO in the sample

    // According to blog: Blocks get numbers too (start/end)
    // We increment by 2 to allow insertion of moves

    for (int bid : func.block_order) {
        auto& block = func.blocks[bid];
        block->from_id = pc;
        for (auto& instr : block->instructions) {
            instr.id = pc;
            pc += 2;
        }
        block->to_id = pc; // Exclusive
    }
}

void ComputeLivenessCorrect(ir::Function& func) {
     for (auto& pair : func.blocks) {
        auto& block = pair.second;
        block->gen.clear();
        block->kill.clear();

        for (auto it = block->instructions.rbegin(); it != block->instructions.rend(); ++it) {
            auto& instr = *it;

            // Phi nodes define a variable (Kill) but do not Gen locally (operands come from preds)
            if (instr.op == ir::OpCode::Phi) {
                if (instr.has_output()) {
                    block->kill.insert(instr.result_id);
                }
                continue;
            }

            if (instr.has_output()) {
                block->kill.insert(instr.result_id);
                block->gen.erase(instr.result_id);
            }
            for (auto& arg : instr.args) {
                if (arg.type == ir::Operand::VirtReg) {
                    block->gen.insert(arg.value);
                }
            }
        }
    }

    // Now run the loop
    bool changed = true;
    while (changed) {
        changed = false;
        for (auto it = func.block_order.rbegin(); it != func.block_order.rend(); ++it) {
            auto& block = func.blocks[*it];
            std::set<int> live_out;

            for (int succ_id : block->succs) {
                auto& succ = func.blocks[succ_id];
                // Union succ->live_in
                for (int r : succ->live_in) live_out.insert(r);

                // Add Phi inputs from succ
                for (auto& instr : succ->instructions) {
                    if (instr.op == ir::OpCode::Phi) {
                        size_t pred_idx = -1;
                        for (size_t i=0; i < succ->preds.size(); ++i) {
                            if (succ->preds[i] == block->id) {
                                pred_idx = i;
                                break;
                            }
                        }
                        if (pred_idx != (size_t)-1 && pred_idx < instr.args.size()) {
                            auto& arg = instr.args[pred_idx];
                            if (arg.type == ir::Operand::VirtReg) {
                                live_out.insert(arg.value);
                            }
                        }
                    }
                }
            }
            block->live_out = live_out;

            std::set<int> new_live_in = live_out;
            for (int k : block->kill) new_live_in.erase(k);
            for (int g : block->gen) new_live_in.insert(g);

            if (new_live_in != block->live_in) {
                block->live_in = new_live_in;
                changed = true;
            }
        }
    }
}

std::map<int, Interval> BuildIntervals(ir::Function& func) {
    ComputeLivenessCorrect(func);
    std::map<int, Interval> intervals;

    // Initialize intervals for all vregs
    // Iterate blocks in reverse order
    for (auto it = func.block_order.rbegin(); it != func.block_order.rend(); ++it) {
        auto& block = func.blocks[*it];
        int block_from = block->from_id;
        int block_to = block->to_id;

        // LiveOut variables range extends to end of block
        for (int reg : block->live_out) {
            if (intervals.find(reg) == intervals.end()) {
                intervals[reg] = {reg, block_from, block_to}; // Initial approximation
            } else {
                intervals[reg].start = std::min(intervals[reg].start, block_from);
                intervals[reg].end = std::max(intervals[reg].end, block_to);
            }
        }

        // Iterate instructions in reverse
        for (auto i_it = block->instructions.rbegin(); i_it != block->instructions.rend(); ++i_it) {
            auto& instr = *i_it;
            if (instr.op == ir::OpCode::Phi) continue;

            // Output defines the start of the interval
            if (instr.has_output()) {
                int reg = instr.result_id;
                // If interval exists (because it's live out or used later in block), update start
                // Otherwise create short interval [id, id+1) ?
                // The blog says: "intervals[opd].setFrom(op.id)"
                if (intervals.find(reg) == intervals.end()) {
                     intervals[reg] = {reg, instr.id, instr.id}; // Dead assignment?
                }
                intervals[reg].start = instr.id;
            }

            // Inputs extend interval
            for (auto& arg : instr.args) {
                if (arg.type == ir::Operand::VirtReg) {
                    int reg = arg.value;
                    if (intervals.find(reg) == intervals.end()) {
                        intervals[reg] = {reg, block_from, instr.id};
                    }
                    intervals[reg].start = std::min(intervals[reg].start, block_from);
                    intervals[reg].end = std::max(intervals[reg].end, instr.id);
                }
            }
        }
    }

    // Fix up intervals:
    // The blog uses "addRange" which unions ranges.
    // Here I used simple Min/Max which gives a single bounding box.
    // "1 interval == 1 range" mode.
    // Correctness check: if a variable is live across a hole, this Min/Max covers the hole, making it live during the hole.
    // This is conservative and safe (just uses more registers), which matches the "simple" approach.

    return intervals;
}

}
