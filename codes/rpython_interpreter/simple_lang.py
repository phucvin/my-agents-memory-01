import sys
import os

try:
    from rpython.rlib.jit import JitDriver, purefunction
except ImportError:
    class JitDriver(object):
        def __init__(self, **args): pass
        def jit_merge_point(self, **args): pass
        def can_enter_jit(self, **args): pass
    def purefunction(f): return f

# ---------------- Objects ----------------
class W_Object(object):
    def intval(self):
        raise Exception("Not an integer")
    def strval(self):
        raise Exception("Not a string")

class W_Int(W_Object):
    def __init__(self, val):
        self.val = val
    def intval(self):
        return self.val
    def __repr__(self):
        return "W_Int"

class W_String(W_Object):
    def __init__(self, val):
        self.val = val
    def strval(self):
        return self.val
    def __repr__(self):
        return "W_String"

# ---------------- AST ----------------
class Node(object):
    pass

class SExpr(object):
    pass

class SList(SExpr):
    def __init__(self, items):
        self.items = items

class SInt(SExpr):
    def __init__(self, value):
        self.value = value

class SStr(SExpr):
    def __init__(self, value):
        self.value = value

class Number(Node):
    def __init__(self, value):
        self.value = value

class Variable(Node):
    def __init__(self, name):
        self.name = name

class BinOp(Node):
    def __init__(self, op, left, right):
        self.op = op
        self.left = left
        self.right = right

class Call(Node):
    def __init__(self, name, args):
        self.name = name
        self.args = args

class If(Node):
    def __init__(self, cond, then_body, else_body):
        self.cond = cond
        self.then_body = then_body
        self.else_body = else_body

class Function(Node):
    def __init__(self, name, params, body):
        self.name = name
        self.params = params
        self.body = body

class Block(Node):
    def __init__(self, stmts):
        self.stmts = stmts

# ---------------- Parser ----------------
def parse_sexpr(tokens):
    if not tokens:
        raise Exception("Unexpected EOF")
    token = tokens.pop(0)
    if token == '(':
        elements = []
        while tokens[0] != ')':
            elements.append(parse_sexpr(tokens))
        tokens.pop(0) # pop ')'
        return SList(elements)
    elif token == ')':
        raise Exception("Unexpected )")
    else:
        return parse_atom(token)

def parse_atom(token):
    try:
        return SInt(int(token))
    except ValueError:
        return SStr(token)

def parse_program(sexpr_list):
    prog = []
    for s in sexpr_list:
        prog.append(parse_stmt(s))
    return Block(prog)

def parse_stmt(s):
    if isinstance(s, SList):
        items = s.items
        head = items[0]
        if isinstance(head, SStr):
            if head.value == 'def':
                name = items[1]
                params_list = items[2]
                body = items[3]

                # These assertions were failing:
                # assert isinstance(name, SStr)
                # assert isinstance(params_list, SList)
                # We should handle them more gracefully or check why they fail.

                if not isinstance(name, SStr):
                     raise Exception("Function name must be a string")
                if not isinstance(params_list, SList):
                     raise Exception("Function parameters must be a list")

                params = []
                for p in params_list.items:
                    if not isinstance(p, SStr):
                        raise Exception("Parameter must be a string")
                    params.append(p.value)

                return Function(name.value, params, parse_expr(body))
            elif head.value == 'print':
                return Call('print', [parse_expr(items[1])])
            else:
                return parse_expr(s)
        else:
            return parse_expr(s)
    else:
        return parse_expr(s)

def parse_expr(s):
    if isinstance(s, SInt):
        return Number(s.value)
    if isinstance(s, SStr):
        return Variable(s.value)
    if isinstance(s, SList):
        items = s.items
        head = items[0]
        if isinstance(head, SStr):
            op = head.value
            if op == 'if':
                return If(parse_expr(items[1]), parse_expr(items[2]), parse_expr(items[3]))
            elif op in ['+', '-', '<']:
                return BinOp(op, parse_expr(items[1]), parse_expr(items[2]))
            else:
                args = [parse_expr(a) for a in items[1:]]
                return Call(op, args)
    raise Exception("Unknown expr")

