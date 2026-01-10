#include "regalloc.h"
#include <algorithm>
#include <iostream>
#include <set>
#include <stack>

namespace ssa {

// Helper for RPO
void PostOrderDFS(Function* func, int block_id, std::set<int>& visited, std::vector<BasicBlock*>& order) {
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

std::vector<BasicBlock*> ComputeRPO(Function* func) {
    std::set<int> visited;
    std::vector<BasicBlock*> order;
    // Assuming 0 is entry
    PostOrderDFS(func, 0, visited, order);
    std::reverse(order.begin(), order.end());
    return order;
}

std::map<int, int> RegisterAllocator::Allocate(Function* func, int num_regs) {
    // 1. Linearize Blocks (RPO)
    std::vector<BasicBlock*> blocks = ComputeRPO(func);

    // 2. Number Instructions & Identify Ranges
    // We map each instruction to a linear index.
    // Index increases by 2 to allow gap for future insertion if needed.
    int current_pos = 0;
    std::map<int, int> inst_pos; // inst_index (in block vector) -> linear_pos (global) - Wait, we need to identify inst by pointer or ID?
    // Instructions are value objects in vector, pointers unstable if vector resizes.
    // But vector is in BasicBlock, and BasicBlock is shared_ptr in Function.
    // However, we iterate blocks.

    // Let's store: block_id -> [start_pos, end_pos]
    std::map<int, std::pair<int, int>> block_ranges;

    // Map SSA Value ID to definition position
    std::map<int, int> def_pos;
    // Map SSA Value ID to list of use positions
    std::map<int, std::vector<int>> use_pos;

    for (auto* block : blocks) {
        int start = current_pos;
        for (const auto& inst : block->instructions) {
            int pos = current_pos;

            // Def
            if (inst.id != -1) {
                def_pos[inst.id] = pos;
            }

            // Use
            for (const auto& arg : inst.args) {
                if (arg.type == Operand::Value) {
                    use_pos[arg.value_id].push_back(pos);
                }
            }

            current_pos += 2;
        }
        int end = current_pos; // End of block (exclusive of last inst, but inclusive of block range)
        block_ranges[block->id] = {start, end};
        // Add a gap for block boundary
        current_pos += 2;
    }

    // 3. Liveness Analysis (Block Level) to handle loops/control flow
    // LiveIn/LiveOut per block
    std::map<int, std::set<int>> live_in;
    std::map<int, std::set<int>> live_out;
    bool changed = true;
    while (changed) {
        changed = false;
        // Iterate in reverse RPO (which is Post Order) for faster convergence
        for (int i = blocks.size() - 1; i >= 0; --i) {
            BasicBlock* block = blocks[i];
            std::set<int> new_out;
            for (int succ : block->succs) {
                if (live_in.count(succ)) {
                    new_out.insert(live_in[succ].begin(), live_in[succ].end());
                }
            }

            std::set<int> new_in = new_out;
            // Apply transfer function: In = Use U (Out - Def)
            // Traverse instructions in reverse
            for (auto it = block->instructions.rbegin(); it != block->instructions.rend(); ++it) {
                if (it->id != -1) {
                    new_in.erase(it->id);
                }
                for (const auto& arg : it->args) {
                    if (arg.type == Operand::Value) {
                        new_in.insert(arg.value_id);
                    }
                }
            }

            if (live_out[block->id] != new_out || live_in[block->id] != new_in) {
                live_out[block->id] = new_out;
                live_in[block->id] = new_in;
                changed = true;
            }
        }
    }

    // 4. Build Live Intervals
    std::vector<LiveInterval> intervals;
    std::set<int> all_values;
    for (auto& kv : def_pos) all_values.insert(kv.first);

    for (int v : all_values) {
        // Start is definition
        int start = def_pos[v];
        int end = start;

        // Uses extend the range
        if (use_pos.count(v)) {
            for (int u : use_pos[v]) {
                if (u > end) end = u;
            }
        }

        // LiveOut extends the range to the end of blocks where it is LiveOut
        // AND LiveIn extends range to start of blocks where it is LiveIn?
        // Actually, simple linear scan:
        // Interval covers from Def to Last Use.
        // But with control flow, "Last Use" in linear order might be in a later block.
        // If v is live across a range of blocks in linear order, we must cover that range.

        // Better approach for simple linear scan on CFG:
        // Find all blocks where v is live (LiveIn or Defined in block).
        // For each such block, the interval must cover the relevant part of the block.
        // Since we want ONE interval [min, max], we take min of all starts and max of all ends.

        // Actually, we can just iterate all blocks.
        // If v is in LiveIn[B], then it is live at B.start.
        // If v is in LiveOut[B], then it is live at B.end.
        // Uses inside B are live at their pos.

        for (auto* block : blocks) {
            bool is_live_in = live_in[block->id].count(v);
            bool is_live_out = live_out[block->id].count(v);

            if (is_live_in) {
                // Live at start of block
                // Start is usually Def, which is earlier. But if loop backedge?
                // RPO guarantees Def dominates Use, but not necessarily index order?
                // Actually RPO guarantees Def is visited before Use (except loop backedges).
                // But in linear scan, we use linear indices.
                // If Def is at 100, and Loop Backedge Use is at 50... wait.
                // SSA Def dominates Use.
                // In a loop:
                //   Block 1 (Def i) -> Block 2 (Use i) -> Block 1.
                //   RPO: 1, 2.
                //   Def at 1. Use at 2.
                //   This is fine.
                // What about:
                //   Block 1 (Def x) -> Block 2 (Use x).
                //   RPO: 1, 2.
                //   Fine.

                // So standard SSA + RPO implies Def index < Use index?
                // Yes, because Def dominates Use.
                // Dominator tree respects RPO?
                // If A dominates B, A can appear before B in RPO.
                // So start is always Def.

                // Wait, what about Phi?
                // Phi uses values from predecessors.
                // v = Phi(a, b).
                // 'a' is defined in PredA. 'a' is used in CurrentBlock (at start).
                // So 'a' is live at end of PredA.
                // In RPO, PredA might be after CurrentBlock (backedge)?
                // Yes.
                // So 'a' interval must extend to PredA end.
                // If PredA index > Def index of 'a', then interval is large.
                // That's fine for simple linear scan.

                // So, for 'v':
                // end = max(end, use_pos...)
                // For every block B where v is LiveOut:
                //   end = max(end, block_ranges[B].second)
                // For every block B where v is LiveIn:
                //   // means it is live at B start.
                //   // Does not necessarily increase 'end', but implies it lives *through* the incoming edge.
                //   // If Predecessor P is far away, we handle that by P's LiveOut.
            }

            if (is_live_out) {
                // Live at end of block
                int block_end = block_ranges[block->id].second;
                if (block_end > end) end = block_end;
            }
        }

        intervals.push_back({v, start, end, -1});
    }

    // 5. Sort Intervals
    std::sort(intervals.begin(), intervals.end());

    // 6. Allocate
    std::map<int, int> assignment;
    std::vector<LiveInterval*> active;

    for (size_t k = 0; k < intervals.size(); ++k) {
        LiveInterval& current = intervals[k];

        // Expire
        auto it = active.begin();
        while (it != active.end()) {
            if ((*it)->end < current.start) {
                it = active.erase(it);
            } else {
                ++it;
            }
        }

        if (active.size() == (size_t)num_regs) {
            // Spill decision
            LiveInterval* spill_candidate = &current;
            for (auto* act : active) {
                if (act->end > spill_candidate->end) {
                    spill_candidate = act;
                }
            }

            if (spill_candidate == &current) {
                current.assigned_reg = -1;
                assignment[current.reg] = -1;
            } else {
                // Spill an active interval
                int stolen_reg = spill_candidate->assigned_reg;
                spill_candidate->assigned_reg = -1;
                assignment[spill_candidate->reg] = -1;

                // Remove spill_candidate from active
                // std::remove in vector is annoying with pointers, just rebuild or swap
                // Simple erase
                for (auto iter = active.begin(); iter != active.end(); ++iter) {
                    if (*iter == spill_candidate) {
                        active.erase(iter);
                        break;
                    }
                }

                current.assigned_reg = stolen_reg;
                assignment[current.reg] = stolen_reg;
                active.push_back(&current);
            }
        } else {
            // Allocate
            std::set<int> used;
            for(auto* act : active) used.insert(act->assigned_reg);

            int r = 0;
            while(used.count(r)) r++;

            current.assigned_reg = r;
            assignment[current.reg] = r;
            active.push_back(&current);
        }
    }

    return assignment;
}

}
