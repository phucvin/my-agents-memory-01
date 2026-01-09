#include <iostream>
#include <vector>
#include <unordered_map>
#include <sys/mman.h>
#include <cstring>
#include <unistd.h>
#include <cstdint>
#include <iomanip>
#include <string>

// --- Definitions ---

enum Reg { R0, R1, R2, R3, NUM_REGS };

enum Opcode {
    MOVI, // MOVI reg, imm
    ADD,  // ADD dest, src
    SUBI, // SUBI reg, imm
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
int registers[NUM_REGS];
int pc = 0;
bool use_jit = true;

// JIT Code Type
typedef void (*JitFunction)(int* regs);

struct Trace {
    std::vector<Instruction> instructions;
    int start_pc;
};

// Global JIT Cache: maps PC -> Compiled Code
std::unordered_map<int, JitFunction> jit_cache;
// Profiling: maps PC (loop header) -> hotness count
std::unordered_map<int, int> loop_counters;

const int HOT_THRESHOLD = 50; // Increased threshold slightly

// --- Helper Functions ---

void print_regs() {
    std::cout << "[Registers] ";
    for (int i = 0; i < NUM_REGS; ++i) {
        std::cout << "R" << i << ":" << registers[i] << " ";
    }
    std::cout << std::endl;
}

// --- JIT Compiler ---

// Simple x86_64 encoder
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

    void emit_prologue_32() {
        // push rbx
        emit_byte(0x53);

        // mov eax, [rdi]      ; R0
        emit_byte(0x8B); emit_byte(0x07);
        // mov ebx, [rdi + 4]  ; R1
        emit_byte(0x8B); emit_byte(0x5F); emit_byte(0x04);
        // mov ecx, [rdi + 8]  ; R2
        emit_byte(0x8B); emit_byte(0x4F); emit_byte(0x08);
        // mov edx, [rdi + 12] ; R3
        emit_byte(0x8B); emit_byte(0x57); emit_byte(0x0C);
    }

    void emit_epilogue_32() {
        // mov [rdi], eax      ; R0
        emit_byte(0x89); emit_byte(0x07);
        // mov [rdi + 4], ebx  ; R1
        emit_byte(0x89); emit_byte(0x5F); emit_byte(0x04);
        // mov [rdi + 8], ecx  ; R2
        emit_byte(0x89); emit_byte(0x4F); emit_byte(0x08);
        // mov [rdi + 12], edx ; R3
        emit_byte(0x89); emit_byte(0x57); emit_byte(0x0C);

        // pop rbx
        emit_byte(0x5B);
        // ret
        emit_byte(0xC3);
    }

    // mov reg, imm32
    void emit_movi(int reg, int imm) {
        // B8+reg imm32
        uint8_t x86_reg = map_reg(reg);
        emit_byte(0xB8 + x86_reg);
        emit_int32(imm);
    }

    // add dest, src
    void emit_add(int dest, int src) {
        // add r/m32, r32
        uint8_t r_dest = map_reg(dest);
        uint8_t r_src = map_reg(src);
        emit_byte(0x01);
        emit_byte(0xC0 | (r_src << 3) | r_dest);
    }

    // sub reg, imm
    void emit_subi(int reg, int imm) {
        // 81 /5 id
        uint8_t r = map_reg(reg);
        emit_byte(0x81);
        emit_byte(0xE8 | r);
        emit_int32(imm);
    }

    // cmp reg, imm
    void emit_cmp(int reg, int imm) {
        // 81 /7 id
        uint8_t r = map_reg(reg);
        emit_byte(0x81);
        emit_byte(0xF8 | r);
        emit_int32(imm);
    }

    // jne rel32
    void emit_jne_rel32(int32_t offset) {
        emit_byte(0x0F);
        emit_byte(0x85);
        emit_int32(offset);
    }

