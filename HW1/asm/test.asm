        ; 8080 assembler code
        .hexfile test.hex
        .binfile test.com
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

	; This program is wirtten to test all OS call





enter_name:				dw 'Enter your name : ',00H 			
enter_age:  			dw 'Enter your age : ', 00H 		
enter_to_load_memory: 	dw 'Enter a number to load memory : ', 00H
generate_rand			dw 'Generated random number is ',00H
newline: 				dw 00AH,00H

begin:
	LXI SP,stack 				; always initialize the stack pointer
								; Now we will call the OS to print the value of sum
	LXI B, enter_name			; put the address of enter_name in registers B and C
	MVI A, PRINT_STR			; store the OS call code to A
	call GTU_OS					; call the OS
	MVI A, READ_STR				; store the OS call code to A
	call GTU_OS					; call the OS
	MVI A, PRINT_STR			; store the OS call code to A
	call GTU_OS					; call the OS
	LXI B, newline 				; put the address of enter_name in registers B and C
	MVI A, PRINT_STR			; store the OS call code to A
	call GTU_OS					; call the OS
	LXI B, enter_age			; put the address of enter_age in registers B and C
	MVI A, PRINT_STR			; store the OS call to A
	call GTU_OS					; call the OS
	MVI A, READ_B               ; store the OS call to A
	call GTU_OS					; call the OS
	MVI A,PRINT_B				; store the O call to A
	call GTU_OS					; call the OS
	LXI B, newline				; put the address of newline in registers B and C
	MVI A, PRINT_STR			; store the OS call code to A
	call GTU_OS					; call the OS
	LXI B, enter_to_load_memory	; put the address of enter_name in registers B and C
	MVI A, PRINT_STR			; store the OS call to A
	call GTU_OS					; call the OS
	MVI A, READ_MEM				; store the OS call to A
	call GTU_OS					; call the OS
	MVI A, PRINT_MEM			; store the OS call to A
	call GTU_OS					; call the OS
	LXI B, newline				; put 
	MVI A, PRINT_STR			; put the address of newline in registers B and C
	call GTU_OS					; call th OS
	LXI B, generate_rand		; put the address of generate_rand in registers B and C
	MVI A, PRINT_STR			; store the OS call to A
	call GTU_OS					; call the OS
	MVI A, GET_RND 				; store the OS call to A
	call GTU_OS					; call the OS
	MVI A, PRINT_B				; store the OS call to A
	call GTU_OS					; call the OS
	LXI B, newline				; put the address of newline in registers B and C
	MVI A, PRINT_STR			; store the OS call to A
	call GTU_OS					; call the OS
	hlt							; end program