def tokenize(text):
    res = []
    for c in text:
        if c == '(':
            res.append(' ')
            res.append('(')
            res.append(' ')
        elif c == ')':
            res.append(' ')
            res.append(')')
            res.append(' ')
        elif c in ['\n', '\r', '\t']:
            res.append(' ')
        else:
            res.append(c)
    text = "".join(res)
    return text.split(' ')

def parse(text):
    tokens = tokenize(text)
    # Filter empty tokens and strip (though split(' ') might produce empty strings)
    # RPython list comprehension is fine.
    # Note: t.strip() might not be fully RPython compliant if t is not string?
    # But tokens are strings.
    # We should just check if t is not empty string?
    # split(' ') can return empty strings if there are multiple spaces.
    # t.strip() removes whitespace, but we replaced whitespace with space, so t is either empty or content.
    # Wait, ' ' becomes ['',''].
    # So checking len(t) > 0 is enough if we rely on split(' ').
    # But let's be safe and use strip() if we are unsure.
    # Actually, RPython supports strip().
    tokens = [t for t in tokens if len(t) > 0 and t != ' ']
    # Wait, split(' ') on "  " returns ['', '', ''].
    # So t != '' is enough.
    tokens = [t for t in tokens if t != '']

    sexprs = []
    while tokens:
        sexprs.append(parse_sexpr(tokens))
    return parse_program(sexprs)

# ---------------- Bytecode ----------------
LOAD_CONST = 1
LOAD_VAR = 2
ADD = 3
SUB = 4
LT = 5
JUMP_IF_FALSE = 6
JUMP = 7
CALL = 8
RETURN = 9
PRINT = 10

class Bytecode(object):
    def __init__(self, name, code, constants, num_vars):
        self.name = name
        self.code = code
        self.constants = constants
        self.num_vars = num_vars

class FunctionObj(object):
    def __init__(self, name, bytecode, arg_count):
        self.name = name
        self.bytecode = bytecode
        self.arg_count = arg_count

class Compiler(object):
    def __init__(self):
        self.functions = {}
        self.constants = []
        self.code = []
        self.local_vars = []
        self.global_funcs = {}

    def get_const(self, val):
        for i, c in enumerate(self.constants):
            if isinstance(val, W_Int) and isinstance(c, W_Int):
                if val.val == c.val: return i
            if isinstance(val, W_String) and isinstance(c, W_String):
                if val.val == c.val: return i

        self.constants.append(val)
        return len(self.constants) - 1

    def get_var(self, name):
        if name in self.local_vars:
            return self.local_vars.index(name)
        raise Exception("Undefined variable: " + name)

    def emit(self, op, arg=0):
        self.code.append(op)
        self.code.append(arg)

    def compile(self, ast):
        if isinstance(ast, Block):
            for stmt in ast.stmts:
                self.compile(stmt)
        elif isinstance(ast, Function):
            old_code = self.code
            old_consts = self.constants
            old_vars = self.local_vars

            self.code = []
            self.constants = []
            self.local_vars = ast.params

            self.compile(ast.body)
            self.emit(RETURN)

            bc = Bytecode(ast.name, self.code, self.constants, len(ast.params))
            self.global_funcs[ast.name] = FunctionObj(ast.name, bc, len(ast.params))

            self.code = old_code
            self.constants = old_consts
            self.local_vars = old_vars

        elif isinstance(ast, Number):
            self.emit(LOAD_CONST, self.get_const(W_Int(ast.value)))
        elif isinstance(ast, Variable):
            self.emit(LOAD_VAR, self.get_var(ast.name))
        elif isinstance(ast, BinOp):
            self.compile(ast.left)
            self.compile(ast.right)
            if ast.op == '+': self.emit(ADD)
            elif ast.op == '-': self.emit(SUB)
            elif ast.op == '<': self.emit(LT)
        elif isinstance(ast, If):
            self.compile(ast.cond)
            idx_jump1 = len(self.code)
            self.emit(JUMP_IF_FALSE, 0)

            self.compile(ast.then_body)
            idx_jump2 = len(self.code)
            self.emit(JUMP, 0)

            self.code[idx_jump1 + 1] = len(self.code)
            self.compile(ast.else_body)

            self.code[idx_jump2 + 1] = len(self.code)

        elif isinstance(ast, Call):
            for arg in ast.args:
                self.compile(arg)
            if ast.name == 'print':
                self.emit(PRINT)
            else:
                self.emit(CALL, self.get_const(W_String(ast.name)))

