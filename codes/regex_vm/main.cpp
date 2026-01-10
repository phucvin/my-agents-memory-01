#include "vm.h"
#include "compiler.h"
#include <iostream>
#include <cassert>

using namespace RegexVM;

void test(const std::string& pattern, const std::string& input, bool expected, const std::vector<std::string>& expected_groups = {}) {
    std::cout << "Testing /" << pattern << "/ on \"" << input << "\"... ";
    Compiler compiler(pattern);
    auto prog = compiler.compile();

    // Debug print
    // for (size_t i = 0; i < prog.size(); ++i) {
    //     std::cout << i << ": " << prog[i].op << " " << prog[i].c << " " << prog[i].x << " " << prog[i].y << " " << prog[i].slot << std::endl;
    // }

    VM vm(prog);
    std::vector<std::string> groups;
    bool result = vm.match(input, groups);

    if (result == expected) {
        if (expected && !expected_groups.empty()) {
            bool groups_match = true;
            if (groups.size() < expected_groups.size()) groups_match = false;
            else {
                for (size_t i = 0; i < expected_groups.size(); ++i) {
                    if (groups[i] != expected_groups[i]) {
                        groups_match = false;
                        std::cout << "Group " << i << " mismatch: " << groups[i] << " != " << expected_groups[i] << " ";
                        break;
                    }
                }
            }
            if (groups_match) std::cout << "PASSED" << std::endl;
            else std::cout << "FAILED (Groups mismatch)" << std::endl;
        } else {
            std::cout << "PASSED" << std::endl;
        }
    } else {
        std::cout << "FAILED (Match result: " << result << ")" << std::endl;
    }
}

int main() {
    test("abc", "abc", true, {"abc"});
    test("abc", "abd", false);
    test("a*b", "aaab", true, {"aaab"});
    test("a*b", "b", true, {"b"});
    test("a|b", "a", true, {"a"});
    test("a|b", "b", true, {"b"});
    test("a(b|c)d", "abd", true, {"abd", "b"});
    test("a(b|c)d", "acd", true, {"acd", "c"});
    test("(a*)b", "aaab", true, {"aaab", "aaa"});
    test("((a*)b)", "aaab", true, {"aaab", "aaab", "aaa"});

    // Nested star
    test("(a*)*", "aaa", true, {"aaa", "aaa"}); // Greedy? Pike VM matches greedy.

    // Multiple groups
    test("(a)(b)", "ab", true, {"ab", "a", "b"});

    // Dot matches
    test("a.c", "abc", true, {"abc"});
    test("a.c", "axc", true, {"axc"});
    test("a.c", "ac", false);
    test(".*", "anything", true, {"anything"});

    std::cout << "Done." << std::endl;
    return 0;
}