    uint8_t map_reg(int r) {
        switch(r) {
            case R0: return 0; // EAX
            case R1: return 3; // EBX
            case R2: return 1; // ECX
            case R3: return 2; // EDX
        }
        return 0;
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
    enc.emit_prologue_32();

    int loop_header_offset = enc.current_offset();

    for (const auto& inst : trace.instructions) {
        switch (inst.op) {
            case MOVI: enc.emit_movi(inst.reg1, inst.imm); break;
            case ADD:  enc.emit_add(inst.reg1, inst.reg2); break;
            case SUBI: enc.emit_subi(inst.reg1, inst.imm); break;
            case CMP:  enc.emit_cmp(inst.reg1, inst.imm); break;
            case JNE: {
                // This logic assumes every JNE in the trace is a back-edge to the loop header.
                // It does not support internal branches (e.g. if/else inside the loop).
                int32_t offset = loop_header_offset - (enc.current_offset() + 6);
                enc.emit_jne_rel32(offset);
                break;
            }
            default: break;
        }
    }

    enc.emit_epilogue_32();

    void* func = enc.finalize();
    return (JitFunction)func;
}

// --- Interpreter ---

void run(std::vector<Instruction>& program) {
    bool tracing = false;
    Trace current_trace;

    while (static_cast<size_t>(pc) < program.size()) {
        // 1. Check if we have JIT code for this PC
        if (use_jit && !tracing && jit_cache.count(pc)) {
            // std::cout << "[JIT] Switching to JIT code at PC " << pc << std::endl;
            JitFunction jit_func = jit_cache[pc];
            jit_func(registers);

            // JIT execution finished (loop exit).
            // Find the JNE that ends the loop to determine next PC.
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
            case MOVI: registers[inst.reg1] = inst.imm; pc++; break;
            case ADD:  registers[inst.reg1] += registers[inst.reg2]; pc++; break;
            case SUBI: registers[inst.reg1] -= inst.imm; pc++; break;
            case CMP:  /* Flags implicitly used by JNE next */ pc++; break;
            case JNE: {
                int target = inst.imm;
                bool condition = false;
                // Peek back one instruction for simplicity
                if (pc > 0 && program[pc-1].op == CMP) {
                    Instruction& cmp = program[pc-1];
                    condition = (registers[cmp.reg1] != cmp.imm);
                }

                if (condition) { // JNE taken
                    if (target <= pc) { // Back-edge
                        if (use_jit && !tracing) {
                            loop_counters[target]++;
                            if (loop_counters[target] > HOT_THRESHOLD) {
                                // std::cout << "[Profiler] Hot loop detected at PC " << target << ". Starting trace." << std::endl;
                                tracing = true;
                                current_trace.start_pc = target;
                                current_trace.instructions.clear();
                            }
                        } else if (tracing) {
                            // Loop closed
                            if (target == current_trace.start_pc) {
                                // std::cout << "[Tracer] Loop closed. Compiling trace." << std::endl;
                                tracing = false;
                                jit_cache[target] = compile_trace(current_trace);
                            }
                        }
                    }
                    pc = target;
                } else {
                    pc++;
                    if (tracing) {
                        // Loop exited during trace recording
                        tracing = false;
                    }
                }
                break;
            }
            case PRINT: std::cout << registers[inst.reg1] << std::endl; pc++; break;
            case EXIT:  return;
        }
    }
}

int main(int argc, char** argv) {
    if (argc > 1 && std::string(argv[1]) == "--no-jit") {
        use_jit = false;
    }

    std::vector<Instruction> program = {
        {MOVI, R0, 0, 0},
        {MOVI, R1, 0, 200000000}, // 200M iterations
        {ADD, R0, R1, 0},         // 2: R0 += R1
        {SUBI, R1, 0, 1},         // 3: R1 -= 1
        {CMP, R1, 0, 0},          // 4: CMP R1, 0
        {JNE, 0, 0, 2},           // 5: JNE 2
        {PRINT, R0, 0, 0},
        {EXIT, 0, 0, 0}
    };

    if (use_jit) {
        std::cout << "Running with JIT..." << std::endl;
    } else {
        std::cout << "Running with Interpreter..." << std::endl;
    }

    clock_t start = clock();
    run(program);
    clock_t end = clock();

    std::cout << "Time: " << std::fixed << std::setprecision(4)
              << double(end - start) / CLOCKS_PER_SEC << "s" << std::endl;

    return 0;
}
