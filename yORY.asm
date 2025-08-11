; Program: Read a character, if it is 'Y' or 'y', print it
.model small
.stack 100h

.code
main:
    ; Read a character from keyboard
    mov ah, 1        ; DOS function 1: read character
    int 21h          ; AL = input character

    ; Check if character is 'Y'
    cmp al, 'Y'
    je print_char

    ; Check if character is 'y'
    cmp al, 'y'
    jne exit_prog    ; If not 'y', exit

print_char:
    ; Print the character
    mov dl, al
    mov ah, 2        ; DOS function 2: display character
    int 21h

exit_prog:
    ; Exit program
    mov ah, 4Ch
    int 21h

end main
