#include <iostream>
#include <vector>
#include <cmath>
#include <random>
#include <string>
#include <algorithm>
#include <iomanip>
#include <cassert>
#include <cstdlib>
#include <ctime>

// ======================================================================================
// Minimal LLM Implementation in Pure C++ (Training & Inference)
// ======================================================================================
//
// Features:
// - Transformer (GPT) Architecture
// - Manual Backpropagation (Reverse Mode Auto-Differentiation via explicit backward methods)
// - Adam Optimizer
// - Training Loop to overfit a sentence
// - 2-Character Tokenization
//
// This code is designed to be readable for software engineers who may not have a deep
// background in mathematics or artificial intelligence.
//
// ======================================================================================

// --- Constants ---
// The size of our base character set. (A-Z, a-z, punctuation).
const int BASE_VOCAB_SIZE = 65;

// The size of the dictionary. We use 2 characters per token.
const int VOCABULARY_SIZE = BASE_VOCAB_SIZE * BASE_VOCAB_SIZE;

// The size of the vector representation for each token.
// Think of this as the "richness" of the information we store about each character.
const int EMBEDDING_DIMENSION = 48;

// The maximum number of tokens the model can look back at.
// Since each token is 2 chars, this covers 128 characters.
const int MAX_SEQUENCE_LENGTH = 64;

// Transformer models split their attention into multiple "heads" to focus on different
// relationships (e.g., one head might track syntax, another might track context).
const int NUMBER_OF_ATTENTION_HEADS = 4;

// The dimension of each attention head.
const int ATTENTION_HEAD_DIMENSION = EMBEDDING_DIMENSION / NUMBER_OF_ATTENTION_HEADS;

// The number of Transformer Blocks (layers) stacked on top of each other.
// More layers allow the model to understand more complex patterns.
const int NUMBER_OF_LAYERS = 2;

// The learning rate for the optimizer. This controls how big the steps are when updating weights.
const float ADAM_LEARNING_RATE = 0.005f;

// --- Tensor Helper ---
// A Tensor is essentially a multi-dimensional array (like a matrix or a 3D grid of numbers).
// In Deep Learning, we also store the 'gradient' (grad) alongside the data.
// The gradient tells us how much increasing a value in 'data' would increase the final error (Loss).
// We use these gradients to adjust the values in the opposite direction to reduce the error.
struct Tensor {
    std::vector<float> data; // The actual values (weights or activations)
    std::vector<float> grad; // The gradients (computed during backpropagation)
    std::vector<int> shape;  // Dimensions, e.g., {64, 48} for a matrix

    Tensor() {}
    Tensor(std::vector<int> s) : shape(s) {
        int size = 1;
        for (int d : s) size *= d;
        data.resize(size, 0.0f);
        grad.resize(size, 0.0f);
    }

    // Reset gradients to zero before a new training step.
    void zero_grad() {
        std::fill(grad.begin(), grad.end(), 0.0f);
    }

    // Initialize the data with random numbers.
    // This is crucial for breaking symmetry so the network can learn.
    void random_init(float std_dev = 0.02f) {
        // Use a random device to seed the generator for true randomness across runs
        std::random_device rd;
        std::mt19937 gen(rd());
        std::normal_distribution<float> d(0.0f, std_dev);
        for (auto &x : data) x = d(gen);
    }

    int size() const {
        return data.size();
    }

    // Helper functions to access data at specific indices easily
    float& at(int i) { return data[i]; }
    float& at(int r, int c) { return data[r * shape[1] + c]; }
    float& at(int b, int r, int c) { return data[b * shape[1] * shape[2] + r * shape[2] + c]; }

    float& grad_at(int i) { return grad[i]; }
    float& grad_at(int r, int c) { return grad[r * shape[1] + c]; }
};

// --- Global Random ---
float random_float() {
    return (float)rand() / RAND_MAX;
}

// --- Math Operations with Backward ---
// In Deep Learning, every operation (like addition, multiplication) has two steps:
// 1. Forward: Compute the result (C = A * B).
// 2. Backward: Compute how the result's change affects inputs (dC -> dA, dB).

