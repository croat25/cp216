*-----------------------------------------------------------
* Program    : screen
* Written by : David Brown
* Date       : 2015-02-27 (2)
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
* Clear the screen buffer. Set every pixel to an arbitrary color.
* Parameters:
*    D1.L: screen buffer color (unchanged).
* Variables:
*    A0.L: address of start of screen buffer (saved).
*    D7.L: screen buffer size in pixels (saved).
SB_CLR	MOVEM.L	D7/A0,-(SP)

	LEA	SB,A0
	MOVE.L	#SB_S,D7

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
*    D1.L: screen width and height (saved)
*    D1.L: pixel color (saved).
*    D1.W: X position (saved).
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
	
SB_DSP1	MOVEM.L	D0-D3/A0,-(SP)

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
SB_DSP_LP1	MOVEQ.L	#80,D0
            *move.l    (a0),d5
            *sub.l     #$00ffffff,d5
            *move.l    d5,(a0)	* Set color task number.
	MOVE.L	(A0)+,D1
            sub.l     #$0ffffff,d1	* Copy pixel color value to D1.
	TRAP	#15	* Set the pen color.
	
* Set X and Y values. X in D1, Y in D2
	MOVEQ.L	#82,D0
            	* Set draw pixel task number.
	MOVE.L	D3,D1
            	
	TRAP	#15	* Draw the pixel
	
	ADDQ.L	#1,D3	* Increment x
	CMP.L	#SB_W,D3	* Are the columns finished?
	BNE	SB_DSP_LP1	* No - display the next pixel
	CLR.L	D3	* Yes - set x to 0
	ADDQ.L	#1,D2	* Increment y
	CMP.L	#SB_H,D2	* Are the rows finished?
	BNE	SB_DSP_LP1	* No - continue drawing
	
	MOVEM.L	(SP)+,D0-D3/A0
	RTS
*------------------------------------------------------------
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
*~Tab type~0~
*~Tab size~8~
