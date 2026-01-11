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

**Output & Analysis:**

Ran with `g++ -O3 -fno-inline -fno-inline-functions -fno-inline-small-functions` to isolate data locality effects from aggressive inlining/vectorization:

```
Benchmarking with 1000000 particles over 100 iterations.
AoS Time: 1107 ms
SoA Time: 352 ms

Analysis: If the compiler automatically optimized for data locality,
it would transform AoS into SoA internally or reorder fields to avoid loading
unused data (like 'id' and 'padding') into the cache.
Since it cannot safely do that (due to memory layout rules), SoA is manually faster.
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

**Output & Analysis:**

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

**Output & Analysis:**

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

**Output & Analysis:**

Comparison of compiling 50 files separately vs as a unity build:

```
Separate Compilation Time: 9870 ms
Unity Build Time: 556 ms
```

## 5. Undefined Behavior and Optimizations (`05_undefined_behavior`)

**Misconception:** "Undefined Behavior (UB) only enables optimizations."

**Reality:** While UB allows the compiler to make assumptions that enable some optimizations (like removing overflow checks), avoiding the introduction of UB can *prevent* other optimizations (like loop hoisting). The compiler cannot perform a transformation if it might introduce UB on a path where it didn't exist before.

**The Demo:**
- `signed_overflow.cpp` demonstrates UB enabling optimization. The compiler assumes signed overflow never happens, so `(a + 1) > a` becomes a constant `true`.
- `loop_hoist.cpp` demonstrates UB disabling optimization. The compiler cannot blindly hoist `b / c` out of a loop if `n` (loop count) might be <= 0, because if `c == 0`, the hoisted division would crash the program on a path where it previously wouldn't have run.

**Run:**
```bash
cd 05_undefined_behavior
make
# Open signed_overflow.s and loop_hoist.s
```

**Output & Analysis:**

**Enabling Optimization:**
In `signed_overflow.s`, `signed_overflow_check` (which checks `(a + 1) > a`) is optimized to just return 1 (true), because signed overflow is UB and the compiler assumes it doesn't happen:
```asm
_Z21signed_overflow_checki:
    ...
    mov eax, 1
    ret
```
In contrast, `unsigned_overflow_check` performs the actual comparison because unsigned wraparound is defined.

**Disabling Optimization:**
In `loop_hoist.s`, `cannot_hoist_trap` (which calculates `b / c` in a loop) keeps the division *after* the loop count check (`test ecx, ecx`) to ensure it doesn't execute if the loop is empty:
```asm
    test ecx, ecx
    jle .L1     ; Jump if n <= 0
    cdq
    idiv edi    ; Division happens only if we passed the check
```
In `manual_hoist_trap`, where the programmer manually moved `b / c` up, the `idiv` instruction appears *before* the check, making it unsafe (it will crash if `c=0` even if `n=0`):
```asm
    idiv r8d    ; Division happens blindly
    test ecx, ecx
    jle .L16
