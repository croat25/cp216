*-----------------------------------------------------------
* Program    : BMP File Reader (bmp.x68)
* Written by : David Brown
* Date       : 2015-03-02
* Description: Reads a 24 bit color BMP file into a screen buffer.
*-----------------------------------------------------------
* Constants
BLACK	EQU	$0	* Set color to black

START	ORG	$400

	MOVE.L	#BLACK,D1	* Set the screen buffer background to black
	JSR	SB_CLR

	* Ask for the BMP file name.
	LEA	FNAME,A1
	JSR	O_DIALOG	* Ask for the filename.

	* Open the BMP file.
	JSR	F_OPENE	* Attempt to open the file. (file_util.X68)
	JSR	F_ERROR	* Display the result of the open attempt. (file_util.X68)
	TST.L	D0	* Check the error code.
	BNE	DONE	* Is it not equal to 0?
	MOVE.L	D1,F_ID	*   No - save the file ID.
	JSR	P_CRLF
	
	JSR	SB_HDINFO	* Display the screen buffer info
	
	* Read the BMP file header and data.
	JSR	S_RD_HDR	* Read the file header. (bmp_util.X68)
	JSR	S_HDINFO	* Display the header info. (bmp_util.X68)
	JSR	P_CRLF
	LEA	PAUSE,A1	* Pause the display
	JSR	P_PRMPT
	MOVE.L	F_ID,D1	* Display the image. (bmp_util.X68)
	JSR	S_DSP24
	JSR	F_CLALL	* Close all files. (file_util.X68)

DONE	STOP	#$2700

*-----------------------------------------------------------
* Asks for a file name.
* Parameters:
*   A1.L: Address of filename storage.
* Variables:
*   A0.L: Temporary filename address holder.
*   A1.L: Display string address.
O_DIALOG	MOVEM.L	A0-A1,-(SP)

	EXG	A1,A0	* Save the filename address.
	LEA	FPRMPT,A1	* Get the prompt address.
	JSR	P_STRNR	* Display the prompt. (io_util.X68)
	EXG	A0,A1	* Reset the filename address.
	JSR	P_RSTR	* Read the filename from the user. (io_util.X68)

	MOVEM.L	(SP)+,A0-A1
	RTS
	
*-----------------------------------------------------------
* Includes:
	INCLUDE 'file_util.X68'
	INCLUDE 'io_util.X68'
	INCLUDE 'graphic_util.X68'
	INCLUDE 'bmp_util.X68'
	INCLUDE 'buffer_util.X68'

*-----------------------------------------------------------
FPRMPT	DC.B	'Filename: ',0
PAUSE	DC.B	'Press Enter to continue',0
FNAME	DS.B	80	* Filename storage.
F_ID	DS.L	1	* File ID storage.
	
*-----------------------------------------------------------
	
	END	START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~
