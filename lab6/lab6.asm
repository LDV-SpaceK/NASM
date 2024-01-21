section .data
    msg db 'Enter 2 number positive integer:',0xa,0xd
    len_msg equ $-msg

    sum_msg db 'Sum of 2 entered number:'
    len_sum_msg equ $-sum_msg
    
    newline db '',0xa,0xd
    newline_len equ $-newline

section .bss
    number1 resb 31
    number2 resb 31
    sum resb 32

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len_msg
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, number1
    mov edx, 10
    int 80h

    mov edx, number1
    sub eax, 1h
    mov word [edx + eax], 0h

    mov eax, 3
    mov ebx, 0
    mov ecx, number2
    mov edx, 10
    int 80h

    mov edx, number2
    sub eax, 1h
    mov word [edx + eax], 0h

    ;count length of number 1
    mov ecx, 0
   Number1_len:
      cmp byte [number1 + ecx], 0
      je  len1
      inc ecx
      jmp Number1_len
   len1:
      mov esi, ecx   ; length of number1 in esi

    ;count length of number 2
   mov ecx, 0
   Number2_len:
      cmp byte [number2 + ecx], 0
      je  len2
      inc ecx
      jmp Number2_len
    len2:
      mov edi, ecx   ; length of number2 in edi

   ; find the maximum length between num1 and num2
   cmp esi, edi
   jae lenMax
   mov esi, edi
   lenMax:
      mov   ecx, esi       ; num of digits


add_loop:  
   mov 	al, [number1 + esi - 1]
   adc 	al, [number2 + edi - 1]
   aaa
   pushf
   add 	al, 48
   popf

   mov	[sum + ecx - 1], al
   dec edi
   dec esi
   loop	add_loop

    mov eax,4
    mov ebx,1
    mov ecx, sum_msg
    mov edx, len_sum_msg
    int 80h

    mov eax,4
    mov ebx,1
    mov ecx,sum
    mov edx,32
    int 80h


    mov eax,1
    int 80h