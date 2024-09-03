add:
    pusha
    mov si,NUMBER_1
    sub si,0x7c00
    add si,0x9000
    sub si,0x200
    call print
    mov ah,0x00
    int 0x16
    cmp al,0x30
    jl add
    cmp al,0x39
    jg add
    mov dh,al
    mov ah,0x0e
    int 0x10
    call print_nl
    mov si,NUMBER_2
    sub si,0x7c00
    add si,0x9000
    sub si,0x200
    call print
    mov ah,0x00
    int 0x16
    cmp al,0x30
    jl add
    cmp al,0x39
    jg add
    mov dl,al
    mov ah,0x0e
    int 0x10
add_after_enter:
    sub dh,0x30
    sub dl,0x30
    movzx ax,dh
    add ax,dx
    call print_nl
    mov si,SUM
    sub si,0x7c00
    add si,0x9000
    sub si,0x200
    call print
    mov ah,0x0e
    add al,0x30
    int 0x10
end_add:
    mov bx,0x00
    cmp bx,0x00
    popa
    ret

NUMBER_1:
    db"Give me your first number:",0
NUMBER_2:
    db"Give me your second number:",0
SUM:
    db"Sum of number is:",0