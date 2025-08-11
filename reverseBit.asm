.model small
.stack 100h

.data
    msg1 db 'Enter a number (0-255): $'
    msg2 db 0Dh,0Ah, 'Reversed bit pattern: $'
    num  db ?

.code
main:
    mov ax, @data
    mov ds, ax

    ; Prompt user
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Read number from keyboard
    call read_number
    mov num, al     ; Store in num

    ; Reverse bits
    mov al, num
    mov cl, 8       ; Loop counter (8 bits)
    xor bl, bl      ; BL will hold reversed bits

rev_loop:
    rcr al, 1       ; Carry = LSB of AL
    rcl bl, 1       ; Carry into MSB of BL
    dec cl
    jnz rev_loop

    mov al, bl      ; AL = reversed pattern

    ; Print message
    lea dx, msg2
    mov ah, 09h
    int 21h

    ; Print as binary
    call print_binary

    ; Exit
    mov ah, 4Ch
    xor al, al
    int 21h

;---------------------------------
; read_number: Read decimal input
; Returns AL = value
;---------------------------------
read_number:
    xor bx, bx
read_loop:
    mov ah, 01h
    int 21h
    cmp al, 0Dh
    je done_read
    sub al, '0'
    xor cx, cx
    mov cl, al
    mov ax, bx
    mov dx, 10
    mul dx
    mov bx, ax
    add bx, cx
    jmp read_loop
done_read:
    mov al, bl
    ret

;---------------------------------
; print_binary: Print AL as binary
;---------------------------------
print_binary:
    mov cl, 8
bin_loop:
    shl al, 1
    jc print1
    mov dl, '0'
    jmp printit
print1:
    mov dl, '1'
printit:
    mov ah, 02h
    int 21h
    dec cl
    jnz bin_loop
    ret

end main
