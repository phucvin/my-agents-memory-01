CXX = g++
CXXFLAGS = -std=c++14 -Wall -Wextra `pkg-config --cflags protobuf`
LDFLAGS = `pkg-config --libs protobuf` -lgtest -lgtest_main -lpthread

TARGET = test_runner
SRCS = test_main.cpp

all: $(TARGET)

$(TARGET): $(SRCS)
	$(CXX) $(CXXFLAGS) -o $@ $(SRCS) $(LDFLAGS)

clean:
	rm -f $(TARGET)
