.model small
.stack 100h

.code
main:
    mov ah, 2        ; DOS function 2: print character
    mov dl, '?'      ; Character to display
    int 21h          ; Call DOS interrupt

    mov ah, 4Ch      ; DOS function 4Ch: exit program
    int 21h

end main
