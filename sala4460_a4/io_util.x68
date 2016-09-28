*-----------------------------------------------------------
* Program    : io_util
* Written by : David Brown
* Date       : 2016-01-25
* Description: Printing utilities
*
* Three registers have special functions:
* D0 contains the task code telling the simulator the type
*	of I/O to perform
* D1 contains either the data or the length of the data
*	involved in I/O depending on the task
* A1 contains the address of strings to be input or output
*	or the path of the file to be used in I/O
*-----------------------------------------------------------
* Prints the prompt at A1 and reads a number into D1.
P_PRMPT	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ.L	#18,D0	Set up prompt and read number into D1.L
	TRAP	#15
	MOVEM.L	(SP)+,D0	Restore D0
	RTS

* Prints the mesage at A1 and the value at D1
P_NUM	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ	#17,D0	Set up to print D1.L without CR/LF
	TRAP	#15	Print the number
	MOVEM.L	(SP)+,D0	Restore D0
	RTS
read1ch   moveq.l #5,d0
                            
          trap    #15
        
          rts
          
          
readnum moveq.l   #4,d0
        trap      #15
        rts
echo    moveq.l #12,d0
        trap    #15
        rts	
* Prints a string with CR/LF
P_STR	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ	#13,D0	Set up to print string at A1 with CR/LF
	TRAP	#15	Print the string
	MOVEM.L	(SP)+,D0	Restore D0
	RTS
displayto   	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ	#14,D0	Set up to print string at A1 with CR/LF
	TRAP	#15	Print the string
	MOVEM.L	(SP)+,D0	Restore D0
	RTS
	
readkeyboard   	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ	#2,D0	Set up to print string at A1 with CR/LF
	TRAP	#15	Print the string
	MOVEM.L	(SP)+,D0	Restore D0
	RTS
* Prints a CR/LF
P_CRLF	MOVEM.L	D0/A1,-(SP)	Preserve D0 and A1
	MOVEQ.L	#13,D0	Set up print with CRLF
	LEA	NULL,A1	Set null string
	TRAP	#15
	MOVEM.L	(SP)+,D0/A1	Restore D0 and A1
	RTS
	
msg2    moveq.l #14,d0
        trap    #15
        rts	
msg13    moveq.l #13,d0
        trap    #15
        rts	       
msg3    moveq.l #4,d0
        trap    #15
        rts	        

* Constants and data.
NULL	DC.B	0	Empty string





*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
