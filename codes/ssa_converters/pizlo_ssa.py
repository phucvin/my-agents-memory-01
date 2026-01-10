import copy
from .ir import *
from .dom import DominatorTree, build_cfg_links
from .standard_ssa import to_standard_ssa

def to_pizlo_ssa(program):
    # Get Standard SSA first
    ssa_prog = to_standard_ssa(program)

    # Iterate over all Phis
    # We need to insert Upsilons in predecessors.

    # Note: Inserting instructions in predecessors might be tricky if multiple Phis need Upsilons in same predecessor.
    # Order doesn't strictly matter for Upsilons to different shadow vars.
    # But we must insert them before the Jump/Branch.

    for b in ssa_prog.blocks:
        # Identify Phis
        phis = [i for i in b.instructions if isinstance(i, Phi)]
        if not phis: continue

        for phi in phis:
            shadow_name = phi.dest # Use the Phi's destination name as base for shadow
            # args: pred_label -> value
            for pred_label, val in phi.args.items():
                # Find predecessor block
                pred_block = None
                for p in ssa_prog.blocks:
                    if p.label == pred_label:
                        pred_block = p
                        break

                if pred_block:
                    # Insert Upsilon at end, but before Terminator
                    upsilon = Upsilon(val, shadow_name)

                    # Find insertion point
                    if pred_block.instructions and isinstance(pred_block.instructions[-1], (Jump, Branch, Return)):
                        pred_block.instructions.insert(len(pred_block.instructions)-1, upsilon)
                    else:
                        pred_block.instructions.append(upsilon)

            # Clear args of Phi
            phi.args = {}
            # Maybe mark it as Pizlo Phi explicitly?
            # My IR `Phi` with empty args prints as `dest = Phi()`, which matches.

    return ssa_prog
