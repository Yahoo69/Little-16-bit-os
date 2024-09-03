help:
    pusha
    mov si,HELP_TEXT
    sub si,0x7c00
    add si,0x9000
    sub si,0x200
    call print
    popa
    ret

HELP_TEXT:
    db"This is list of command of my os:",0x0d,0x0a,
    db"*help-comand to get help",0x0d,0x0a,
    db"*print_nl-comand to print new line",0x0d,0x0a,
    db"*shutdown-comand to shutdown computer(currently not working)",0x0d,0x0a,
    db"*save_char_for_later-comand to save char for later",0x0d,0x0a,
    db"*face-easter egg",0x0d,0x0a,
    db"*add-add two numbers",0