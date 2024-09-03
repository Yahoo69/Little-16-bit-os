mov ax,0x0000
mov ds,ax
mov ss,ax
mov es,ax
mov fs,ax
mov gs,ax
call print_nl
mov bx,COMMAND
sub bx,0x7c00
add bx,0x9000
sub bx,0x200
mov cx,0x00

read_char:
    mov ah,0x00
    int 0x16
    cmp al,1    ;sprawdzenie czy w rejestrze znajduje się znak
    jg print_char
    jmp read_char

print_char:
    mov ah,0x0e
    mov al,al
    mov bh,0x00 ;strona
    mov bl,0x02 ;kolor
    int 0x10

check_enter:
    cmp al,0x0d
    je do
    call append_to_command
    jne read_char

do:
    call print_nl
    call recognize_command
    mov bx,COMMAND
    sub bx,0x7c00
    add bx,0x9000
    sub bx,0x200
    call clear_command
    jmp read_char
    
recognize_command:
    pusha
    mov al,0x00
    cmp al,0x01
    mov si,COMMAND 
    sub si,0x7c00
    add si,0x9000
    sub si,0x200
recognize_save_char_for_later_command:
    mov di,SAVE_CHAR_FOR_LATER
    sub di,0x7c00
    add di,0x9000
    sub di,0x200
    mov bx,save_char_for_later
    sub bx,0x7c00
    add bx,0x9000
    sub bx,0x200
    call second_step
    je end_of_recognition_process
recognize_shutdown_command:
    mov di,SHUTDOWN 
    sub di,0x7c00
    add di,0x9000
    sub di,0x200
    mov bx,shutdown
    sub bx,0x7c00
    add bx,0x9000
    sub bx,0x200
    call second_step
    je end_of_recognition_process
recognize_help_command:
    mov di,HELP 
    sub di,0x7c00
    add di,0x9000
    sub di,0x200
    mov bx,help
    sub bx,0x7c00
    add bx,0x9000
    sub bx,0x200
    call second_step
    je end_of_recognition_process
recognize_print_nl_command:
    mov di,PRINT_NL 
    sub di,0x7c00
    add di,0x9000
    sub di,0x200
    mov bx,print_nl
    sub bx,0x7c00
    add bx,0x9000
    sub bx,0x200
    call second_step
    je end_of_recognition_process
recognize_add_command:
    mov di,ADD
    sub di,0x7c00
    add di,0x9000
    sub di,0x200
    mov bx,add
    sub bx,0x7c00
    add bx,0x9000
    sub bx,0x200
    call second_step
    je end_of_recognition_process
recognize_face_command:
    mov di,FACE 
    sub di,0x7c00
    add di,0x9000
    sub di,0x200
    mov bx,face
    sub bx,0x7c00
    add bx,0x9000
    sub bx,0x200
    call second_step
    jne fourth_step
    jmp end_of_recognition_process
second_step:
    mov al,[si]
    cmp al,[di]
    jne third_step
    cmp al,0x00
    je jmp_to_command
    add si,0x01
    add di,0x01
    jmp second_step
third_step:
    ret
fourth_step:
    mov si,BAD_COMMAND
    sub si,0x7c00
    add si,0x9000
    sub si,0x200
    call print
    call print_nl
    popa
    ret
end_of_recognition_process:
    popa 
    ret

jmp_to_command:
    pusha
    call bx
    call print_nl
    popa
    ret


clear_command: 
    mov byte [bx],0x00 ; gdy przenosimy watości bezpośrednio to podajemy wielkość np:.byte,word,double word
    add bx,0x01
    sub cx,0x01
    cmp cx,0x00
    jge clear_command
    mov bx,COMMAND
    sub bx,0x7c00
    add bx,0x9000
    sub bx,0x200
    mov cx,0x00
    ret


append_to_command:
    mov bx,COMMAND
    sub bx,0x7c00
    add bx,0x9000
    sub bx,0x200
    add bx,cx
    mov byte [bx],al
    add cx,0x01
    ret

BAD_COMMAND:
    db "Your command is incorrect!",0

%include"print_nl.asm"
%include"print.asm"

times 1024 db 0         ;odstęp od reszty kodu do komendy

COMMAND:                ;komenda
    db 0

times 1024 db 0         ;odstęp dla komendy od listy komend

COMMAND_LIST:           ;list komend
    ADD:        db "add",0
    HELP:       db "help",0
    PRINT_NL:   db "print_nl",0,;blendy moga byc spowodowane zlym przesunieciem
    PRINT:      db "print",0
    SHUTDOWN:   db "shutdown",0
    FACE:       db "face",0
    SAVE_CHAR_FOR_LATER:        db "save_char_for_later",0

times 1024 db 0         ; osdtęp od programów

%include"help_command.asm"
%include"face.asm"
%include"save_char_for_later.asm"
%include"add.asm"
%include"shutdown.asm"

times 9728-($-$$) db 0