// Matrix Multiplication (Forward Pass)
// C = A @ B
// A: [M, K], B: [K, N], C: [M, N]
void matrix_multiply_forward(const Tensor& A, const Tensor& B, Tensor& C) {
    int M = A.shape[0];
    int K = A.shape[1];
    int N = B.shape[1];
    C = Tensor({M, N});

    for (int m = 0; m < M; ++m) {
        for (int n = 0; n < N; ++n) {
            float sum = 0.0f;
            for (int k = 0; k < K; ++k) {
                sum += A.data[m * K + k] * B.data[k * N + n];
            }
            C.data[m * N + n] = sum;
        }
    }
}

// Matrix Multiplication (Backward Pass)
// dC is the gradient of the Loss with respect to C.
// We propagate this gradient back to A and B.
void matrix_multiply_backward(const Tensor& A, const Tensor& B, const Tensor& dC, Tensor& dA, Tensor& dB) {
    int M = A.shape[0];
    int K = A.shape[1];
    int N = B.shape[1];

    // Gradients flow backwards through matrix multiplication:
    // dA += dC @ B^T
    // dB += A^T @ dC

    for (int m = 0; m < M; ++m) {
        for (int n = 0; n < N; ++n) {
            float d = dC.grad[m * N + n];
            if (d == 0.0f) continue;

            for (int k = 0; k < K; ++k) {
                dA.grad[m * K + k] += d * B.data[k * N + n];
                dB.grad[k * N + n] += A.data[m * K + k] * d;
            }
        }
    }
}

// Element-wise addition: C = A + B
void add_forward(const Tensor& A, const Tensor& B, Tensor& C) {
    C = A; // Copy shape and size
    for (size_t i = 0; i < A.data.size(); ++i) {
        C.data[i] = A.data[i] + B.data[i];
    }
}

// Backward for addition.
// If C = A + B, then a change in C distributes equally to A and B.
void add_backward(const Tensor& dC, Tensor& dA, Tensor& dB) {
    for (size_t i = 0; i < dC.grad.size(); ++i) {
        dA.grad[i] += dC.grad[i];
        dB.grad[i] += dC.grad[i];
    }
}

// Layer Normalization
// This operation stabilizes the learning process by ensuring inputs to a layer
// have a mean of 0 and a variance of 1.
// x: [Seq, Embed], gamma: [Embed], beta: [Embed]
void layer_norm_forward(const Tensor& x, const Tensor& gamma, const Tensor& beta, Tensor& out, Tensor& mean_cache, Tensor& rstd_cache) {
    int seq_len = x.shape[0];
    int embed_dim = x.shape[1];
    out = Tensor(x.shape);
    mean_cache = Tensor({seq_len});
    rstd_cache = Tensor({seq_len});

    for (int i = 0; i < seq_len; ++i) {
        float mean = 0.0f;
        int offset = i * embed_dim;
        for (int j = 0; j < embed_dim; ++j) mean += x.data[offset + j];
        mean /= embed_dim;
        mean_cache.data[i] = mean;

        float var = 0.0f;
        for (int j = 0; j < embed_dim; ++j) {
            float diff = x.data[offset + j] - mean;
            var += diff * diff;
        }
        var /= embed_dim;
        // rstd = reciprocal standard deviation
        float rstd = 1.0f / std::sqrt(var + 1e-5f);
        rstd_cache.data[i] = rstd;

        for (int j = 0; j < embed_dim; ++j) {
            float norm = (x.data[offset + j] - mean) * rstd;
            // Scale by gamma and shift by beta (learnable parameters)
            out.data[offset + j] = norm * gamma.data[j] + beta.data[j];
        }
    }
}

