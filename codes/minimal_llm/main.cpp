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
//
// ======================================================================================

// --- Constants ---
const int VOCAB_SIZE = 65;      // Char-level vocab
const int EMBED_DIM = 48;       // Dimension of embeddings
const int SEQ_LEN = 64;         // Maximum context length (Increased to fit the sentence)
const int NUM_HEADS = 4;        // Number of attention heads
const int HEAD_DIM = EMBED_DIM / NUM_HEADS;
const int NUM_LAYERS = 2;       // Number of Transformer Blocks
const float LEARNING_RATE = 0.005f;

// --- Tensor Helper ---
struct Tensor {
    std::vector<float> data;
    std::vector<float> grad;
    std::vector<int> shape;

    Tensor() {}
    Tensor(std::vector<int> s) : shape(s) {
        int size = 1;
        for (int d : s) size *= d;
        data.resize(size, 0.0f);
        grad.resize(size, 0.0f);
    }

    void zero_grad() {
        std::fill(grad.begin(), grad.end(), 0.0f);
    }

    void random_init(float std_dev = 0.02f) {
        std::mt19937 gen(42);
        std::normal_distribution<float> d(0.0f, std_dev);
        for (auto &x : data) x = d(gen);
    }

    int size() const {
        return data.size();
    }

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

// C = A @ B
// A: [M, K], B: [K, N], C: [M, N]
void matmul_forward(const Tensor& A, const Tensor& B, Tensor& C) {
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

// dC is gradient of Loss w.r.t C
// We accumulate into dA and dB
void matmul_backward(const Tensor& A, const Tensor& B, const Tensor& dC, Tensor& dA, Tensor& dB) {
    int M = A.shape[0];
    int K = A.shape[1];
    int N = B.shape[1];

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

// Element-wise add
void add_forward(const Tensor& A, const Tensor& B, Tensor& C) {
    C = A; // Copy shape and size
    for (size_t i = 0; i < A.data.size(); ++i) {
        C.data[i] = A.data[i] + B.data[i];
    }
}

void add_backward(const Tensor& dC, Tensor& dA, Tensor& dB) {
    for (size_t i = 0; i < dC.grad.size(); ++i) {
        dA.grad[i] += dC.grad[i];
        dB.grad[i] += dC.grad[i];
    }
}

// Layer Norm
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
        float rstd = 1.0f / std::sqrt(var + 1e-5f);
        rstd_cache.data[i] = rstd;

        for (int j = 0; j < embed_dim; ++j) {
            float norm = (x.data[offset + j] - mean) * rstd;
            out.data[offset + j] = norm * gamma.data[j] + beta.data[j];
        }
    }
}

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

// Softmax
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

class Optimizer {
public:
    virtual void step() = 0;
    virtual void add_param(Tensor* p) = 0;
    virtual void zero_grad() = 0;
};

class Adam : public Optimizer {
    struct ParamState {
        Tensor* p;
        std::vector<float> m;
        std::vector<float> v;
    };
    std::vector<ParamState> params;
    float lr, beta1, beta2, eps;
    int t;

public:
    Adam(float lr=0.001f) : lr(lr), beta1(0.9f), beta2(0.999f), eps(1e-8f), t(0) {}

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

                float m_hat = ps.m[i] / (1 - std::pow(beta1, t));
                float v_hat = ps.v[i] / (1 - std::pow(beta2, t));

                ps.p->data[i] -= lr * m_hat / (std::sqrt(v_hat) + eps);
            }
        }
    }
};

class Module {
public:
    virtual void register_params(Optimizer& opt) {}
};

class Linear : public Module {
public:
    Tensor W, b;
    Tensor x_cache;

    Linear(int in_dim, int out_dim) {
        W = Tensor({in_dim, out_dim});
        b = Tensor({1, out_dim});
        W.random_init(1.0f / std::sqrt(in_dim));
    }

    void register_params(Optimizer& opt) override {
        opt.add_param(&W);
        opt.add_param(&b);
    }

    Tensor forward(const Tensor& x) {
        x_cache = x;
        Tensor out;
        matmul_forward(x, W, out);
        int seq_len = out.shape[0];
        int out_dim = out.shape[1];
        for (int i = 0; i < seq_len; ++i) {
            for (int j = 0; j < out_dim; ++j) {
                out.at(i, j) += b.data[j];
            }
        }
        return out;
    }

