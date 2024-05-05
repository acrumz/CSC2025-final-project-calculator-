.386p                      ; Enable 386 protected mode instructions
.model flat, stdcall       ; Flat memory model with stdcall calling convention
.stack 4096                ; Allocate 4 KB stack

; atoi.asm - Function to convert ASCII input to an integer
.code
_atoi PROC near
    push ebp
    mov ebp, esp

    ; Save registers that will be used
    push edi
    push ecx
    push edx

    mov edi, [ebp+8] ; Address of input string passed in as argument
    xor eax, eax     ; Initialize result to zero
    xor ecx, ecx     ; Initialize index to zero

atoi_loop:
    movzx edx, byte ptr [edi + ecx]
    test edx, edx      ; Check if the character is NULL
    jz atoi_done
    sub edx, '0'       ; Convert ASCII character to its integer value
    imul eax, eax, 10  ; Multiply result by 10 (shift decimal place)
    add eax, edx       ; Add new digit to the result
    inc ecx
    jmp atoi_loop

atoi_done:
    ; Restore registers
    pop edx
    pop ecx
    pop edi

    ; Restore the stack frame and return the value in EAX
    mov esp, ebp
    pop ebp
    ret 4

_atoi ENDP

END
