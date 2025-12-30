# Minimal LLM in C++

This is a minimal, educational implementation of a Transformer-based Large Language Model (LLM) written in pure C++ with no external dependencies (like PyTorch, TensorFlow, or BLAS). It relies solely on the C++ Standard Library.

## Features

- **Pure C++**: Uses `std::vector` for tensor storage and basic math.
- **Training & Inference**: Includes a complete training loop with manual backpropagation.
- **Components**:
  - `Tensor` struct for data handling and **Gradient Storage**.
  - `Linear` layer (Matrix Multiplication) with `backward` pass.
  - `LayerNorm` with `backward` pass.
  - `MultiHeadAttention` (Self-Attention with Causal Masking) with `backward` pass.
  - `FeedForward` (MLP) with `backward` pass.
  - `Block` (Transformer Layer).
  - `Adam` Optimizer.
  - `CrossEntropyLoss`.
- **Architecture**: A GPT-style decoder-only model.
- **Tokenizer**: A hardcoded character-level tokenizer (A-Z, a-z, space, punctuation).

## Usage

1. **Compile**:
   ```bash
   make
   ```

2. **Run**:
   ```bash
   ./main
   ```

The program will:
1. Initialize the model with random weights.
2. Train (overfit) on the sentence: *"The quick brown fox jumps over the lazy dog."*
3. Print the loss at every 20 steps.
4. After training, generate text starting with the prompt "The".

## Limitations

- **Performance**: This implementation prioritizes readability and simplicity over performance. It runs on the CPU and uses naive matrix multiplication algorithms (`O(n^3)`).
- **Overfitting**: The current example overfits a single sentence to demonstrate that the gradients and learning mechanism work. It is not a pre-trained general-purpose model.
- **Numerical Stability**: Basic float precision without sophisticated stability tricks (though it handles the demo case fine).

## Code Structure

- `main.cpp`: Contains the entire implementation in a single file (~800 lines).
  - `Tensor` struct: Container for `data` and `grad`.
  - `matmul_forward/backward`: Matrix multiplication with gradient computation.
  - `layer_norm_forward/backward`: Layer normalization logic.
  - Classes (`Linear`, `MultiHeadAttention`, etc.): Neural network modules with `forward` and `backward` methods.
  - `Optimizer` / `Adam`: Parameter updates.
  - `GPT` class: The main model assembly.
  - `main()`: Sets up the model, runs the training loop, and executes the generation loop.
