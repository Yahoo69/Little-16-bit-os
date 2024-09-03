print_nl:
    pusha
    mov ah,0x0e
    mov al,0x0d
    int 0x10
    mov al,0x0a
    int 0x10
    mov al,"$"
    mov bh,0x00 ;strona
    mov bl,0x02 ;kolor
    int 0x10
    popa
    ret

