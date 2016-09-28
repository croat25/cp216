*-----------------------------------------------------------
* Program    : Bit Map Utilities (bmp_util.x68)
* Written by : David Brown
* Date       : 2015-03-02
* Description: Utilities for reading bit map image files (.BMP)
*
* To display image, copy contents of image file to screen buffer,
* display the contents of the screen buffer.
*
* Image vs Screen Buffer
*
* +-------------------------------------+
* | ^                    |^             | ^
* | |                    ||             | |
* | |                    | image        | |
* | |                    | height       | |
* | | image              ||             | SB_H
* | | bytes              ||             | screen buffer
* |@ ----------------->  |v             | height
* +----------------------+              | |
* |<--- image width ---->               | |
* |                                     | |
* |                                     | |
* |                                     | |
* |                                     | v
* +-------------------------------------+
*  <----- SB_W screen buffer width ----> 
*
* image width <= screen buffer width
* image height <= screen buffer height
*
* File contents are placed starting at lower left corner
* of the image: @
*
*-----------------------------------------------------------
* Constants

* DIB header offsets.	Offset to:
O_FSIZE	EQU	nn	* file size.
O_PIXELS	EQU	nn	* beginning of pixel array.
O_WIDTH	EQU	nn	* image width in pixels.
O_HEIGHT	EQU	nn	* image height in pixels.
O_BPP	EQU	nn	* bits per pixel.
O_ISIZE	EQU	nn	* image size in bytes.
O_COLOR	EQU	nn	* color table.

*-----------------------------------------------------------
* Reads the BMP file header. Converts the header little-endian
* data to big-endian.
* Parameters:
*   D1.L - file handle
* Variables:
*   D0.L: Values to be reversed (little to big endian).
*   D2.L: File read buffer size.
*   A1.L: String addresses.
* Must include 'file_util.X68'.
S_RD_HDR	MOVEM.L	D0-D2/A1,-(SP)

	* Read the entire BMP file header.
	LEA	HDR,A1	* Set address of header data.
	MOVE.L	#HDR_SZ,D2	* Set size of file read buffer.
	JSR	F_READ	* Read from the file. (file_util.X68)
	* Get the file size.
	MOVE.L	O_FSIZE(A1),D0
	JSR	L2B_L	* Reverse the bytes.
	MOVE.L	D0,O_FSIZE(A1)
	* Get the pixel array location.
	MOVE.L	O_PIXELS(A1),D0
	JSR	L2B_L	* Reverse the bytes.
	MOVE.L	D0,O_PIXELS(A1)
	* Get the image width.
	MOVE.L	O_WIDTH(A1),D0
	JSR	L2B_L	* Reverse the bytes.
	MOVE.L	D0,O_WIDTH(A1)
	* Get the image height.
	MOVE.L	O_HEIGHT(A1),D0
	JSR	L2B_L	* Reverse the bytes.
	MOVE.L	D0,O_HEIGHT(A1)
	* Get the bits per pixel.
	MOVE.W	O_BPP(A1),D0
	JSR	L2B_W	* Reverse the bytes.
	MOVE.W	D0,O_BPP(A1)
	* Get the image size.
	MOVE.L	O_ISIZE(A1),D0
	JSR	L2B_L	* Reverse the bytes.
	MOVE.L	D0,O_ISIZE(A1)

	MOVEM.L	(SP)+,D0-D2/A1
	RTS

*-----------------------------------------------------------
* Change from little-endian to big endian (long word).
* Parameters:
*   D0.L - Long word to reverse.
L2B_L	
	* your code here

	RTS

*-----------------------------------------------------------
* Change from little-endian to big endian (word).
* Parameters:
*   D0.L - Word to reverse.
L2B_W	
	* your code here
	
	RTS
	
*-----------------------------------------------------------
* Prints header information (for debugging).
* Variables:
*    D1.L: Numeric data.
*    A2.L: Header data address.
* Must include 'io_util.X68'.
S_HDINFO	MOVEM.L	D1/A1-A2,-(SP)

	LEA	HDR,A2	* Initialize the header address.
	LEA	P_FSIZE,A1	* Print file size (bytes).
	MOVE.L	O_FSIZE(A2),D1
	JSR	P_NUM	* Print the message and number. (io_util.X68)
	JSR	P_CRLF	* (io_util.X68)
	LEA	P_PIXELS,A1	* Print start address of pixel array.
	MOVE.L	O_PIXELS(A2),D1
	JSR	P_NUM	* Print the message and number. (io_util.X68)
	JSR	P_CRLF	* (io_util.X68)
	LEA	P_WIDTH,A1	* Print image width (pixels).
	MOVE.L	O_WIDTH(A2),D1
	JSR	P_NUM	* Print the message and number. (io_util.X68)
	JSR	P_CRLF	* (io_util.X68)
	LEA	P_HEIGHT,A1	* Print image height (pixels).
	MOVE.L	O_HEIGHT(A2),D1
	JSR	P_NUM	* Print the message and number. (io_util.X68)
	JSR	P_CRLF	* (io_util.X68)
	LEA	P_BPP,A1	* Print bits per pixel.
	MOVE.W	O_BPP(A2),D1
	JSR	P_NUM	* Print the message and number. (io_util.X68)
	JSR	P_CRLF	* (io_util.X68)
	LEA	P_ISIZE,A1	* Print pixel array size (bytes).
	MOVE.L	O_ISIZE(A2),D1
	JSR	P_NUM	* Print the message and number. (io_util.X68)
	JSR	P_CRLF	* (io_util.X68)

	MOVEM.L	(SP)+,D1/A1-A2
	RTS

