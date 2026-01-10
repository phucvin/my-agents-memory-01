class Instruction:
    def __init__(self):
        pass

    def __repr__(self):
        return self.__str__()

class Const(Instruction):
    def __init__(self, dest, value):
        self.dest = dest
        self.value = value

    def __str__(self):
        return f"{self.dest} = Const({self.value})"

class BinOp(Instruction):
    def __init__(self, dest, op, left, right):
        self.dest = dest
        self.op = op
        self.left = left
        self.right = right

    def __str__(self):
        return f"{self.dest} = {self.op}({self.left}, {self.right})"

class Jump(Instruction):
    def __init__(self, target):
        self.target = target # Target BasicBlock label or object

    def __str__(self):
        return f"Jump({self.target})"

class Branch(Instruction):
    def __init__(self, cond, true_target, false_target):
        self.cond = cond
        self.true_target = true_target
        self.false_target = false_target

    def __str__(self):
        return f"Branch({self.cond}, {self.true_target}, {self.false_target})"

class Phi(Instruction):
    def __init__(self, dest, args=None):
        self.dest = dest
        self.args = args if args is not None else {} # Map: Block Label -> Var

    def __str__(self):
        if not self.args:
            return f"{self.dest} = Phi()"
        args_str = ", ".join([f"{blk}: {val}" for blk, val in self.args.items()])
        return f"{self.dest} = Phi({args_str})"

class Upsilon(Instruction):
    def __init__(self, value, shadow_dest):
        self.value = value
        self.shadow_dest = shadow_dest

    def __str__(self):
        return f"Upsilon({self.value}, ^{self.shadow_dest})"

class Print(Instruction):
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return f"Print({self.value})"

class Return(Instruction):
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return f"Return({self.value})"

class BasicBlock:
    def __init__(self, label):
        self.label = label
        self.instructions = []
        self.predecessors = []
        self.successors = []
        self.params = [] # For Functional SSA

    def add_instruction(self, instr):
        self.instructions.append(instr)

    def __str__(self):
        lines = [f"{self.label}:"]
        if self.params:
            lines[0] += f" ({', '.join(self.params)})"
        for instr in self.instructions:
            lines.append(f"    {instr}")
        return "\n".join(lines)

class Function:
    def __init__(self, name, blocks, entry_block):
        self.name = name
        self.blocks = blocks
        self.entry_block = entry_block

    def __str__(self):
        return "\n".join([str(b) for b in self.blocks])
