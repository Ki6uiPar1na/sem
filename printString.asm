; Program: Read string from user and print it back
.model small
.stack 100h

.data
    prompt  db "Enter a string: $"
    newline db 0Dh,0Ah, '$'
    buffer  db 50       ; max characters
            db 0        ; number of chars entered
            db 50 dup(0)

.code
main:
    mov ax, @data
    mov ds, ax

    ; Show prompt
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; Read string into buffer
    lea dx, buffer
    mov ah, 0Ah
    int 21h

    ; Print newline
    mov ah, 09h
    lea dx, newline
    int 21h

    ; Print the entered string
    mov ah, 09h
    lea dx, buffer+2   ; skip length bytes
    int 21h

    ; Exit
    mov ah, 4Ch
    int 21h
end main
