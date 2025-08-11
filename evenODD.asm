org 100h           ; COM program start

.data
msg1 db "Enter a number: $"
even_msg db 13,10, "The number is EVEN.$"
odd_msg  db 13,10, "The number is ODD.$"

buffer db 6         ; Max length (5 digits)
       db 0         ; Actual length
       db 6 dup(0)  ; Input buffer

.code
start:
    mov ah, 09h
    mov dx, offset msg1
    int 21h          ; Show prompt

    mov ah, 0Ah
    mov dx, offset buffer
    int 21h          ; Read input

    ; Get last digit entered
    mov cl, [buffer+1]      ; Number of characters entered
    mov si, offset buffer+2
    add si, cx
    dec si                  ; SI points to last digit

    mov al, [si]            ; Load last digit ASCII
    sub al, '0'             ; Convert to number

    test al, 1              ; Check if last bit is 1 (odd)
    jz is_even

is_odd:
    mov ah, 09h
    mov dx, offset odd_msg
    int 21h
    jmp done

is_even:
    mov ah, 09h
    mov dx, offset even_msg
    int 21h

done:
    mov ah, 4Ch
    int 21h
