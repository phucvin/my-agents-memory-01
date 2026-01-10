#pragma once

#include "ir.h"
#include <set>
#include <map>
#include <stack>

namespace ssa {

// Helper to compute Dominators and Dominance Frontier
struct DominatorTree {
    Function* func;
    std::map<int, std::set<int>> doms; // set of dominators for each block
    std::map<int, int> idom; // immediate dominator
    std::map<int, std::vector<int>> dom_tree_children;
    std::map<int, std::set<int>> df; // dominance frontier

    DominatorTree(Function* f);
    void Compute();
    void ComputeDominanceFrontier();
};

// Generic converter base or utility functions
class SSAConverter {
public:
    static std::shared_ptr<Function> ConvertToStandard(const Function& input);
    static std::shared_ptr<Function> ConvertToFunctional(const Function& input);
    static std::shared_ptr<Function> ConvertToPizlo(const Function& input);
};

}
