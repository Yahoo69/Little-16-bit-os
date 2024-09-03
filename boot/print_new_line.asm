print_new_line:
    pusha
    mov ah,0x0e
    mov al,0x0d
    int 0x10
    mov al,0x0a
    int 0x10
    popa
    ret
