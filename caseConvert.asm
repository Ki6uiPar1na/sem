.model small
.stack 100h

.data
    msg1 db 'Enter a letter: $'
    msg2 db 0Dh,0Ah, 'Converted letter: $'

.code
main:
    mov ax, @data
    mov ds, ax

    ; Show prompt
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Read a single character
    mov ah, 01h
    int 21h
    mov bl, al      ; Save input in BL

    ; Check if uppercase (A-Z)
    cmp bl, 'A'
    jb not_upper
    cmp bl, 'Z'
    ja not_upper
    add bl, 20h     ; Convert to lowercase (ASCII difference)
    jmp show_result

not_upper:
    ; Check if lowercase (a-z)
    cmp bl, 'a'
    jb show_result
    cmp bl, 'z'
    ja show_result
    sub bl, 20h     ; Convert to uppercase

show_result:
    ; Show result message
    lea dx, msg2
    mov ah, 09h
    int 21h

    ; Print converted letter
    mov dl, bl
    mov ah, 02h
    int 21h

    ; Exit program
    mov ah, 4Ch
    mov al, 0
    int 21h

end main
