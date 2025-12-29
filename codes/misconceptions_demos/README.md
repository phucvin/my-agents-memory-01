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

## Demo Outputs

### 1. Data Locality

Ran with `g++ -O3 -fno-inline -fno-inline-functions -fno-inline-small-functions` to isolate data locality effects from aggressive inlining/vectorization:

```
Benchmarking with 1000000 particles over 100 iterations.
AoS Time: 1140 ms
SoA Time: 346 ms

Analysis: If the compiler automatically optimized for data locality,
it would transform AoS into SoA internally or reorder fields to avoid loading
unused data (like 'id' and 'padding') into the cache.
Since it cannot safely do that (due to memory layout rules), SoA is manually faster.
```

### 2. Inlining Enables Optimizations

Generated LLVM IR (`example.ll`). The `foo_const` function (which calls `sat_div(a, 3)`) has optimized away the check and the generic division:

```llvm
define dso_local noundef i32 @_Z9foo_consti(i32 noundef %0) local_unnamed_addr #0 {
  %2 = sdiv i32 %0, 3
  ret i32 %2
}
```

In contrast, `foo_var` retains the check:

```llvm
define dso_local noundef i32 @_Z7foo_varii(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %4, label %7
  ...
```

### 3. Branch Prediction Hints

Generated assembly (`main.s`).
For `test_branch` (likely `x==0`), the compiler places the `critical_function` call on the fall-through/direct path:

```asm
_Z11test_branchi:
    ...
	testl	%edi, %edi
	jne	.L5                 ; Jump to rare path if x != 0
	jmp	_Z17critical_functionv ; Fall through to critical (likely)
.L5:
	jmp	_Z13rare_functionv
```

For `test_branch_unlikely` (unlikely `x==0`), it prioritizes `rare_function`:

```asm
_Z20test_branch_unlikelyi:
    ...
	testl	%edi, %edi
	je	.L8                 ; Jump to critical path if x == 0 (unlikely)
	jmp	_Z13rare_functionv  ; Fall through to rare (likely)
.L8:
	jmp	_Z17critical_functionv
```

### 4. Separate vs. Unity Compilation

Comparison of compiling 50 files separately vs as a unity build:

```
Separate Compilation Time: 10289 ms
Unity Build Time: 586 ms
```
