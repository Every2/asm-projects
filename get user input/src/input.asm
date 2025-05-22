SYS_READ equ 3
SYS_WRITE equ 4

section .data
input_msg db "Type a number: ", 10 ; Declare message and new line
len_input_msg equ $ - input_msg

section .bss
buffer resd 32 ; Allocate 32 bytes

section .text
global _start
_start:
    mov edx, len_input_msg ; pass the len to a register
    mov ecx, input_msg	  ; pass the message to a register
    mov ebx, 1		  ; file descriptor
    mov eax, SYS_WRITE	  ; Syscall write
    int 0x80
    mov eax, SYS_READ ; Read user input
    xor ebx, ebx      ; 0, standard input (stdin)
    lea ecx, [buffer] ; Save input in the buffer
    mov edx, 4	      ; Read 4 bytes (32 bit integer)
    int 0x80
    mov edx, 4 	      ; Read 4 Bytes
    mov ecx, buffer   ; Read Buffer again
    mov ebx, 2	      ; 2, standard output (stout)
    mov eax, SYS_WRITE 	; Print the digited number
    int 0x80
    mov eax, 1 
    xor ebx, ebx
    int 0x80

