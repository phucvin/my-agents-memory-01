import copy
from .ir import *
from .dom import DominatorTree, build_cfg_links

def to_standard_ssa(program):
    prog = copy.deepcopy(program)
    build_cfg_links(prog)
    dom_tree = DominatorTree(prog)

    defs = {}
    all_vars = set()

    for b in prog.blocks:
        for instr in b.instructions:
            if hasattr(instr, 'dest'):
                v = instr.dest
                all_vars.add(v)
                if v not in defs:
                    defs[v] = set()
                defs[v].add(b)

    # Insert Phis
    # Store original var in Phi
    for v in all_vars:
        if v not in defs: continue
        worklist = list(defs[v])
        processed = set()
        while worklist:
            b = worklist.pop(0)
            for f in dom_tree.get_dominance_frontier(b):
                if f in processed:
                    continue

                has_phi = False
                for instr in f.instructions:
                    if isinstance(instr, Phi) and getattr(instr, 'original_dest', None) == v:
                        has_phi = True
                        break

                if not has_phi:
                    phi = Phi(v, {})
                    phi.original_dest = v # Tag it
                    f.instructions.insert(0, phi)
                    processed.add(f)
                    if f not in defs[v]:
                        defs[v].add(f)
                        worklist.append(f)

    stacks = {v: [] for v in all_vars}
    counters = {v: 0 for v in all_vars}

    def gen_name(v):
        n = counters[v]
        counters[v] += 1
        return f"{v}_{n}"

    visited = set()

    def rename(b):
        if b in visited: return
        visited.add(b)

        pushed_counts = {v: 0 for v in all_vars}

        for instr in b.instructions:
            if isinstance(instr, Phi):
                old_dest = instr.original_dest
                new_dest = gen_name(old_dest)
                instr.dest = new_dest
                stacks[old_dest].append(new_dest)
                pushed_counts[old_dest] += 1
            else:
                # Replace uses
                if isinstance(instr, (BinOp, Branch, Print, Return, Upsilon)):
                     # Handle Upsilon value as use
                    attrs = ['left', 'right', 'cond', 'value']
                    for attr in attrs:
                        if hasattr(instr, attr):
                            val = getattr(instr, attr)
                            if val in stacks and stacks[val]:
                                setattr(instr, attr, stacks[val][-1])

                # Replace dest
                if hasattr(instr, 'dest') and not isinstance(instr, Phi):
                    old_dest = instr.dest
                    new_dest = gen_name(old_dest)
                    instr.dest = new_dest
                    stacks[old_dest].append(new_dest)
                    pushed_counts[old_dest] += 1

        # Update Phis in successors
        for succ in b.successors:
            for instr in succ.instructions:
                if isinstance(instr, Phi):
                    orig = instr.original_dest
                    if orig in stacks and stacks[orig]:
                        instr.args[b.label] = stacks[orig][-1]

        # Dominator tree traversal order
        # We need to traverse down the dominator tree
        # dom_tree.doms contains ALL dominators.
        # We need children in dom tree.

        # Build dom tree children map
        dom_children = {blk: [] for blk in prog.blocks}
        for blk in prog.blocks:
            idom = dom_tree.idom(blk)
            if idom and idom != blk:
                dom_children[idom].append(blk)

        for child in dom_children[b]:
            rename(child)

        # Pop stacks
        for v, count in pushed_counts.items():
            for _ in range(count):
                stacks[v].pop()

    rename(prog.entry_block)
    return prog
