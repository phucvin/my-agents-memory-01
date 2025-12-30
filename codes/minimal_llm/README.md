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
Step 0, Loss: 8.86248
Step 20, Loss: 0.193206
...
Step 200, Loss: 0.00216047

Training complete. Generating text...
Thequick brown fox jumps over the lazy dog.
quickbrk brown fox jumps over the lazy dog.do
applen k browbrfox jumps over the lazy dog.do

Generating for 10 random words (30% in-training):
Braine k brown fox jumps over the lazy dog.do
Lightick brown fox jumps over the lazy dog.do
thequick brown fox jumps over the lazy dog.
Moonquick brown fox jumps over the lazy dog.
Lifequick brown fox jumps over the lazy dog.
Earthick brown fox jumps over the lazy dog.do
brownover towy dog.dog.dodoer the lazy dog.do
Spacen k brown fox jumps over the lazy dog.do
dogquick brown fox jumps over the lazy dog.
Skye n k brown fox jumps over the lazy dog.
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
