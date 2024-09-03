shutdown:
    mov ah, 0x53    
    mov al, 0x02    ;ustawienie insterfejsu apm na tryb 16 bitowy
    xor bx,bx
    int 0x15

    mov ah, 0x53
    mov al, 0x08    ;zezwala lub zabrania na zarządaznie mocą   
    mov bx, 0x0001  ;dla każdego urządzenia
    mov cx, 0x0001  ;zezwalaj
    int 0x15

    mov ax, 0x5307  ;ustawianie stanu zasilania
    mov cx, 0x0003  ;stan zasilania
    mov bx, 0x0001  ;rozkazuje ustawić stan na wszystkich urządzeniach komputera 
    int 0x15

    jmp $