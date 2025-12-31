#include <iostream>
#include <fstream>
#include <sstream>
#include "lexer.h"
#include "parser.h"

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

    Lexer lexer(source);
    std::vector<Token> tokens = lexer.tokenize();

    /*
    for (auto& t : tokens) {
        std::cout << t.line << ":" << t.col << " " << tokenTypeToString(t.type) << " " << t.text << std::endl;
    }
    */

    Parser parser(tokens);
    auto program = parser.parse();

    std::cout << "Parsed successfully with " << program->statements.size() << " statements." << std::endl;

    return 0;
}
