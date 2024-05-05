; readline.asm - Function to read a line of input from the console
.386p                      ; Enable 386 protected mode instructions
.model flat, stdcall       ; Flat memory model with stdcall calling convention
.stack 4096                ; Allocate 4 KB stack

; External function declarations
EXTERN GetStdHandle@4: PROC
EXTERN ReadConsoleA@20: PROC

.data
inputBuffer db 32 dup(0)
bytesRead dd 0
consoleInputHandle dd 0
stdinHandle dd -10 ; Standard input handle code

.code
_readline@4 PROC
    ; Get handle to standard input
    push stdinHandle
    call GetStdHandle@4
    mov consoleInputHandle, eax

    ; Read line of input from console
    push offset bytesRead
    push 32
    push offset inputBuffer
    push consoleInputHandle
    call GetStdHandle@4

    ; Copy the input from inputBuffer to the location provided
    ; Assuming the destination pointer is passed as the first argument
    mov edi, [esp + 4]  ; Load destination pointer from stack
    lea esi, inputBuffer
    mov ecx, 32         ; Length of inputBuffer
    rep movsb           ; Copy bytes from inputBuffer to destination

    ret 4               ; Adjust the stack by 4 bytes (one argument)
_readline@4 ENDP
END