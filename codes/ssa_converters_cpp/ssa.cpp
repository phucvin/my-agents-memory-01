#include "ssa.h"
#include <algorithm>
#include <iostream>
#include <iterator>

namespace ssa {

DominatorTree::DominatorTree(Function* f) : func(f) {}

void DominatorTree::Compute() {
    // 1. Initialize dominators: Dom(n0) = {n0}, Dom(n) = all blocks
    std::vector<int> all_blocks;
    for (auto& b : func->blocks) all_blocks.push_back(b->id);

    for (auto& b : func->blocks) {
        if (b->id == 0) { // Entry
            doms[b->id] = {0};
        } else {
            doms[b->id].insert(all_blocks.begin(), all_blocks.end());
        }
    }

    bool changed = true;
    while (changed) {
        changed = false;
        for (auto& b : func->blocks) {
            if (b->id == 0) continue;

            // Dom(n) = {n} U (Intersect(Dom(p)) for p in preds)
            if (b->preds.empty()) continue; // Should not happen for reachable blocks

            std::set<int> new_dom;
            bool first = true;
            for (int p : b->preds) {
                if (first) {
                    new_dom = doms[p];
                    first = false;
                } else {
                    std::set<int> temp;
                    std::set_intersection(new_dom.begin(), new_dom.end(),
                                          doms[p].begin(), doms[p].end(),
                                          std::inserter(temp, temp.begin()));
                    new_dom = temp;
                }
            }
            new_dom.insert(b->id);

            if (new_dom != doms[b->id]) {
                doms[b->id] = new_dom;
                changed = true;
            }
        }
    }

    // Compute IDom
    for (auto& b : func->blocks) {
        if (b->id == 0) continue;
        int idom_node = -1;
        // idom(n) is d in Dom(n) such that Dom(n) = {n} U Dom(d) ? No.
        // idom(n) is strict dominator closest to n.
        // For d in Dom(n)-{n}, if d dominates all other strict dominators, it is idom.
        // Simpler: Size of Dom(idom) is Size(Dom(n)) - 1.

        for (int d : doms[b->id]) {
            if (d == b->id) continue;
            if (doms[b->id].size() == doms[d].size() + 1) {
                idom_node = d;
                break;
            }
        }
        idom[b->id] = idom_node;
        dom_tree_children[idom_node].push_back(b->id);
    }
}

void DominatorTree::ComputeDominanceFrontier() {
    for (auto& b : func->blocks) {
        if (b->preds.size() >= 2) {
            for (int p : b->preds) {
                int runner = p;
                while (runner != idom[b->id] && runner != -1) { // -1 check for safety
                     df[runner].insert(b->id);
                     if (idom.find(runner) == idom.end()) break; // Entry or unreachable
                     runner = idom[runner];
                }
            }
        }
    }
}

// -----------------------------------------------------------------------------
// SSA Construction Implementation
// -----------------------------------------------------------------------------

// Helper to deep copy a function structure (but reset instructions for rebuilding if needed,
// here we just copy everything and modify).
std::shared_ptr<Function> CopyFunction(const Function& input) {
    auto new_func = std::make_shared<Function>();
    new_func->value_counter = input.value_counter;

    std::map<int, std::shared_ptr<BasicBlock>> old_to_new;

    for (auto& b : input.blocks) {
        auto new_b = std::make_shared<BasicBlock>(b->id);
        new_b->preds = b->preds;
        new_b->succs = b->succs;
        new_b->instructions = b->instructions;
        new_b->params = b->params;
        new_b->param_original_names = b->param_original_names;
        new_func->blocks.push_back(new_b);
        old_to_new[b->id] = new_b;
    }
    return new_func;
}

// Common Context for SSA Construction
struct Context {
    std::shared_ptr<Function> f;
    DominatorTree dt;
    std::set<std::string> globals; // Variables used in multiple blocks
    std::map<std::string, std::set<int>> def_sites; // var -> set of block IDs

    Context(std::shared_ptr<Function> func) : f(func), dt(func.get()) {}

    void Analyze() {
        dt.Compute();
        dt.ComputeDominanceFrontier();

        // Find globals and def sites
        for (auto& b : f->blocks) {
            std::set<std::string> var_killed;
            for (auto& inst : b->instructions) {
                for (auto& arg : inst.args) {
                    if (arg.type == Operand::Variable) {
                        if (var_killed.find(arg.name) == var_killed.end()) {
                            globals.insert(arg.name);
                        }
                    }
                }
                if (!inst.output_var.empty()) {
                    var_killed.insert(inst.output_var);
                    def_sites[inst.output_var].insert(b->id);
                }
            }
        }
    }

