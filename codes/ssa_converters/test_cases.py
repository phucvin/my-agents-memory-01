from .ir import *

def create_test_program():
    # Program:
    # x = 1
    # y = 10
    # if x < 5:
    #    x = x + 1
    # else:
    #    x = x * 2
    # while y > 0:
    #    y = y - 1
    #    x = x + y
    # print x

    # Blocks: entry, if_check, then, else, loop_header, loop_body, exit

    entry = BasicBlock("entry")
    entry.add_instruction(Const("x", 1))
    entry.add_instruction(Const("y", 10))
    entry.add_instruction(Jump("if_check"))

    if_check = BasicBlock("if_check")
    if_check.add_instruction(BinOp("cond", "<", "x", 5))
    if_check.add_instruction(Branch("cond", "then", "else"))

    then_blk = BasicBlock("then")
    then_blk.add_instruction(BinOp("x", "+", "x", 1))
    then_blk.add_instruction(Jump("loop_header"))

    else_blk = BasicBlock("else")
    else_blk.add_instruction(BinOp("x", "*", "x", 2))
    else_blk.add_instruction(Jump("loop_header"))

    loop_header = BasicBlock("loop_header")
    loop_header.add_instruction(BinOp("loop_cond", ">", "y", 0))
    loop_header.add_instruction(Branch("loop_cond", "loop_body", "exit"))

    loop_body = BasicBlock("loop_body")
    loop_body.add_instruction(BinOp("y", "-", "y", 1))
    loop_body.add_instruction(BinOp("x", "+", "x", "y"))
    loop_body.add_instruction(Jump("loop_header"))

    exit_blk = BasicBlock("exit")
    exit_blk.add_instruction(Print("x"))
    exit_blk.add_instruction(Return(0))

    prog = Function("test_prog",
                    [entry, if_check, then_blk, else_blk, loop_header, loop_body, exit_blk],
                    entry)
    return prog
