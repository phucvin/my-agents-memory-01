#include <iostream>
#include <vector>
#include <cmath>
#include <random>
#include <string>
#include <algorithm>
#include <iomanip>

// ======================================================================================
// Minimal LLM Implementation in Pure C++
// ======================================================================================
//
// This is a didactic implementation of a Transformer-based Language Model (like GPT).
// It uses only the C++ Standard Library. There are no external dependencies like
// Torch, TensorFlow, or BLAS.
//
// The goal is to show the *structure* and *data flow* of an LLM.
//
// NOTE:
// 1. This runs on CPU and is not optimized for speed.
// 2. The weights are initialized randomly, so the output will be nonsense.
// 3. We use `float` for simplicity.
//
// ======================================================================================

// --- Constants ---
const int VOCAB_SIZE = 65;      // Example: simple char-level vocab (A-Z, a-z, etc.)
const int EMBED_DIM = 64;       // Dimension of embeddings
const int SEQ_LEN = 16;         // Maximum context length
const int NUM_HEADS = 4;        // Number of attention heads
const int HEAD_DIM = EMBED_DIM / NUM_HEADS;
const int NUM_LAYERS = 2;       // Number of Transformer Blocks

// --- Tensor Helper ---
// A simple 1D, 2D, or 3D container. For simplicity, we just manage a flat vector
// and handle indexing manually.
struct Tensor {
    std::vector<float> data;
    std::vector<int> shape;

    Tensor() {}
    Tensor(std::vector<int> s) : shape(s) {
        int size = 1;
        for (int d : s) size *= d;
        data.resize(size, 0.0f);
    }

    // Initialize with He/Xavier-like random values
    void random_init() {
        std::mt19937 gen(42);
        std::normal_distribution<float> d(0.0f, 0.02f);
        for (auto &x : data) x = d(gen);
    }

    float& at(int i) { return data[i]; }
    float& at(int r, int c) { return data[r * shape[1] + c]; }
    float& at(int b, int r, int c) { return data[b * shape[1] * shape[2] + r * shape[2] + c]; }

    // For 4D tensors (Batch, Head, Seq, HeadDim)
    float& at(int b, int h, int s, int d) {
         // shape: [B, H, S, D]
         int idx = b * (shape[1]*shape[2]*shape[3]) +
                   h * (shape[2]*shape[3]) +
                   s * (shape[3]) +
                   d;
         return data[idx];
    }
};

// --- Math Operations ---

void matmul(const Tensor& A, const Tensor& B, Tensor& C) {
    // A: [M, K], B: [K, N], C: [M, N]
    int M = A.shape[0];
    int K = A.shape[1]; // Must match B.shape[0]
    int N = B.shape[1];

    C = Tensor({M, N});

    for (int m = 0; m < M; ++m) {
        for (int n = 0; n < N; ++n) {
            float sum = 0.0f;
            for (int k = 0; k < K; ++k) {
                // Since A and B are passed as const references, we need to handle raw access
                // or use a const-correct accessor. For brevity, using raw vector access logic:
                // A.at(m, k) -> A.data[m*K + k]
                // B.at(k, n) -> B.data[k*N + n]
                sum += A.data[m * K + k] * B.data[k * N + n];
            }
            C.at(m, n) = sum;
        }
    }
}

void softmax(Tensor& x) {
    // Apply softmax along the last dimension
    // x can be [Batch, Seq] or [Batch, Seq, Seq] etc.
    // We treat it as rows of the last dimension.

    int last_dim = x.shape.back();
    int num_rows = x.data.size() / last_dim;

    for (int i = 0; i < num_rows; ++i) {
        int offset = i * last_dim;

        // Find max for numerical stability
        float max_val = x.data[offset];
        for (int j = 1; j < last_dim; ++j) {
            if (x.data[offset + j] > max_val) max_val = x.data[offset + j];
        }

        // Exponentiate and sum
        float sum = 0.0f;
        for (int j = 0; j < last_dim; ++j) {
            x.data[offset + j] = std::exp(x.data[offset + j] - max_val);
            sum += x.data[offset + j];
        }

        // Normalize
        for (int j = 0; j < last_dim; ++j) {
            x.data[offset + j] /= sum;
        }
    }
}