    Tensor backward(Tensor& dOut) {
        int seq_len = dOut.shape[0];
        int out_dim = dOut.shape[1];

        for (int i = 0; i < seq_len; ++i) {
            for (int j = 0; j < out_dim; ++j) {
                b.grad[j] += dOut.grad_at(i, j);
            }
        }

        Tensor dx({seq_len, W.shape[0]});
        matmul_backward(x_cache, W, dOut, dx, W);
        return dx;
    }
};

class LayerNormMod : public Module {
    Tensor gamma, beta;
    Tensor x_cache, mean_cache, rstd_cache;
    int dim;
public:
    LayerNormMod(int dim) : dim(dim) {
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

class FeedForward : public Module {
    Linear l1, l2;
    Tensor hidden_cache;
public:
    FeedForward(int dim) : l1(dim, 4 * dim), l2(4 * dim, dim) {}

    void register_params(Optimizer& opt) override {
        l1.register_params(opt);
        l2.register_params(opt);
    }

    Tensor forward(const Tensor& x) {
        hidden_cache = l1.forward(x);
        for (float &val : hidden_cache.data) {
            if (val < 0) val = 0;
        }
        return l2.forward(hidden_cache);
    }

    Tensor backward(Tensor& dOut) {
        Tensor dHidden = l2.backward(dOut);
        for (size_t i = 0; i < dHidden.grad.size(); ++i) {
            if (hidden_cache.data[i] <= 0) dHidden.grad[i] = 0.0f;
        }
        return l1.backward(dHidden);
    }
};

class MultiHeadAttention : public Module {
    Linear c_attn;
    Linear c_proj;
    int dim, n_heads, head_dim;
    Tensor x_cache, qkv_cache, scores_cache, prob_cache;

public:
    MultiHeadAttention(int dim, int n_heads)
        : c_attn(dim, 3 * dim), c_proj(dim, dim), dim(dim), n_heads(n_heads), head_dim(dim/n_heads) {}

    void register_params(Optimizer& opt) override {
        c_attn.register_params(opt);
        c_proj.register_params(opt);
    }

    Tensor forward(const Tensor& x) {
        x_cache = x;
        int seq_len = x.shape[0];

        qkv_cache = c_attn.forward(x);

        Tensor output({seq_len, dim});
        prob_cache = Tensor({n_heads, seq_len, seq_len});

        float scale = 1.0f / std::sqrt((float)head_dim);

        for (int h = 0; h < n_heads; ++h) {
            for (int i = 0; i < seq_len; ++i) {
                for (int j = 0; j < seq_len; ++j) {
                    float dot = 0.0f;
                    if (j <= i) {
                         for (int d = 0; d < head_dim; ++d) {
                             float q = qkv_cache.at(i, h * head_dim + d);
                             float k = qkv_cache.at(j, dim + h * head_dim + d);
                             dot += q * k;
                         }
                         dot *= scale;
                    } else {
                        dot = -1e9f;
                    }
                    prob_cache.at(h, i, j) = dot;
                }
            }

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

        return c_proj.forward(output);
    }

    Tensor backward(Tensor& dOut) {
        Tensor dProjIn = c_proj.backward(dOut);
        int seq_len = dOut.shape[0];

        Tensor dQKV({seq_len, 3 * dim});
        float scale = 1.0f / std::sqrt((float)head_dim);

        for (int h = 0; h < n_heads; ++h) {
             for (int i = 0; i < seq_len; ++i) {
                 for (int j = 0; j < seq_len; ++j) {
                     float p = prob_cache.at(h, i, j);
                     for (int d = 0; d < head_dim; ++d) {
                         float dout_val = dProjIn.grad_at(i, h*head_dim + d);
                         float v = qkv_cache.at(j, 2*dim + h*head_dim + d);
                         dQKV.grad_at(j, 2*dim + h*head_dim + d) += p * dout_val;
                     }
                 }
             }

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

                         dQKV.grad_at(i, h*head_dim + d) += scaled_dScore * k_val;
                         dQKV.grad_at(j, dim + h*head_dim + d) += scaled_dScore * q;
                     }
                 }
             }
        }

        return c_attn.backward(dQKV);
    }
};

