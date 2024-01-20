section .data
    input db 'Input anything here: '
    input_len equ $-input

    output_string db 'Your string entered: '
    output_len equ $-output_string

    newline db '',0xa,0xd
    newline_len equ $-newline

    no_upper_string db 'Your strings entered is not contain lower case.',0xa,0xd
    no_upper_string_len equ $-no_upper_string

section .bss
    string resb 32

section .text
    global _start

_start:
    ; input message
    mov eax, 4
    mov ebx, 1
    mov ecx, input
    mov edx, input_len
    int 0x80

    ; input string
    mov eax, 3
    mov ebx, 0
    mov ecx, string
    mov edx, 32
    int 0x80

    mov ecx, string
    call convertToUppercase

    ;if there is no lowercase letter
    cmp edx, 0
    je No_uppercase

    ; output modified string
    mov eax, 4
    mov ebx, 1
    mov ecx, output_string
    mov edx, output_len
    int 0x80

    ; output modified string
    mov eax, 4
    mov ebx, 1
    mov ecx, string
    mov edx, 32
    int 0x80

end:
    mov eax, 1
    int 0x80

convertToUppercase:
    xor esi, esi
    xor edx, edx

convertLoop:
    mov al, [ecx + esi]
    cmp al,0
    je convertEnd

    cmp al, 'a'
    jl convertContinue
    cmp al, 'z'
    jg convertContinue

    ;count lowercase letter
    inc edx
    sub al, 32
    mov [ecx + esi], al

convertContinue:
    inc esi
    jmp convertLoop

convertEnd:
    ret

No_uppercase:
    mov eax,4
    mov ebx,1
    mov ecx,no_upper_string
    mov edx,no_upper_string_len
    int 80h
    jmp end
