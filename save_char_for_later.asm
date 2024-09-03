save_char_for_later:
    pusha
    mov ax,0x0000
    mov si,GET_CHAR_TEXT
    sub si,0x7c00
    add si,0x9000
    sub si,0x200
    call print
save_char_for_later_2:
    mov ah,0x00
    int 0x16
    mov bx,PLACE_FOR_DATA
    sub bx,0x7c00
    add bx,0x9000
    sub bx,0x200
    mov [bx],al
    mov ah,0x0e
    mov al,al
    mov bh,0x00
    mov bl,0x02
    int 0x10
save_char_for_later_3:
    mov ah,0x03
    mov al,0x01
    mov bx,PLACE_FOR_DATA
    sub bx,0x7c00
    add bx,0x9000
    sub bx,0x200
    mov ch,0x00
    mov cl,0x13
    mov dh,0x00
    mov dl,[BOOT_DRIVE]
    int 0x13
    cmp ah,0x00
    je  save_char_for_later_sucess
    jne reset_disk_controler
save_char_for_later_sucess:
    call print_nl
    mov si,CHAR_SAVED
    sub si,0x7c00
    add si,0x9000
    sub si,0x200
    call print
    popa 
    ret

reset_disk_controler:
    mov ah,0x00
    int 0x13
    call print_nl
    jmp save_char_for_later

GET_CHAR_TEXT:
    db"Give me a char:",0
CHAR_SAVED:
    db"Your char is saved for later!",0
PLACE_FOR_DATA:
    times 512 db 0

