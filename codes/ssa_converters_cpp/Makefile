CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -g

OBJS = main.o ir.o ssa.o regalloc.o

all: ssa_converter

ssa_converter: $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $(OBJS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f *.o ssa_converter
