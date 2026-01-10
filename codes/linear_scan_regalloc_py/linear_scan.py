import re
import sys
from collections import defaultdict

class Instruction:
    def __init__(self, index, text, block_id):
        self.index = index
        self.text = text.strip()
        self.block_id = block_id
        self.op = ""
        self.lhs = None # The variable defined (string, e.g. "%1")
        self.args = []  # List of operands (strings, e.g. "%1", "10")
        self.is_phi = False
        self.parse()

    def parse(self):
        # Format: %id = Op(args) or Op(args)
        # Regex to capture LHS, Op, Args
        # Special case: Preds: ..., Succs: ... are not instructions for our purpose (metadata)

        match = re.match(r'^\s*(%(\d+))\s*=\s*(\w+)\((.*)\)', self.text)
        if match:
            self.lhs = match.group(1)
            self.op = match.group(3)
            args_str = match.group(4)
            self.args = [x.strip() for x in args_str.split(',')] if args_str else []
        else:
            match = re.match(r'^\s*(\w+)\((.*)\)', self.text)
            if match:
                self.op = match.group(1)
                args_str = match.group(2)
                self.args = [x.strip() for x in args_str.split(',')] if args_str else []

        if self.op == "Phi":
            self.is_phi = True

    def __repr__(self):
        return f"{self.index}: {self.text}"

class Block:
    def __init__(self, bid):
        self.id = bid
        self.instructions = []
        self.preds = []
        self.succs = []
        self.live_in = set()
        self.live_out = set()
        self.start_index = -1
        self.end_index = -1

class Interval:
    def __init__(self, var):
        self.var = var
        self.start = float('inf')
        self.end = -1
        self.reg = None
        self.stack_slot = None

    def add_range(self, start, end):
        self.start = min(self.start, start)
        self.end = max(self.end, end)

    def __repr__(self):
        loc = self.reg
        if loc == "Spill":
            loc = f"[Stack{self.stack_slot}]"
        return f"{self.var}: {loc} \t(Interval: [{self.start}, {self.end}])"