*-----------------------------------------------------------
* Reads from a 24 bit color BMP file into a screen buffer and display the pixels.
* Screen buffer must be large enough to hold the contents of the file.
* Parameters
*   D1.L: File ID.
* Variables:
*   A1.L: File read buffer address.
*   A2.L: Header address.
*   A3.L: Screen buffer address.
*   D2.L: File buffer size (bytes).
*   D3.L: X count (pixels).
*   D4.L: Y count (pixels).
*   D5.L: Row padding (bytes) - BMP rows stored in even number of long words.
*   D6.L: Screen buffer width (bytes).
*   D7.L: Screen buffer height (bytes).
*
S_DSP24	MOVEM.L	D1-D7/A1-A3,-(SP)

	* Verify that the file contents will fit into the screen buffer.
	LEA	HDR,A2
	CMP.L	#SB_W,O_WIDTH(A2)	* Is the file wider than the screen buffer?
	BGT	S_ERR_W
	CMP.L	#SB_H,O_HEIGHT(A2)	* Is the file higher than the screen buffer?
	BGT	S_ERR_H

	* Initialize file handling information.
	CLR.L	BUF24	* Clear the file buffer.
	LEA	BUF24,A1	* Set the file buffer address.
	ADDA.L	#1,A1	* Use lowest three bytes of buffer (high byte left clear).
	LEA	HDR,A2	* Set BMP header address.
	MOVE.L	O_PIXELS(A2),D2	* Move BMP file pointer to beginning of the pixel array in file.
	JSR	F_POS	* (file_util.X68)
	MOVE.L	#BUF24SZ,D2	* Set file buffer read size.
	
	* Initialize screen buffer starting location.
	LEA	SB,A3	* Set screen buffer address.
	MOVE.L	O_HEIGHT(A2),D7	* Get the BMP height in pixels.
	SUBQ.L	#1,D7	
	MULU	#SB_W,D7	* Multiply by the screen buffer width.
	LSL.L	#2,D7	* Multiply by 4 for total number of bytes (1 long word per pixel).
	ADDA.L	D7,A3	* Move to beginning of last line of image within screen buffer.
	
	* Determine the row padding, if any
	MOVE.L	O_WIDTH(A2),D5	* Define the BMP width in pixels.
	AND.L	#4-1,D5	* Determine the row padding in bytes (= pixel width mod 4).
	
	* Set the row width in bytes
	MOVE.L	O_WIDTH(A2),D6	* Define the BMP width in bytes.
	LSL.L	#2,D6

	* Set the image height in pixels.
	MOVE.L	O_HEIGHT(A2),D7	* Get the BMP height in pixels.
	SUBQ.L	#1,D7

	* Set the image width in pixels.
	MOVE.L	O_WIDTH(A2),D4	* Initialize the Y counter.
	SUBQ.L	#1,D4

CONT	JSR	F_READ	* Read from BMP file. (file_util.X68)
*	JSR	F_ERROR	* Error checking - not in production program. (file_util.X68)
	MOVE.L	BUF24,(A3)+	* Put the pixel color info (3 bytes) into the screen buffer (4 bytes).
	DBRA	D4,CONT	* Decrement the x count.
	
	* Handle end of row.
	MOVE.L	D5,D2	* Set to read the padding bytes.
	JSR	F_READ	* Read padding from the BMP file. (file_util.X68)
	MOVE.L	#BUF24SZ,D2	* Reset to read the regular buffer size.

	* Move to the beginning of the previous screen buffer line.
	SUBA.L	D6,A3	* Subtract image width in bytes.
	SUBA.L	#SB_W*4,A3	* Subtract screen buffer width in bytes.
	
	* Reset the image width in pixels.
	MOVE.L	O_WIDTH(A2),D4	* Initialize the Y counter.
	SUBQ.L	#1,D4

	DBRA	D7,CONT

	* Display the image from the screen buffer.
	JSR	SB_DSP	* Display the contents of the screen buffer. (buffer_util.X68)
	JMP	_S_DSP24
	
	* Display error messages if image is too large for screen buffer.
S_ERR_W	LEA	P_ERR_W,A1	* Image is too wide.
	JSR	P_STR
	JMP	_S_DSP24

S_ERR_H	LEA	P_ERR_H,A1	* Image is too tall.
	JSR	P_STR
	
_S_DSP24	MOVEM.L	(SP)+,D1-D7/A1-A3
	RTS

*-----------------------------------------------------------
* BMP data definitions.

* Messages.
P_FSIZE	DC.B	'File size:          ',0
P_PIXELS	DC.B	'Pixel array offset: ',0
P_WIDTH	DC.B	'Image width:        ',0
P_HEIGHT	DC.B	'Image height:       ',0
P_BPP	DC.B	'Bits per pixel:     ',0
P_ISIZE	DC.B	'Image size (bytes): ',0

P_ERR_H	DC.B	'Error: Image wider than the screen buffer',0
P_ERR_W	DC.B	'Error: Image taller than the screen buffer',0

_	DC.W	1	* Unused - forces header to start at even address

* The BMP header data.
HDR_SZ	EQU	$36	* Header size.
HDR	DS.B	HDR_SZ	* Start of header block.
HDR_E	EQU	*	* End of header block.

* The color table.
COLOR_SZ	EQU	$100	* Maximum color table size (256 colors at 4 bytes each).
COLOR	DS.L	COLOR_SZ	* Start of color table (maximum size)
COLOR_E	EQU	*	* End of color table.
COLOR_BYTES	DS.L	1	* Actual size of color table used.

* 24 bit BMP file buffer information.
BUF24SZ	EQU	3
BUF24	DS.B	4

* 16 bit BMP file buffer information.
BUF16SZ	EQU	2
BUF16	DS.B	2

* 8 bit BMP file buffer information.
BUF8SZ	EQU	1
BUF8	DS.B	1

*-----------------------------------------------------------


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~
