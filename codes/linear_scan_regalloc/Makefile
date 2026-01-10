CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -g

OBJS = main.o ir.o parser.o liveness.o regalloc.o

all: regalloc

regalloc: $(OBJS)
	$(CXX) $(CXXFLAGS) -o regalloc $(OBJS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f regalloc $(OBJS)
