.model small
.stack 100h

.code
main:
    ; --- Read first number ---
    mov     ah, 1           ; read char
    int     21h
    sub     al, '0'         ; convert ASCII to number
    mov     bl, al          ; store in BL

    ; --- Read second number ---
    mov     ah, 1
    int     21h
    sub     al, '0'
    cmp     al, bl
    jle     skip1
    mov     bl, al          ; update max
skip1:

    ; --- Read third number ---
    mov     ah, 1
    int     21h
    sub     al, '0'
    cmp     al, bl
    jle     skip2
    mov     bl, al
skip2:

    ; --- Print newline first ---
    mov     dl, 0Dh         ; carriage return
    mov     ah, 2
    int     21h
    mov     dl, 0Ah         ; line feed
    mov     ah, 2
    int     21h

    ; --- Print largest ---
    add     bl, '0'         ; convert number back to ASCII
    mov     dl, bl
    mov     ah, 2
    int     21h

    ; Exit program
    mov     ah, 4Ch
    int     21h