#pragma once
#include "ir.h"
#include <map>
#include <string>

namespace ssa {

class CodeGenerator {
public:
    static std::string GenerateAssembly(Function* func, const std::map<int, int>& allocation, int num_regs);
};

}
