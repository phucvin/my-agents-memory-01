#!/bin/bash

# Clean up
rm -rf src
rm -f main_separate main_unity

# Generate files
python3 generate_project.py

echo "Files generated."

# Measure Separate Compilation Time
echo "Compiling separately..."
start_time=$(date +%s%N)
# Compile each file to object
for f in src/file_*.cpp; do
    g++ -c $f -o "${f%.cpp}.o"
done
# Compile main
g++ -c src/main.cpp -o src/main.o
# Link
g++ src/*.o -o main_separate
end_time=$(date +%s%N)
separate_time=$(( (end_time - start_time) / 1000000 ))
echo "Separate Compilation Time: ${separate_time} ms"

# Measure Unity Build Time
echo "Compiling Unity Build..."
start_time=$(date +%s%N)
g++ src/unity_build.cpp -o main_unity
end_time=$(date +%s%N)
unity_time=$(( (end_time - start_time) / 1000000 ))
echo "Unity Build Time: ${unity_time} ms"

echo "Cleanup..."
rm -rf src main_separate main_unity
