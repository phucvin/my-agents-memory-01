#include <iostream>
#include <vector>
#include <unordered_map>
#include <sys/mman.h>
#include <cstring>
#include <unistd.h>
#include <cstdint>
#include <iomanip>
#include <string>
#include <fstream>
#include <sstream>
#include <cctype>
#include <map>

// --- Definitions ---

enum Type { TYPE_INT, TYPE_UNKNOWN };

struct Value {
    Type type;
    int64_t val; // Use 64-bit for alignment
};

enum Opcode {
    MOVI, // MOVI dest, imm
    MOV,  // MOV dest, src
    ADD,  // ADD dest, src
    SUB,  // SUB dest, src
    SUBI, // SUBI dest, imm
    CMP,  // CMP reg, imm
    JNE,  // JNE target (target is instruction index)
    PRINT,// PRINT reg
    EXIT  // EXIT
};

struct Instruction {
    Opcode op;
    int reg1;
    int reg2;
    int imm;
};

// Machine state
const int MAX_REGS = 256;
Value registers[MAX_REGS];
int pc = 0;
bool use_jit = true;

// JIT Code Type
typedef void (*JitFunction)(Value* regs);

struct Trace {
    std::vector<Instruction> instructions;
    int start_pc;
};

// Global JIT Cache: maps PC -> Compiled Code
std::unordered_map<int, JitFunction> jit_cache;
// Profiling: maps PC (loop header) -> hotness count
std::unordered_map<int, int> loop_counters;

const int HOT_THRESHOLD = 50;

// --- Helper Functions ---

void print_val(const Value& v) {
    if (v.type == TYPE_INT) {
        std::cout << v.val;
    } else {
        std::cout << "<unknown>";
    }
}

// --- JIT Compiler ---

class Encoder {
    std::vector<uint8_t> code;
public:
    void emit_byte(uint8_t b) { code.push_back(b); }
    void emit_int32(int32_t val) {
        code.push_back(val & 0xFF);
        code.push_back((val >> 8) & 0xFF);
        code.push_back((val >> 16) & 0xFF);
        code.push_back((val >> 24) & 0xFF);
    }

    void emit_prologue() {
        emit_byte(0x53); // push rbx
    }

    void emit_epilogue() {
        emit_byte(0x5B); // pop rbx
        emit_byte(0xC3); // ret
    }

    int get_val_offset(int reg_idx) {
        return reg_idx * 16 + 8;
    }

    // mov dest, imm32
    void emit_movi(int dest, int imm) {
        int offset = get_val_offset(dest);
        emit_byte(0x48);
        emit_byte(0xC7);
        emit_byte(0x87);
        emit_int32(offset);
        emit_int32(imm);
    }

    // mov dest, src
    void emit_mov(int dest, int src) {
        int dest_off = get_val_offset(dest);
        int src_off = get_val_offset(src);
        // mov rax, [rdi + src_off]
        emit_byte(0x48); emit_byte(0x8B); emit_byte(0x87); emit_int32(src_off);
        // mov [rdi + dest_off], rax
        emit_byte(0x48); emit_byte(0x89); emit_byte(0x87); emit_int32(dest_off);
    }

    // add dest, src
    void emit_add(int dest, int src) {
        int dest_off = get_val_offset(dest);
        int src_off = get_val_offset(src);
        // mov rax, [rdi + src_off]
        emit_byte(0x48); emit_byte(0x8B); emit_byte(0x87); emit_int32(src_off);
        // add [rdi + dest_off], rax
        emit_byte(0x48); emit_byte(0x01); emit_byte(0x87); emit_int32(dest_off);
    }

    // sub dest, src
    void emit_sub(int dest, int src) {
        int dest_off = get_val_offset(dest);
        int src_off = get_val_offset(src);
        // mov rax, [rdi + src_off]
        emit_byte(0x48); emit_byte(0x8B); emit_byte(0x87); emit_int32(src_off);
        // sub [rdi + dest_off], rax
        emit_byte(0x48); emit_byte(0x29); emit_byte(0x87); emit_int32(dest_off);
    }

    // sub reg, imm
    void emit_subi(int reg, int imm) {
        int offset = get_val_offset(reg);
        // sub qword [rdi + offset], imm
        emit_byte(0x48); emit_byte(0x81); emit_byte(0xAF); emit_int32(offset);
        emit_int32(imm);
    }

    // cmp reg, imm
    void emit_cmp(int reg, int imm) {
        int offset = get_val_offset(reg);
        // cmp qword [rdi + offset], imm
        emit_byte(0x48);
        emit_byte(0x81);
        emit_byte(0xBF);
        emit_int32(offset);
        emit_int32(imm);
    }

    // jne rel32
    void emit_jne_rel32(int32_t offset) {
        emit_byte(0x0F);
        emit_byte(0x85);
        emit_int32(offset);
    }

