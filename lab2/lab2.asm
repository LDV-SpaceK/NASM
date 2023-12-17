section .data
    input db 'Input: ', 0xa, 0xd
    input_len equ $-input

    string db 'Nhap vao chieu dai va chieu rong:', 0xa, 0xd
    string_len equ $-string

    output db 'Output:', 0xa, 0xd
    output_len equ $-output

    perimeter_string db 'Chu vi cua hinh chu nhat: '
    perimeter_len equ $-perimeter_string

    area_string db 'Dien tich cua hinh chu nhat: '
    area_len equ $-area_string

    newline db '', 0xa, 0xd
    newline_len equ $-newline

section .bss
    area resb 1
    perimeter resb 1
    length resb 10
    width resb 10
section .text
    global _start

_start:
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    mov ecx, input 
    mov edx, input_len
    int 80h

    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    mov ecx, string
    mov edx, string_len
    int 80h

    mov eax,3
    mov ebx,0
    lea ecx, length
    mov edx, 10
    int 80h

    mov eax,3
    mov ebx,0
    lea ecx, width
    mov edx, 10
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, output_len
    int 80h

    mov al, [length]
    sub al, '0'
    mov bl, [width]
    sub bl, '0'
    add al, bl
    shl al, 1
    add al, '0'
    mov [perimeter], al

    mov eax, 4         
    mov ebx, 1        
    mov ecx, perimeter_string 
    mov edx, perimeter_len         
    int 80h   

    mov eax, 4         
    mov ebx, 1        
    mov ecx, perimeter 
    mov edx, 1         
    int 80h  

    mov eax, 4         
    mov ebx, 1        
    mov ecx, newline
    mov edx, newline_len      
    int 80h       

    mov al, [length]
    sub al, '0'
    mov bl, [width]
    sub bl, '0'
    mul bl
    add al, '0'
    mov [area], al

    mov eax, 4
    mov ebx, 1         
    mov ecx, area_string     
    mov edx, area_len         
    int 80h   

    mov eax, 4
    mov ebx, 1         
    mov ecx, area      
    mov edx, 1         
    int 80h   

    mov eax, 4         
    mov ebx, 1        
    mov ecx, newline
    mov edx, newline_len      
    int 80h       

    mov eax, 1
    int 80h