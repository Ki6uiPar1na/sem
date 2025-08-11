.model small
.stack 100h

.data
    num1 db ?
    num2 db ?
    sum  db ?
    diff db ?

    msg1 db 'Enter first number (0-99): $'
    msg2 db 0Dh,0Ah, 'Enter second number (0-99): $'
    msg3 db 0Dh,0Ah, 'Sum = $'
    msg4 db 0Dh,0Ah, 'Difference = $'

.code
main:
    mov ax, @data
    mov ds, ax

    ; Ask for first number
    lea dx, msg1
    mov ah, 09h
    int 21h

    call read_number
    mov num1, al

    ; Ask for second number
    lea dx, msg2
    mov ah, 09h
    int 21h

    call read_number
    mov num2, al

    ; Addition
    mov al, num1
    add al, num2
    mov sum, al

    ; Subtraction
    mov al, num1
    sub al, num2
    mov diff, al

    ; Show sum
    lea dx, msg3
    mov ah, 09h
    int 21h
    mov al, sum
    call print_number

    ; Show difference
    lea dx, msg4
    mov ah, 09h
    int 21h
    mov al, diff
    call print_number

    ; Exit
    mov ah, 4Ch
    mov al, 00
    int 21h

; -------------------------------------
; Procedure: read_number
; Reads a number (0–99) from keyboard, returns in AL
; -------------------------------------
read_number:
    xor bx, bx         ; BX will hold the number
read_loop:
    mov ah, 01h        ; Read char from keyboard
    int 21h
    cmp al, 0Dh        ; Enter pressed?
    je  done_read
    sub al, '0'        ; Convert ASCII to number
    xor cx, cx         ; Clear CX to avoid garbage in CH
    mov cl, al         ; Move digit into CL
    mov ax, bx
    mov dx, 10
    mul dx             ; AX = BX * 10
    mov bx, ax
    add bx, cx         ; BX = BX + digit
    jmp read_loop
done_read:
    mov al, bl         ; Return result in AL
    ret

; -------------------------------------
; Procedure: print_number
; Prints number in AL (0–255)
; -------------------------------------
print_number:
    mov ah, 0
    mov bl, 10
    div bl             ; AL = tens, AH = ones
    mov bh, ah         ; Save ones digit in BH

    cmp al, 0
    je one_digit
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

one_digit:
    mov al, bh
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    ret

end main
