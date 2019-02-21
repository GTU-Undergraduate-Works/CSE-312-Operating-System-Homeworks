        ; 8080 assembler code
        .hexfile Sort.hex
        .binfile Sort.com
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

    ; This program generates 50 random bytes, sorts them
    ; and prints on screen

   
          ; initialize array wit zero
array:    dw 0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,0H,

message1:	dw 'Generated Numbers',00AH,00H       ; null-teminated string
message2:   dw 'Sorted Numbers', 00AH, 00H        ; null-teminated string

newline: dw 00AH,00H                              ; null-terminated newline string

begin:
    LXI SP,stack            ; always initialize the stack pointer
    MVI L, 50               ; L = 50
    LXI D,array             ; put the address of array to registers D and E    

    LXI B, message1         ; put the address of message1 to registers D and E
    MVI A, PRINT_STR        ; store the OS call to A
    call GTU_OS             ; call the OS

putArray:
        MVI A,GET_RND  		; store the OS call to A	  
	    call GTU_OS         ; call the OS 
	    MOV A,B	            ; A = B
	    STAX D
        LDAX D
        mov B,A             ; B = A
		MVI A, PRINT_B      ; store the OS call to A
		call GTU_OS	        ; call the OS
        LXI B, newline      ; put the address of newline to registers B and C
        MVI A, PRINT_STR    ; store the OS call to A
        call GTU_OS         ; call the OS
        INR E               ; E = E + 1   
	    INR E   	        ; E = E + 1
		DCR L               ; L = L - 1
		JNZ putArray 
		MVI L, 50           ; L = 50       
		 
		 
beginSort:
    MVI C, 49               ; C = 49       
    LXI D,array             ; put the address of the array to array to registers D and E
    DCR L                   ; L = L - 1
    JZ printMessage2       

LOOP:
    LDAX D 
    MOV B,A                 ; B = A
    INR E                   ; E = E + 1
    INR E                   ; E = E + 1
    LDAX D          
    MOV H,A                 ; H = A
    jmp check1
    
pass:    
    DCR C                   ; C = C - 1
    JZ  beginSort           
    JMP LOOP   
    
check1:
    MVI A,0                 ; A = 0
    SUB H                   ; A = A - H
    JM check2       
    JMP check3    
    
check2:    
    MVI A,0                 ; A = 0
    SUB B                   ; A = A - B
    JM check4        
    JMP swapValues        
    
check3:    
    MVI A,0                 ; A = 0
    SUB B                   ; A = A - B
    JP check4        
    JMP pass     

check4:
    MOV A,H                 ; A = H
    SUB B                   ; A = A - 1
    JM swapValues         
    JMP pass    


swapValues:
    MOV A,B                 ; A = B    
    STAX D          
    DCR E                   ; E = E - 1
    DCR E                   ; E = E - 1
    MOV A,H
    STAX D           
    INR E                   ; E = E + 1
    INR E                   ; E = E + 1
    JMP pass
    
printMessage2:
    LXI D,array             ; put the address of the array to regiters D and E
    MVI L, 50               ; L = 50       
    LXI B, message2	        ; put the address of the array to regiters D and E
	MVI A, PRINT_STR	    ; store the OS code to A
	call GTU_OS	            ; call the OS 

printSortedNumbers:
    LDAX D          
    MOV B,A                 ; B = A
    MVI A, PRINT_B          ; store the OS code to A
    call GTU_OS             ; call the OS
    LXI B, newline          ; put the address of newline to registers
    MVI A, PRINT_STR        ; store the OS code to A
    call GTU_OS             ; call the OS
    INR E                   ; E = E + 1
    INR E                   ; E = E + 1
    DCR L                   ; E = E - 1          
    JNZ printSortedNumbers      
    hlt             
    
    
