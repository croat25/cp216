*-----------------------------------------------------------
* Program    : Screen Buffer Utilities (buffer_util.x68)
* Written by : David Brown
* Date       : 2015-03-02
* Description: Screen Buffer Simulation Utilities
*-----------------------------------------------------------
* Screen Buffer Definitions.

* Size of screen buffer in pixels.
SB_W	EQU	640
SB_H	EQU	640

* Screen buffer is 1 long word per pixel.
* Each long word stores the pixel color in $00BBGGRR format.
* Beginning address of buffer is pixel at 0,0 (upper left corner).
* Pixels are stored in row major order: X is incremented within Y.
* i.e. 0,0 * 1,0 * 2,0 * 3,0 * etc.
SB_S	EQU	SB_W*SB_H	* Screen buffer size in pixels (long words).

*-----------------------------------------------------------
* Display screen buffer information.
* Variables:
*    D1.L: buffer width and height in pixels (saved)
*    A1.L: address display messages (saved).
SB_HDINFO	MOVEM.L	D1/A1,-(SP)

	LEA	SB_MSG_W,A1	* Display the screen buffer width
	MOVE.L	#SB_W,D1
	JSR	P_NUM
	JSR	P_CRLF
	
	LEA	SB_MSG_H,A1	* Display the screen buffer height
	MOVE.L	#SB_H,D1
	JSR	P_NUM
	JSR	P_CRLF
	
	JSR	P_CRLF

	MOVEM.L	(SP)+,D1/A1
	RTS

*-----------------------------------------------------------
* Clear the screen buffer. Set every pixel to an arbitrary color.
* Parameters:
*    D1.L: screen buffer color (unchanged).
* Variables:
*    D7.L: pixel counter
*    A0.L: address of start of screen buffer (saved).
SB_CLR	MOVEM.L	D7/A0,-(SP)

	LEA	SB,A0	* Set the screen buffer address
	MOVE.L	#SB_S,D7	* Initialize the pixel counter

SB_CLR_LP	MOVE.L	D1,(A0)+	* Set the pixel color.
	SUBQ.L	#1,D7
	BGT	SB_CLR_LP
	
	MOVEM.L	(SP)+,D7/A0
	RTS

*------------------------------------------------------------
* Display the contents of the screen buffer.
* Draws screen contents from top left across and down to bottom right.
* Variables:
*    A0.L: address of start of screen buffer (saved).
*    D0.L: EASy68K task numbers (saved).
*    D1.L|W: holds parameter for the TRAP call.
*    D2.W: Y position (saved).
*    D3.L: temporary x (saved).
SB_DSP	MOVEM.L	D0-D3/A0,-(SP)

* Set the output screen size
	MOVEQ.L	#33,D0
	MOVE.L	#SB_W*$10000,D1	* Set the screen width (upper word)
	ADD.W	#SB_H,D1	* Set the screen height (lower word)
	TRAP	#15

	LEA	SB,A0	* Go to the screen buffer
	CLR.L	D2	* Initialize x
	CLR.L	D3	* Initialize y

* Set the output color - color stored in long word of screen buffer
* in $00BBGGRR format. (Defined by EASy68K Simulator graphics tasks.)
SB_DSP_LP	MOVEQ.L	#80,D0	* Set color task number.
	MOVE.L	(A0)+,D1	* Copy pixel color value to D1.
	TRAP	#15	* Set the pen color.
	
* Set X and Y values. X in D1, Y in D2
	MOVEQ.L	#82,D0	* Set draw pixel task number.
	MOVE.L	D3,D1	* Set x (y is already set)
	TRAP	#15	* Draw the pixel
	
	ADDQ.L	#1,D3	* Increment x
	CMP.L	#SB_W,D3	* Are the columns finished?
	BNE	SB_DSP_LP	* No - display the next pixel
	CLR.L	D3	* Yes - set x to 0
	ADDQ.L	#1,D2	* Increment y
	CMP.L	#SB_H,D2	* Are the rows finished?
	BNE	SB_DSP_LP	* No - continue drawing
	
	MOVEM.L	(SP)+,D0-D3/A0
	RTS

*------------------------------------------------------------
SB_MSG_W	DC.B	'Screen buffer width: ',0
SB_MSG_H	DC.B	'Screen buffer height: ',0

* The screen buffer.
SB	DS.L	SB_S	* Screen buffer storage.
SB_E	EQU	*	* Screen buffer end address.

*------------------------------------------------------------



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
