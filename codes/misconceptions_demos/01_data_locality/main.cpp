#include <iostream>
#include <vector>
#include <chrono>
#include <random>

// ==========================================
// Approach 1: Array of Structs (AoS)
// This is the "natural" object-oriented way.
// ==========================================

struct ParticleAoS {
    float x, y, z;
    float vx, vy, vz;
    int id;
    char padding[32]; // Simulating a larger struct to make cache misses more likely
};

void updateAoS(std::vector<ParticleAoS>& particles, float dt) {
    for (auto& p : particles) {
        p.x += p.vx * dt;
        p.y += p.vy * dt;
        p.z += p.vz * dt;
    }
}

// ==========================================
// Approach 2: Struct of Arrays (SoA)
// This is Data-Oriented Design.
// ==========================================

struct ParticlesSoA {
    std::vector<float> x, y, z;
    std::vector<float> vx, vy, vz;
    std::vector<int> id;
    // We don't need padding here because we only iterate over the data we need.

    void resize(size_t n) {
        x.resize(n); y.resize(n); z.resize(n);
        vx.resize(n); vy.resize(n); vz.resize(n);
        id.resize(n);
    }
};

void updateSoA(ParticlesSoA& particles, size_t n, float dt) {
    // Explicitly optimize for autovectorization by using local pointers
    // and restricting them if possible (though vector iterators are usually fine)
    float* __restrict px = particles.x.data();
    float* __restrict py = particles.y.data();
    float* __restrict pz = particles.z.data();
    const float* __restrict pvx = particles.vx.data();
    const float* __restrict pvy = particles.vy.data();
    const float* __restrict pvz = particles.vz.data();

    for (size_t i = 0; i < n; ++i) {
        px[i] += pvx[i] * dt;
        py[i] += pvy[i] * dt;
        pz[i] += pvz[i] * dt;
    }
}

// ==========================================
// Benchmark Utils
// ==========================================

int main() {
    const size_t N = 1000000;
    const int ITERATIONS = 100;
    const float dt = 0.016f;

    std::cout << "Benchmarking with " << N << " particles over " << ITERATIONS << " iterations.\n";

    // Setup AoS
    std::vector<ParticleAoS> aos(N);
    for(size_t i=0; i<N; ++i) {
        aos[i].vx = 1.0f; aos[i].vy = 2.0f; aos[i].vz = 3.0f;
    }

    // Warmup AoS
    updateAoS(aos, dt);

    auto start = std::chrono::high_resolution_clock::now();
    for(int i=0; i<ITERATIONS; ++i) {
        updateAoS(aos, dt);
    }
    auto end = std::chrono::high_resolution_clock::now();
    std::cout << "AoS Time: "
              << std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count()
              << " ms" << std::endl;

    // Setup SoA
    ParticlesSoA soa;
    soa.resize(N);
    for(size_t i=0; i<N; ++i) {
        soa.vx[i] = 1.0f; soa.vy[i] = 2.0f; soa.vz[i] = 3.0f;
    }

    // Warmup SoA
    updateSoA(soa, N, dt);

    start = std::chrono::high_resolution_clock::now();
    for(int i=0; i<ITERATIONS; ++i) {
        updateSoA(soa, N, dt);
    }
    end = std::chrono::high_resolution_clock::now();
    std::cout << "SoA Time: "
              << std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count()
              << " ms" << std::endl;

    std::cout << "\nAnalysis: If the compiler automatically optimized for data locality,\n"
              << "it would transform AoS into SoA internally or reorder fields to avoid loading\n"
              << "unused data (like 'id' and 'padding') into the cache.\n"
              << "Since it cannot safely do that (due to memory layout rules), SoA is manually faster.\n";

    return 0;
}
