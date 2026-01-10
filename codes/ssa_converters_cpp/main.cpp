#include "ir.h"
#include "ssa.h"
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

    // Functional SSA
    auto func_ssa = SSAConverter::ConvertToFunctional(func);
    WriteToFile("functional_ssa.txt", func_ssa->ToString());

    // Pizlo SSA
    auto pizlo_ssa = SSAConverter::ConvertToPizlo(func);
    WriteToFile("pizlo_ssa.txt", pizlo_ssa->ToString());

    return 0;
}