```
This illustrates that the compiler is restricted from performing this optimization automatically because it must avoid introducing UB on the `n <= 0` path.

## 6. -O3 vs -O2 (`06_O3_vs_O2`)

**Misconception:** "-O3 produces much faster code than -O2."

**Reality:** For most general-purpose code, `-O3` often produces code that is performance-equivalent to `-O2`. Sometimes `-O3` can even be slower or larger due to aggressive unrolling or vectorization that misses the mark or trashes the instruction cache. The specific optimizations added in `-O3` (like aggressive loop vectorization) only help specific types of compute-bound loops.

**The Demo:**
- Compiles a Linked List traversal benchmark with `-O2` and `-O3`.
- This workload is dominated by memory latency (pointer chasing), so auto-vectorization (the main benefit of -O3) cannot help.
- Compares execution time and binary size.
- You will often see they are nearly identical, showing that `-O3` is not a "magic speedup" button for all code.

**Run:**
```bash
cd 06_O3_vs_O2
./run_comparison.sh
```

**Output & Analysis:**

Ran `run_comparison.sh` which compares traversing a large linked list (random memory access) compiled with `-O2` vs `-O3`.

```
Compiling with -O2...
Compiling with -O3...
---------------------------------------------------
Binary Size Comparison:
main_O2: 18072 bytes
main_O3: 17984 bytes
---------------------------------------------------
Running -O2...
Traversal Time: 1308.66 ms
Sum (verification): 49999995000000
Running -O3...
Traversal Time: 1286.97 ms
Sum (verification): 49999995000000
---------------------------------------------------
Assembly Comparison (MD5):
ea5939aeed53c2a587ffa8ecbcc8fa51  main_O2.s
60cc8e97bebfd877a359271ab9a4af6d  main_O3.s
---------------------------------------------------
Note: For pointer-chasing code (like Linked Lists), -O3 rarely provides
benefits over -O2 because the bottleneck is memory latency, not instruction count.
Often, the generated assembly is identical or very similar.
```

## 7. The Role of the Inline Keyword (`07_inline_keyword`)

**Misconception:** "The `inline` keyword forces the compiler to inline the function."

**Reality:** The `inline` keyword acts as a *hint* to the compiler. In LLVM IR, it might add the `inlinehint` attribute, which slightly lowers the threshold for inlining, but the compiler is free to ignore it if the function is too large. Conversely, the compiler will happily inline small functions *without* the `inline` keyword.

**The Demo:**
- `example.cpp` defines `sum_inline` (with keyword) and `sum_no_inline` (without).
- Generating LLVM IR (`make`) shows that `sum_inline` is marked `linkonce_odr` (allowing multiple definitions for linking purposes), which is the primary semantic meaning of `inline` in C++.
- At optimization levels like `-O2`, both are likely inlined or not based on the cost model, regardless of the keyword.

**Run:**
```bash
cd 07_inline_keyword
make
# Open example.ll to see the IR attributes
```

**Output & Analysis:**

Generated LLVM IR (`example.ll`). The `sum_inline` function (declared `inline`) is marked with `linkonce_odr` and `comdat`, which is the linking semantic of `inline`.

```llvm
define linkonce_odr dso_local noundef i32 @_Z10sum_inlineii(i32 noundef %0, i32 noundef %1) #0 comdat {
  ...
}
```

However, at `-O0` (and effectively handled by the frontend), the presence of the `inline` keyword does not force inlining. At higher optimization levels (e.g., `-O2`), both `sum_inline` and `sum_no_inline` would likely be inlined if they are small enough, or not if they are too large, regardless of the keyword. The keyword primarily ensures the function can be defined in a header file without "multiple definition" errors.

## Other Misconceptions (Not Demoed)

The original article covers several other misconceptions that are not demonstrated here due to their theoretical nature or the complexity of creating a stable, contained demo.

1.  **"Optimization gives us optimal programs"**
    *   **Why no demo:** Proving "non-optimality" with a simple code example is difficult because "optimal" is often undefined for execution time on modern hardware (due to noise, layout effects, etc.). The concept is theoretical.

2.  **"Javascript interpreters JIT at runtime because they don't know which paths are hot ahead of time"**
    *   **Why no demo:** This repository focuses on C++/Native compilers. Demonstrating JIT motivation requires a JavaScript engine environment and deep internal inspection tools.

3.  **"If you have a compiler, you don't need an interpreter"**
    *   **Why no demo:** This is an architectural discussion about the utility of interpreters (e.g., for Wasm startup time). It's not a specific coding pattern that can be "benchmarked" or "disassembled" easily in a simple C++ repo.

4.  **"Templates are slow to compile"**
    *   **Why no demo:** While true that C++ compilation is slow, attributing it solely to templates vs header inclusion vs other factors requires a massive comparative benchmark (e.g., comparing D vs C++) which is out of scope for small demos.

5.  **"Why does link-time optimization (LTO) happen at link-time?"**
    *   **Why no demo:** This explains the history of build systems. Demonstrating the *timing* or *architecture* of LTO vs Whole Program Optimization requires analyzing build pipelines, not just running code.

6.  **"The middle-end is target/platform-independent"**
    *   **Why no demo:** Demonstrating target dependence requires a cross-compilation setup (e.g., compiling for x86 vs ARM) and diffing the "platform-independent" IR to show leaked details (like pointer sizes or ABI calling conventions).

7.  **"99% correctness rate is ok"**
    *   **Why no demo:** This relates to using AI/LLMs for code generation. It is a correctness argument, not a performance or behavior characteristic of standard compilers.
