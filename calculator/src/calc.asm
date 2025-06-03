SYS_READ equ 3
SYS_WRITE equ 4

section .data
msg: db "Please enter a number: "
msg_len: equ $-msg

section .bss
buffer: resb 4
buffer_len: resd 1

section .text
global _start
_start:
  push ebp
  mov ebp, esp
  push msg_len
  push msg
  call write_msg
  add esp, 8
  call read_input
  push buffer_len
  push buffer
  call write_msg
  add esp, 8
  mov eax, 1
  xor ebx, ebx
  int 0x80
  pop ebp

write_msg:
  push ebp
  mov ebp, esp
  mov edx, [ebp + 12]
  mov ecx, [ebp + 8]
  mov ebx, 1
  mov eax, SYS_WRITE
  int 0x80
  mov esp, ebp
  pop ebp
  ret

read_input:
  mov edx, buffer_len
  mov ecx, buffer
  mov ebx, 0
  mov eax, SYS_READ
  int 0x80
  ret
  
