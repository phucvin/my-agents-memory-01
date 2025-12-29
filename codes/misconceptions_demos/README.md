# Compiler Misconceptions Demos

This directory contains code examples illustrating concepts from the article ["Common Misconceptions about Compilers"](https://sbaziotis.com/compilers/common-misconceptions-about-compilers.html).

## 1. Data Locality (`01_data_locality`)

**Misconception:** "The compiler optimizes for data locality."

**Reality:** The compiler rarely changes the layout of your data structures (e.g., changing Array of Structs to Struct of Arrays) because it's often unsafe or violates the language standard (e.g., pointer arithmetic expectations). You must design your data for cache locality yourself.

**The Demo:**
- Compares iterating over an "Array of Structs" (AoS) vs a "Struct of Arrays" (SoA).
- The SoA version is usually significantly faster because it utilizes the CPU cache better (fewer cache misses).
- The compiler does NOT automatically transform the slow AoS code into the fast SoA code.

**Run:**
```bash
cd 01_data_locality
make run
```

## 2. Inlining Enables Optimizations (`02_inlining_enables_opts`)

**Misconception:** "Inlining is useful primarily because it eliminates a call instruction."

**Reality:** The removal of the `call` instruction is a minor benefit. The *major* benefit is that inlining exposes the function body to the optimizer in the context of the caller. This enables further optimizations like constant propagation and dead code elimination that were impossible across function boundaries.

**The Demo:**
- `example.cpp` defines a function `sat_div` with a check for division by zero.
- It is called with a constant (`sat_div(a, 3)`).
- Inspecting the generated LLVM IR (`make`) shows that the division by zero check is completely removed in the inlined version because the compiler sees that `3 != 0`.

**Run:**
```bash
cd 02_inlining_enables_opts
make
# Open example.ll to see the IR
```

## 3. Branch Prediction Hints (`03_branch_prediction`)

**Misconception:** "`__builtin_expect` generates branch hint instructions for the CPU."

**Reality:** On most modern architectures (like x86_64), it does *not* emit specific "hint" instructions. Instead, it guides the compiler to layout the basic blocks in memory such that the "expected" path is the fall-through path (sequential), improving instruction cache usage.

**The Demo:**
- Uses `__builtin_expect` to mark branches as likely or unlikely.
- Generates assembly (`main.s`).
- You can inspect `main.s` to see that the compiler reorders the assembly labels/blocks based on the hint, rather than adding special prefixes.

**Run:**
```bash
cd 03_branch_prediction
make
# Open main.s to see the assembly layout
```

## 4. Separate vs. Unity Compilation (`04_separate_compilation`)

**Misconception:** "Separate compilation is always better/faster."

**Reality:** Separate compilation (one object file per source file) can be slow due to repeated parsing of headers and heavy linking. "Unity builds" (including all sources into one file) can be much faster to compile and allow for better optimization (whole-program view) without LTO.

**The Demo:**
- Generates a dummy project with 50 C++ files.
- Compares the time to compile them separately vs all together (Unity Build).
- The Unity Build is often faster.

**Run:**
```bash
cd 04_separate_compilation
./run_comparison.sh
```
