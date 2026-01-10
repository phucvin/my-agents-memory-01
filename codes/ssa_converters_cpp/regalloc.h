#pragma once
#include "ir.h"
#include <map>
#include <vector>
#include <set>

namespace ssa {

struct LiveInterval {
    int reg; // SSA value ID
    int start;
    int end;
    int assigned_reg = -1; // Physical register ID or -1 if spilled

    bool Overlaps(const LiveInterval& other) const {
        return start < other.end && other.start < end;
    }

    // For sorting
    bool operator<(const LiveInterval& other) const {
        return start < other.start;
    }
};

class RegisterAllocator {
public:
    // Returns map from SSA Value ID -> Physical Register ID (0-indexed)
    // If allocated_reg is -1, it means spilled (conceptually).
    static std::map<int, int> Allocate(Function* func, int num_regs);
};

}
