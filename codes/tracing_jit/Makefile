CXX = g++
CXXFLAGS = -O3 -std=c++17 -Wall

all: tracing_jit

tracing_jit: main.cpp
	$(CXX) $(CXXFLAGS) -o tracing_jit main.cpp

clean:
	rm -f tracing_jit
