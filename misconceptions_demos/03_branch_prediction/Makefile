all: main.s

main.s: main.cpp
	# -fverbose-asm: Puts source code lines in the assembly output (for GCC)
	# clang also supports it but output differs.
	g++ -O2 -S -fverbose-asm main.cpp -o main.s

clean:
	rm -f main.s