void add(Tensor& A, const Tensor& B) {
    // Element-wise add A += B
    for (size_t i = 0; i < A.data.size(); ++i) {
        A.data[i] += B.data[i];
    }
}

void layer_norm(Tensor& x, const Tensor& gamma, const Tensor& beta) {
    // Input x: [Seq, Embed]
    // gamma, beta: [Embed]
    int seq_len = x.shape[0];
    int embed_dim = x.shape[1];

    for (int i = 0; i < seq_len; ++i) {
        float mean = 0.0f;
        float var = 0.0f;
        int offset = i * embed_dim;

        for (int j = 0; j < embed_dim; ++j) mean += x.data[offset + j];
        mean /= embed_dim;

        for (int j = 0; j < embed_dim; ++j) {
            float diff = x.data[offset + j] - mean;
            var += diff * diff;
        }
        var /= embed_dim;

        float std_inv = 1.0f / std::sqrt(var + 1e-5f);

        for (int j = 0; j < embed_dim; ++j) {
            float norm = (x.data[offset + j] - mean) * std_inv;
            x.data[offset + j] = norm * gamma.data[j] + beta.data[j];
        }
    }
}

// --- Modules ---

class LayerNorm {
public:
    Tensor gamma;
    Tensor beta;
    int dim;

    LayerNorm(int d, int unused_arg_for_consistency_with_others = 0) : dim(d) {
        // Constructor signature match logic if needed, but here simple
        gamma = Tensor({dim});
        for(auto& v:gamma.data) v=1.0f;
        beta = Tensor({dim});
        // beta init 0
    }

    Tensor forward(const Tensor& x) {
        // We reuse the function we defined earlier, but need to adapt it.
        // The function `layer_norm` modifies in place or we need to change it to return.
        // Let's modify the class to use the function but return a new tensor or modify a copy.
        Tensor out = x; // Copy
        // We need to move the `layer_norm` function logic here or call it.
        // The previous function signature was: void layer_norm(Tensor& x, const Tensor& gamma, const Tensor& beta)

        // We can't easily call the global function because of forward declaration issues if we didn't declare it.
        // But `layer_norm` function is defined above.
        ::layer_norm(out, gamma, beta);
        return out;
    }
};

class Linear {
public:
    Tensor W; // [In, Out]
    Tensor b; // [Out]

    Linear(int in_dim, int out_dim) {
        W = Tensor({in_dim, out_dim});
        b = Tensor({1, out_dim}); // Broadcastable
        W.random_init();
        // bias initialized to 0 usually
    }

    Tensor forward(const Tensor& x) {
        // x: [Seq, In]
        // Out = xW + b
        Tensor out;
        matmul(x, W, out);

        // Add bias (broadcasting over Seq dimension)
        int seq_len = out.shape[0];
        int out_dim = out.shape[1];
        for (int i = 0; i < seq_len; ++i) {
            for (int j = 0; j < out_dim; ++j) {
                out.at(i, j) += b.data[j];
            }
        }
        return out;
    }
};

class MultiHeadAttention {
    Linear c_attn; // Combined projection for Q, K, V
    Linear c_proj; // Output projection

public:
    MultiHeadAttention(int dim, int n_heads)
        : c_attn(dim, 3 * dim), c_proj(dim, dim) {}

