import unittest
from ssa import *

class TestSSA(unittest.TestCase):
    def test_simple_linear(self):
        # x = 1
        # y = x + 1
        prog = [
            Assign("x", Num(1)),
            Assign("y", BinOp("+", Var("x"), Num(1)))
        ]
        builder = CFGBuilder()
        blocks, entry = builder.build(prog)
        converter = SSAConverter(blocks, entry)
        converter.convert()

        found_x_def = False
        found_y_def = False

        # Verify Literals and Variables are preserved
        op_checked = False

        # Structure:
        # x_0 = 1
        # t0_0 = x_0 + 1
        # y_0 = t0_0

        for b in blocks:
            for instr in b.instrs:
                if isinstance(instr, SetInst):
                    if instr.dst == "x_0": found_x_def = True
                    if instr.dst == "y_0": found_y_def = True
                if isinstance(instr, OpInst):
                    # We expect t0_0 = x_0 + 1
                    op_checked = True
                    self.assertEqual(instr.arg1, "x_0")
                    self.assertEqual(instr.arg2, 1) # AST Num is int 1
                    self.assertTrue(instr.dst.startswith("t")) # Temp var

        self.assertTrue(found_x_def)
        self.assertTrue(found_y_def)
        self.assertTrue(op_checked)

    def test_if_functional(self):
        # x = 0
        # if 1:
        #   x = 1
        # else:
        #   x = 2
        # print x

        prog = [
            Assign("x", Num(0)),
            If(Num(1),
               [Assign("x", Num(1))],
               [Assign("x", Num(2))]),
            Print(Var("x"))
        ]

        builder = CFGBuilder()
        blocks, entry = builder.build(prog)
        converter = SSAConverter(blocks, entry)
        converter.convert()

        # We expect the join block to have a parameter for x
        # And predecessors to jump with arguments

        join_block = None
        for b in blocks:
            if "join" in b.label:
                join_block = b
                break

        self.assertIsNotNone(join_block)
        # Check params
        # Note: variable naming might vary, but it should have one param
        self.assertEqual(len(join_block.params), 1)
        self.assertTrue(join_block.params[0].startswith("x_"))

        # Check predecessors (then, else) have args in jumps
        for pred in join_block.preds:
            term = pred.instrs[-1]
            if isinstance(term, JumpInst):
                self.assertEqual(len(term.args), 1)
            elif isinstance(term, BranchInst):
                # Should not happen in this simple if-join logic (jumps are inserted)
                pass

    def test_loop_functional(self):
        # i = 0
        # while i < 10:
        #   i = i + 1

        prog = [
            Assign("i", Num(0)),
            While(BinOp("<", Var("i"), Num(10)),
                  [Assign("i", BinOp("+", Var("i"), Num(1)))])
        ]

        builder = CFGBuilder()
        blocks, entry = builder.build(prog)
        converter = SSAConverter(blocks, entry)
        converter.convert()

        # Loop header should have parameters (for i)
        header_block = None
        for b in blocks:
            if "loop_header" in b.label:
                header_block = b
                break

        self.assertIsNotNone(header_block)
        self.assertGreaterEqual(len(header_block.params), 1)

        # Check entry jump args
        # Check backedge jump args
        for pred in header_block.preds:
            term = pred.instrs[-1]
            if isinstance(term, JumpInst):
                self.assertGreaterEqual(len(term.args), 1)

if __name__ == "__main__":
    unittest.main()
