section .data
    input db 'Input: '
    input_len equ $-input

    output db 'Output:', 0xa, 0xd
    output_len equ $-output

    Hello db 'Hello '
    Hello_len equ $-Hello

    syntax db ' !!', 0xa, 0xd
    syntax_len equ $-syntax

    Welcome db 'Welcome, '
    Welcome_len equ $-Welcome

    toEHC db ' to EHC', 0xa, 0xd
    toEHC_len equ $-toEHC

section .bss
    name resb 10

section .text
    global _start

_start:
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    mov ecx, input 
    mov edx, input_len
    int 80h

    mov eax, 3 ; sys_read
    mov ebx, 0 ; stdin
    mov ecx, name
    mov edx, 10
    int 80h

    mov edx, name
    sub eax, 1h
    mov word [edx + eax], 0h

    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, output_len
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, Hello
    mov edx, Hello_len
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, syntax
    mov edx, syntax_len
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, Welcome
    mov edx, Welcome_len
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, toEHC
    mov edx, toEHC_len
    int 80h

    mov eax, 1
    int 80h
