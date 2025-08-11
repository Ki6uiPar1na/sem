.model small
.stack 100h

.code
main:
    mov cx, 80       ; Loop counter = 80 stars
    mov ah, 2        ; DOS function 2: print character
    mov dl, '*'      ; Character to print

print_loop:
    int 21h          ; Print '*'
    loop print_loop  ; Decrement CX, repeat until CX = 0

    mov ah, 4Ch      ; DOS function 4Ch: exit program
    int 21h

end main
