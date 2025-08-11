.model small
.stack 100h

.data
msg     db 'Enter a string: $'
buffer  db 20              ; max 19 chars + 1 for length

.code
main:
    mov     ax, @data
    mov     ds, ax

    ; Print prompt
    mov     dx, offset msg
    mov     ah, 9
    int     21h

    ; Read string from user
    lea     dx, buffer
    mov     ah, 0Ah
    int     21h

    ; Print newline (carriage return + line feed)
    mov     dl, 0Dh
    mov     ah, 2
    int     21h
    mov     dl, 0Ah
    mov     ah, 2
    int     21h

    ; Print the first character entered
    lea     si, buffer
    mov     al, [si+2]     ; first char is at buffer+2
    mov     dl, al
    mov     ah, 2
    int     21h

    ; Exit
    mov     ah, 4Ch
    int     21h
end