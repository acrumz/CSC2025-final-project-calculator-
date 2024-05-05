.386p                      ; Enable 386 protected mode instructions
.model flat, stdcall      ; Flat memory model with stdcall calling convention


; External function declarations
EXTERN _readline@4@0: PROC
EXTERN _writeline@0: PROC
EXTERN _atoi@0: PROC
EXTERN _itoa: PROC


.data
input1 db 32 dup(0)          ; Buffer for first number
input2 db 32 dup(0)          ; Buffer for second number
output db 32 dup(0)          ; Buffer for the result
prompt1 db "Enter number 1: ", 0
prompt2 db "Enter number 2: ", 0
resultText db "The multiplication result is: ", 0

.code
_main PROC near
    ; Prompt for and read the first number
    push offset prompt1
    call _writeline@0
    push offset input1         ; Pass the address of `input1` buffer to `readline`
    call _readline@4@0
    push offset input1         ; Convert input1 to an integer
    call _atoi@0
    mov ecx, eax               ; Store the first number in ECX

    ; Prompt for and read the second number
    push offset prompt2
    call _writeline@0
    push offset input2         ; Pass the address of `input2` buffer to `readline`
    call _readline@4@0
    push offset input2         ; Convert input2 to an integer
    call _atoi@0
    mov ebx, eax               ; Store the second number in EBX

    ; Perform multiplication
    mov eax, ecx               ; Load the first number into EAX
    mul ebx                    ; Multiply EAX by EBX (EAX = ECX * EBX)

    ; Convert the result to a string
    push eax                   ; Pass the result value in EAX
    push offset output         ; Pass the address of the `output` buffer
    call _itoa

    ; Print the result message
    push offset resultText
    call _writeline@0
    push offset output
    call _writeline@0

    ; Exit the program
    xor eax, eax               ; Set exit code to 0 (success)
    push eax

_main ENDP
END
