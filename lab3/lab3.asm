section .data
    input db 'Enter a number: '
    input_len equ $-input

    numberdivided db 2

    zero db '>This is even number!!'
    zero_len equ $-zero

    one db '>This is odd number!!'
    one_len equ $-one

    one_constant equ 1
    zero_constant equ 0
section .bss
    number resb 10
    quotient resb 10
    remainder resb 10

section .text
    global _start

_start:
    mov eax,4
    mov ebx,1
    mov ecx,input
    mov edx,input_len
    int 80h

    ;Input
    mov eax,3
    mov ebx,0
    mov ecx,number
    mov edx,10
    int 80h

    ;user input is 0
    cmp eax, 0
    je remainder_zero

    mov al,[number]
    sub al,'0'
    xor ah,ah
    div byte [numberdivided]
    mov [remainder],ah
    mov [quotient],al
    
    cmp byte [remainder], zero_constant
    je remainder_zero

    cmp byte [remainder], one_constant
    je remainder_one

remainder_zero:
    mov eax,4 
    mov ebx,1
    mov ecx,zero
    mov edx,zero_len
    int 80h
    jmp end

remainder_one:
    mov eax,4 
    mov ebx,1
    mov ecx,one
    mov edx,one_len
    int 80h
    jmp end

end:
    ;End
    mov eax,1
    int 80h
