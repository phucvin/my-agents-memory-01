import sys

# --- AST ---

class ASTNode:
    pass

class Num(ASTNode):
    def __init__(self, val):
        self.val = val
    def __repr__(self):
        return str(self.val)

class Var(ASTNode):
    def __init__(self, name):
        self.name = name
    def __repr__(self):
        return self.name

class BinOp(ASTNode):
    def __init__(self, op, left, right):
        self.op = op
        self.left = left
        self.right = right
    def __repr__(self):
        return f"({self.left} {self.op} {self.right})"

class Assign(ASTNode):
    def __init__(self, name, expr):
        self.name = name
        self.expr = expr
    def __repr__(self):
        return f"{self.name} = {self.expr}"

class If(ASTNode):
    def __init__(self, cond, then_body, else_body=None):
        self.cond = cond
        self.then_body = then_body
        self.else_body = else_body or []
    def __repr__(self):
        return f"if {self.cond} {{ ... }}"

class While(ASTNode):
    def __init__(self, cond, body):
        self.cond = cond
        self.body = body
    def __repr__(self):
        return f"while {self.cond} {{ ... }}"

class Print(ASTNode):
    def __init__(self, expr):
        self.expr = expr
    def __repr__(self):
        return f"print {self.expr}"

# --- IR / CFG ---

class Block:
    def __init__(self, label):
        self.label = label
        self.instrs = []
        self.succs = []
        self.preds = []
        # Removed params for Pizlo SSA

    def add_instr(self, instr):
        self.instrs.append(instr)
        instr.block = self

    def add_succ(self, block):
        if block not in self.succs:
            self.succs.append(block)
        if self not in block.preds:
            block.preds.append(self)

    def __repr__(self):
        return f"Block {self.label}"

class Instruction:
    pass

class SetInst(Instruction):
    def __init__(self, dst, val):
        self.dst = dst
        self.val = val # Int or Var
    def __repr__(self):
        return f"{self.dst} = {self.val}"

class OpInst(Instruction):
    def __init__(self, dst, op, arg1, arg2):
        self.dst = dst
        self.op = op
        self.arg1 = arg1
        self.arg2 = arg2
    def __repr__(self):
        return f"{self.dst} = {self.arg1} {self.op} {self.arg2}"

class BranchInst(Instruction):
    def __init__(self, cond, true_target, false_target):
        self.cond = cond
        self.true_target = true_target
        self.false_target = false_target
        # Removed args for Pizlo SSA
    def __repr__(self):
        return f"br {self.cond}, {self.true_target.label}, {self.false_target.label}"

class JumpInst(Instruction):
    def __init__(self, target):
        self.target = target
        # Removed args for Pizlo SSA
    def __repr__(self):
        return f"jmp {self.target.label}"

class PrintInst(Instruction):
    def __init__(self, val):
        self.val = val
    def __repr__(self):
        return f"print {self.val}"

class PhiInst(Instruction):
    def __init__(self, dst):
        self.dst = dst
        self.args = {} # block_label -> val, temporarily used during construction
        self.original_var = None
        self.shadow_var = None # The Pizlo shadow variable name
    def __repr__(self):
        # In Pizlo form, Phi takes no explicit args, implicitly reads shadow_var
        if self.shadow_var:
            return f"{self.dst} = phi()  # reads {self.shadow_var}"
        # Fallback for intermediate state
        args_str = ", ".join(f"[{v}, {l}]" for l, v in self.args.items())
        return f"{self.dst} = phi({args_str})"

class UpsilonInst(Instruction):
    def __init__(self, val, shadow_var):
        self.val = val
        self.shadow_var = shadow_var
    def __repr__(self):
        return f"upsilon({self.val}, {self.shadow_var})"

# --- CFG Builder ---

