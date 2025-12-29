all: example.ll example.s

example.ll: example.cpp
	# -S -emit-llvm: Emit LLVM Intermediate Representation
	# -O3: Enable optimizations (including inlining)
	clang++ -O3 -S -emit-llvm example.cpp -o example.ll

example.s: example.cpp
	# Emit assembly
	clang++ -O3 -S example.cpp -o example.s

clean:
	rm -f example.ll example.s