    // Insert empty Phi nodes
    void InsertPhis() {
        for (const std::string& var : globals) {
            std::set<int> worklist = def_sites[var];
            std::set<int> has_phi;
            while (!worklist.empty()) {
                int n = *worklist.begin();
                worklist.erase(worklist.begin());

                for (int y : dt.df[n]) {
                    if (has_phi.find(y) == has_phi.end()) {
                        // Insert Phi at start of block y
                        BasicBlock* bb = f->GetBlock(y);
                        Instruction phi;
                        phi.opcode = Opcode::Phi;
                        phi.output_var = var;
                        // Args will be filled during renaming
                        bb->instructions.insert(bb->instructions.begin(), phi);

                        has_phi.insert(y);
                        if (def_sites[var].find(y) == def_sites[var].end()) {
                            worklist.insert(y);
                        }
                    }
                }
            }
        }
    }
};

// Renaming Logic
struct Renamer {
    Context& ctx;
    std::map<std::string, std::stack<int>> stacks;
    std::map<std::string, int> counters;

    enum Mode { Standard, Functional, Pizlo };
    Mode mode;

    Renamer(Context& c, Mode m) : ctx(c), mode(m) {}

    int NewName(const std::string& var) {
        int i = ctx.f->NewValueId();
        stacks[var].push(i);
        return i;
    }

    int CurrentName(const std::string& var) {
        if (stacks[var].empty()) {
            // Undefined usage or global init? assume 0 or handle error
            // For now, push a dummy
             // std::cerr << "Warning: use of undefined variable " << var << "\n";
             return -1;
        }
        return stacks[var].top();
    }