class Block : public Module {
    LayerNormMod ln1;
    MultiHeadAttention attn;
    LayerNormMod ln2;
    FeedForward mlp;
    Tensor resid1_cache, norm1_cache, attn_out_cache;
    Tensor resid2_cache, norm2_cache;

public:
    Block(int dim, int n_heads)
        : ln1(dim), attn(dim, n_heads), ln2(dim), mlp(dim) {}

    void register_params(Optimizer& opt) override {
        ln1.register_params(opt);
        attn.register_params(opt);
        ln2.register_params(opt);
        mlp.register_params(opt);
    }

    Tensor forward(const Tensor& input) {
        resid1_cache = input;
        norm1_cache = ln1.forward(input);
        attn_out_cache = attn.forward(norm1_cache);

        Tensor x;
        add_forward(resid1_cache, attn_out_cache, x);

        resid2_cache = x;
        norm2_cache = ln2.forward(x);
        Tensor mlp_out = mlp.forward(norm2_cache);

        Tensor out;
        add_forward(resid2_cache, mlp_out, out);
        return out;
    }

    Tensor backward(Tensor& dOut) {
        Tensor dResid2(dOut.shape), dMlpOut(dOut.shape);
        add_backward(dOut, dResid2, dMlpOut);

        Tensor dNorm2 = mlp.backward(dMlpOut);
        Tensor dX_from_norm2 = ln2.backward(dNorm2);

        for (size_t i = 0; i < dResid2.grad.size(); ++i) {
            dResid2.grad[i] += dX_from_norm2.grad[i];
        }
        Tensor dX = dResid2;

        Tensor dResid1(dX.shape), dAttnOut(dX.shape);
        add_backward(dX, dResid1, dAttnOut);

        Tensor dNorm1 = attn.backward(dAttnOut);
        Tensor dInput_from_norm1 = ln1.backward(dNorm1);

         for (size_t i = 0; i < dResid1.grad.size(); ++i) {
            dResid1.grad[i] += dInput_from_norm1.grad[i];
        }

        return dResid1;
    }
};

class GPT : public Module {
public:
    Tensor wte;
    Tensor wpe;
    std::vector<Block*> blocks;
    LayerNormMod ln_f;
    Linear lm_head;

    GPT() : ln_f(EMBED_DIM), lm_head(EMBED_DIM, VOCAB_SIZE) {
        wte = Tensor({VOCAB_SIZE, EMBED_DIM}); wte.random_init();
        wpe = Tensor({SEQ_LEN, EMBED_DIM}); wpe.random_init();

        for (int i = 0; i < NUM_LAYERS; ++i) {
            blocks.push_back(new Block(EMBED_DIM, NUM_HEADS));
        }
    }

    ~GPT() {
        for (auto b : blocks) delete b;
    }

    void register_params(Optimizer& opt) override {
        opt.add_param(&wte);
        opt.add_param(&wpe);
        for (auto b : blocks) b->register_params(opt);
        ln_f.register_params(opt);
        lm_head.register_params(opt);
    }

    Tensor forward(const std::vector<int>& idx) {
        int t = idx.size();
        // Bounds check
        if (t > SEQ_LEN) {
             std::cerr << "Error: Sequence length " << t << " exceeds max " << SEQ_LEN << std::endl;
             exit(1);
        }

        Tensor x({t, EMBED_DIM});

        for (int i = 0; i < t; ++i) {
            int token_id = idx[i];
            for (int j = 0; j < EMBED_DIM; ++j) {
                x.at(i, j) = wte.at(token_id, j) + wpe.at(i, j);
            }
        }

        for (auto& block : blocks) {
            x = block->forward(x);
        }

        x = ln_f.forward(x);
        Tensor logits = lm_head.forward(x);
        return logits;
    }