    void* finalize() {
        void* mem = mmap(nullptr, code.size(), PROT_READ | PROT_WRITE | PROT_EXEC,
                         MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        memcpy(mem, code.data(), code.size());
        return mem;
    }

    int current_offset() { return code.size(); }
};

JitFunction compile_trace(const Trace& trace) {
    Encoder enc;
    enc.emit_prologue();

    int loop_header_offset = enc.current_offset();

    for (const auto& inst : trace.instructions) {
        switch (inst.op) {
            case MOVI: enc.emit_movi(inst.reg1, inst.imm); break;
            case MOV:  enc.emit_mov(inst.reg1, inst.reg2); break;
            case ADD:  enc.emit_add(inst.reg1, inst.reg2); break;
            case SUB:  enc.emit_sub(inst.reg1, inst.reg2); break;
            case SUBI: enc.emit_subi(inst.reg1, inst.imm); break;
            case CMP:  enc.emit_cmp(inst.reg1, inst.imm); break;
            case JNE: {
                int32_t offset = loop_header_offset - (enc.current_offset() + 6);
                enc.emit_jne_rel32(offset);
                break;
            }
            default: break;
        }
    }

    enc.emit_epilogue();

    void* func = enc.finalize();
    return (JitFunction)func;
}

// --- Interpreter ---

void run(std::vector<Instruction>& program) {
    bool tracing = false;
    Trace current_trace;

    while (static_cast<size_t>(pc) < program.size()) {
        if (use_jit && !tracing && jit_cache.count(pc)) {
            JitFunction jit_func = jit_cache[pc];
            jit_func(registers);

            int loop_end_pc = -1;
            for(size_t i = pc; i < program.size(); ++i) {
                if (program[i].op == JNE && program[i].imm == pc) {
                    loop_end_pc = i;
                    break;
                }
            }
            if (loop_end_pc != -1) {
                pc = loop_end_pc + 1;
                continue;
            }
        }

        Instruction& inst = program[pc];

        if (tracing) {
            current_trace.instructions.push_back(inst);
        }

        switch (inst.op) {
            case MOVI:
                registers[inst.reg1].val = inst.imm;
                registers[inst.reg1].type = TYPE_INT;
                pc++;
                break;
            case MOV:
                registers[inst.reg1] = registers[inst.reg2];
                pc++;
                break;
            case ADD:
                registers[inst.reg1].val += registers[inst.reg2].val;
                pc++;
                break;
            case SUB:
                registers[inst.reg1].val -= registers[inst.reg2].val;
                pc++;
                break;
            case SUBI:
                registers[inst.reg1].val -= inst.imm;
                pc++;
                break;
            case CMP:  /* Flags implicitly used by JNE next */ pc++; break;
            case JNE: {
                int target = inst.imm;
                bool condition = false;
                if (pc > 0 && program[pc-1].op == CMP) {
                    Instruction& cmp = program[pc-1];
                    condition = (registers[cmp.reg1].val != cmp.imm);
                }

                if (condition) {
                    if (target <= pc) { // Back-edge
                        if (use_jit && !tracing) {
                            loop_counters[target]++;
                            if (loop_counters[target] > HOT_THRESHOLD) {
                                tracing = true;
                                current_trace.start_pc = target;
                                current_trace.instructions.clear();
                            }
                        } else if (tracing) {
                            if (target == current_trace.start_pc) {
                                tracing = false;
                                jit_cache[target] = compile_trace(current_trace);
                            }
                        }
                    }
                    pc = target;
                } else {
                    pc++;
                    if (tracing) tracing = false;
                }
                break;
            }
            case PRINT:
                print_val(registers[inst.reg1]);
                std::cout << std::endl;
                pc++;
                break;
            case EXIT:  return;
        }
    }
}

// --- Parser ---

struct Token {
    std::string text;
    enum Kind { ID, NUM, K_VAR, K_WHILE, K_PRINT, EQ, PLUS, MINUS, LBRACE, RBRACE, LPAREN, RPAREN, SEMI, LT, GT, END } kind;
};

std::vector<Token> tokenize(const std::string& src) {
    std::vector<Token> tokens;
    size_t i = 0;
    while (i < src.size()) {
        if (isspace(src[i])) { i++; continue; }
        if (isalpha(src[i])) {
            std::string s;
            while (i < src.size() && isalnum(src[i])) s += src[i++];
            if (s == "var") tokens.push_back({s, Token::K_VAR});
            else if (s == "while") tokens.push_back({s, Token::K_WHILE});
            else if (s == "print") tokens.push_back({s, Token::K_PRINT});
            else tokens.push_back({s, Token::ID});
        } else if (isdigit(src[i])) {
            std::string s;
            while (i < src.size() && isdigit(src[i])) s += src[i++];
            tokens.push_back({s, Token::NUM});
        } else {
            char c = src[i++];
            switch(c) {
                case '=': tokens.push_back({"=", Token::EQ}); break;
                case '+': tokens.push_back({"+", Token::PLUS}); break;
                case '-': tokens.push_back({"-", Token::MINUS}); break;
                case '{': tokens.push_back({"{", Token::LBRACE}); break;
                case '}': tokens.push_back({"}", Token::RBRACE}); break;
                case '(': tokens.push_back({"(", Token::LPAREN}); break;
                case ')': tokens.push_back({")", Token::RPAREN}); break;
                case ';': tokens.push_back({";", Token::SEMI}); break;
                case '<': tokens.push_back({"<", Token::LT}); break;
                case '>': tokens.push_back({">", Token::GT}); break;
            }
        }
    }
    tokens.push_back({"", Token::END});
    return tokens;
}

class Parser {
    std::vector<Token> tokens;
    size_t pos = 0;
    std::map<std::string, int> var_map;
    int next_reg = 0;
    std::vector<Instruction> code;

public:
    Parser(const std::vector<Token>& t) : tokens(t) {}

