import copy
from .ir import *
from .standard_ssa import to_standard_ssa

def to_functional_ssa(program):
    # First convert to Standard SSA
    ssa_prog = to_standard_ssa(program)

    # In Functional SSA:
    # 1. Phi nodes in a block become parameters of that block.
    # 2. Jumps/Branches to that block must provide arguments matching the parameters.

    # Map Block -> List of (Phi Dest Variable)
    block_params = {}

    for b in ssa_prog.blocks:
        phis = [i for i in b.instructions if isinstance(i, Phi)]
        # Define params
        params = [phi.dest for phi in phis]
        b.params = params
        block_params[b.label] = params

        # Remove Phis from instructions
        b.instructions = [i for i in b.instructions if not isinstance(i, Phi)]

    # Update Jumps/Branches
    # We need to look at predecessors to find the values for the arguments.
    # In Standard SSA, Phi(b1: v1, b2: v2).
    # This means if we come from b1, the argument is v1.

    # We iterate over all blocks and their successors (jumps)
    # But wait, the Jump instruction in IR doesn't strictly hold arguments in my current IR.
    # I should modify Jump/Branch to hold arguments?
    # Or keep Jump as is and assume arguments are implicit?
    # Functional SSA usually makes them explicit: Jump(target, args...)

    # My IR `Jump` only has `target`. I can subclass or modify it.
    # Let's modify `Jump` and `Branch` in this functional version or monkey-patch?
    # Better: create new Instruction types or add `args` field to Jump/Branch dynamically.

    for b in ssa_prog.blocks:
        # Find the terminator
        if not b.instructions: continue
        term = b.instructions[-1]

        if isinstance(term, Jump):
            # Target block params
            target_label = term.target
            # Find the target block object? IR Jump has label or object?
            # In `standard_ssa`, we built links, so `term.target` is likely the label string from original parsing
            # but `build_cfg_links` links objects.
            # My `Jump` IR only stores `target`. `build_cfg_links` uses it to find block.
            # So `term.target` is a label string.

            target_blk = None
            for blk in ssa_prog.blocks:
                if blk.label == target_label:
                    target_blk = blk
                    break

            if target_blk and target_blk.label in block_params:
                # Construct args
                # For each param P in target (which corresponds to a Phi P = Phi(...)),
                # we need to find the value for current block `b.label`.
                # Wait, where is the Phi info? We removed it.
                # We should have stored the mapping before removing Phis.
                pass

    # Let's restart the loop with better strategy

    # 1. Collect Phi info: TargetBlock -> { ParamVar -> { PredLabel -> Value } }
    phi_map = {} # BlockLabel -> [ {pred: val} for each param ]

    for b in ssa_prog.blocks:
        phis = [i for i in b.instructions if isinstance(i, Phi)]
        b_phis_info = []
        for phi in phis:
            b_phis_info.append(phi.args) # Map: pred_label -> val
        phi_map[b.label] = b_phis_info

    # 2. Update blocks to have params (already done above, but let's redo cleanly)
    for b in ssa_prog.blocks:
        phis = [i for i in b.instructions if isinstance(i, Phi)]
        b.params = [phi.dest for phi in phis]
        b.instructions = [i for i in b.instructions if not isinstance(i, Phi)]

    # 3. Update Terminators
    for b in ssa_prog.blocks:
        if not b.instructions: continue
        term = b.instructions[-1]

        targets = []
        if isinstance(term, Jump):
            targets.append((term.target, term))
        elif isinstance(term, Branch):
            targets.append((term.true_target, term))
            targets.append((term.false_target, term))

        for t_label, instr in targets:
            if t_label in phi_map:
                # List of args for this jump
                args = []
                # For each param in target
                for phi_args in phi_map[t_label]:
                    # Find value coming from current block b
                    val = phi_args.get(b.label)
                    # If val is None, it means the Phi wasn't fully populated or logic error.
                    # Standard SSA should have populated it.
                    if val is None:
                        val = "Undef"
                    args.append(val)

                # Attach args to instruction
                # We can add a new attribute `args` to Jump/Branch or `true_args`/`false_args`
                if isinstance(instr, Jump):
                    instr.args = args
                elif isinstance(instr, Branch):
                    if t_label == instr.true_target:
                        instr.true_args = args
                    else:
                        instr.false_args = args

    return ssa_prog

# We need to update __str__ of Jump/Branch to show args if present
def patch_ir_str():
    old_jump_str = Jump.__str__
    def new_jump_str(self):
        base = old_jump_str(self)
        if hasattr(self, 'args') and self.args:
            return f"{base} args({', '.join(map(str, self.args))})"
        return base
    Jump.__str__ = new_jump_str

    old_branch_str = Branch.__str__
    def new_branch_str(self):
        parts = [f"Branch({self.cond}"]

        t_args = ""
        if hasattr(self, 'true_args') and self.true_args:
            t_args = f" args({', '.join(map(str, self.true_args))})"
        parts.append(f"{self.true_target}{t_args}")

        f_args = ""
        if hasattr(self, 'false_args') and self.false_args:
            f_args = f" args({', '.join(map(str, self.false_args))})"
        parts.append(f"{self.false_target}{f_args})")

        return ", ".join(parts)
    # The default str is f"Branch({self.cond}, {self.true_target}, {self.false_target})"
    # Let's just replace it entirely
    def branch_str_replacement(self):
        t_args = ""
        if hasattr(self, 'true_args') and self.true_args:
            t_args = f"({', '.join(map(str, self.true_args))})"
        f_args = ""
        if hasattr(self, 'false_args') and self.false_args:
            f_args = f"({', '.join(map(str, self.false_args))})"
        return f"Branch({self.cond}, {self.true_target}{t_args}, {self.false_target}{f_args})"

    Branch.__str__ = branch_str_replacement

patch_ir_str()
