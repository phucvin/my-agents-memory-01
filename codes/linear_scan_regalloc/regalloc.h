#ifndef REGALLOC_H
#define REGALLOC_H

#include "liveness.h"
#include <vector>

namespace regalloc {

struct Allocation {
    std::map<int, int> reg_mapping; // vreg -> preg
    std::map<int, int> stack_mapping; // vreg -> stack slot
    int spilled_count = 0;
};

Allocation LinearScan(const std::map<int, liveness::Interval>& intervals, int num_regs);

}

#endif
