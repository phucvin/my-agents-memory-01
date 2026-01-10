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
        op_checked = False

        for b in blocks:
            for instr in b.instrs:
                if isinstance(instr, SetInst):
                    if instr.dst == "x_0": found_x_def = True
                    if instr.dst == "y_0": found_y_def = True
                if isinstance(instr, OpInst):
                    op_checked = True
                    self.assertEqual(instr.arg1, "x_0")
                    self.assertEqual(instr.arg2, 1)
                    self.assertTrue(instr.dst.startswith("t"))

        self.assertTrue(found_x_def)
        self.assertTrue(found_y_def)
        self.assertTrue(op_checked)

    def test_if_pizlo(self):
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

        # Expectation:
        # Join block has Phi() reading ^x_N
        # Predecessors have Upsilon(..., ^x_N)

        join_block = None
        for b in blocks:
            if "join" in b.label:
                join_block = b
                break

        self.assertIsNotNone(join_block)

        # Check for Phi for x
        phi_inst = None
        for instr in join_block.instrs:
            if isinstance(instr, PhiInst) and instr.shadow_var.startswith("^x_"):
                phi_inst = instr
                break

        self.assertIsNotNone(phi_inst, "Phi node for x not found in Join block")

        # Check predecessors have Upsilon
        for pred in join_block.preds:
            found_upsilon = False
            for instr in pred.instrs:
                if isinstance(instr, UpsilonInst):
                    if instr.shadow_var == phi_inst.shadow_var:
                        found_upsilon = True
            self.assertTrue(found_upsilon, f"Upsilon for {phi_inst.shadow_var} not found in pred {pred.label}")

    def test_loop_pizlo(self):
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

        # Loop header should have Phi for i
        header_block = None
        for b in blocks:
            if "loop_header" in b.label:
                header_block = b
                break

        self.assertIsNotNone(header_block)

        phi_inst = None
        for instr in header_block.instrs:
            if isinstance(instr, PhiInst) and instr.shadow_var.startswith("^i_"):
                phi_inst = instr
                break
        self.assertIsNotNone(phi_inst, "Phi node for i not found in Loop Header")

        # Check predecessors (Entry, Backedge) have Upsilon
        for pred in header_block.preds:
            found_upsilon = False
            for instr in pred.instrs:
                if isinstance(instr, UpsilonInst):
                    if instr.shadow_var == phi_inst.shadow_var:
                        found_upsilon = True
            self.assertTrue(found_upsilon, f"Upsilon for {phi_inst.shadow_var} not found in pred {pred.label}")

if __name__ == "__main__":
    unittest.main()
