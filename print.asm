print:
    pusha
    mov ah,0x0e
    mov bh,0x00
    mov bl,0x02

print_loop:
    mov al,[si]
    cmp al,0
    je end_print
    int 0x10
    add si,1
    jmp print_loop

end_print:
    popa
    ret

