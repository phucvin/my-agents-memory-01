#!/bin/bash
set -e

# NOTE: We use g++ because clang++ in this environment seems unstable with some configurations.

echo "Compiling with -O2..."
g++ -O2 main.cpp -o main_O2
echo "Compiling with -O3..."
g++ -O3 main.cpp -o main_O3

echo "---------------------------------------------------"
echo "Binary Size Comparison:"
ls -l main_O2 main_O3 | awk '{print $9 ": " $5 " bytes"}'

echo "---------------------------------------------------"
echo "Running -O2..."
./main_O2
echo "Running -O3..."
./main_O3

echo "---------------------------------------------------"
echo "Assembly Comparison (MD5):"
g++ -O2 -S main.cpp -o main_O2.s
g++ -O3 -S main.cpp -o main_O3.s
md5sum main_O2.s main_O3.s

echo "---------------------------------------------------"
echo "Note: For pointer-chasing code (like Linked Lists), -O3 rarely provides"
echo "benefits over -O2 because the bottleneck is memory latency, not instruction count."
echo "Often, the generated assembly is identical or very similar."

# Cleanup
rm -f main_O2 main_O3 main_O2.s main_O3.s
