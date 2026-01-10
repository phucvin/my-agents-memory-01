#include "vm.h"
#include <set>
#include <map>

namespace RegexVM {

VM::VM(const std::vector<Instruction>& prog) : prog_(prog) {}

// A helper structure to manage the list of active threads
struct ThreadList {
    std::vector<Thread> threads;
    std::set<int> visited; // active PC in current step to prevent duplicates/loops

    void add_thread(const Thread& t, const std::vector<Instruction>& prog) {
        if (visited.count(t.pc)) return;
        visited.insert(t.pc);

        if (t.pc >= prog.size()) return;

        const Instruction& inst = prog[t.pc];
        if (inst.op == OP_JMP) {
            add_thread(Thread(inst.x, t.saved), prog);
        } else if (inst.op == OP_SPLIT) {
            add_thread(Thread(inst.x, t.saved), prog);
            add_thread(Thread(inst.y, t.saved), prog);
        } else if (inst.op == OP_SAVE) {
            Thread new_t = t;
            // The slot value is the index in the input string?
            // Wait, we need the current string position (sp) which is not passed here.
            // But this add_thread is called recursively. The `sp` is implicit for the step.
            // Actually, for SAVE, we need to record the current position.
            // But we don't have access to `sp` here easily if we treat it as simple recursion.
            // We should treat SAVE as a consuming instruction or handle it carefully.

            // In Pike VM, SAVE is non-consuming (epsilon transition), but it modifies the thread state.
            // So we execute it immediately and continue.
            // However, we need the `current_input_pos`.
            // Let's refactor `add_thread` to take `current_sp`.
        } else {
            threads.push_back(t);
        }
    }
};

// Refined helper to include current string position for SAVE
void add_thread(Thread t,
                std::vector<Thread>& pool,
                std::set<int>& visited,
                const std::vector<Instruction>& prog,
                int current_sp) {

    if (t.pc >= prog.size()) return;

    // Special handling for SAVE: the state (pc, saved) matters, but usually for Pike VM
    // we just use (pc). However, if we discard a thread because PC is visited,
    // we might discard a thread with *better* captures?
    // In "leftmost greedy", we want the first thread arriving at PC.
    // So 'visited' check is correct for prioritization.
    // BUT, SAVE instruction itself shouldn't just mark PC visited and stop others if it's epsilon?
    // No, if we have:
    // L1: SAVE 0 -> L2
    // L2: CHAR 'a'
    // If we process path A -> L1, we mark L1 visited. We go to L2, mark L2 visited.
    // Path B -> L1. L1 visited. Stop.
    // This assumes Path A is higher priority.

    // The issue with the test failures might be related to how SPLIT is ordered or SAVE handling.
    // Let's debug by checking if 'visited' check needs to be skipped for SAVE?
    // No, because SAVE increments PC. So the 'key' (PC) changes.
    // Wait, the recursive call `add_thread` checks `visited.count(t.pc)`.
    // If `inst.op == OP_SAVE`, we do `t.pc++` and call `add_thread`.
    // So we check visited for the *target* of SAVE.
    // We do NOT check visited for the SAVE instruction itself in the `OP_SAVE` block logic effectively,
    // because we already passed the check at the top of the function for the *current* PC (the SAVE instruction).

    // Wait.
    // 1. Enter `add_thread` with PC pointing to SAVE.
    // 2. Check `visited`: if yes, return. Else insert PC.
    // 3. Switch `OP_SAVE`: update saved, increment PC (now points to next inst), recurse.
    // 4. Recurse enters `add_thread` with new PC. Checks `visited`.

    // This seems correct for DAGs.
    // For loops (StarNode), we might have issues?
    // StarNode: SPLIT L2, End. L2: ... JMP L1.
    // If we have `(a*)*`, we might have loops of epsilons?
    // `(a*)*` matches empty string.
    // Empty match -> loop -> infinite recursion?

    if (visited.count(t.pc)) return;
    visited.insert(t.pc);

    const Instruction& inst = prog[t.pc];

    switch (inst.op) {
        case OP_JMP:
            t.pc = inst.x;
            add_thread(t, pool, visited, prog, current_sp);
            break;
        case OP_SPLIT:
            {
                Thread t1 = t; t1.pc = inst.x;
                add_thread(t1, pool, visited, prog, current_sp);
                Thread t2 = t; t2.pc = inst.y;
                add_thread(t2, pool, visited, prog, current_sp);
            }
            break;
        case OP_SAVE:
            {
                // Ensure vector is large enough
                if (t.saved.size() <= (size_t)inst.slot) {
                    t.saved.resize(inst.slot + 1, -1);
                }
                t.saved[inst.slot] = current_sp;
                t.pc++;

                // SAVE is an epsilon transition, so we immediately process the next instruction.
                // However, we must ensure we don't discard this thread just because 'visited' has the *original* PC.
                // But wait, 'visited' tracks PCs processed in this step.
                // If we hit SAVE at PC=10, we process it. The next instruction is PC=11.
                // We call add_thread for PC=11.
                // If PC=11 was already visited in this step (by another path), we drop this path.
                // This is standard Pike VM behavior: "first thread to reach PC wins".
                // Since we process threads in priority order (left to right), the first one is the "best".

                add_thread(t, pool, visited, prog, current_sp);
            }
            break;
        default:
            // CHAR, MATCH
            // These consume or finish, so they are added to the list for the *next* step (or current matching phase)
            pool.push_back(t);
            break;
    }
}

bool VM::match(const std::string& input, std::vector<std::string>& captured_groups) {
    std::vector<Thread> clist;
    std::vector<Thread> nlist;
    std::set<int> visited;

    // Initial thread
    // Assuming 2 slots per capture group (start, end)
    // We don't know how many slots upfront easily unless passed, but vector resizes dynamically.
    Thread start_t(0, {});
    add_thread(start_t, clist, visited, prog_, 0);

    const char* p = input.c_str();
    const char* end = p + input.length();
    int sp = 0;

    Thread* matched_thread = nullptr;
    // We need to keep a copy of the successful match because clist clears.
    // Actually, if we hit MATCH, we can stop if we are satisfied with *any* match?
    // Regex usually wants longest match or first match.
    // Pike VM delivers "leftmost greedy" if we order SPLIT x, y correctly (prefer x).

    // Loop over input
    // We also need to run one more step at the end of input to handle empty matches or end-anchors if any (not supported yet).
    // Or simply to catch the MATCH instruction if it's reached after the last char.

    // Note: The loop should run `input.length() + 1` times effectively?
    // or we process `clist` which might contain MATCH.

    for (int i = 0; i <= input.length(); ++i) {
        visited.clear();
        nlist.clear();

        // Check for match in current list and prepare next list
        bool found_match_in_step = false;

        for (const auto& t : clist) {
            const Instruction& inst = prog_[t.pc];
            if (inst.op == OP_MATCH) {
                // Found a match!
                // Since threads are prioritized, the first one we see is the best one?
                // Yes, if we enqueued correctly.
                // But we continue to process the string?
                // If we want "anchored" match (match entire string), we only accept if i == len.
                // If we want "search", it's different.
                // Let's assume the regex is anchored for now (implicit ^...$).
                // Or checking `match` usually implies "matches the string".

                if (i == input.length()) { // Matched at the end
                    // Convert saved slots to strings
                    captured_groups.clear();
                    for (size_t k = 0; k < t.saved.size(); k += 2) {
                        if (k + 1 < t.saved.size()) {
                            int start = t.saved[k];
                            int end = t.saved[k+1];
                            if (start != -1 && end != -1) {
                                captured_groups.push_back(input.substr(start, end - start));
                            } else {
                                captured_groups.push_back("");
                            }
                        }
                    }
                    return true;
                }
            } else if (inst.op == OP_CHAR) {
                if (i < input.length() && inst.c == input[i]) {
                    Thread next_t = t;
                    next_t.pc++;
                    add_thread(next_t, nlist, visited, prog_, i + 1);
                }
            }
        }
        clist = std::move(nlist);
        if (clist.empty()) break;
    }

    return false;
}

} // namespace RegexVM
