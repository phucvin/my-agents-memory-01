#!/bin/bash
set -e

# Cleanup function
cleanup() {
    rm -f ecsc factorial.c factorial loop.c loop *.out
}

# Trap cleanup on exit
trap cleanup EXIT

# Clean start
cleanup

# Compile the compiler
g++ -std=c++17 src/main.cpp -o ecsc

echo "Compiler built successfully."

# Test Factorial
echo "Running Factorial Test..."
./ecsc tests/factorial.el > factorial.c
# Check if output is empty or obviously wrong before gcc
if [ ! -s factorial.c ]; then
    echo "Error: factorial.c is empty"
    exit 1
fi

gcc factorial.c -o factorial
./factorial > factorial.out
EXPECTED_FACT="120"
GOT_FACT=$(cat factorial.out)

if [ "$GOT_FACT" == "$EXPECTED_FACT" ]; then
    echo "Factorial Test Passed!"
else
    echo "Factorial Test Failed! Expected '$EXPECTED_FACT', got '$GOT_FACT'"
    echo "Generated C code:"
    cat factorial.c
    exit 1
fi

# Test Loop (Evens)
echo "Running Loop Test..."
./ecsc tests/loop.el > loop.c
gcc loop.c -o loop
./loop > loop.out
EXPECTED_LOOP=$'0\n2\n4\n6\n8'
GOT_LOOP=$(cat loop.out)

if [ "$GOT_LOOP" == "$EXPECTED_LOOP" ]; then
    echo "Loop Test Passed!"
else
    echo "Loop Test Failed!"
    echo "Expected:"
    echo "$EXPECTED_LOOP"
    echo "Got:"
    echo "$GOT_LOOP"
    echo "Generated C code:"
    cat loop.c
    exit 1
fi

echo "All tests passed."
