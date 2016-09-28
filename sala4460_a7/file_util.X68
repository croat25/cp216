*-----------------------------------------------------------
* Program    : file_util
* Written by : David Brown
* Date       : 2015-03-02
* Description: File Utilities
*
* Three registers have special functions:
* D0 contains the task code telling the simulator the type
*	of I/O to perform
* D1 contains either the data or the length of the data
*	involved in I/O depending on the task
* A1 contains the address of strings to be input or output
*	or the path of the file to be used in I/O
*-----------------------------------------------------------
* Close all open files.
* Variables:
*   D0: I/O task number
F_CLALL	MOVEM.L D0,-(SP)

	MOVEQ.L	#50,D0
	TRAP	#15

	MOVEM.L (SP)+,D0
	RTS

*-----------------------------------------------------------
* Open an existing file.
* Parameters:
*   A1.L: Address of file name to open.
* Returns:
*   D0.W: Error code, if any.
*   D1.L: File ID.
F_OPENE	MOVEQ.L	#51,D0	* Set up file open, name in A1
	TRAP	#15
	RTS

*-----------------------------------------------------------
* Open a new file.
* Parameters:
*   A1.L: Address of file name to open.
* Returns:
*   D0.W: Error code, if any.
*   D1.L: File ID.
F_OPENN	MOVEQ.L	#52,D0	* Set up file open, name in A1
	TRAP	#15
	RTS

*-----------------------------------------------------------
* Parameters:
*   D0.L: Error code.
* Variables:
*   A0.L: Address of error message table.
*   A1.L: Address of string to print.
F_ERROR	MOVEM.L D0/A0-A1,-(SP)

	LEA	F_TABLE,A0	* Get start of lookup table.
	LSL.L	#2,D0	* Multiply error number by 4 for lookup table steps.
	MOVE.L	0(A0,D0.L),A1	* Load the proper string address into A1.
	JSR	P_STR	* Print the error message. (io_util.X68)

	MOVEM.L (SP)+,D0/A0-A1
	RTS

*-----------------------------------------------------------
* Read from the file into the input data buffer
* Parameters
*   A1.L: Buffer address.
*   D1.L: File ID.
*   D2.L: Size of buffer (bytes)
* Variables:
*   D0.L: I/O task number.
* Returns:
*   D0.W: Error flag.
*   D2.L: Bytes actually read.
F_READ	MOVEQ.L	#53,D0	Set up read file
	TRAP	#15
	RTS

*-----------------------------------------------------------
* Write to the file from the input data buffer
* Parameters
*   A1.L: Buffer address.
*   D1.L: File ID.
*   D2.L: Size of buffer (bytes)
* Variables:
*   D0.L: I/O task number.
* Returns:
*   D0.W: Error flag.
F_WRITE	MOVEQ.L	#53,D0	Set up read file
	TRAP	#15
	RTS

*-----------------------------------------------------------
* Positions the file pointer to a given position.
* Parameters
*   D1.L: File ID.
*   D2.L: The file position (in bytes from start of file).
* Variables:
*   D0.L: I/O task number.
* Returns:
*   D0.W: Error flag.
F_POS	MOVEQ.L	#55,D0
	TRAP	#15
	RTS

*-----------------------------------------------------------
* Data

* Error messages.
F_ERR0	DC.B	'Success.',0	* Error code 0
F_ERR1	DC.B	'End of file.',0	* Error code 1
F_ERR2	DC.B	'File error.',0	* Error code 2
F_ERR3	DC.B	'File is read only.',0	* Error code 3
* Lookup table.
F_TABLE	DC.L	F_ERR0,F_ERR1,F_ERR2,F_ERR3

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~
