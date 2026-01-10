#ifndef LIVENESS_H
#define LIVENESS_H

#include "ir.h"
#include <map>

namespace liveness {

struct Interval {
    int reg_id;
    int start;
    int end;

    // For debugging
    std::string ToString() const;
};

void NumberInstructions(ir::Function& func);
void ComputeLiveness(ir::Function& func);
std::map<int, Interval> BuildIntervals(ir::Function& func);

}

#endif
