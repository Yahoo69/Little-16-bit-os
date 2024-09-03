load_from_disk:
    pusha

    call reset_disk
    mov ah,0x02
    mov al,0x11    ;liczba sektorow do odczytu
    mov bx,KERNEL_OFFSET   ; przesuniecie miejsca w ktorym znajda sie dane
    mov ch,0x00     ;numer sciezki, cylindra ktory odczytujemy
    mov cl,0x02     ;sector od ktorego zaczynamy odczyt
    mov dh,0x00     ;numer glowicy
    mov dl,[BOOT_DRIVE]     ;numer dysku
    int 0x13

    jc disk_error
    
    cmp al,0x11   ;al po odczycie jest ustawiane na liczbę odczytanych sektorów
    jne sector_error

    mov si,KERNEL_LOADED
    call print_string

    popa
    ret

disk_error:
    mov si,DISK_ERROR_MESSAGE
    call print_string
    call print_new_line
    cmp ah,0x01
    je function_or_unit_not_avalible
    jmp disk_loop

function_or_unit_not_avalible:
    mov si, NOT_AVALIBLE_FUNCTION_OR_UNIT
    call print_string
    call print_new_line
    jmp disk_loop

sector_error:
    mov si,SECTOR_ERROR_MESSAGE
    call print_string
    jmp disk_loop
    
reset_disk:
    pusha 
    mov ah,0x00
    mov dl,[BOOT_DRIVE]
    int 0x13
    popa
    ret

disk_loop:  
    jmp $

KERNEL_LOADED:
    db  "Kernel loaded!",0
DISK_ERROR_MESSAGE:
    db "Disk read error!",0
NOT_AVALIBLE_FUNCTION_OR_UNIT:
    db "Function or unit not avalible!",0
SECTOR_ERROR_MESSAGE:
    db "Incorect number of sectors read!",0