    Token peek() { return tokens[pos]; }
    Token consume() { return tokens[pos++]; }
    void expect(Token::Kind k) {
        if (peek().kind != k) {
            std::cerr << "Syntax Error: Expected kind " << k << " got " << peek().text << std::endl;
            exit(1);
        }
        consume();
    }

    int get_var(const std::string& name) {
        if (var_map.find(name) == var_map.end()) {
            var_map[name] = next_reg++;
            if (next_reg >= MAX_REGS) {
                std::cerr << "Error: Too many variables" << std::endl;
                exit(1);
            }
        }
        return var_map[name];
    }

    void parse() {
        while (peek().kind != Token::END) {
            parse_stmt();
        }
        code.push_back({EXIT, 0, 0, 0});
    }

    void parse_stmt() {
        if (peek().kind == Token::K_VAR) {
            consume();
            std::string name = consume().text;
            expect(Token::EQ);
            int val = std::stoi(consume().text);
            expect(Token::SEMI);
            code.push_back({MOVI, get_var(name), 0, val});
        } else if (peek().kind == Token::K_WHILE) {
            consume();
            expect(Token::LPAREN);
            std::string var = consume().text;
            expect(Token::GT);
            int val = std::stoi(consume().text);
            expect(Token::RPAREN);
            expect(Token::LBRACE);

            int loop_start = code.size();
            int body_start = loop_start;
            while (peek().kind != Token::RBRACE) {
                parse_stmt();
            }
            expect(Token::RBRACE);

            code.push_back({CMP, get_var(var), 0, val});
            code.push_back({JNE, 0, 0, body_start});

        } else if (peek().kind == Token::K_PRINT) {
            consume();
            expect(Token::LPAREN);
            std::string name = consume().text;
            expect(Token::RPAREN);
            expect(Token::SEMI);
            code.push_back({PRINT, get_var(name), 0, 0});
        } else if (peek().kind == Token::ID) {
            std::string name = consume().text;
            expect(Token::EQ);
            std::string operand1 = consume().text;
            Token op = consume();
            if (op.kind == Token::PLUS || op.kind == Token::MINUS) {
                std::string operand2 = consume().text;
                bool is_num = isdigit(operand2[0]);
                int reg_dest = get_var(name);
                int reg_op1 = get_var(operand1);

                // If dest != op1, we need to move op1 to dest first, then apply op2
                if (reg_dest != reg_op1) {
                    code.push_back({MOV, reg_dest, reg_op1, 0});
                }

                if (op.kind == Token::PLUS) {
                    if (is_num) {
                         // Not supported
                    } else {
                        code.push_back({ADD, reg_dest, get_var(operand2), 0});
                    }
                } else { // MINUS
                    if (is_num) {
                        code.push_back({SUBI, reg_dest, 0, std::stoi(operand2)});
                    } else {
                        code.push_back({SUB, reg_dest, get_var(operand2), 0});
                    }
                }
            }
            expect(Token::SEMI);
        } else {
            consume();
        }
    }

    std::vector<Instruction> get_code() { return code; }
};

int main(int argc, char** argv) {
    std::string filename;

    for(int i=1; i<argc; ++i) {
        std::string arg = argv[i];
        if (arg == "--no-jit") {
            use_jit = false;
        } else {
            filename = arg;
        }
    }

    std::string source;
    if (!filename.empty()) {
        std::ifstream f(filename);
        if (!f) {
            std::cerr << "Could not open file: " << filename << std::endl;
            return 1;
        }
        std::stringstream buffer;
        buffer << f.rdbuf();
        source = buffer.str();
    } else {
        source =
            "var sum = 0; "
            "var x = 200000000; "
            "while (x > 0) { "
            "  sum = sum + x; "
            "  x = x - 1; "
            "} "
            "print(sum);";
        std::cout << "Executing default program: " << source << std::endl;
    }

    if (use_jit) {
        std::cout << "Running with JIT..." << std::endl;
    } else {
        std::cout << "Running with Interpreter..." << std::endl;
    }

    auto tokens = tokenize(source);
    Parser p(tokens);
    p.parse();
    auto prog = p.get_code();

    clock_t start = clock();
    run(prog);
    clock_t end = clock();

    std::cout << "Time: " << std::fixed << std::setprecision(4)
              << double(end - start) / CLOCKS_PER_SEC << "s" << std::endl;

    return 0;
}
