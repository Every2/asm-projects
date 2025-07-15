SYS_READ equ 3
SYS_WRITE equ 4

section .data
msg: db "Please enter a number: "
msg_len: equ $-msg
op_msg: db "Choose one operation: +, -, *, / "
op_len: equ $-op_msg
second_msg: db "Please enter another number: "
second_len: equ $-second_msg
buffer_len: equ 4
opb_len: equ 2
result_len: equ 4
error: db "Invalid operator.", 10
error_len: equ $-error

section .bss
buffer: resb 4
num: resb 4
op_buffer: resb 2
num2: resb 4
result: resb 4

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

  call to_integer
  mov [num2], eax
  xor eax, eax
  call clear_buffer

  cmp byte [op_buffer], '+'
  je .sum_op
  cmp byte [op_buffer], '-'
  je .less_op
  cmp byte [op_buffer], '*'
  je .times_op
  cmp byte [op_buffer], '/'
  je .div_op
  jmp .error_case

  .sum_op:
    mov eax, [num]
    add eax, [num2]
    mov [result], eax
    jmp .done

  .less_op:
    mov eax, [num]
    sub eax, [num2]
    mov [result], eax
    jmp .done

  .times_op:
    mov eax, [num]
    imul eax, [num2]
    mov [result], eax
    jmp .done

  .div_op:
    mov eax, [num]
    mov ecx, [num2]
    xor edx, edx
    div ecx
    mov [result], eax
    jmp .done

  .error_case:
    push error_len
    push error
    call write_msg
    add esp, 8
    xor eax, eax
    mov eax, 1
    xor ebx, ebx
    int 0x80
    
  .done:    
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
