section .data
msg db "Hello World!", 10 ; Declare the message and break line
len equ $ - msg		    ; Get the size

section .text
global _start
_start:
    mov edx, len  ; pass the len to edx register
    mov ecx, msg  ; pass the message to ecx
    mov ebx, 1	  ; file descriptor
    mov eax, 4	  ; Syscall write
    int 0x80	  
    mov eax, 1 	  ; Exit syscall
    xor ebx, ebx  ; return 0
    int 0x80
