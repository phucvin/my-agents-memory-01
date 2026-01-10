#include "regalloc.h"
#include <algorithm>
#include <iostream>
#include <set>

namespace regalloc {

using namespace liveness;

Allocation LinearScan(const std::map<int, Interval>& intervals, int num_regs) {
    Allocation alloc;
    std::vector<Interval> sorted_intervals;
    for (auto& p : intervals) {
        sorted_intervals.push_back(p.second);
    }

    // Sort by start position
    std::sort(sorted_intervals.begin(), sorted_intervals.end(), [](const Interval& a, const Interval& b) {
        return a.start < b.start;
    });

    std::vector<Interval> active;
    std::set<int> free_regs;
    for (int i = 0; i < num_regs; ++i) free_regs.insert(i);

    int next_stack_slot = 0;

    for (const auto& current : sorted_intervals) {
        // Expire Old Intervals
        // Remove intervals from active that end before current.start
        auto it = active.begin();
        while (it != active.end()) {
            if (it->end <= current.start) {
                // Return register to pool
                if (alloc.reg_mapping.count(it->reg_id)) {
                    free_regs.insert(alloc.reg_mapping[it->reg_id]);
                }
                it = active.erase(it);
            } else {
                ++it;
            }
        }

        if (active.size() == (size_t)num_regs) {
            // Spill at interval
            // Find interval in active that ends last
            auto spill_it = std::max_element(active.begin(), active.end(), [](const Interval& a, const Interval& b) {
                return a.end < b.end;
            });

            if (spill_it->end > current.end) {
                // Spill the active one
                int spill_reg = spill_it->reg_id;
                int reg = alloc.reg_mapping[spill_reg];

                // Move spill_reg to stack
                alloc.reg_mapping.erase(spill_reg);
                alloc.stack_mapping[spill_reg] = next_stack_slot++;
                alloc.spilled_count++;

                // Assign reg to current
                alloc.reg_mapping[current.reg_id] = reg;

                // Replace in active
                *spill_it = current;
                // We replaced the element, but we need to ensure 'active' is sorted by end point?
                // The algorithm says "add i to active, sorted by increasing end point".
                // My active list is not strictly sorted by end point in this loop, I scan it.
                // But for correctness of "max_element", it doesn't need to be sorted.
            } else {
                // Spill current
                alloc.stack_mapping[current.reg_id] = next_stack_slot++;
                alloc.spilled_count++;
            }
        } else {
            // Allocate register
            int reg = *free_regs.begin();
            free_regs.erase(free_regs.begin());
            alloc.reg_mapping[current.reg_id] = reg;
            active.push_back(current);
        }
    }

    return alloc;
}

}