// Backward pass for Layer Norm is mathematically complex, involving partial derivatives
// with respect to mean and variance.
void layer_norm_backward(const Tensor& dOut, const Tensor& x, const Tensor& gamma, Tensor& dx, Tensor& dgamma, Tensor& dbeta, const Tensor& mean_cache, const Tensor& rstd_cache) {
    int seq_len = x.shape[0];
    int embed_dim = x.shape[1];

    for (int i = 0; i < seq_len; ++i) {
        float mean = mean_cache.data[i];
        float rstd = rstd_cache.data[i];
        int offset = i * embed_dim;

        float d_sigma_sq = 0.0f;
        float d_mu = 0.0f;

        for (int j = 0; j < embed_dim; ++j) {
            float norm_val = (x.data[offset + j] - mean) * rstd;
            float d_y = dOut.grad[offset + j];

            dgamma.grad[j] += d_y * norm_val;
            dbeta.grad[j] += d_y;

            float d_norm = d_y * gamma.data[j];
            d_sigma_sq += d_norm * (x.data[offset + j] - mean) * (-0.5f) * std::pow(rstd, 3);
            d_mu += d_norm * (-rstd);
        }

        for (int j = 0; j < embed_dim; ++j) {
            float d_norm = dOut.grad[offset + j] * gamma.data[j];
            float term1 = d_norm * rstd;
            float term2 = d_sigma_sq * 2.0f * (x.data[offset + j] - mean) / embed_dim;
            float term3 = d_mu / embed_dim;

            dx.grad[offset + j] += term1 + term2 + term3;
        }
    }
}

// Softmax Function
// Converts raw scores (logits) into probabilities (values between 0 and 1 that sum to 1).
void softmax_forward(Tensor& x) {
    int last_dim = x.shape.back();
    int num_rows = x.data.size() / last_dim;

    for (int i = 0; i < num_rows; ++i) {
        int offset = i * last_dim;
        float max_val = x.data[offset];
        for (int j = 1; j < last_dim; ++j) {
            if (x.data[offset + j] > max_val) max_val = x.data[offset + j];
        }

        float sum = 0.0f;
        for (int j = 0; j < last_dim; ++j) {
            x.data[offset + j] = std::exp(x.data[offset + j] - max_val);
            sum += x.data[offset + j];
        }
        for (int j = 0; j < last_dim; ++j) {
            x.data[offset + j] /= sum;
        }
    }
}

// --- Modules ---

// Abstract base class for an Optimizer
class Optimizer {
public:
    virtual void step() = 0;
    virtual void add_param(Tensor* p) = 0;
    virtual void zero_grad() = 0;
};

// Adam Optimizer (Adaptive Moment Estimation)
// A smart way to update weights. Instead of just subtracting the gradient,
// it keeps track of momentum (moving average of gradients) to smooth out the updates.
class AdamOptimizer : public Optimizer {
    struct ParamState {
        Tensor* p;
        std::vector<float> m; // First moment (mean)
        std::vector<float> v; // Second moment (variance)
    };
    std::vector<ParamState> params;
    float lr, beta1, beta2, eps;
    int t;

public:
    AdamOptimizer(float lr=0.001f) : lr(lr), beta1(0.9f), beta2(0.999f), eps(1e-8f), t(0) {}

    void add_param(Tensor* p) override {
        params.push_back({p, std::vector<float>(p->data.size(), 0.0f), std::vector<float>(p->data.size(), 0.0f)});
    }

    void zero_grad() override {
        for (auto& ps : params) ps.p->zero_grad();
    }

    void step() override {
        t++;
        for (auto& ps : params) {
            for (size_t i = 0; i < ps.p->data.size(); ++i) {
                float g = ps.p->grad[i];
                ps.m[i] = beta1 * ps.m[i] + (1 - beta1) * g;
                ps.v[i] = beta2 * ps.v[i] + (1 - beta2) * g * g;

                // Bias correction
                float m_hat = ps.m[i] / (1 - std::pow(beta1, t));
                float v_hat = ps.v[i] / (1 - std::pow(beta2, t));

                // Update parameter
                ps.p->data[i] -= lr * m_hat / (std::sqrt(v_hat) + eps);
            }
        }
    }
};

// Abstract base class for Neural Network Modules
class NeuralNetworkModule {
public:
    virtual void register_params(Optimizer& opt) {}
};

// Linear Layer (Fully Connected Layer)
// Performs the operation: y = xW + b
class LinearLayer : public NeuralNetworkModule {
public:
    Tensor weights; // W
    Tensor bias;    // b
    Tensor x_cache; // Store input for backward pass

    LinearLayer(int in_dim, int out_dim) {
        weights = Tensor({in_dim, out_dim});
        bias = Tensor({1, out_dim});
        weights.random_init(1.0f / std::sqrt(in_dim));
    }