class CFGBuilder:
    def __init__(self):
        self.blocks = []
        self.current_block = None
        self.block_counter = 0
        self.temp_counter = 0

    def new_block(self, label_hint=""):
        label = f"L{self.block_counter}_{label_hint}" if label_hint else f"L{self.block_counter}"
        self.block_counter += 1
        blk = Block(label)
        self.blocks.append(blk)
        return blk

    def set_current_block(self, blk):
        self.current_block = blk

    def emit(self, instr):
        self.current_block.add_instr(instr)

    def new_temp(self):
        name = f"t{self.temp_counter}"
        self.temp_counter += 1
        return name

    def compile_expr(self, expr):
        if isinstance(expr, Num):
            return expr.val
        elif isinstance(expr, Var):
            return expr.name
        elif isinstance(expr, BinOp):
            l = self.compile_expr(expr.left)
            r = self.compile_expr(expr.right)
            dst = self.new_temp()
            self.emit(OpInst(dst, expr.op, l, r))
            return dst
        else:
            raise ValueError(f"Unknown expr {expr}")

    def compile_stmts(self, stmts):
        for stmt in stmts:
            self.compile_stmt(stmt)

    def compile_stmt(self, stmt):
        if isinstance(stmt, Assign):
            val = self.compile_expr(stmt.expr)
            self.emit(SetInst(stmt.name, val))
        elif isinstance(stmt, Print):
            val = self.compile_expr(stmt.expr)
            self.emit(PrintInst(val))
        elif isinstance(stmt, If):
            cond_val = self.compile_expr(stmt.cond)

            start_block = self.current_block
            true_block = self.new_block("then")
            else_block = self.new_block("else")
            join_block = self.new_block("join")

            start_block.add_succ(true_block)
            start_block.add_succ(else_block)
            self.emit(BranchInst(cond_val, true_block, else_block))

            self.set_current_block(true_block)
            self.compile_stmts(stmt.then_body)
            # Check if last instruction is already a terminator (e.g. from nested control flow)
            if not self.current_block.instrs or not isinstance(self.current_block.instrs[-1], (BranchInst, JumpInst)):
                self.emit(JumpInst(join_block))
                self.current_block.add_succ(join_block)

            self.set_current_block(else_block)
            self.compile_stmts(stmt.else_body)
            if not self.current_block.instrs or not isinstance(self.current_block.instrs[-1], (BranchInst, JumpInst)):
                self.emit(JumpInst(join_block))
                self.current_block.add_succ(join_block)

            self.set_current_block(join_block)

        elif isinstance(stmt, While):
            header_block = self.new_block("loop_header")
            body_block = self.new_block("loop_body")
            exit_block = self.new_block("loop_exit")

            # Jump from current to header
            self.emit(JumpInst(header_block))
            self.current_block.add_succ(header_block)

            # Header: check condition
            self.set_current_block(header_block)
            cond_val = self.compile_expr(stmt.cond)
            self.emit(BranchInst(cond_val, body_block, exit_block))
            header_block.add_succ(body_block)
            header_block.add_succ(exit_block)

            # Body
            self.set_current_block(body_block)
            self.compile_stmts(stmt.body)
            # Jump back to header
            if not self.current_block.instrs or not isinstance(self.current_block.instrs[-1], (BranchInst, JumpInst)):
                self.emit(JumpInst(header_block))
                self.current_block.add_succ(header_block)

            # Exit
            self.set_current_block(exit_block)

    def build(self, stmts):
        entry = self.new_block("entry")
        self.set_current_block(entry)
        self.compile_stmts(stmts)
        return self.blocks, entry

# --- SSA Conversion ---

def get_post_order(entry):
    visited = set()
    post_order = []

    def dfs(u):
        visited.add(u)
        for v in u.succs:
            if v not in visited:
                dfs(v)
        post_order.append(u)

    dfs(entry)
    return post_order

def compute_dominators(blocks, entry):
    # Standard iterative algorithm
    # dom(n) = {n} U (Intersect_{p in preds(n)} dom(p))

    dom = {b: set(blocks) for b in blocks}
    dom[entry] = {entry}

    changed = True
    while changed:
        changed = False
        for b in blocks:
            if b == entry: continue

            new_dom = None
            for p in b.preds:
                if new_dom is None:
                    new_dom = dom[p].copy()
                else:
                    new_dom &= dom[p]

            if new_dom is not None:
                new_dom.add(b)
                if new_dom != dom[b]:
                    dom[b] = new_dom
                    changed = True
    return dom

