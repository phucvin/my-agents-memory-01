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
        # Use str() for params to ensure they are strings if they happen to be objects?
        # Phi dests are usually strings.
        b.params = [phi.dest for phi in phis]

        # Remove Phis from instructions
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
            if t_label in phi_map and phi_map[t_label]:
                # List of args for this jump
                args = []
                # For each param in target
                for phi_args in phi_map[t_label]:
                    # Find value coming from current block b
                    val = phi_args.get(b.label)
                    # If val is None, it means the Phi wasn't fully populated or logic error.
                    if val is None:
                        val = "Undef"
                    args.append(val)

                # Attach args to instruction
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
    # Store original methods to allow multiple patch calls safely or just overwrite
    # But since we reload modules or run once, straightforward overwrite is fine.

    # Capture the class to be sure
    JumpClass = Jump
    BranchClass = Branch

    original_jump_str = JumpClass.__str__

    def new_jump_str(self):
        # We can't easily call original_jump_str(self) if it's bound method?
        # No, unbound function.
        # But to be safe, let's just reimplement the string formatting.
        base = f"Jump({self.target})"
        if hasattr(self, 'args') and self.args:
            return f"{base} args({', '.join(map(str, self.args))})"
        return base

    JumpClass.__str__ = new_jump_str

    def new_branch_str(self):
        t_args = ""
        if hasattr(self, 'true_args') and self.true_args:
            t_args = f"({', '.join(map(str, self.true_args))})"
        f_args = ""
        if hasattr(self, 'false_args') and self.false_args:
            f_args = f"({', '.join(map(str, self.false_args))})"
        return f"Branch({self.cond}, {self.true_target}{t_args}, {self.false_target}{f_args})"

    BranchClass.__str__ = new_branch_str

patch_ir_str()