    void backward(Tensor& dLogits, const std::vector<int>& idx) {
        Tensor dX = lm_head.backward(dLogits);
        dX = ln_f.backward(dX);

        for (int i = NUM_LAYERS - 1; i >= 0; --i) {
            dX = blocks[i]->backward(dX);
        }

        int t = idx.size();
        for (int i = 0; i < t; ++i) {
            int token_id = idx[i];
            for (int j = 0; j < EMBED_DIM; ++j) {
                float g = dX.grad_at(i, j);
                wte.grad_at(token_id, j) += g;
                wpe.grad_at(i, j) += g;
            }
        }
    }
};

// --- Utils ---

int char_to_index(char c) {
    if (c >= 'A' && c <= 'Z') return c - 'A';
    if (c >= 'a' && c <= 'z') return c - 'a' + 26;
    if (c == ' ') return 52;
    if (c == '.') return 53;
    if (c == ',') return 54;
    return 64;
}

char index_to_char(int i) {
    if (i >= 0 && i < 26) return 'A' + i;
    if (i >= 26 && i < 52) return 'a' + (i - 26);
    if (i == 52) return ' ';
    if (i == 53) return '.';
    if (i == 54) return ',';
    return '?';
}

std::vector<int> encode(const std::string& s) {
    std::vector<int> tokens;
    for (char c : s) tokens.push_back(char_to_index(c));
    return tokens;
}

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
             total_loss -= std::log(probs[target] + 1e-9f);

             for (int j = 0; j < vocab_size; ++j) {
                 float y = (j == target) ? 1.0f : 0.0f;
                 dLogits.grad_at(i, j) = (probs[j] - y) / seq_len;
             }
        }
    }
    return total_loss / seq_len;
}

int main() {
    srand(42);
    GPT model;
    Adam optimizer(LEARNING_RATE);
    model.register_params(optimizer);

    std::string text = "The quick brown fox jumps over the lazy dog.";
    std::vector<int> data = encode(text);

    std::cout << "Model initialized. Training on: \"" << text << "\"" << std::endl;

    for (int step = 0; step <= 200; ++step) {
        if (data.size() <= 1) break;

        std::vector<int> input_ids(data.begin(), data.end() - 1);
        std::vector<int> target_ids(data.begin() + 1, data.end());

        if (input_ids.size() > SEQ_LEN) {
             input_ids.resize(SEQ_LEN);
             target_ids.resize(SEQ_LEN);
        }

        Tensor logits = model.forward(input_ids);

        Tensor dLogits;
        float loss = cross_entropy_loss(logits, target_ids, dLogits);

        optimizer.zero_grad();
        model.backward(dLogits, input_ids);
        optimizer.step();

        if (step % 20 == 0) {
            std::cout << "Step " << step << ", Loss: " << loss << std::endl;
        }
    }

    std::cout << "\nTraining complete. Generating text..." << std::endl;

    std::string prompt = "The";
    std::vector<int> tokens = encode(prompt);

    std::cout << prompt;
    for (int i = 0; i < 40; ++i) {
        Tensor logits = model.forward(tokens);

        int last_idx = logits.shape[0] - 1;
        int vocab_size = logits.shape[1];

        int best_token = 0;
        float best_val = -1e9f;
        for (int v = 0; v < vocab_size; ++v) {
            if (logits.at(last_idx, v) > best_val) {
                best_val = logits.at(last_idx, v);
                best_token = v;
            }
        }

        tokens.push_back(best_token);
        std::cout << index_to_char(best_token) << std::flush;
        if (tokens.size() > SEQ_LEN) tokens.erase(tokens.begin());
    }
    std::cout << std::endl;

    // Second Generation: "quick"
    std::string prompt2 = "quick";
    std::vector<int> tokens2 = encode(prompt2);

    std::cout << prompt2;
    for (int i = 0; i < 40; ++i) {
        Tensor logits = model.forward(tokens2);

        int last_idx = logits.shape[0] - 1;
        int vocab_size = logits.shape[1];

        int best_token = 0;
        float best_val = -1e9f;
        for (int v = 0; v < vocab_size; ++v) {
            if (logits.at(last_idx, v) > best_val) {
                best_val = logits.at(last_idx, v);
                best_token = v;
            }
        }

        tokens2.push_back(best_token);
        std::cout << index_to_char(best_token) << std::flush;
        if (tokens2.size() > SEQ_LEN) tokens2.erase(tokens2.begin());
    }
    std::cout << std::endl;

    return 0;
}