def compute_idoms(blocks, doms, entry):
    idoms = {}
    for b in blocks:
        if b == entry: continue
        strict_doms = doms[b] - {b}
        if not strict_doms: continue
        sorted_doms = sorted(strict_doms, key=lambda x: len(doms[x]))
        idoms[b] = sorted_doms[-1]
    return idoms

def compute_dominance_frontier(blocks, idoms):
    df = {b: set() for b in blocks}
    for b in blocks:
        if len(b.preds) >= 2:
            for p in b.preds:
                runner = p
                while runner != idoms.get(b):
                    if runner is None: break
                    df[runner].add(b)
                    runner = idoms.get(runner)
    return df

class SSAConverter:
    def __init__(self, blocks, entry):
        self.blocks = blocks
        self.entry = entry
        self.doms = compute_dominators(blocks, entry)
        self.idoms = compute_idoms(blocks, self.doms, entry)
        self.df = compute_dominance_frontier(blocks, self.idoms)

    def convert(self):
        globals_, blocks_def_var = self.get_globals()
        self.insert_phis(globals_, blocks_def_var)
        self.rename_vars(globals_)
        self.convert_to_pizlo_form()

    def get_globals(self):
        globals_ = set()
        blocks_def_var = {} # var -> set(block)

        for b in self.blocks:
            for instr in b.instrs:
                # Defs
                dst = None
                if isinstance(instr, SetInst): dst = instr.dst
                elif isinstance(instr, OpInst): dst = instr.dst
                elif isinstance(instr, PhiInst): dst = instr.dst

                if dst:
                    if dst not in blocks_def_var: blocks_def_var[dst] = set()
                    blocks_def_var[dst].add(b)
                    globals_.add(dst)
        return globals_, blocks_def_var

    def insert_phis(self, globals_, blocks_def_var):
        for x in globals_:
            worklist = list(blocks_def_var.get(x, []))
            visited = set(worklist)
            has_phi = set()

            while worklist:
                b = worklist.pop(0)
                for d in self.df[b]:
                    if d not in has_phi:
                        # Insert phi
                        phi = PhiInst(x)
                        phi.original_var = x # Store for renaming
                        d.instrs.insert(0, phi)
                        has_phi.add(d)
                        if d not in visited:
                            visited.add(d)
                            worklist.append(d)

    def rename_vars(self, globals_):
        counters = {v: 0 for v in globals_}
        # stacks for all vars (including temps)
        stack = {}

        def get_stack(n):
            if n not in stack: stack[n] = []
            return stack[n]

        def new_name(n):
            if n not in counters: counters[n] = 0
            i = counters[n]
            counters[n] += 1
            return f"{n}_{i}"

        dom_tree = {b: [] for b in self.blocks}
        for b, parent in self.idoms.items():
            dom_tree[parent].append(b)

        for k in dom_tree:
            dom_tree[k].sort(key=lambda x: x.label)

        def rename(b):
            pushed_counts = {}

            # 1. Rename Phi definitions
            for instr in b.instrs:
                if isinstance(instr, PhiInst):
                    old_name = instr.original_var
                    new_dst = new_name(old_name)
                    instr.dst = new_dst
                    get_stack(old_name).append(new_dst)
                    pushed_counts[old_name] = pushed_counts.get(old_name, 0) + 1

            # 2. Rename regular instructions (uses and defs)
            for instr in b.instrs:
                if isinstance(instr, PhiInst): continue

                # Replace Uses
                if isinstance(instr, SetInst):
                    if isinstance(instr.val, str) and not instr.val.isdigit(): # var
                        stk = get_stack(instr.val)
                        if stk: instr.val = stk[-1]
                        else: instr.val = f"{instr.val}_undef"
                elif isinstance(instr, OpInst):
                    if isinstance(instr.arg1, str) and not instr.arg1.isdigit():
                        stk1 = get_stack(instr.arg1)
                        if stk1: instr.arg1 = stk1[-1]
                        else: instr.arg1 = f"{instr.arg1}_undef"

                    if isinstance(instr.arg2, str) and not instr.arg2.isdigit():
                        stk2 = get_stack(instr.arg2)
                        if stk2: instr.arg2 = stk2[-1]
                        else: instr.arg2 = f"{instr.arg2}_undef"
                elif isinstance(instr, BranchInst):
                    # cond is usually a temp from OpInst, but treat as var
                     if isinstance(instr.cond, str) and not instr.cond.isdigit():
                         stk = get_stack(instr.cond)
                         if stk: instr.cond = stk[-1]
                         else: instr.cond = f"{instr.cond}_undef"
                elif isinstance(instr, PrintInst):
                     if isinstance(instr.val, str) and not instr.val.isdigit():
                         stk = get_stack(instr.val)
                         if stk: instr.val = stk[-1]
                         else: instr.val = f"{instr.val}_undef"

                # Replace Defs
                dst = None
                if isinstance(instr, SetInst): dst = instr.dst
                elif isinstance(instr, OpInst): dst = instr.dst

                if dst:
                    new_dst = new_name(dst)
                    get_stack(dst).append(new_dst)
                    instr.dst = new_dst
                    pushed_counts[dst] = pushed_counts.get(dst, 0) + 1

            # 3. Fill Phi arguments in successors
            for succ in b.succs:
                for instr in succ.instrs:
                    if isinstance(instr, PhiInst):
                        orig = instr.original_var
                        stk = get_stack(orig)
                        if stk:
                            instr.args[b.label] = stk[-1]
                        else:
                            instr.args[b.label] = f"{orig}_undef"

            # 4. Recurse
            for child in dom_tree.get(b, []):
                rename(child)

            # 5. Restore stack
            for v, count in pushed_counts.items():
                for _ in range(count):
                    get_stack(v).pop()

        rename(self.entry)

    def convert_to_pizlo_form(self):
        # Post-pass to convert Phis to Pizlo form (Implicit Phis + Upsilons)
        for b in self.blocks:
            # Collect Phis
            phis = [instr for instr in b.instrs if isinstance(instr, PhiInst)]
            if not phis:
                continue

            for phi in phis:
                # Assign shadow variable
                phi.shadow_var = f"^{phi.dst}"

                # Insert Upsilon in predecessors
                for pred in b.preds:
                    val = phi.args.get(pred.label)
                    # Create Upsilon instruction
                    upsilon = UpsilonInst(val, phi.shadow_var)

                    # Insert before the terminator of the predecessor
                    if pred.instrs and isinstance(pred.instrs[-1], (JumpInst, BranchInst)):
                        pred.instrs.insert(-1, upsilon)
                    else:
                        pred.instrs.append(upsilon)

                # Clear args to signal Pizlo form
                phi.args = {}

def print_cfg(blocks):
    for b in blocks:
        print(f"{b.label}:")
        for instr in b.instrs:
            print(f"  {instr}")

        if not b.instrs or not isinstance(b.instrs[-1], (JumpInst, BranchInst)):
            if b.succs:
                print(f"  => {', '.join(s.label for s in b.succs)}")
            else:
                print("  => (end)")
        print()

def run_test():
    # Example:
    # x = 1
    # y = 1
    # if x:
    #   y = 2
    # print y

    prog = [
        Assign("x", Num(1)),
        Assign("y", Num(1)),
        If(Var("x"),
           [Assign("y", Num(2))],
           []),
        Print(Var("y"))
    ]

    builder = CFGBuilder()
    blocks, entry = builder.build(prog)

    print("--- Initial CFG ---")
    print_cfg(blocks)

    converter = SSAConverter(blocks, entry)
    converter.convert()

    print("--- Pizlo SSA Form CFG ---")
    print_cfg(blocks)

if __name__ == "__main__":
    run_test()
