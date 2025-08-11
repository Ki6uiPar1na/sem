.model small
.stack 100h

.data
prompt       db 'Enter marks (0-99): $'
gradeAplus   db 'A+$'
gradeA       db 'A$'
gradeB       db 'B$'
gradeC       db 'C$'

input        db 3              ; max length = 2 digits + CR
             db ?              ; actual length (filled by DOS)
             db 3 dup(?)       ; buffer for input

.code
main:
    mov ax, @data
    mov ds, ax

    ; Print prompt
    lea dx, prompt
    mov ah, 9
    int 21h

    ; Read input
    lea dx, input
    mov ah, 0Ah
    int 21h

    ; Convert to number
    mov cl, input[1]           ; number of characters typed
    mov si, offset input + 2
    xor ax, ax

    cmp cl, 2
    jne one_digit

    ; Two digits
    mov al, [si]               ; first digit
    sub al, '0'
    mov bl, 10
    mul bl                     ; AX = first_digit * 10
    mov bl, [si+1]
    sub bl, '0'
    add al, bl
    jmp after_conv

one_digit:
    mov al, [si]
    sub al, '0'

after_conv:
    ; Check marks and print grade
    cmp al, 80
    jae print_Aplus
    cmp al, 70
    jae print_A
    cmp al, 60
    jae print_B
    jmp print_C

print_Aplus:
    lea dx, gradeAplus
    jmp print_grade

print_A:
    lea dx, gradeA
    jmp print_grade

print_B:
    lea dx, gradeB
    jmp print_grade

print_C:
    lea dx, gradeC

print_grade:
    mov ah, 9
    int 21h

    mov ah, 4Ch
    int 21h
end main
