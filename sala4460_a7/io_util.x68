*-----------------------------------------------------------
* Program    : I/O Utilities (io_util.x68)
* Written by : David Brown
* Date       : 2015-03-02
* Description: Text I/O Utilities
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
* Parameters:
*   A1.L: Prompt address.
* Variables:
*   D0.L: Task number.
* Returns:
*   D1.L: Numeric value read from keyboard.
P_PRMPT	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ.L	#18,D0	Set up prompt and read number into D1.L
	TRAP	#15
	MOVEM.L	(SP)+,D0	Restore D0
	RTS

*-----------------------------------------------------------
* Prints the mesage at A1 and the value at D1 with no CRLF.
* Parameters:
*   A1.L: String address.
*   D1.L: Numeric value to print.
* Variables:
*   D0.L: Task number.
P_NUM	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ	#17,D0	Set up to print D1.L without CR/LF
	TRAP	#15	Print the number
	MOVEM.L	(SP)+,D0	Restore D0
	RTS
	
	
	
GETNUM	
	MOVEQ.L	#4,D0		
	TRAP	#15
	RTS


readNUM	
	MOVEQ.L	#3,D0		
	TRAP	#15
	RTS	
*-----------------------------------------------------------
* Prints a string with CR/LF.
* Parameters:
*   A1.L: String address.
* Variables:
*   D0.L: Task number.
P_STR	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ	#13,D0	Set up to print string at A1 with CR/LF
	TRAP	#15	Print the string
	MOVEM.L	(SP)+,D0	Restore D0
	RTS

*-----------------------------------------------------------
* Prints a CR/LF.
* Variables:
*   A1.L: Null string address.
*   D0.L: Task number.
P_CRLF	MOVEM.L	D0/A1,-(SP)	Preserve D0 and A1
	MOVEQ.L	#13,D0	Set up print with CRLF
	LEA	NULL,A1	Set null string
	TRAP	#15
	MOVEM.L	(SP)+,D0/A1	Restore D0 and A1
	RTS

*-----------------------------------------------------------
* Prints a string without CR/LF
* Parameters:
*   A1.L: String address.
* Variables:
*   D0.L: Task number.
P_STRNR	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ	#14,D0	Set up to print string at A1 with CR/LF
	TRAP	#15	Print the string
	MOVEM.L	(SP)+,D0	Restore D0
	RTS

*-----------------------------------------------------------
* Reads a single character from the keyboard - stored in D1.
* Variables:
*   D0.L: Task number.
* Returns:
*   D1.B: Character value.
P_CHAR	MOVEM.L	D0,-(SP)
	MOVEQ.L	#5,D0
	TRAP	#15
	MOVEM.L	(SP)+,D0
	RTS
	
	
	
	
P_MSG	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ	#14,D0	Set up to print string at A1 with CR/LF
	TRAP	#15	Print the string
	MOVEM.L	(SP)+,D0	Restore D0
	RTS

*-----------------------------------------------------------
* Reads a string from the keyboard.
* Parameters:
*   A1.L: String address.
* Variables:
*   D0.L: Task number.
P_RSTR	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ	#2,D0	Set up to read string into (A1)
	TRAP	#15	Read the string
	MOVEM.L	(SP)+,D0	Restore D0
	RTS

*-----------------------------------------------------------
* Turns the keyboard echo on.
* Variables:
*   D0.L: Task number.
*   D1.L: Echo set.
P_ECHO_ON	MOVEM.L	D0-D1,-(SP)

	MOVEQ.L	#1,D1
	MOVEQ.L	#12,D0
	TRAP	#15

	MOVEM.L	(SP)+,D0-D1
	RTS

*-----------------------------------------------------------
* Turns keyboard echo off.
* Variables:
*   D0.L: Task number.
*   D1.L: Echo reset.
P_ECHO_OFF	MOVEM.L	D0-D1,-(SP)

	MOVEQ.L	#0,D1
	MOVEQ.L	#12,D0
	TRAP	#15

	MOVEM.L	(SP)+,D0-D1
	RTS

*-----------------------------------------------------------
* Display a single character.
* Parameters:
*   D1.B: Character to display.
* Variables:
*   D0.L: Task number.
P_DCHAR	MOVEM.L	D0,-(SP)

	MOVEQ.L	#6,D0
	TRAP	#15

	MOVEM.L	(SP)+,D0
	RTS

*-----------------------------------------------------------
* Constants and data.
NULL	DC.B	0	* Empty string

*-----------------------------------------------------------

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
