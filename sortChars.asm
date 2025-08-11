; P18: Read two characters and print them in ascending order
.model small
.stack 100h

.code
main:
    ; Read first character
    mov ah, 1        ; DOS function 1: read character
    int 21h          ; AL = input char
    mov bl, al       ; Store in BL

    ; Read second character
    mov ah, 1
    int 21h
    mov bh, al       ; Store in BH

    ; Compare first and second characters
    cmp bl, bh       ; Compare BL and BH
    jbe print_order  ; Jump if BL <= BH (already in order)

    ; Swap if BL > BH
    xchg bl, bh

print_order:
    ; Print first character
    mov ah, 2
    mov dl, bl
    int 21h

    ; Print second character
    mov dl, bh
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

end main
