; Program for finding the sum of n elements and printing result in hex
.MODEL small
.STACK 100h
.DATA
    ARR db 25h,12h,15h,1Fh,2Bh
    sum db 0
    msg db 0Dh,0Ah,"Sum in Hex: $"

.CODE
main proc
    mov ax, @data
    mov ds, ax
	
    mov cx, 5           ; number of elements
    mov ax, 0
    mov bx, offset ARR
	
repeat:
    add al, [bx]        ; add array element
    inc bx
    dec cx
    jnz repeat
	
    mov sum, al         ; store sum

    ; print message
    mov ah, 09h
    lea dx, msg
    int 21h

    ; convert AL (sum) to hex and display
    mov al, sum
    call PrintHex

    ; exit
    mov ah, 4Ch
    int 21h
main endp

;-----------------------------------------------------
; Subroutine: PrintHex
; Input: AL = value to print in hexadecimal (2 hex digits)
;-----------------------------------------------------
PrintHex proc
    push ax
    push bx
    mov bl, al          ; BL = value

    ; upper nibble
    mov al, bl
    shr al, 4
    call HexDigit

    ; lower nibble
    mov al, bl
    and al, 0Fh
    call HexDigit

    pop bx
    pop ax
    ret
PrintHex endp

;-----------------------------------------------------
; Subroutine: HexDigit
; Input: AL = 0-15, prints ASCII hex digit
;-----------------------------------------------------
HexDigit proc
    add al, 30h
    cmp al, '9'
    jbe short out
    add al, 7           ; adjust for A-F
out:
    mov dl, al
    mov ah, 02h
    int 21h
    ret
HexDigit endp
end main
