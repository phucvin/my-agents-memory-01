CXX = g++
CXXFLAGS = -std=c++17 -Wall -g

SRC = src/main.cpp src/Lexer.cpp src/Parser.cpp src/Interpreter.cpp
OBJ = $(SRC:.cpp=.o)
TARGET = silang

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJ)

clean:
	rm -f $(OBJ) $(TARGET)
