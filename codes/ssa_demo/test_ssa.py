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

        # Check that we have valid SSA
        # Just check output structure for now
        # x should be renamed to x_0
        # y should be y_0
        # usage of x in binop should be x_0

        found_x_def = False
        found_y_def = False

        for b in blocks:
            for instr in b.instrs:
                if isinstance(instr, SetInst):
                    if instr.dst == "x_0": found_x_def = True
                    if instr.dst == "y_0": found_y_def = True
                    if instr.dst == "y_0" and instr.val == "x_0": pass # Correct propagation
                if isinstance(instr, OpInst):
                    if instr.dst == "y_0" and instr.arg1 == "x_0": pass

        self.assertTrue(found_x_def)
        # In our IR, BinOp result is assigned to temp, then temp assigned to y.
        # So y = t0, t0 = x + 1.
        # Let's verify general structure.

    def test_if_phi(self):
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

        # We expect a Phi node for x in the join block
        phi_found = False
        for b in blocks:
            for instr in b.instrs:
                if isinstance(instr, PhiInst) and instr.dst.startswith("x_"):
                    phi_found = True
                    self.assertEqual(len(instr.args), 2)

        self.assertTrue(phi_found, "Phi node for x not found in If-Join")

    def test_loop_phi(self):
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

        # We expect a Phi node for i in the loop header
        phi_found = False
        for b in blocks:
            if "loop_header" in b.label:
                for instr in b.instrs:
                    if isinstance(instr, PhiInst) and instr.dst.startswith("i_"):
                        phi_found = True
                        self.assertGreaterEqual(len(instr.args), 2) # Entry and Backedge

        self.assertTrue(phi_found, "Phi node for i not found in Loop Header")

if __name__ == "__main__":
    unittest.main()
