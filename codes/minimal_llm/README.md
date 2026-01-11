# Minimal LLM in C++

This is a minimal, educational implementation of a Transformer-based Large Language Model (LLM) written in pure C++ with no external dependencies (like PyTorch, TensorFlow, or BLAS). It relies solely on the C++ Standard Library.

## Overview for Software Engineers

If you are a software engineer without a background in Deep Learning, this project maps complex AI concepts to familiar programming constructs:

- **Tensors are just Arrays**: A `Tensor` here is just a wrapper around `std::vector<float>` with some metadata (dimensions). It holds the numbers we compute on.
- **Model Parameters are State**: The "knowledge" of the model is stored in `Tensor` objects (weights and biases). Training is just updating this state to minimize errors.
- **Forward Pass is Execution**: Running the model (`forward`) is a deterministic function call stack that transforms input data into output predictions.
- **Backward Pass is Debugging/Feedback**: Think of backpropagation (`backward`) as tracing back through the execution to blame specific variables (weights) for the incorrect output and suggesting a fix (gradient).
- **Embeddings are Lookup Tables**: We convert characters (integers) into vectors (lists of floats) using a lookup table.
- **Attention is a Database Join**: The attention mechanism allows tokens to "query" other tokens to find relevant information ("values") based on how well they match ("keys").

## Features

- **Pure C++**: Uses `std::vector` for tensor storage and basic math.
- **Training & Inference**: Includes a complete training loop with manual backpropagation.
- **Components**:
  - `Tensor`: Data container with **Gradient Storage**.
  - `LinearLayer`: Fully connected layer (Matrix Multiplication).
  - `LayerNormalization`: Stabilizes data distribution.
  - `MultiHeadSelfAttention`: The core Transformer mechanism allowing context awareness.
  - `FeedForwardNetwork`: Simple MLP for processing information.
  - `TransformerBlock`: A single layer of the GPT architecture.
  - `AdamOptimizer`: The algorithm that updates the weights based on gradients.
- **Architecture**: A GPT-style decoder-only model.
- **Tokenizer**: A hardcoded 2-character tokenizer. Each token represents a pair of characters (e.g., "Th", "e "), increasing the vocabulary to ~4000 tokens.

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
4. After training, generate text starting with two prompts: "The" and "quick".

### Example Output

```
Model initialized. Training on: "The quick brown fox jumps over the lazy dog."
Step 0, Loss: 9.23588
Step 20, Loss: 0.138295
Step 40, Loss: 0.0106303
Step 60, Loss: 0.00559261
Step 80, Loss: 0.0043842
Step 100, Loss: 0.00373135
Step 120, Loss: 0.0032471
Step 140, Loss: 0.002856
Step 160, Loss: 0.00253216
Step 180, Loss: 0.00226069
Step 200, Loss: 0.00203119

Training complete. Generating text...
Thequick brown fox jumps over the lazy dog.g.g. lazy dog.x jumps over the lazy dog.x jumpg.azy dog.azy
quickbrowheown fox jumps over the lazy dog.g.g.own fox jump the lazy dog.x jumpg.er town g.azy dog.azy do
appleick brown fox jumps over the lazy dog.g.x jumps over the lazy dog. lazy dog. lazy dog.azy dog.azy do

Generating for 10 random words (30% in-training):
Codequick brown fox jumps over the lazy dog.g.g.own fox jumps over the lazy dog. lazy dog.g.azy dog.azy
Sunquick brown fox jumps over the lazy dog.g.x jumps over the lazy dog. lazy dog. lazy dog.azy dog.g.g.
dogquick brown fox jumps over the lazy dog.g.g.own fox jumps over the lazy dog. lazy dog.g.azy dog.azy
Spaceick brown fox jumps over the lazy dog.g. lazy dog.x jump the lazy dog.x jumps over tg.azy dog. tg.y
lazyquick brown fox jumps over the lazy dog.g.g. lazy dog.y dog.g.g.y dog.g.x jumps ovown g.azy dog.azy
Moonquick brown fox jumps over the lazy dog.g.g.own fox jumps over the lazy dog. lazy dog.g.azy dog.azy
Thequick brown fox jumps over the lazy dog.g.g. lazy dog.x jumps over the lazy dog.x jumpg.azy dog.azy
Timequick brown fox jumps over the lazy dog.g.x jumps over the lazy dog. lazy dog. lazy dog.azy dog.g.g.
Skyquick brown fox jumps over the lazy dog.g.g.own fox jumps over the lazy dog. lazy dog.g.azy dog.azy
Lightick brown fox jumps over the lazy dog.g.x jumps over the lazy dog. lazy dog. lazy dog.azy dog.azy do
```

## Code Structure

- `main.cpp`: Contains the entire implementation in a single file (~900 lines).
  - **Data Structures**: `Tensor` (data + gradients).
  - **Math**: `matrix_multiply`, `add`, `softmax` (forward and backward versions).
  - **Modules**:
    - `LinearLayer`: `y = xW + b`
    - `MultiHeadSelfAttention`: Calculates relationships between tokens.
    - `TransformerBlock`: Combines Attention and FeedForward layers.
    - `GPTModel`: The main container.
  - **Optimization**: `AdamOptimizer` handles the weight updates.
  - **Main Loop**:
    1. **Encoding**: Convert string to integers.
    2. **Forward**: Predict next token.
    3. **Loss**: Compare prediction to actual.
    4. **Backward**: Calculate gradients.
    5. **Step**: Update weights.

## Limitations

- **Performance**: This implementation prioritizes readability and simplicity over performance. It runs on the CPU and uses naive matrix multiplication algorithms (`O(n^3)`).
- **Overfitting**: The current example overfits a single sentence to demonstrate that the gradients and learning mechanism work. It is not a pre-trained general-purpose model.
- **Numerical Stability**: Basic float precision without sophisticated stability tricks.
