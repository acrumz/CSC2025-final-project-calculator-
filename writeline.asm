.386p                      ; Enable 386 protected mode instructions
.model flat, stdcall       ; Flat memory model with stdcall calling convention
; .stack 4096                ; Allocate 4 KB stack

; writeline.asm - Function to write a line to the console
extern GetStdHandle@4: PROC
extern WriteConsoleA@20: PROC

.data
consoleOutputHandle dd 0
stdoutHandle dd -11 ; Standard output handle code

.code
_writeline PROC near
    ; Get handle to standard output
    push stdoutHandle
    call GetStdHandle@4
    mov consoleOutputHandle, eax

    ; Write string passed as an argument to the console
    pop eax
    push 0  ; Reserve space for a NULL pointer
    push -1 ; Write the entire string
    push eax
    push consoleOutputHandle
    call WriteConsoleA@20

    ret
_writeline ENDP
END