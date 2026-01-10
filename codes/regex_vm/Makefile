CXX = g++
CXXFLAGS = -std=c++17 -Wall -O2

SRCS = main.cpp vm.cpp compiler.cpp
OBJS = $(SRCS:.cpp=.o)
TARGET = regex_vm

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)
