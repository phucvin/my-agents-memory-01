CXX = g++
CXXFLAGS = -O2 -Wall -std=c++17
TARGET = agent

all: $(TARGET)

$(TARGET): main.cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) main.cpp

clean:
	rm -f $(TARGET) gemini_request.json
