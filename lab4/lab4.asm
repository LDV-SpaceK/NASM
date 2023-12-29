section .data
    input db 'Input: '
    input_len equ $-input

    sumof db 'Sum of '
    sumof_len equ $-sumof

    sequences db ' sequences is: '
    sequences_len equ $-sequences

section .bss
    number resb 10
    sum resb 10
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

    mov edx, number
    sub eax, 1h
    mov word [edx + eax], 0h

    ;convert into integer
    sub byte [number], '0'

    mov byte [sum],0
    mov ebx, 0

    loop_start:
        add [sum], ebx
        inc ebx
        cmp ebx, [number]
        jle loop_start

    mov eax,4
    mov ebx,1
    mov ecx,sumof
    mov edx,sumof_len
    int 80h

    add byte [number], '0'
    mov eax,4
    mov ebx,1
    mov ecx,number
    mov edx,10
    int 80h

    mov eax,4
    mov ebx,1
    mov ecx,sequences
    mov edx,sequences_len
    int 80h

    add byte [sum],'0'
    mov eax,4
    mov ebx,1
    mov ecx,sum
    mov edx,10
    int 80h

end:
    mov eax,1
    int 80h    