    Tensor forward(const Tensor& x) {
        // x: [Seq, Dim]
        int seq_len = x.shape[0];
        int dim = x.shape[1];

        // 1. QKV Projection
        Tensor qkv = c_attn.forward(x); // [Seq, 3 * Dim]

        // 2. Split into heads
        // We want to simulate logic: [Seq, 3, Heads, HeadDim] -> transpose to [3, Heads, Seq, HeadDim]
        // For simplicity in this flat tensor structure, we will just compute attention manually per head.

        Tensor output({seq_len, dim});

        for (int h = 0; h < NUM_HEADS; ++h) {
            // Extract Q, K, V for this head
            // Shape of each: [Seq, HeadDim]
            Tensor Q({seq_len, HEAD_DIM});
            Tensor K({seq_len, HEAD_DIM});
            Tensor V({seq_len, HEAD_DIM});

            for (int t = 0; t < seq_len; ++t) {
                for (int d = 0; d < HEAD_DIM; ++d) {
                    // qkv layout: [Seq, 3 * Dim]
                    // We interpret Dim as Heads * HeadDim
                    // So for a specific time t, we have a row of length 3*Dim.
                    // Q part is 0..Dim, K part is Dim..2*Dim, V part is 2*Dim..3*Dim
                    // Inside Q part, head h starts at h*HeadDim.

                    int q_offset = h * HEAD_DIM + d;
                    int k_offset = EMBED_DIM + h * HEAD_DIM + d;
                    int v_offset = 2 * EMBED_DIM + h * HEAD_DIM + d;

                    Q.at(t, d) = qkv.at(t, q_offset);
                    K.at(t, d) = qkv.at(t, k_offset);
                    V.at(t, d) = qkv.at(t, v_offset);
                }
            }

            // 3. Scaled Dot-Product Attention: Softmax(Q @ K.T / sqrt(HeadDim)) @ V

            // Scores: [Seq, Seq]
            Tensor scores({seq_len, seq_len});
            float scale = 1.0f / std::sqrt((float)HEAD_DIM);

            for (int i = 0; i < seq_len; ++i) { // Target position
                for (int j = 0; j < seq_len; ++j) { // Source position
                    float dot = 0.0f;
                    for (int d = 0; d < HEAD_DIM; ++d) {
                        dot += Q.at(i, d) * K.at(j, d);
                    }
                    scores.at(i, j) = dot * scale;
                }
            }

            // Masking (Causal / Autoregressive)
            // Mask out future tokens (j > i) by setting to -infinity
            for (int i = 0; i < seq_len; ++i) {
                for (int j = i + 1; j < seq_len; ++j) {
                    scores.at(i, j) = -1e9f;
                }
            }

            softmax(scores);

            // Weighted Sum of V
            // HeadOutput = Scores @ V
            // [Seq, Seq] @ [Seq, HeadDim] -> [Seq, HeadDim]
            for (int i = 0; i < seq_len; ++i) {
                for (int d = 0; d < HEAD_DIM; ++d) {
                    float val = 0.0f;
                    for (int j = 0; j < seq_len; ++j) {
                        val += scores.at(i, j) * V.at(j, d);
                    }
                    // Place result back into global output buffer directly
                    // Concatenate heads: head h writes to range [h*HeadDim, (h+1)*HeadDim]
                    output.at(i, h * HEAD_DIM + d) = val;
                }
            }
        }

        // 4. Output Projection
        return c_proj.forward(output);
    }
};

class FeedForward {
    Linear l1;
    Linear l2;
public:
    FeedForward(int dim) : l1(dim, 4 * dim), l2(4 * dim, dim) {}

    Tensor forward(const Tensor& x) {
        Tensor hidden = l1.forward(x);

        // GELU approximation or ReLU (using ReLU for simplicity)
        for (float &val : hidden.data) {
            if (val < 0) val = 0;
        }

        return l2.forward(hidden);
    }
};

class Block {
    LayerNorm ln1;
    MultiHeadAttention attn;
    LayerNorm ln2;
    FeedForward mlp;

public:
    Block(int dim, int n_heads)
        : ln1(dim), attn(dim, n_heads), ln2(dim), mlp(dim)
    {
    }

    Tensor forward(const Tensor& input) {
        Tensor x = input; // Work with a copy? No, we need to preserve residual.

        // Residual 1
        Tensor residual = x;
        Tensor norm_x = ln1.forward(x);
        Tensor attn_out = attn.forward(norm_x);
        add(residual, attn_out);
        x = residual;

        // Residual 2
        residual = x;
        norm_x = ln2.forward(x);
        Tensor mlp_out = mlp.forward(norm_x);
        add(residual, mlp_out);

        return residual;
    }
};

