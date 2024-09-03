[bits 16]
[org 0x7c00]

KERNEL_OFFSET equ 0x9000

mov ax,0x0000
mov ds,ax
mov ss,ax
mov es,ax

mov [BOOT_DRIVE],dl ;na starcie bios umieszcza w rejestrze dl numer dysku z którego wystartował, nie działa to na wszystkich biosach

mov bp,0x8000
mov sp,bp

mov ah,0x00
mov al,0x13
int 0x10

mov si,STARTED_FROM_REAL_MODE
call print_string
call print_new_line

mov bx,KERNEL_OFFSET
call load_from_disk
call KERNEL_OFFSET

jmp $

%include"boot/print_new_line.asm"
%include"boot/print_string.asm"
%include"boot/load_from_disk.asm"

STARTED_FROM_REAL_MODE: db "System started from 16 bit real mode!",0
BOOT_DRIVE: db 0

times 510-($-$$) db 0
dw 0xaa55

%include"read_chars.asm"
