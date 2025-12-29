all: signed_overflow.s loop_hoist.s

signed_overflow.s: signed_overflow.cpp
	g++ -O3 -S -masm=intel signed_overflow.cpp -o signed_overflow.s

loop_hoist.s: loop_hoist.cpp
	g++ -O3 -S -masm=intel loop_hoist.cpp -o loop_hoist.s

clean:
	rm -f *.s
