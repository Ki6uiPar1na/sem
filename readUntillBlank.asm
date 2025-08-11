.model small
.stack 100h

.code
main:
    mov ah, 1          ; DOS function 1: read character from keyboard

read_loop:
    int 21h            ; Wait for key press, result in AL
    cmp al, ' '        ; Compare with space character
    je  end_prog       ; If space, jump to end
    jmp read_loop      ; Otherwise, keep reading characters

end_prog:
    mov ah, 4Ch        ; DOS function 4Ch: exit program
    int 21h

end main
