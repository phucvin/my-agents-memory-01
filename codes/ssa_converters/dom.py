from .ir import *

class DominatorTree:
    def __init__(self, cfg):
        self.cfg = cfg
        self.doms = {} # node -> immediate dominator
        self.compute_dominators()
        self.df = {} # node -> dominance frontier
        self.compute_dominance_frontier()

    def compute_dominators(self):
        # A simple iterative algorithm for dominators
        all_blocks = set(self.cfg.blocks)
        for b in all_blocks:
            self.doms[b] = all_blocks if b != self.cfg.entry_block else {b}

        changed = True
        while changed:
            changed = False
            for b in self.cfg.blocks:
                if b == self.cfg.entry_block:
                    continue

                # Intersect dominators of all predecessors
                if not b.predecessors:
                    new_doms = {b}
                else:
                    new_doms = None
                    for p in b.predecessors:
                        if new_doms is None:
                            new_doms = self.doms[p].copy()
                        else:
                            new_doms &= self.doms[p]
                    if new_doms is None:
                        new_doms = set()
                    new_doms.add(b)

                if new_doms != self.doms[b]:
                    self.doms[b] = new_doms
                    changed = True

    def compute_dominance_frontier(self):
        # A set of blocks that are strictly dominated by d
        # DF(d) = { n | d dominates a predecessor of n, but d does not strictly dominate n }

        # Initialize DF
        for b in self.cfg.blocks:
            self.df[b] = set()

        for b in self.cfg.blocks:
            if len(b.predecessors) >= 2:
                for p in b.predecessors:
                    runner = p
                    while runner != self.idom(b) and runner is not None:
                        # Note: runner might not be dominated by idom(b) if loop?
                        # Standard algo:
                        # runner = p
                        # while runner != idom(b):
                        #    df[runner].add(b)
                        #    runner = idom(runner)

                        # We need immediate dominators first to make this efficient,
                        # but we have set of all dominators.
                        # Let's compute immediate dominators first.
                        self.df[runner].add(b)
                        runner = self.idom(runner)

    def idom(self, b):
        # Immediate dominator of b is the dominator d such that d strictly dominates b
        # and every other strict dominator of b dominates d.
        strict_doms = self.doms[b] - {b}
        if not strict_doms:
            return None

        # Find the one that is dominated by all others
        # It's the one with the largest set of dominators
        curr_idom = None
        max_len = -1

        for d in strict_doms:
            if len(self.doms[d]) > max_len:
                max_len = len(self.doms[d])
                curr_idom = d
        return curr_idom

    def get_dominance_frontier(self, b):
        return self.df.get(b, set())

def build_cfg_links(function):
    # Ensure predecessors and successors are set
    block_map = {b.label: b for b in function.blocks}
    for b in function.blocks:
        b.successors = []
        b.predecessors = []

    for b in function.blocks:
        if not b.instructions:
            continue
        last = b.instructions[-1]
        targets = []
        if isinstance(last, Jump):
            targets.append(last.target)
        elif isinstance(last, Branch):
            targets.append(last.true_target)
            targets.append(last.false_target)

        for t in targets:
            if t in block_map:
                target_block = block_map[t]
                b.successors.append(target_block)
                target_block.predecessors.append(b)
