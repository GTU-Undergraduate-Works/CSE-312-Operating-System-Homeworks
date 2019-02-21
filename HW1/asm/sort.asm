        ; 8080 assembler code
        .hexfile sort.hex
        .binfile sort.com
        ; try "hex" for downloading in hex format
        .download bin  
        .objcopy gobjcopy
        .postbuild echo "OK!"
        ;.nodump

    ; OS call list
PRINT_B     equ 1
PRINT_MEM   equ 2
READ_B      equ 3
READ_MEM    equ 4
PRINT_STR   equ 5
READ_STR    equ 6
GET_RND     equ 7


    ; Position for stack pointer
stack   equ 0F000h

    org 000H
    jmp begin

    ; Start of our Operating System
GTU_OS: PUSH D
    push D
    push H
    push psw
    nop ; This is where we run our OS in C++, see the CPU8080::isSystemCall()
        ; function for the detail.
    pop psw
    pop h
    pop d
    pop D
    ret
    ; ---------------------------------------------------------------
    ; YOU SHOULD NOT CHANGE ANYTHING ABOVE THIS LINE        

    ; This program generates 50 random bytes, sorts increasing order 
    ; and prinsts on screen


array: dw 0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H

message1: dw 'Generated Random Numbers',00AH,00H
message2: dw 'Sorted Numbers', 00AH,00H
newline: dw 00AH,00H

begin: 
    LXI SP, stack           ; always initialize the stack pointer
    MVI L, 50               ; D = 50
    LXI D, array            ; put the adress of array to registers D and E

    LXI B, message1         ; put the address of message1 to registers B and C
    MVI A, PRINT_STR        ; store the OS call to A
    call GTU_OS             ; call the OS

generateLoop:
    MVI A, GET_RND          ; store the OS code to A
    call GTU_OS             ; call the OS
    MOV A,B                 ; A = B
    STAX D
    LDAX D
    MOV B,A                 ; B = A
    MVI A, PRINT_B          ; store the OS call to A
    call GTU_OS             ; call the OS
    LXI B, newline          ; put the adress of newline to registers B and C
    MVI A, PRINT_STR        ; store the OS code to A
    call GTU_OS             ; call the OS
    INR E                   ; E = E + 1
    INR E                   ; E = E + 1
    DCR L                   ; L = L - 1
    JNZ generateLoop        
    MVI L, 50               ; L = 50               


    LXI B, message2         ; put the address of message2 to registers B and C
    MVI A, PRINT_STR        ; store the OS call to A
    call GTU_OS             ; call the OS

printSortedNumbers:
    LDAX D
    MOV B,A                 ; B = A
    MVI A, PRINT_B          ; store the OS call to A
    call GTU_OS             ; call the OS
    LXI B, newline          ; put the adress of newline to registers B and C
    MVI A, PRINT_STR        ; store the OS code to A
    call GTU_OS             ; call the OS
    INR E                   ; E = E + 1
    INR E                   ; E = E + 1
    DCR L                   ; L = L - 1
    JNZ printSortedNumbers
    hlt