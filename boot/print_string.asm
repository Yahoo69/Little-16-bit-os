print_string:
    pusha
    mov ah,0x0e
    mov bh,0x00
    mov bl,0x02

print_next_char:
    mov al,[es:si]
    cmp al,0
    je end_print_string
    int 0x10
    add si,1
    jmp print_next_char

end_print_string:
    popa
    ret
