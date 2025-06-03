bin/calc: bin/ src/calc.asm
	nasm -f elf32 -o bin/calc.o src/calc.asm
	ld -m elf_i386 bin/calc.o -o bin/calc

bin/:
	mkdir bin

run: bin/calc
	./bin/calc

.PHONY: clean
clean:
	rm -rf bin