    void register_params(Optimizer& opt) override {
        opt.add_param(&weights);
        opt.add_param(&bias);
    }

    Tensor forward(const Tensor& x) {
        x_cache = x;
        Tensor out;
        matrix_multiply_forward(x, weights, out);
        // Add bias to every row
        int seq_len = out.shape[0];
        int out_dim = out.shape[1];
        for (int i = 0; i < seq_len; ++i) {
            for (int j = 0; j < out_dim; ++j) {
                out.at(i, j) += bias.data[j];
            }
        }
        return out;
    }

    Tensor backward(Tensor& dOut) {
        int seq_len = dOut.shape[0];
        int out_dim = dOut.shape[1];

        // Gradient for bias
        for (int i = 0; i < seq_len; ++i) {
            for (int j = 0; j < out_dim; ++j) {
                bias.grad[j] += dOut.grad_at(i, j);
            }
        }

        Tensor dx({seq_len, weights.shape[0]});
        matrix_multiply_backward(x_cache, weights, dOut, dx, weights);
        return dx;
    }
};

class LayerNormalization : public NeuralNetworkModule {
    Tensor gamma, beta;
    Tensor x_cache, mean_cache, rstd_cache;
    int dim;
public:
    LayerNormalization(int dim) : dim(dim) {
        gamma = Tensor({dim}); for(auto& v:gamma.data) v=1.0f;
        beta = Tensor({dim});
    }

    void register_params(Optimizer& opt) override {
        opt.add_param(&gamma);
        opt.add_param(&beta);
    }

    Tensor forward(const Tensor& x) {
        x_cache = x;
        Tensor out;
        layer_norm_forward(x, gamma, beta, out, mean_cache, rstd_cache);
        return out;
    }

    Tensor backward(const Tensor& dOut) {
        Tensor dx(x_cache.shape);
        layer_norm_backward(dOut, x_cache, gamma, dx, gamma, beta, mean_cache, rstd_cache);
        return dx;
    }
};

// Feed Forward Network
// Simple two-layer MLP with ReLU activation in between.
// Logic: Linear -> ReLU -> Linear
class FeedForwardNetwork : public NeuralNetworkModule {
    LinearLayer l1, l2;
    Tensor hidden_cache;
public:
    FeedForwardNetwork(int dim) : l1(dim, 4 * dim), l2(4 * dim, dim) {}

    void register_params(Optimizer& opt) override {
        l1.register_params(opt);
        l2.register_params(opt);
    }

    Tensor forward(const Tensor& x) {
        hidden_cache = l1.forward(x);
        // ReLU Activation: max(0, val)
        for (float &val : hidden_cache.data) {
            if (val < 0) val = 0;
        }
        return l2.forward(hidden_cache);
    }

    Tensor backward(Tensor& dOut) {
        Tensor dHidden = l2.backward(dOut);
        // Backward for ReLU
        for (size_t i = 0; i < dHidden.grad.size(); ++i) {
            if (hidden_cache.data[i] <= 0) dHidden.grad[i] = 0.0f;
        }
        return l1.backward(dHidden);
    }
};

// Multi-Head Self-Attention
// This is the core of the Transformer. It allows the model to look at other tokens in the sequence.
// - Query (Q): What am I looking for?
// - Key (K): What do I contain?
// - Value (V): What information do I pass along?
class MultiHeadSelfAttention : public NeuralNetworkModule {
    LinearLayer key_query_value_projection; // Projects input to combined Q, K, V
    LinearLayer output_projection;          // Projects attention output back to embedding dimension
    int dim, n_heads, head_dim;
    Tensor x_cache, qkv_cache, scores_cache, prob_cache;

public:
    MultiHeadSelfAttention(int dim, int n_heads)
        : key_query_value_projection(dim, 3 * dim), output_projection(dim, dim), dim(dim), n_heads(n_heads), head_dim(dim/n_heads) {}

    void register_params(Optimizer& opt) override {
        key_query_value_projection.register_params(opt);
        output_projection.register_params(opt);
    }

