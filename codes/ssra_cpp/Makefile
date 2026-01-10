CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -g

all: ssra

ssra: main.cpp allocator.h ir.h lru.h
	$(CXX) $(CXXFLAGS) main.cpp -o ssra

clean:
	rm -f ssra
