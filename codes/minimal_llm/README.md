# Minimal LLM in C++

This is a minimal, educational implementation of a Transformer-based Large Language Model (LLM) written in pure C++ with no external dependencies (like PyTorch, TensorFlow, or BLAS). It relies solely on the C++ Standard Library.

## Features

- **Pure C++**: Uses `std::vector` for tensor storage and basic math.
- **Components**:
  - `Tensor` struct for 1D/2D data handling.
  - `Linear` layer (Matrix Multiplication).
  - `LayerNorm`.
  - `MultiHeadAttention` (Self-Attention with Causal Masking).
  - `FeedForward` (MLP).
  - `Block` (Transformer Layer).
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

## Limitations

- **Random Weights**: The model is initialized with random weights. It has not been trained. Therefore, the output text will be gibberish. The purpose is to demonstrate the *architecture* and *inference flow*, not to produce coherent text.
- **Performance**: This implementation prioritizes readability and simplicity over performance. It runs on the CPU and uses naive matrix multiplication algorithms.
- **Numerical Stability**: Basic float precision without sophisticated stability tricks.

## Code Structure

- `main.cpp`: Contains the entire implementation in a single file for ease of reading.
  - `Tensor` struct: Simple container for data.
  - `matmul`, `softmax`, `layer_norm`: Fundamental operations.
  - Classes (`Linear`, `MultiHeadAttention`, etc.): Neural network modules.
  - `GPT` class: The main model assembly.
  - `main()`: Entry point setting up the model and running the generation loop.