class GPT {
public:
    Tensor wte; // Token embeddings [Vocab, Dim]
    Tensor wpe; // Positional embeddings [MaxSeq, Dim]
    std::vector<Block> blocks;
    LayerNorm ln_f;
    Linear lm_head; // Usually ties weights with wte, but separate here for simplicity

    GPT() : ln_f(EMBED_DIM), lm_head(EMBED_DIM, VOCAB_SIZE) {
        wte = Tensor({VOCAB_SIZE, EMBED_DIM}); wte.random_init();
        wpe = Tensor({SEQ_LEN, EMBED_DIM}); wpe.random_init();

        for (int i = 0; i < NUM_LAYERS; ++i) {
            blocks.emplace_back(EMBED_DIM, NUM_HEADS);
        }
    }

    Tensor forward(const std::vector<int>& idx) {
        int t = idx.size();
        // 1. Embeddings
        Tensor x({t, EMBED_DIM});
        for (int i = 0; i < t; ++i) {
            int token_id = idx[i];
            // Token emb + Pos emb
            for (int j = 0; j < EMBED_DIM; ++j) {
                x.at(i, j) = wte.at(token_id, j) + wpe.at(i, j);
            }
        }

        // 2. Transformer Blocks
        for (auto& block : blocks) {
            x = block.forward(x);
        }

        // 3. Final Layer Norm
        x = ln_f.forward(x);

        // 4. Logits
        Tensor logits = lm_head.forward(x); // [Seq, Vocab]
        return logits;
    }

    int generate_next_token(const std::vector<int>& idx) {
        Tensor logits = forward(idx);

        // Get logits for the last time step
        int last_seq_idx = logits.shape[0] - 1;
        int vocab_size = logits.shape[1];

        // Simple Greedy Decoding (argmax)
        // Or Sampling. Let's do simple sampling to see variation.

        // Extract last row
        Tensor last_logits({1, vocab_size});
        for (int i=0; i<vocab_size; ++i) {
            last_logits.data[i] = logits.at(last_seq_idx, i);
        }

        softmax(last_logits); // Probabilities

        // Sample
        float r = (float)rand() / RAND_MAX;
        float cdf = 0.0f;
        for (int i = 0; i < vocab_size; ++i) {
            cdf += last_logits.data[i];
            if (r < cdf) return i;
        }
        return vocab_size - 1;
    }
};

// --- Utils ---

// Simple character tokenizer
char index_to_char(int i) {
    if (i >= 0 && i < 26) return 'A' + i;
    if (i >= 26 && i < 52) return 'a' + (i - 26);
    if (i == 52) return ' ';
    if (i == 53) return '.';
    if (i == 54) return ',';
    return '?'; // Placeholder
}

int char_to_index(char c) {
    if (c >= 'A' && c <= 'Z') return c - 'A';
    if (c >= 'a' && c <= 'z') return c - 'a' + 26;
    if (c == ' ') return 52;
    if (c == '.') return 53;
    if (c == ',') return 54;
    return 0; // Default to 'A'
}

int main() {
    std::srand(time(0));
    GPT model;

    std::string prompt_text = "Hello";
    std::vector<int> tokens;
    for (char c : prompt_text) tokens.push_back(char_to_index(c));

    std::cout << "Model initialized. Config: "
              << NUM_LAYERS << " Layers, "
              << NUM_HEADS << " Heads, "
              << EMBED_DIM << " EmbedDim." << std::endl;
    std::cout << "Prompt: " << prompt_text << std::endl;
    std::cout << "Generating..." << std::endl;

    // Generation Loop
    for (int i = 0; i < 20; ++i) {
        // Crop context if too long (simple sliding window)
        if (tokens.size() > SEQ_LEN) {
            tokens.erase(tokens.begin());
        }

        int next_token = model.generate_next_token(tokens);
        tokens.push_back(next_token);

        std::cout << index_to_char(next_token) << std::flush;
    }
    std::cout << std::endl << "Done." << std::endl;

    return 0;
}