    Tensor forward(const Tensor& x) {
        x_cache = x;
        int seq_len = x.shape[0];

        // 1. Get Q, K, V from input
        qkv_cache = key_query_value_projection.forward(x);

        Tensor output({seq_len, dim});
        prob_cache = Tensor({n_heads, seq_len, seq_len});

        float scale = 1.0f / std::sqrt((float)head_dim);

        for (int h = 0; h < n_heads; ++h) {
            for (int i = 0; i < seq_len; ++i) {
                for (int j = 0; j < seq_len; ++j) {
                    float dot = 0.0f;
                    // Causal Masking: We can only look at past tokens (j <= i)
                    if (j <= i) {
                         for (int d = 0; d < head_dim; ++d) {
                             float q = qkv_cache.at(i, h * head_dim + d);
                             float k = qkv_cache.at(j, dim + h * head_dim + d);
                             dot += q * k;
                         }
                         dot *= scale; // Scale scores
                    } else {
                        dot = -1e9f; // Mask out future tokens
                    }
                    prob_cache.at(h, i, j) = dot;
                }
            }

            // 2. Softmax to get attention probabilities
            for (int i = 0; i < seq_len; ++i) {
                float max_val = -1e9f;
                for (int j = 0; j < seq_len; ++j) {
                    float val = prob_cache.at(h, i, j);
                    if (val > max_val) max_val = val;
                }
                float sum = 0.0f;
                for (int j = 0; j < seq_len; ++j) {
                    float val = std::exp(prob_cache.at(h, i, j) - max_val);
                    prob_cache.at(h, i, j) = val;
                    sum += val;
                }
                for (int j = 0; j < seq_len; ++j) {
                    prob_cache.at(h, i, j) /= sum;
                }
            }

            // 3. Weighted sum of Values
            for (int i = 0; i < seq_len; ++i) {
                for (int d = 0; d < head_dim; ++d) {
                    float val = 0.0f;
                    for (int j = 0; j < seq_len; ++j) {
                         float v = qkv_cache.at(j, 2 * dim + h * head_dim + d);
                         val += prob_cache.at(h, i, j) * v;
                    }
                    output.at(i, h * head_dim + d) = val;
                }
            }
        }

        return output_projection.forward(output);
    }

    Tensor backward(Tensor& dOut) {
        Tensor dProjIn = output_projection.backward(dOut);
        int seq_len = dOut.shape[0];

        Tensor dQKV({seq_len, 3 * dim});
        float scale = 1.0f / std::sqrt((float)head_dim);

        for (int h = 0; h < n_heads; ++h) {
             // Backward through value aggregation
             for (int i = 0; i < seq_len; ++i) {
                 for (int j = 0; j < seq_len; ++j) {
                     float p = prob_cache.at(h, i, j);
                     for (int d = 0; d < head_dim; ++d) {
                         float dout_val = dProjIn.grad_at(i, h*head_dim + d);
                         float v = qkv_cache.at(j, 2*dim + h*head_dim + d);
                         // Gradient w.r.t V
                         dQKV.grad_at(j, 2*dim + h*head_dim + d) += p * dout_val;
                     }
                 }
             }

             // Backward through Softmax
             for (int i = 0; i < seq_len; ++i) {
                 std::vector<float> dP(seq_len, 0.0f);
                 for (int j = 0; j < seq_len; ++j) {
                      for (int d = 0; d < head_dim; ++d) {
                          float dout_val = dProjIn.grad_at(i, h*head_dim + d);
                          float v = qkv_cache.at(j, 2*dim + h*head_dim + d);
                          dP[j] += dout_val * v;
                      }
                 }

                 float sum_p_dp = 0.0f;
                 for (int k = 0; k < seq_len; ++k) sum_p_dp += prob_cache.at(h, i, k) * dP[k];

                 for (int j = 0; j < seq_len; ++j) {
                     float p = prob_cache.at(h, i, j);
                     float dScore = p * (dP[j] - sum_p_dp);

                     if (j > i) continue;

                     float scaled_dScore = dScore * scale;
                     for (int d = 0; d < head_dim; ++d) {
                         float q = qkv_cache.at(i, h*head_dim + d);
                         float k_val = qkv_cache.at(j, dim + h*head_dim + d);

                         // Gradient w.r.t Q
                         dQKV.grad_at(i, h*head_dim + d) += scaled_dScore * k_val;
                         // Gradient w.r.t K
                         dQKV.grad_at(j, dim + h*head_dim + d) += scaled_dScore * q;
                     }
                 }
             }
        }

        return key_query_value_projection.backward(dQKV);
    }
};