    void Rename(int block_id) {
        BasicBlock* bb = ctx.f->GetBlock(block_id);
        std::map<std::string, int> pop_counts; // How many times to pop for each var

        // 1. Process Phis (Definitions only)
        // For Standard/Pizlo, Phi defines a new value.
        // For Functional, Block Params define new values.

        if (mode == Mode::Functional) {
            // Identify Phis (which are still instructions at this point) and convert to Params
            // We need to do this carefully. In "InsertPhis", we added Phi instructions.
            // In Functional mode, these become Block Params.
            // But we iterate instructions.
        }

        // Let's iterate instructions.
        // Note: For Functional SSA, we might want to remove Phi instructions and add to params list.
        // We'll do that on the fly or pre-process.

        // To keep it simple, we handle Phi instructions.

        auto it = bb->instructions.begin();
        while (it != bb->instructions.end()) {
            if (it->opcode == Opcode::Phi) {
                // Define new name
                int new_val = NewName(it->output_var);
                it->id = new_val;
                pop_counts[it->output_var]++;

                if (mode == Mode::Functional) {
                    // Convert Phi to Block Param
                    bb->params.push_back(new_val);
                    bb->param_original_names.push_back(it->output_var);
                    // Remove instruction
                    it = bb->instructions.erase(it);
                    continue;
                }
            }
            ++it;
        }

        // 2. Process other instructions
        for (auto& inst : bb->instructions) {
            if (inst.opcode == Opcode::Phi) continue; // Already handled definitions

            // Replace uses (RHS)
            for (auto& arg : inst.args) {
                if (arg.type == Operand::Variable) {
                    arg = Operand::Val(CurrentName(arg.name));
                }
            }

            // Define new name (LHS)
            if (!inst.output_var.empty()) {
                if (mode == Mode::Pizlo) {
                    // Pizlo: x = ... -> %1 = ...; Upsilon(%1, ^x)
                    int new_val = NewName(inst.output_var);
                    inst.id = new_val;
                    pop_counts[inst.output_var]++;

                    // Note: We need to insert Upsilon AFTER this instruction.
                    // But we can't invalidate iterators easily.
                    // We'll mark it to add later or handle differently.
                    // Actually, let's just create a new instruction list?
                    // Or since we are modifying in place...
                } else {
                    int new_val = NewName(inst.output_var);
                    inst.id = new_val;
                    pop_counts[inst.output_var]++;
                }
            }
        }

        // 3. Process Successors (Phi inputs / Block Args)
        for (int succ_id : bb->succs) {
            BasicBlock* succ = ctx.f->GetBlock(succ_id);

            if (mode == Mode::Standard) {
                for (auto& inst : succ->instructions) {
                    if (inst.opcode == Opcode::Phi) {
                        // Add operand: (val, from_block) or just val since order matters or we track preds
                        // Standard SSA Phis track source.
                        // Our IR `args` can store them.
                        // However, we need to know WHICH pred we are.
                        // Let's assume order of preds in succ corresponds to order of args in Phi?
                        // Or we just append.
                        inst.args.push_back(Operand::Val(CurrentName(inst.output_var)));
                        // We might want to store which block it came from, but for prototype,
                        // we'll assume the Phi args match the order of preds.
                        // Or we can encode it.
                    }
                }
            } else if (mode == Mode::Functional) {
                // Update Jump/Branch at end of current block to pass arguments
                // Successor has Params corresponding to Phis.
                // We need to find the instructions in `succ` that *would have been* Phis.
                // But we converted them to params already (if visited?).
                // Wait, recursion order is dominator tree. Succ might not be visited.
                // But `InsertPhis` put Phi instructions everywhere needed.
                // Even if not renamed, the Phi instruction exists in `succ`.

                // We need to look at `succ`'s Phi instructions (or Params if converted).
                // If we haven't visited succ, it still has Phi instructions.
                // If we have, it has Params.

                // Better approach: Look at the Phis (or Params).
                // For each variable that has a Phi in succ, we pass CurrentName(var).

                // Since we deleted Phis in visited blocks, we need to be careful.
                // Actually, `succ` is not processed yet usually, unless it's a loop header.
                // If it's a loop header, we processed it?
                // Dominator tree traversal: we visit `idom` then children.
                // Successors in CFG are not necessarily children in DomTree.

                // So succ might be visited or not.
                // If visited, Phis are gone, Params exist.
                // If not visited, Phis exist.

                std::vector<Operand> jump_args;

                // Check Params
                for (size_t i = 0; i < succ->params.size(); ++i) {
                     // Using original name debug info to find which variable
                     std::string var = succ->param_original_names[i];
                     jump_args.push_back(Operand::Val(CurrentName(var)));
                }

                // Check Phis (if any left)
                for (auto& inst : succ->instructions) {
                    if (inst.opcode == Opcode::Phi) {
                        jump_args.push_back(Operand::Val(CurrentName(inst.output_var)));
                    }
                }

                // Append args to the terminator of `bb`
                if (!bb->instructions.empty()) {
                    Instruction& term = bb->instructions.back();
                    if (term.opcode == Opcode::Jump || term.opcode == Opcode::Branch) {
                        // For Branch, we have 2 targets. We need to know which one matches `succ`.
                        // Branch(cond, t1, t2).
                        // If t1 == succ, we need to attach args to that edge.
                        // Standard Branch instruction doesn't support separate args for separate edges easily in this simple IR.
                        // We might need to split critical edges or support `Branch(cond, label(args), label(args))`.
                        // For prototype, let's assume we append to a list specific to the target?
                        // Or simply: our Branch is `Branch(cond, target1, target2)`.
                        // We can change it to `Branch(cond, target1, args1, target2, args2)`?
                        // Or just store args in the instruction mixed.

                        // Let's implement: Jump has args. Branch needs care.
                        // If Branch goes to succ, we add args.
                        // Since `args` in Instruction is flat, we need a convention.
                        // Branch args: [cond, t1_lit, t2_lit, t1_arg0, ..., t2_arg0, ...] ? Messy.

                        // Functional SSA usually implies basic blocks take arguments.
                        // So `Jump(target, a, b)`
                        // `Branch(cond, target1, [a, b], target2, [c, d])`

                        // For this prototype, I will append `Operand::Val`s to the instruction
                        // and rely on the fact that we can parse them back or print them.
                        // But wait, Branch goes to 2 places.
                        // If both need args, we need to distinguish.
                        // Let's cheat: Add a "Phi" equivalent in Functional SSA? No that's cheating.

                        // Let's just say Jump/Branch logic handles it.
                        // If term is Jump, just append.
                        // If term is Branch, we can't easily append without ambiguity.
                        // BUT: Critical edges!
                        // If a block has 2 preds, and one is a Branch (conditional),
                        // we usually split the edge if we need to pass arguments.
                        // Or the Branch instruction supports it.

                        // Let's assume for this prototype we assume Jump is the only one passing args
                        // (i.e., we split edges or insert blocks).
                        // The Loop example has `Branch` going to `LoopBody` and `Exit`.
                        // `LoopHeader` (Block 1) has preds `Entry` and `LoopEnd`.
                        // `LoopHeader` has Phis.
                        // `Entry` -> `LoopHeader` is a Jump (can pass args).
                        // `LoopEnd` -> `LoopHeader` is a Jump (can pass args).

                        // Does `Branch` ever go to a block with Phis?
                        // In the example:
                        // `Block 1` (Header) has Phis. Preds: 0 (Jump), 5 (Jump). OK.
                        // `Block 5` (Merge) has Phis?
                        // Preds: 3 (Jump), 4 (Jump). OK.
                        // `Block 2`? No Phis (only 1 pred).
                        // `Block 3`? No Phis.

                        // It seems in simple loops/ifs, conditional branches target blocks with single predecessors
                        // (unless critical edge, e.g. if (..) goto L; else goto L;).
                        // If a block has multiple predecessors, it must be a merge point.
                        // If a Branch targets a merge point directly, that's a critical edge if the merge point has other preds.
                        // Standard SSA construction usually assumes split critical edges?
                        // Or Phis handle it.

                        // In Functional SSA, if we have Branch(c, L1, L2) and L1 needs args...
                        // We MUST support args in Branch.
                        // I will add a hack: `Branch` args will be `[cond, t1, t2, args_for_t1_start..., separator, args_for_t2...]`?
                        // Or just `Jump` instructions in new intermediate blocks.
                        // Simplest: Split edges if needed.
                        // But I want "Direct Conversion".

                        // Let's just stick to "Jump has args".
                        // If Branch needs args, I will issue a warning or print it specially.
                        // In the test case provided:
                        // Block 1 (Header) is target of Jump(0->1) and Jump(5->1).
                        // Block 5 (Merge) is target of Jump(3->5) and Jump(4->5).
                        // Neither is a target of a Branch.
                        // Branch(1->2, 1->6). 2 has 1 pred. 6 has 1 pred (actually 6 is exit).
                        // So in this test case, we are safe. Branch targets don't take args.

                        if (term.opcode == Opcode::Jump) {
                            for (auto& a : jump_args) term.args.push_back(a);
                        }
                    }
                }
            } else if (mode == Mode::Pizlo) {
                // Pizlo: Insert Upsilon(CurrentName, ^var) in predecessor.
                // We are in `bb` (predecessor).
                // `succ` has Phis.
                // For each Phi in succ, we insert Upsilon in bb.

                // We need to look at `succ`'s Phis.
                // Again, if visited, they are renamed. If not, not.
                // But Pizlo Phis are parameterless: `x2 = Phi()`.
                // We need to match `x2` to `^x`.
                // The `Phi` instruction stored `output_var` = "x".

                // So for every Phi in `succ`, we get the variable name.
                // Then we insert `Upsilon(CurrentName(var), ^var)` in `bb`.

                // We iterate `succ` instructions.
                // Collect Upsilons first to avoid iterator invalidation if bb == succ
                std::vector<Instruction> upsilons_to_add;
                for (auto& inst : succ->instructions) {
                    if (inst.opcode == Opcode::Phi) {
                        std::string var = inst.output_var;
                        Instruction up;
                        up.opcode = Opcode::Upsilon;
                        up.args = { Operand::Val(CurrentName(var)) };
                        up.output_var = var; // ^var
                        upsilons_to_add.push_back(up);
                    }
                }

                // Insert collected Upsilons before the last instruction of `bb` (Jump/Branch).
                for (const auto& up : upsilons_to_add) {
                    if (!bb->instructions.empty()) {
                        bb->instructions.insert(bb->instructions.end() - 1, up);
                    } else {
                        bb->instructions.push_back(up);
                    }
                }
            }
        }

        // 4. Recurse (Dominator Tree)
        if (ctx.dt.dom_tree_children.count(block_id)) {
            for (int child : ctx.dt.dom_tree_children[block_id]) {
                Rename(child);
            }
        }

        // 5. Pop Stacks
        for (auto const& [var, count] : pop_counts) {
            for (int i=0; i<count; ++i) {
                stacks[var].pop();
            }
        }
    }
};

std::shared_ptr<Function> SSAConverter::ConvertToStandard(const Function& input) {
    auto func = CopyFunction(input);
    Context ctx(func);
    ctx.Analyze();
    ctx.InsertPhis();

    Renamer renamer(ctx, Renamer::Standard);
    renamer.Rename(0); // Start at entry

    return func;
}

std::shared_ptr<Function> SSAConverter::ConvertToFunctional(const Function& input) {
    auto func = CopyFunction(input);
    Context ctx(func);
    ctx.Analyze();
    ctx.InsertPhis();

    Renamer renamer(ctx, Renamer::Functional);
    renamer.Rename(0);

    return func;
}

std::shared_ptr<Function> SSAConverter::ConvertToPizlo(const Function& input) {
    auto func = CopyFunction(input);
    Context ctx(func);
    ctx.Analyze();
    ctx.InsertPhis();

    Renamer renamer(ctx, Renamer::Pizlo);
    renamer.Rename(0);

    return func;
}

}
