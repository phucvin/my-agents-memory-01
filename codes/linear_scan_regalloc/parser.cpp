#include "parser.h"
#include <sstream>
#include <iostream>
#include <regex>

namespace parser {

using namespace ir;

OpCode ParseOp(const std::string& s) {
    if (s == "Const") return OpCode::Const;
    if (s == "Add") return OpCode::Add;
    if (s == "Sub") return OpCode::Sub;
    if (s == "Lt") return OpCode::Lt;
    if (s == "Mul") return OpCode::Mul;
    if (s == "Phi") return OpCode::Phi;
    if (s == "Jump") return OpCode::Jump;
    if (s == "Branch") return OpCode::Branch;
    if (s == "Return") return OpCode::Return;
    return OpCode::Unknown;
}

Function Parse(const std::string& input) {
    Function func;
    std::stringstream ss(input);
    std::string line;
    Block* current_block = nullptr;

    std::regex block_header(R"(Block (\d+):)");
    std::regex preds_regex(R"(Preds:(.*))");
    std::regex succs_regex(R"(Succs:(.*))");
    std::regex instr_assign(R"(\s*%(\d+)\s*=\s*([a-zA-Z0-9]+)\((.*)\))");
    std::regex instr_void(R"(\s*([a-zA-Z0-9]+)\((.*)\))");

    while (std::getline(ss, line)) {
        if (line.empty()) continue;

        std::smatch matches;
        if (std::regex_search(line, matches, block_header)) {
            int id = std::stoi(matches[1]);
            func.blocks[id] = std::make_unique<Block>();
            current_block = func.blocks[id].get();
            current_block->id = id;
            func.block_order.push_back(id); // Assume input is somewhat ordered, will reorder later
        } else if (std::regex_search(line, matches, preds_regex)) {
            std::stringstream ps(matches[1]);
            int p;
            while (ps >> p) current_block->preds.push_back(p);
        } else if (std::regex_search(line, matches, succs_regex)) {
            std::stringstream s_ss(matches[1]);
            int s_id;
            while (s_ss >> s_id) current_block->succs.push_back(s_id);
        } else if (std::regex_search(line, matches, instr_assign)) {
            Instruction instr;
            instr.text = line;
            instr.result_id = std::stoi(matches[1]);
            if (instr.result_id > func.max_vreg) func.max_vreg = instr.result_id;

            instr.op = ParseOp(matches[2]);

            std::string args_str = matches[3];
            std::regex arg_split(R"([^,\s]+)");
            auto args_begin = std::sregex_iterator(args_str.begin(), args_str.end(), arg_split);
            auto args_end = std::sregex_iterator();

            for (std::sregex_iterator i = args_begin; i != args_end; ++i) {
                std::string arg = i->str();
                if (arg[0] == '%') {
                    instr.args.push_back(Operand::Reg(std::stoi(arg.substr(1))));
                } else {
                    try {
                        instr.args.push_back(Operand::Const(std::stoi(arg)));
                    } catch (...) {
                         // Might be just text, ignore for now or handle
                    }
                }
            }
            current_block->instructions.push_back(instr);
        } else if (std::regex_search(line, matches, instr_void)) {
            Instruction instr;
            instr.text = line;
            instr.result_id = -1;
            instr.op = ParseOp(matches[1]);

            std::string args_str = matches[2];
            // Split args
            std::regex arg_split(R"([^,\s]+)");
            auto args_begin = std::sregex_iterator(args_str.begin(), args_str.end(), arg_split);
            auto args_end = std::sregex_iterator();

            for (std::sregex_iterator i = args_begin; i != args_end; ++i) {
                std::string arg = i->str();
                if (arg[0] == '%') {
                    instr.args.push_back(Operand::Reg(std::stoi(arg.substr(1))));
                } else {
                    // Could be block id for branch
                    try {
                        instr.args.push_back(Operand::Const(std::stoi(arg)));
                    } catch (...) {
                    }
                }
            }
            current_block->instructions.push_back(instr);
        }
    }

    return func;
}

}
