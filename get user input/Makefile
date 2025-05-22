bin/input: bin/ src/input.asm
	nasm -f elf32 -o bin/input.o src/input.asm
	ld -m elf_i386 bin/input.o -o bin/input

bin/:
	mkdir bin

run: bin/input
	./bin/input

.PHONY: clean
clean:
	rm -rf bin
