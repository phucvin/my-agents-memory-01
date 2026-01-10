#include "ir.h"
#include "ssa.h"
#include "regalloc.h"
#include <iostream>
#include <fstream>

using namespace ssa;

void WriteToFile(const std::string& filename, const std::string& content) {
    std::ofstream ofs(filename);
    ofs << content;
    ofs.close();
    std::cout << "Written to " << filename << "\n";
}

int main() {
    Function func;
    func.BuildTestProgram();

    std::string original = func.ToString();
    WriteToFile("original.txt", original);

    // Standard SSA
    auto std_ssa = SSAConverter::ConvertToStandard(func);
    WriteToFile("standard_ssa.txt", std_ssa->ToString());

    // Register Allocation on Standard SSA
    // Let's assume 3 physical registers
    std::cout << "Running Register Allocation on Standard SSA (3 regs)...\n";
    auto assignment = RegisterAllocator::Allocate(std_ssa.get(), 3);

    std::string reg_output = "Register Allocation (Value -> Reg):\n";
    for (auto kv : assignment) {
        reg_output += "%" + std::to_string(kv.first) + " -> ";
        if (kv.second == -1) reg_output += "SPILLED";
        else reg_output += "R" + std::to_string(kv.second);
        reg_output += "\n";
    }
    WriteToFile("regalloc.txt", reg_output);

    // Functional SSA
    auto func_ssa = SSAConverter::ConvertToFunctional(func);
    WriteToFile("functional_ssa.txt", func_ssa->ToString());

    // Pizlo SSA
    auto pizlo_ssa = SSAConverter::ConvertToPizlo(func);
    WriteToFile("pizlo_ssa.txt", pizlo_ssa->ToString());

    return 0;
}
