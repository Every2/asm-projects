bin/hello: bin/ src/hello.asm
	nasm -f elf32 -o bin/hello.o src/hello.asm
	ld -m elf_i386 bin/hello.o -o bin/hello

bin/:
	mkdir bin

run: bin/hello
	./bin/hello

.PHONY: clean
clean:
	rm -rf bin
