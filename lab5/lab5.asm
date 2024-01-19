section .data
    input db 'Input anythings here: '
    input_len equ $-input

    output_string db 'Your string entered: '
    output_len equ $-output_string

    newline db '',0xa,0xd
    newline_len equ $-newline

section .bss
    string resd 10

section .text
    global _start

_start:
    ;input message
    mov eax,4
    mov ebx,1
    mov ecx,input
    mov edx,input_len
    int 80h

    ;input string
    mov eax,3
    mov ebx,0
    mov ecx,string
    mov edx,32
    int 80h

    mov edx, string
    sub eax, 1h
    mov word [edx + eax], 0h

    mov eax,4
    mov ebx,1
    mov ecx, output_string
    mov edx, output_len
    int 80h

    mov esi, string

    loop:
    mov al,[esi]

    test al,al
    jz end

    cmp al, 'a'
    jg convertintoUpper
    cmp al, 'z'
    jl convertintoUpper

    mov eax,4
    mov ebx,1
    mov ecx,esi
    mov edx,1
    int 80h

    inc esi

    jmp loop

    convertintoUpper:
    mov eax, 0
    movzx ecx, byte[esi+eax]
    test ecx,ecx
    jz end
    sub ecx, 32
    mov [esi+eax],cl
    inc eax
    jmp convertintoUpper

    end:
    mov eax, 1
    int 0x80
