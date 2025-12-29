import os

def generate_project(num_files=50):
    if not os.path.exists("src"):
        os.makedirs("src")

    # Generate header
    with open("src/common.h", "w") as f:
        f.write("#ifndef COMMON_H\n#define COMMON_H\n")
        f.write("#include <vector>\n#include <numeric>\n")
        f.write("int heavy_computation(int input);\n")
        for i in range(num_files):
            f.write(f"int func_{i}(int input);\n")
        f.write("#endif\n")

    # Generate source files
    for i in range(num_files):
        with open(f"src/file_{i}.cpp", "w") as f:
            f.write(f'#include "common.h"\n')
            f.write(f"int func_{i}(int input) {{\n")
            # Some dummy heavy work (templates often slow things down, so let's use some)
            f.write("    std::vector<int> v(1000, input);\n")
            f.write("    return std::accumulate(v.begin(), v.end(), 0);\n")
            f.write("}\n")

    # Generate main
    with open("src/main.cpp", "w") as f:
        f.write('#include "common.h"\n#include <iostream>\n')
        f.write("int main() {\n")
        f.write("    int result = 0;\n")
        for i in range(num_files):
            f.write(f"    result += func_{i}(1);\n")
        f.write("    std::cout << result << std::endl;\n")
        f.write("    return 0;\n")
        f.write("}\n")

    # Create Unity Build file (include all sources in one)
    with open("src/unity_build.cpp", "w") as f:
        for i in range(num_files):
            f.write(f'#include "file_{i}.cpp"\n')
        # We need to handle main separately or rename it, but for simplicity
        # we can just include main content here or compile main separately.
        # Let's just put main logic here for the unity build.
        f.write('#include <iostream>\n')
        f.write("int main() {\n")
        f.write("    int result = 0;\n")
        for i in range(num_files):
            f.write(f"    result += func_{i}(1);\n")
        f.write("    std::cout << result << std::endl;\n")
        f.write("    return 0;\n")
        f.write("}\n")

if __name__ == "__main__":
    generate_project()