// Transformer Block
// Composed of: LayerNorm -> Attention -> Add(Residual) -> LayerNorm -> FeedForward -> Add(Residual)
class TransformerBlock : public NeuralNetworkModule {
    LayerNormalization attention_norm;
    MultiHeadSelfAttention self_attention;
    LayerNormalization mlp_norm;
    FeedForwardNetwork feed_forward;

    // Cache for backward pass
    Tensor resid1_cache, norm1_cache, attn_out_cache;
    Tensor resid2_cache, norm2_cache;

public:
    TransformerBlock(int dim, int n_heads)
        : attention_norm(dim), self_attention(dim, n_heads), mlp_norm(dim), feed_forward(dim) {}

    void register_params(Optimizer& opt) override {
        attention_norm.register_params(opt);
        self_attention.register_params(opt);
        mlp_norm.register_params(opt);
        feed_forward.register_params(opt);
    }

    Tensor forward(const Tensor& input) {
        // Sub-layer 1: Attention with residual connection
        resid1_cache = input;
        norm1_cache = attention_norm.forward(input);
        attn_out_cache = self_attention.forward(norm1_cache);

        Tensor x;
        add_forward(resid1_cache, attn_out_cache, x);

        // Sub-layer 2: Feed Forward with residual connection
        resid2_cache = x;
        norm2_cache = mlp_norm.forward(x);
        Tensor mlp_out = feed_forward.forward(norm2_cache);

        Tensor out;
        add_forward(resid2_cache, mlp_out, out);
        return out;
    }

    Tensor backward(Tensor& dOut) {
        // Backward for Sub-layer 2
        Tensor dResid2(dOut.shape), dMlpOut(dOut.shape);
        add_backward(dOut, dResid2, dMlpOut);

        Tensor dNorm2 = feed_forward.backward(dMlpOut);
        Tensor dX_from_norm2 = mlp_norm.backward(dNorm2);

        for (size_t i = 0; i < dResid2.grad.size(); ++i) {
            dResid2.grad[i] += dX_from_norm2.grad[i];
        }
        Tensor dX = dResid2;

        // Backward for Sub-layer 1
        Tensor dResid1(dX.shape), dAttnOut(dX.shape);
        add_backward(dX, dResid1, dAttnOut);

        Tensor dNorm1 = self_attention.backward(dAttnOut);
        Tensor dInput_from_norm1 = attention_norm.backward(dNorm1);

         for (size_t i = 0; i < dResid1.grad.size(); ++i) {
            dResid1.grad[i] += dInput_from_norm1.grad[i];
        }

        return dResid1;
    }
};

// GPT Model (Decoder-Only Transformer)
class GPTModel : public NeuralNetworkModule {
public:
    Tensor token_embedding_table;    // WTE: Maps Token IDs to Vectors
    Tensor position_embedding_table; // WPE: Maps Position IDs to Vectors
    std::vector<TransformerBlock*> blocks;
    LayerNormalization final_layer_norm;
    LinearLayer language_model_head; // Projects final vectors to Vocabulary size

    GPTModel() : final_layer_norm(EMBEDDING_DIMENSION), language_model_head(EMBEDDING_DIMENSION, VOCABULARY_SIZE) {
        token_embedding_table = Tensor({VOCABULARY_SIZE, EMBEDDING_DIMENSION}); token_embedding_table.random_init();
        position_embedding_table = Tensor({MAX_SEQUENCE_LENGTH, EMBEDDING_DIMENSION}); position_embedding_table.random_init();

        for (int i = 0; i < NUMBER_OF_LAYERS; ++i) {
            blocks.push_back(new TransformerBlock(EMBEDDING_DIMENSION, NUMBER_OF_ATTENTION_HEADS));
        }
    }

    ~GPTModel() {
        for (auto b : blocks) delete b;
    }

