#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include "Lexer.h"
#include "Parser.h"
#include "Interpreter.h"

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <script>" << std::endl;
        return 1;
    }

    std::ifstream file(argv[1]);
    if (!file.is_open()) {
        std::cerr << "Could not open file " << argv[1] << std::endl;
        return 1;
    }

    std::stringstream buffer;
    buffer << file.rdbuf();
    std::string source = buffer.str();

    silang::Lexer lexer(source);
    std::vector<silang::Token> tokens = lexer.scanTokens();


    /*
    // Debug tokens
    for (const auto& t : tokens) {
        std::cout << "Token: " << t.text << " Type: " << (int)t.type << " Line: " << t.line << std::endl;
    }
    */

    silang::Parser parser(tokens);
    std::shared_ptr<silang::Program> program = parser.parse();

    if (program) {
        silang::Interpreter interpreter;
        interpreter.interpret(program);
    } else {
        std::cerr << "Parsing failed." << std::endl;
        return 1;
    }

    return 0;
}
