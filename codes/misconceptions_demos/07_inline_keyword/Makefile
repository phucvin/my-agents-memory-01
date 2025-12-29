all: example.ll

example.ll: example.cpp
	# We use -S -emit-llvm to generate human-readable LLVM IR.
	# We use -O1 to enable some optimizations but keep structure clean enough to read,
	# or just -O0 if we want to see the raw attributes before inlining happens.
	# However, 'inlinehint' is added by the frontend (clang), so -O0 is fine to see it.
	clang++ -O0 -S -emit-llvm example.cpp -o example.ll

clean:
	rm -f example.ll