    void register_params(Optimizer& opt) override {
        opt.add_param(&token_embedding_table);
        opt.add_param(&position_embedding_table);
        for (auto b : blocks) b->register_params(opt);
        final_layer_norm.register_params(opt);
        language_model_head.register_params(opt);
    }

    Tensor forward(const std::vector<int>& idx) {
        int t = idx.size();
        // Bounds check
        if (t > MAX_SEQUENCE_LENGTH) {
             std::cerr << "Error: Sequence length " << t << " exceeds max " << MAX_SEQUENCE_LENGTH << std::endl;
             exit(1);
        }

        Tensor x({t, EMBEDDING_DIMENSION});

        // 1. Embedding Layer: Combine Token and Position Embeddings
        for (int i = 0; i < t; ++i) {
            int token_id = idx[i];
            for (int j = 0; j < EMBEDDING_DIMENSION; ++j) {
                // x = TokenEmb + PosEmb
                x.at(i, j) = token_embedding_table.at(token_id, j) + position_embedding_table.at(i, j);
            }
        }

        // 2. Transformer Blocks
        for (auto& block : blocks) {
            x = block->forward(x);
        }

        // 3. Final Layer Norm and Projection
        x = final_layer_norm.forward(x);
        Tensor logits = language_model_head.forward(x);
        return logits;
    }

    void backward(Tensor& dLogits, const std::vector<int>& idx) {
        Tensor dX = language_model_head.backward(dLogits);
        dX = final_layer_norm.backward(dX);

        for (int i = NUMBER_OF_LAYERS - 1; i >= 0; --i) {
            dX = blocks[i]->backward(dX);
        }

        int t = idx.size();
        for (int i = 0; i < t; ++i) {
            int token_id = idx[i];
            for (int j = 0; j < EMBEDDING_DIMENSION; ++j) {
                float g = dX.grad_at(i, j);
                token_embedding_table.grad_at(token_id, j) += g;
                position_embedding_table.grad_at(i, j) += g;
            }
        }
    }
};

// --- Utils ---

int single_char_to_index(char c) {
    if (c >= 'A' && c <= 'Z') return c - 'A';
    if (c >= 'a' && c <= 'z') return c - 'a' + 26;
    if (c == ' ') return 52;
    if (c == '.') return 53;
    if (c == ',') return 54;
    return 64; // Unknown
}

char index_to_single_char(int i) {
    if (i >= 0 && i < 26) return 'A' + i;
    if (i >= 26 && i < 52) return 'a' + (i - 26);
    if (i == 52) return ' ';
    if (i == 53) return '.';
    if (i == 54) return ',';
    return '?';
}

int pair_to_index(char c1, char c2) {
    return single_char_to_index(c1) * BASE_VOCAB_SIZE + single_char_to_index(c2);
}

std::pair<char, char> index_to_pair(int i) {
    int idx1 = i / BASE_VOCAB_SIZE;
    int idx2 = i % BASE_VOCAB_SIZE;
    return {index_to_single_char(idx1), index_to_single_char(idx2)};
}

std::vector<int> encode(const std::string& s) {
    std::vector<int> tokens;
    for (size_t i = 0; i < s.length(); i += 2) {
        char c1 = s[i];
        char c2 = (i + 1 < s.length()) ? s[i + 1] : ' '; // Pad with space
        tokens.push_back(pair_to_index(c1, c2));
    }
    return tokens;
}

// Cross Entropy Loss
// Measures how well the predicted probabilities match the actual target token.
float cross_entropy_loss(Tensor& logits, const std::vector<int>& targets, Tensor& dLogits) {
    int seq_len = logits.shape[0];
    int vocab_size = logits.shape[1];

    dLogits = Tensor(logits.shape);
    float total_loss = 0.0f;

    for (int i = 0; i < seq_len; ++i) {
        float max_val = -1e9f;
        for (int j = 0; j < vocab_size; ++j) {
            if (logits.at(i, j) > max_val) max_val = logits.at(i, j);
        }
        float sum = 0.0f;
        std::vector<float> probs(vocab_size);
        for (int j = 0; j < vocab_size; ++j) {
            probs[j] = std::exp(logits.at(i, j) - max_val);
            sum += probs[j];
        }
        for (int j = 0; j < vocab_size; ++j) probs[j] /= sum;

        int target = targets[i];
        if (target < vocab_size) {
             // Loss = -log(probability of correct class)
             total_loss -= std::log(probs[target] + 1e-9f);

             // Gradient of Cross Entropy + Softmax is: prob - 1 (if correct class) else prob
             for (int j = 0; j < vocab_size; ++j) {
                 float y = (j == target) ? 1.0f : 0.0f;
                 dLogits.grad_at(i, j) = (probs[j] - y) / seq_len;
             }
        }
    }
    return total_loss / seq_len;
}