# ---------------- VM ----------------

def get_location(pc, bytecode):
    # RPython JIT location printing must be careful.
    return "pc=" + str(pc) + " name=" + bytecode.name

# RPython JIT requires greens and reds to be sorted by type: Ints, Refs, Floats.
# greens: pc (int), name_idx (int), code (ref) -> ['pc', 'name_idx', 'code']
# reds: frame (ref), stack (ref), funcs (ref), constants (ref)
jitdriver = JitDriver(greens=['pc', 'bytecode'], reds=['frame', 'stack', 'funcs'],
                      get_printable_location=get_location)

def execute(bytecode, funcs, args):
    stack = []
    frame = args[:]
    pc = 0

    while pc < len(bytecode.code):
        jitdriver.jit_merge_point(pc=pc, bytecode=bytecode, frame=frame, stack=stack, funcs=funcs)

        code = bytecode.code
        constants = bytecode.constants

        op = code[pc]
        arg = code[pc+1]
        pc += 2

        if op == LOAD_CONST:
            stack.append(constants[arg])
        elif op == LOAD_VAR:
            stack.append(frame[arg])
        elif op == ADD:
            b = stack.pop()
            a = stack.pop()
            stack.append(W_Int(a.intval() + b.intval()))
        elif op == SUB:
            b = stack.pop()
            a = stack.pop()
            stack.append(W_Int(a.intval() - b.intval()))
        elif op == LT:
            b = stack.pop()
            a = stack.pop()
            stack.append(W_Int(int(a.intval() < b.intval())))
        elif op == JUMP_IF_FALSE:
            val = stack.pop()
            if val.intval() == 0:
                pc = arg
        elif op == JUMP:
            pc = arg
        elif op == CALL:
            fname_w = constants[arg]
            fname = fname_w.strval()
            if fname not in funcs:
                print("Function not found: %s" % fname)
                return W_Int(0)
            func_obj = funcs[fname]
            fargs = []
            for _ in range(func_obj.arg_count):
                fargs.append(stack.pop())
            fargs.reverse()

            res = execute(func_obj.bytecode, funcs, fargs)
            stack.append(res)
        elif op == RETURN:
            return stack.pop()
        elif op == PRINT:
            val = stack.pop()
            print(val.intval())
            stack.append(val)

    return W_Int(0)

# ---------------- Main ----------------

def entry_point(argv):
    if len(argv) < 2:
        print("Usage: %s <source_file>" % argv[0])
        return 1

    filename = argv[1]
    fp = os.open(filename, os.O_RDONLY, 0o777)
    content = ""
    while True:
        read = os.read(fp, 4096)
        if len(read) == 0:
            break
        content += read
    os.close(fp)

    try:
        ast = parse(content)
    except Exception as e:
        # RPython might not support printing exception object directly in restricted environment if it's not wrapped properly,
        # but standard python does. In RPython we usually rely on specific error printing.
        # But 'e' is an Exception.
        print("Parse error: %s" % str(e))
        return 1

    compiler = Compiler()
    compiler.compile(ast)

    main_bc = Bytecode("main", compiler.code, compiler.constants, 0)
    execute(main_bc, compiler.global_funcs, [])

    return 0

def target(*args):
    return entry_point, None

if __name__ == '__main__':
    entry_point(sys.argv)
