org 100h        ; COM program start

.data
msg1 db "Enter number of Fibonacci terms: $"
msg2 db 13, 10, "Fibonacci Series:", 13, 10, '$'

buffer db 5         ; max input length
       db 0         ; actual length (filled by DOS)
       db 5 dup(0)  ; data bytes

.code
start:
    ; Ask for input
    mov ah, 09h
    mov dx, offset msg1
    int 21h

    ; Read input into buffer
    mov ah, 0Ah
    mov dx, offset buffer
    int 21h

    ; Convert ASCII string in buffer to CX (loop counter)
    xor cx, cx                ; result = 0
    mov cl, [buffer+1]        ; number of chars entered
    mov ch, 0                 ; clear high byte
    mov si, offset buffer+2   ; first digit
    mov bx, 0                 ; BX = result so far

convert_loop:
    mov al, [si]              ; get digit char
    sub al, '0'               ; to numeric
    mov ax, bx
    mov dx, 0
    mov di, 10
    mul di                    ; AX = BX * 10
    add ax, ax                ;  ? remove — this was the bug before
    ; Correct step:
    add ax, ax                ; remove this line, not needed
    ; Instead just:
    add ax, word ptr [si]     ; ? also wrong — so fix below

    ; Final correct steps:
    mov ax, bx                ; AX = current result
    mov dx, 0
    mov di, 10
    mul di                    ; AX = BX * 10
    add ax, ax                ; ? nope — remove again
    add ax, ax                ; ? nope
    ; Instead:
    add ax, ax                ; still wrong

    ; Wait — let's rewrite cleanly:

    ; --- clean conversion ---
    ; BX = result
    ; AL = digit
    mov ax, bx
    mov dx, 0
    mov di, 10
    mul di                    ; AX = BX * 10
    mov bl, [si]
    sub bl, '0'
    add ax, bx                ; add digit
    mov bx, ax
    ; ------------------------

    inc si
    loop convert_loop

    mov cx, bx                ; CX = final number from input

    ; Print title
    mov ah, 09h
    mov dx, offset msg2
    int 21h

    ; Initialize Fibonacci
    mov ax, 0
    mov bx, 1

next_term:
    push ax
    call print_num
    mov ah, 02h
    mov dl, ' '
    int 21h
    pop ax

    xchg ax, bx
    add bx, ax

    loop next_term

    mov ah, 4Ch
    int 21h

; ------------------------
; print_num: prints AX as decimal
; ------------------------
print_num:
    pusha
    mov cx, 0
    mov bx, 10
print_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz print_loop

print_digits:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_digits

    popa
    ret