// --- Text Generation Helper ---
void generate_text(GPTModel& model, const std::string& prompt, int length = 50) {
    std::vector<int> tokens = encode(prompt);
    std::cout << prompt;
    for (int i = 0; i < length; ++i) {
        Tensor logits = model.forward(tokens);

        int last_idx = logits.shape[0] - 1;
        int vocab_size = logits.shape[1];

        // Greedy decoding: pick the token with highest probability
        int best_token = 0;
        float best_val = -1e9f;
        for (int v = 0; v < vocab_size; ++v) {
            if (logits.at(last_idx, v) > best_val) {
                best_val = logits.at(last_idx, v);
                best_token = v;
            }
        }

        tokens.push_back(best_token);
        std::pair<char, char> p = index_to_pair(best_token);
        std::cout << p.first << p.second << std::flush;
        if (tokens.size() > MAX_SEQUENCE_LENGTH) tokens.erase(tokens.begin());
    }
    std::cout << std::endl;
}

int main() {
    // Seed global random with time
    srand(time(NULL));

    GPTModel model;
    AdamOptimizer optimizer(ADAM_LEARNING_RATE);
    model.register_params(optimizer);

    std::string text = "The quick brown fox jumps over the lazy dog.";
    std::vector<int> data = encode(text);

    std::cout << "Model initialized. Training on: \"" << text << "\"" << std::endl;

    for (int step = 0; step <= 200; ++step) {
        if (data.size() <= 1) break;

        // Input: "The quick..."
        std::vector<int> input_ids(data.begin(), data.end() - 1);
        // Target: "he quick..." (shifted by 1)
        std::vector<int> target_ids(data.begin() + 1, data.end());

        if (input_ids.size() > MAX_SEQUENCE_LENGTH) {
             input_ids.resize(MAX_SEQUENCE_LENGTH);
             target_ids.resize(MAX_SEQUENCE_LENGTH);
        }

        // 1. Forward Pass
        Tensor logits = model.forward(input_ids);

        // 2. Compute Loss
        Tensor dLogits;
        float loss = cross_entropy_loss(logits, target_ids, dLogits);

        // 3. Backward Pass (Compute Gradients)
        optimizer.zero_grad();
        model.backward(dLogits, input_ids);

        // 4. Update Weights
        optimizer.step();

        if (step % 20 == 0) {
            std::cout << "Step " << step << ", Loss: " << loss << std::endl;
        }
    }

    std::cout << "\nTraining complete. Generating text..." << std::endl;

    // Fixed generations for consistency checks
    generate_text(model, "The");
    generate_text(model, "quick");
    generate_text(model, "apple");

    // Random word generation
    std::vector<std::string> training_words = {"The", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"};
    std::vector<std::string> other_words = {
        "Sun", "Moon", "Earth", "Sky", "Code", "Brain", "Life", "Time", "Space", "Light"
    };

    // Shuffle and pick
    std::random_device rd;
    std::mt19937 g(rd());

    std::shuffle(training_words.begin(), training_words.end(), g);
    std::shuffle(other_words.begin(), other_words.end(), g);

    std::vector<std::string> selected_words;
    // 3 from training (30% of 10)
    for (int i = 0; i < 3 && i < training_words.size(); ++i) selected_words.push_back(training_words[i]);
    // 7 from other
    for (int i = 0; i < 7 && i < other_words.size(); ++i) selected_words.push_back(other_words[i]);

    // Shuffle selected words for random order
    std::shuffle(selected_words.begin(), selected_words.end(), g);

    std::cout << "\nGenerating for 10 random words (30% in-training):" << std::endl;
    for (const auto& word : selected_words) {
        generate_text(model, word);
    }

    return 0;
}
