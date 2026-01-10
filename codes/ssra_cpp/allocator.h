#pragma once
#include "ir.h"
#include "lru.h"
#include <vector>
#include <algorithm>
#include <iostream>

template <size_t N>
class RegisterAllocator {
public:
    std::vector<Allocation> allocations;
    std::array<SsaVariable, N> registers;
    Lru<N> register_lru;
    std::vector<int> spare_memory;
    int total_memory_slots = 0;
    std::vector<AsmOp> out;

    RegisterAllocator(int max_ssa_vars) {
        allocations.resize(max_ssa_vars, Allocation::make_unassigned());
        for (size_t i = 0; i < N; ++i) {
            registers[i] = SsaVariable{SsaVariable::INVALID};
        }
    }

    Allocation* get_allocation(SsaVariable v) {
        if (v.id < 0 || (size_t)v.id >= allocations.size()) return nullptr;
        return &allocations[v.id];
    }

    int get_fresh_memory() {
        if (spare_memory.empty()) {
            return total_memory_slots++;
        }
        int m = spare_memory.back();
        spare_memory.pop_back();
        return m;
    }

    void release_mem(int m) {
        spare_memory.push_back(m);
    }

    int evict(int reg) {
        SsaVariable v = registers[reg];
        assert(v.id != SsaVariable::INVALID);

        int m = get_fresh_memory();
        allocations[v.id] = Allocation::make_memory(m);
        registers[reg] = SsaVariable{SsaVariable::INVALID};

        out.push_back(AsmOp{AsmOpType::Load, reg, -1, -1, m, "LOAD"});

        return m;
    }

    int get_free_register() {
        for (size_t i = 0; i < N; ++i) {
            if (registers[i].id == SsaVariable::INVALID) {
                return i;
            }
        }
        int reg = register_lru.pop();
        evict(reg);
        return reg;
    }

    int get_out_reg(SsaVariable v) {
        Allocation* alloc = get_allocation(v);
        if (alloc->type == AllocationType::Register) {
            return alloc->index;
        } else if (alloc->type == AllocationType::Memory) {
            int r = get_free_register();
            // Store needs to be emitted AFTER Op (Reverse) -> Op, Store (Forward)
            // But here get_out_reg is called before Op.
            // If we emit Store here, it is pushed BEFORE Op.
            // Forward: Op, Store.
            // Wait. get_out_reg is usually called first.
            // Then Op is pushed.
            // So out: [Store, Op].
            // Forward: Op, Store.
            // Correct.
            out.push_back(AsmOp{AsmOpType::Store, r, -1, -1, alloc->index, "STORE"});

            release_mem(alloc->index);
            allocations[v.id] = Allocation::make_register(r);
            registers[r] = v;
            register_lru.poke(r);
            return r;

        } else {
            int r = get_free_register();
            allocations[v.id] = Allocation::make_register(r);
            registers[r] = v;
            register_lru.poke(r);
            return r;
        }
    }

    void release_reg(int r) {
        if (r < 0 || (size_t)r >= N) return;
        SsaVariable v = registers[r];
        if (v.id != SsaVariable::INVALID) {
            allocations[v.id] = Allocation::make_unassigned();
            registers[r] = SsaVariable{SsaVariable::INVALID};
        }
    }

    void rebind_register(SsaVariable v, int r) {
        allocations[v.id] = Allocation::make_register(r);
        registers[r] = v;
        register_lru.poke(r);
    }

    void bind_initial_register(SsaVariable v, int r) {
        allocations[v.id] = Allocation::make_register(r);
        registers[r] = v;
        register_lru.poke(r);
    }

    void op_binary(SsaVariable out_var, SsaVariable lhs_var, SsaVariable rhs_var, Opcode /*op_code*/, const std::string& name) {
        int r_out = get_out_reg(out_var);

        release_reg(r_out);

        int r_lhs = -1;
        int r_rhs = -1;

        std::vector<AsmOp> pending_stores;

        auto process_input = [&](SsaVariable inp, int preferred_reg) -> int {
            Allocation* alloc = get_allocation(inp);
            if (alloc->type == AllocationType::Register) {
                int r = alloc->index;
                register_lru.poke(r);
                return r;
            } else if (alloc->type == AllocationType::Memory) {
                 int r = preferred_reg;
                 if (registers[r].id != SsaVariable::INVALID) {
                     r = get_free_register();
                 }

                 int m_index = alloc->index;
                 rebind_register(inp, r);
                 // Delay store
                 pending_stores.push_back(AsmOp{AsmOpType::Store, r, -1, -1, m_index, "STORE"});
                 release_mem(m_index);
                 return r;
            } else {
                 int r = preferred_reg;
                 if (registers[r].id != SsaVariable::INVALID) {
                     r = get_free_register();
                 }
                 bind_initial_register(inp, r);
                 return r;
            }
        };

        r_lhs = process_input(lhs_var, r_out);

        if (lhs_var == rhs_var) {
            r_rhs = r_lhs;
        } else {
            int pref = (registers[r_out].id == SsaVariable::INVALID) ? r_out : -1;
            r_rhs = process_input(rhs_var, (pref != -1) ? pref : 0);
        }

        this->out.push_back(AsmOp{AsmOpType::Binary, r_out, r_lhs, r_rhs, -1, name});

        // Push pending stores
        for (const auto& op : pending_stores) {
            this->out.push_back(op);
        }
    }

    void op_unary(SsaVariable out_var, SsaVariable arg_var, const std::string& name) {
        int r_out = get_out_reg(out_var);
        Allocation* alloc = get_allocation(arg_var);

        if (alloc->type == AllocationType::Register) {
            int lhs = alloc->index;
            this->out.push_back(AsmOp{AsmOpType::Unary, r_out, lhs, -1, -1, name});
            release_reg(r_out);
            register_lru.poke(lhs);
        } else if (alloc->type == AllocationType::Memory) {
            int m_y = alloc->index;
            this->out.push_back(AsmOp{AsmOpType::Unary, r_out, r_out, -1, -1, name});
            rebind_register(arg_var, r_out);
            this->out.push_back(AsmOp{AsmOpType::Store, r_out, -1, -1, m_y, "STORE"});
            release_mem(m_y);
        } else {
             this->out.push_back(AsmOp{AsmOpType::Unary, r_out, r_out, -1, -1, name});
             bind_initial_register(arg_var, r_out);
        }
    }

    void op_nullary(SsaVariable out_var, const std::string& name) {
        int r_out = get_out_reg(out_var);
        this->out.push_back(AsmOp{AsmOpType::Unary, r_out, -1, -1, -1, name});
        release_reg(r_out);
    }
};
