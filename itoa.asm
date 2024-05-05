.386p                      ; Enable 386 protected mode instructions
.model flat, stdcall       ; Flat memory model with stdcall calling convention
.stack 4096                ; Allocate 4 KB stack


; itoa.asm - Function to convert integer to ASCII
.code
_itoa PROC near
    mov eax, [esp+4] ; Integer value to convert
    mov edi, [esp+8] ; Output buffer to store the result
    mov ecx, 10      ; Base 10 conversion

    ; Convert number to ASCII
    xor edx, edx
itoa_loop:
    div ecx          ; Divide EAX by 10, remainder in EDX
    add dl, '0'      ; Convert remainder to ASCII digit
    dec edi
    mov [edi], dl
    test eax, eax    ; Check if we've finished converting
    jnz itoa_loop

    ; Return the result address
    ret
_itoa ENDP
END