class Program:
    def __init__(self):
        self.blocks = {} # map id -> Block
        self.linear_instructions = []
        self.intervals = {} # map var -> Interval

    def parse(self, text):
        lines = text.splitlines()
        current_block = None
        instr_counter = 0

        for line in lines:
            line = line.strip()
            if not line:
                continue

            # Block Header
            m_block = re.match(r'Block (\d+):', line)
            if m_block:
                bid = int(m_block.group(1))
                current_block = Block(bid)
                self.blocks[bid] = current_block
                continue

            if not current_block:
                continue

            # Metadata
            if line.startswith("Preds:"):
                parts = line.split(":", 1)[1].strip()
                if parts:
                    current_block.preds = [int(x) for x in parts.split()]
                continue

            if line.startswith("Succs:"):
                parts = line.split(":", 1)[1].strip()
                if parts:
                    current_block.succs = [int(x) for x in parts.split()]
                continue

            # Instruction
            instr = Instruction(instr_counter, line, current_block.id)
            current_block.instructions.append(instr)
            self.linear_instructions.append(instr)

            if current_block.start_index == -1:
                current_block.start_index = instr_counter
            current_block.end_index = instr_counter

            instr_counter += 1

    def compute_liveness(self):
        # 1. Compute LiveIn and LiveOut for each block iteratively
        changed = True
        while changed:
            changed = False
            # Iterate in reverse post-order or just arbitrary.
            # Reverse block ID order is a simple heuristic for backward flow.
            for bid in sorted(self.blocks.keys(), reverse=True):
                block = self.blocks[bid]

                # LiveOut = Union(LiveIn(s) for s in succs)
                new_live_out = set()
                for s in block.succs:
                    if s in self.blocks:
                        new_live_out.update(self.blocks[s].live_in)

                # LiveIn = Use U (LiveOut - Def)
                # But we need to handle instructions inside.
                # However, for block-level sets, we can compute Use_B and Def_B
                # Or just iterate instructions backward.

                current_live = new_live_out.copy()

                # Process instructions in reverse
                for instr in reversed(block.instructions):
                    # For Phi nodes, they define a variable, but the uses happen in predecessors!
                    # So Phi definition KILLS the variable in this block.
                    # But Phi uses are NOT added to LiveIn of this block.

                    if instr.lhs:
                        if instr.lhs in current_live:
                            current_live.remove(instr.lhs)

                    if not instr.is_phi:
                        for arg in instr.args:
                            if arg.startswith('%'):
                                current_live.add(arg)

                # Handling Phi uses at block level:
                # Phi uses effectively belong to the end of specific predecessor blocks.
                # They do NOT contribute to LiveIn of the current block.
                # So the logic above (skipping Phi uses) is correct for LiveIn of THIS block.

                if block.live_out != new_live_out or block.live_in != current_live:
                    block.live_out = new_live_out
                    block.live_in = current_live
                    changed = True

    def build_intervals(self):
        # Initialize intervals for all defined variables
        for instr in self.linear_instructions:
            if instr.lhs:
                if instr.lhs not in self.intervals:
                    self.intervals[instr.lhs] = Interval(instr.lhs)
                # Definition site is start of interval
                self.intervals[instr.lhs].add_range(instr.index, instr.index)

        # Iterate blocks to extend intervals
        for bid in sorted(self.blocks.keys()):
            block = self.blocks[bid]

            # Variables live out of the block extend to the end of the block
            # In linear scan terms, the "end of block" is the index of the last instruction.
            block_end = block.end_index

            for var in block.live_out:
                if var not in self.intervals:
                     self.intervals[var] = Interval(var) # Should exist if defined
                self.intervals[var].add_range(block.start_index, block_end)

            # Process instructions to refine ranges
            for instr in block.instructions:
                # Uses
                if not instr.is_phi:
                    for arg in instr.args:
                        if arg.startswith('%'):
                            if arg not in self.intervals:
                                self.intervals[arg] = Interval(arg) # Parameter?
                            self.intervals[arg].add_range(block.start_index, instr.index)

                # Phi Uses: These extend to the end of the specific predecessor
                # We handle this by iterating Phi nodes and updating intervals for their operands
                # relative to the predecessor blocks.
                if instr.is_phi:
                    # Arg format: standard SSA text just lists args.
                    # We assume order matches Preds list.
                    for i, arg in enumerate(instr.args):
                        if arg.startswith('%') and i < len(block.preds):
                            pred_id = block.preds[i]
                            pred_block = self.blocks[pred_id]
                            # Use is at the end of predecessor
                            if arg not in self.intervals:
                                self.intervals[arg] = Interval(arg)
                            self.intervals[arg].add_range(pred_block.start_index, pred_block.end_index)

    def allocate_registers(self, num_regs=4):
        # Linear Scan Algorithm
        # 1. Sort intervals by start position
        sorted_intervals = sorted(self.intervals.values(), key=lambda x: x.start)

        free_regs = [f"R{i}" for i in range(num_regs)]
        active = [] # List of intervals
        stack_slot_counter = 0

        for i in sorted_intervals:
            # Expire old intervals
            # Remove intervals from active that end before i.start
            # Sort active by end to easily find expired ones?
            # Or just iterate. Standard algo says sort active by end.

            new_active = []
            for a in active:
                if a.end >= i.start:
                    new_active.append(a)
                else:
                    # Release register
                    if a.reg and a.reg.startswith('R'):
                        free_regs.append(a.reg)
            active = new_active

            if not free_regs:
                # Spill
                # Heuristic: spill the one that ends furthest in the future (could be i itself)
                spill_candidate = max(active + [i], key=lambda x: x.end)
                if spill_candidate == i:
                    i.reg = "Spill"
                    i.stack_slot = stack_slot_counter
                    stack_slot_counter += 1
                else:
                    # Steal register
                    i.reg = spill_candidate.reg
                    spill_candidate.reg = "Spill"
                    spill_candidate.stack_slot = stack_slot_counter
                    stack_slot_counter += 1
                    active.remove(spill_candidate)
                    active.append(i)
                    active.sort(key=lambda x: x.end)
            else:
                # Assign register
                # Pick one (e.g., first available)
                # Sort free_regs to be deterministic
                free_regs.sort()
                reg = free_regs.pop(0)
                i.reg = reg
                active.append(i)
                active.sort(key=lambda x: x.end)

    def get_operand_loc(self, operand):
        if operand not in self.intervals:
            # Maybe a constant or undefined?
            return operand
        inter = self.intervals[operand]
        if inter.reg == "Spill":
            return f"[stack{inter.stack_slot}]"
        return inter.reg

    def generate_assembly(self):
        print("\nGenerated Pseudo-Assembly:")
        for bid in sorted(self.blocks.keys()):
            block = self.blocks[bid]
            print(f"L{bid}:")

            # Identify pending Phi moves for successors
            # Map successor_id -> list of moves (dest_var, src_var)
            # But we are iterating linear instructions.
            # Usually we process instructions, and at the branch (or end), we emit moves.

            for instr in block.instructions:
                if instr.is_phi:
                    continue # Phis are handled in predecessors

                # Check for Branch/Jump to handle Phi copies
                # If this instruction is a branch/jump, we need to emit copies for successors BEFORE it?
                # Actually, standard SSA: copies are parallel on the edge.
                # If we emit before branch, we are fine for unconditional jumps.
                # For conditional branch, we have two successors. We can't emit moves for both here blindly.
                # But wait, in critical edge splitting, we would put moves in a new block.
                # If we don't have critical edges, we can put moves at end of this block IF it only goes to one succ
                # OR if the succ only has one pred.
                # If we have `Branch(%c, T, F)`, we can't emit moves for T and F here if they conflict.
                # But Phi moves for T are only needed if we go to T.
                # So technically they should be IN the branch target or on the edge.
                # Pseudo-assembly: "If %c Jump L_T_WithMoves else Jump L_F_WithMoves"?
                # Or just assume the standard layout:
                # For a prototype, let's just print the moves before the branch if unique,
                # or annotating the edge.

                # Let's try to emit them right before the terminator for simplicity,
                # assuming no conflicts or just printing them as "on edge to X: ..."

                # Handling normal instructions
                output = []

                # Prepare operands
                # If spilled, load to temp
                tmps = ["R_TMP1", "R_TMP2", "R_TMP3"] # Scratch registers
                tmp_idx = 0

                real_args = []
                for arg in instr.args:
                    if arg.startswith('%'):
                        loc = self.get_operand_loc(arg)
                        if loc.startswith('['):
                            # Emit Load
                            print(f"  LOAD {tmps[tmp_idx]}, {loc}  ; Reload {arg}")
                            real_args.append(tmps[tmp_idx])
                            tmp_idx += 1
                        else:
                            real_args.append(loc)
                    else:
                        real_args.append(arg)

                # Branch / Jump special handling for Phis
                if instr.op in ["Branch", "Jump"]:
                    # Succs are in instr args usually.
                    # Branch(%cond, true_blk, false_blk)
                    # Jump(target)
                    targets = []
                    if instr.op == "Jump":
                        targets = [int(instr.args[0])]
                    elif instr.op == "Branch":
                        targets = [int(instr.args[1]), int(instr.args[2])]

                    for tid in targets:
                        # Find Phis in target block `tid`
                        succ = self.blocks.get(tid)
                        if succ:
                            for s_instr in succ.instructions:
                                if s_instr.is_phi:
                                    # Find index of current block `bid` in succ.preds
                                    try:
                                        pred_idx = succ.preds.index(bid)
                                        src_val = s_instr.args[pred_idx]
                                        dest_var = s_instr.lhs

                                        # Emit Move: dest_var = src_val
                                        # But this happens ON THE EDGE to `tid`.
                                        # We will print it as a comment or pseudo-instr
                                        print(f"  ; On edge to L{tid}: {dest_var} = {src_val}")

                                        # Generate Move Code
                                        # Src
                                        src_loc = src_val
                                        if src_val.startswith('%'):
                                            src_loc = self.get_operand_loc(src_val)
                                            if src_loc.startswith('['):
                                                print(f"  LOAD {tmps[tmp_idx]}, {src_loc} ; Reload for Phi")
                                                src_loc = tmps[tmp_idx]
                                                tmp_idx = (tmp_idx + 1) % 3

                                        # Dest
                                        dest_loc = self.get_operand_loc(dest_var)
                                        if dest_loc.startswith('['):
                                            # Move to memory: LOAD src to Reg, STORE Reg to Dest
                                            # We already have src in Reg (src_loc)
                                            if not src_loc.startswith('R'):
                                                # Const or something, load to Reg
                                                print(f"  MOV {tmps[tmp_idx]}, {src_loc}")
                                                src_loc = tmps[tmp_idx]
                                                tmp_idx = (tmp_idx + 1) % 3
                                            print(f"  STORE {dest_loc}, {src_loc} ; Spill Phi dest {dest_var}")
                                        else:
                                            # Move Reg to Reg
                                            if src_loc != dest_loc:
                                                print(f"  MOV {dest_loc}, {src_loc}")

                                    except ValueError:
                                        pass

                # Emit operation
                if instr.op == "Return":
                     print(f"  RETURN {real_args[0]}")
                elif instr.op == "Branch":
                     # Branch cond, T, F
                     print(f"  BRANCH {real_args[0]}, L{real_args[1]}, L{real_args[2]}")
                elif instr.op == "Jump":
                     print(f"  JUMP L{real_args[0]}")
                else:
                    # BinOp or Assignment
                    # Dest
                    if instr.lhs:
                        dest_loc = self.get_operand_loc(instr.lhs)
                        dest_reg = dest_loc
                        is_spilled = False
                        if dest_loc.startswith('['):
                            dest_reg = tmps[tmp_idx] # Use temp for result
                            is_spilled = True

                        args_str = ", ".join(real_args)
                        print(f"  {instr.op.upper()} {dest_reg}, {args_str}")

                        if is_spilled:
                            print(f"  STORE {dest_loc}, {dest_reg} ; Spill {instr.lhs}")
                    else:
                        # Void op?
                        args_str = ", ".join(real_args)
                        print(f"  {instr.op.upper()} {args_str}")

    def print_allocation(self):
        print("Register Allocation Results:")
        # Sort by var name/number
        for var in sorted(self.intervals.keys(), key=lambda x: int(x[1:]) if x[1:].isdigit() else x):
            inter = self.intervals[var]
            loc = inter.reg
            if loc == "Spill":
                loc = f"Stack[{inter.stack_slot}]"
            print(f"{var}: {loc} \t(Interval: [{inter.start}, {inter.end}])")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Linear Scan Register Allocator for SSA")
    parser.add_argument("file", help="Path to SSA input file")
    parser.add_argument("--regs", type=int, default=4, help="Number of physical registers")
    args = parser.parse_args()

    with open(args.file, 'r') as f:
        content = f.read()

    prog = Program()
    prog.parse(content)
    prog.compute_liveness()
    prog.build_intervals()
    prog.allocate_registers(num_regs=args.regs)
    prog.print_allocation()
    prog.generate_assembly()
