        ; 8080 assembler code
        .hexfile PrintNumbers.hex
        .binfile PrintNumbers.com
        ; try "hex" for downloading in hex format
        .download bin  
        .objcopy gobjcopy
        .postbuild echo "OK!"
        ;.nodump

	; OS call list
PRINT_B		equ 1
PRINT_MEM	equ 2
READ_B		equ 3
READ_MEM	equ 4
PRINT_STR	equ 5
READ_STR	equ 6
GET_RND		equ 7

Number 		equ 50

	; Position for stack pointer
stack   equ 0F000h

	org 000H
	jmp begin

	; Start of our Operating System
GTU_OS:	PUSH D
	push D
	push H
	push psw
	nop	; This is where we run our OS in C++, see the CPU8080::isSystemCall()
		; function for the detail.
	pop psw
	pop h
	pop d
	pop D
	ret
	; ---------------------------------------------------------------
	; YOU SHOULD NOT CHANGE ANYTHING ABOVE THIS LINE    

	; This program prints integer from 0 to 50 by steps of 2 on the screen


newline: dw 00AH,00H 	; null terminated newline string

begin:
	LXI SP, stack		; always initialize the stack pointer
	MVI D,0				; initialize D with 0

loop:
	MOV B,D 			; B = D
	MVI A, PRINT_B      ; store the OS call to A
	call GTU_OS			; call the OS
	LXI B, newline      ; put the adress of string in register B and C
	MVI A, PRINT_STR    ; store the OS call to A
	call GTU_OS			; call the OS
	INR D 				; D = D + 1
	INR D 				; D = D + 1
	MVI A,Number 		; A = number
	SUB D 				; A = A - D
	JP loop             ; if A is positive, jump to loop
	hlt      			; end program
	



