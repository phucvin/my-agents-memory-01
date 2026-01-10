#include "compiler.h"
#include <stdexcept>
#include <iostream>

namespace RegexVM {

// AST Node Definitions
struct Node {
    virtual ~Node() = default;
    virtual void emit(Compiler& c, std::vector<int>& out_patches) = 0;
};

// Helper to patch a list of jumps
void patch_all(std::vector<Instruction>& prog, const std::vector<int>& list, int target) {
    for (int pc : list) {
        if (prog[pc].op == OP_JMP) prog[pc].x = target;
        else if (prog[pc].op == OP_SPLIT) prog[pc].y = target;
    }
}

struct CharNode : public Node {
    char ch;
    CharNode(char c) : ch(c) {}
    void emit(Compiler& c, std::vector<int>& out_patches) override {
        c.emit(OP_CHAR, 0, 0, 0, ch);
        // Falls through
    }
};

struct ConcatNode : public Node {
    Node *left, *right;
    ConcatNode(Node* l, Node* r) : left(l), right(r) {}
    ~ConcatNode() { delete left; delete right; }
    void emit(Compiler& c, std::vector<int>& out_patches) override {
        std::vector<int> l_out;
        left->emit(c, l_out);

        int right_start = c.current_pc();
        patch_all(c.prog_access(), l_out, right_start);

        right->emit(c, out_patches);
    }
};

struct AltNode : public Node {
    Node *left, *right;
    AltNode(Node* l, Node* r) : left(l), right(r) {}
    ~AltNode() { delete left; delete right; }
    void emit(Compiler& c, std::vector<int>& out_patches) override {
        int split_pc = c.current_pc();
        c.emit(OP_SPLIT);

        int l1 = c.current_pc();
        std::vector<int> l_out;
        left->emit(c, l_out);

        int jmp_pc = c.current_pc();
        c.emit(OP_JMP);
        l_out.push_back(jmp_pc);

        int l2 = c.current_pc();
        std::vector<int> r_out;
        right->emit(c, r_out);

        c.patch(split_pc, l1);
        c.prog_access()[split_pc].y = l2;

        out_patches.insert(out_patches.end(), l_out.begin(), l_out.end());
        out_patches.insert(out_patches.end(), r_out.begin(), r_out.end());
    }
};

struct StarNode : public Node {
    Node* child;
    StarNode(Node* c) : child(c) {}
    ~StarNode() { delete child; }
    void emit(Compiler& c, std::vector<int>& out_patches) override {
        int l1 = c.current_pc();
        c.emit(OP_SPLIT);

        int l2 = c.current_pc();
        c.patch(l1, l2); // Patch x to point to start of child

        std::vector<int> c_out;
        child->emit(c, c_out);

        patch_all(c.prog_access(), c_out, l1);
        c.emit(OP_JMP, l1);

        out_patches.push_back(l1); // The 'y' of SPLIT is exit
    }
};

struct GroupNode : public Node {
    Node* child;
    int index;
    GroupNode(Node* c, int idx) : child(c), index(idx) {}
    ~GroupNode() { delete child; }
    void emit(Compiler& c, std::vector<int>& out_patches) override {
        c.emit(OP_SAVE, 0, 0, index * 2);
        child->emit(c, out_patches);

        int save_pc = c.current_pc();
        c.emit(OP_SAVE, 0, 0, index * 2 + 1);

        patch_all(c.prog_access(), out_patches, save_pc);
        out_patches.clear();
        // Fall through
    }
};


Compiler::Compiler(const std::string& pattern) : pattern_(pattern), pos_(0), capture_count_(0) {}
Compiler::~Compiler() {}

void Compiler::emit(OpCode op, int x, int y, int slot, char c) {
    prog_.push_back({op, c, x, y, slot});
}

int Compiler::current_pc() { return prog_.size(); }

void Compiler::patch(int pc, int target) {
    if (prog_[pc].op == OP_JMP) prog_[pc].x = target;
    else if (prog_[pc].op == OP_SPLIT) prog_[pc].x = target; // We use x for primary target usually?
    // Wait, in AltNode I did: patch(split_pc, l1) -> x=l1. And direct assign y=l2.
    // That's fine.
}

char Compiler::peek() {
    if (pos_ >= pattern_.size()) return 0;
    return pattern_[pos_];
}

char Compiler::consume() {
    return pattern_[pos_++];
}

bool Compiler::match_char(char c) {
    if (peek() == c) {
        consume();
        return true;
    }
    return false;
}

std::vector<Instruction> Compiler::compile() {
    prog_.clear();
    pos_ = 0;
    capture_count_ = 0; // 0 is global match

    // Implicit group 0
    capture_count_++; // 1 for next group
    Node* root = parse_expr();

    // Wrap in group 0
    // Actually, let's just emit group 0 ops manually to avoid node overhead?
    // Or create a GroupNode.
    // GroupNode(root, 0);
    // But root might be null if empty?
    if (!root) return {}; // Handle empty regex?

    emit(OP_SAVE, 0, 0, 0);
    std::vector<int> out;
    root->emit(*this, out);
    int end_save = current_pc();
    emit(OP_SAVE, 0, 0, 1);

    patch_all(prog_, out, end_save);

    emit(OP_MATCH);

    delete root;
    return prog_;
}

// Helper struct for Epsilon match (empty string)
struct EpsilonNode : public Node {
    void emit(Compiler& c, std::vector<int>& out_patches) override {
        // Do nothing, just fall through
    }
};

// Expr -> Term ('|' Term)*
Node* Compiler::parse_expr() {
    Node* left = parse_term();
    if (!left) left = new EpsilonNode();

    while (match_char('|')) {
        Node* right = parse_term();
        if (!right) right = new EpsilonNode();
        left = new AltNode(left, right);
    }
    return left;
}

// Term -> Factor*
// Concatenation
Node* Compiler::parse_term() {
    Node* left = nullptr;

    // While peek() is not '|' and not ')' and not EOF
    while (peek() != '|' && peek() != ')' && peek() != 0) {
        Node* right = parse_factor();
        if (right) {
            if (left) {
                left = new ConcatNode(left, right);
            } else {
                left = right;
            }
        }
    }
    return left;
}

// Factor -> Atom ('*')?
Node* Compiler::parse_factor() {
    Node* atom = parse_atom();
    while (match_char('*')) {
        atom = new StarNode(atom);
    }
    return atom;
}

// Atom -> Char | '(' Expr ')'
Node* Compiler::parse_atom() {
    if (match_char('(')) {
        int idx = capture_count_++;
        Node* expr = parse_expr();
        if (!match_char(')')) {
            // Error handling?
            std::cerr << "Expected ')'" << std::endl;
        }
        return new GroupNode(expr, idx);
    } else {
        char c = consume();
        // Handle escapes? For now just simple chars
        return new CharNode(c);
    }
}

} // namespace RegexVM
