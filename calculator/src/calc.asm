SYS_READ equ 3
SYS_WRITE equ 4

section .data
msg: db "Please enter a number: "
msg_len: equ $-msg
op_msg: db "Choose one operation: +, -, *, / "
op_len: equ $-op_msg
second_msg: db "Please enter another number: "
second_len: equ $-second_msg

section .bss
buffer: resb 4
buffer_len: resd 1
num: resb 4
op_buffer: resb 1
opb_len: resb 1

section .text
global _start
_start:
  push msg_len
  push msg
  call write_msg
  add esp, 8

  push buffer_len
  push buffer
  call read_input
  add esp, 8

  call to_integer
  mov [num], eax
  xor eax, eax
  call clear_buffer

  push op_len
  push op_msg
  call write_msg
  add esp, 8
  
  push opb_len
  push op_buffer
  call read_input
  add esp, 8

  push second_len
  push second_msg
  call write_msg
  add esp, 8

  push buffer_len
  push buffer
  call read_input
  add esp, 8

  ;call to_integer

 ; push buffer_len
 ; push buffer
 ; call write_msg
 ; add esp, 8
   
  mov eax, 1
  xor ebx, ebx
  int 0x80

clear_buffer:
  mov ecx, 1
  lea edx, [buffer]
  xor eax, eax
  .loop:
    mov [edx + ecx * 4], eax
    dec ecx
    jnz .loop
  ret

;jump_if_equal:
  

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
  push ebp
  mov ebp, esp
  mov edx, [ebp + 12]
  mov ecx, [ebp + 8]
  mov ebx, 0
  mov eax, SYS_READ
  int 0x80
  mov esp, ebp
  pop ebp
  ret
  
to_integer:
  xor eax, eax
  xor ecx, ecx
 
  .loop:
    mov bl, [buffer + ecx]
    cmp bl, 10
    je .done
    cmp bl, 0
    je .done
    
    sub bl, '0'
    cmp bl, 9
    ja .done
    
    imul eax, eax, 10
    add eax, ebx

    inc ecx
    jmp .loop
   
   .done:
     ret
