*-----------------------------------------------------------
* Title      :a7q2
* Written by :Bruno Salapic	
* Date       :2015/month/day
* Description:q
*-----------------------------------------------------------
buffersize  equ 2048
START:      org		$1000        ; first instruction of program

            *lea     fname,a1
            jsr     o_dialog
            jsr     f_opene
            jsr     f_error
            bne     finish
            move.l  d1,filee
            
            lea     data,a1
            move    #buffersize,d2
            jsr     f_read


finish   		stop 		#$2700
    		
    		
O_DIALOG	MOVEM.L	A0-A1,-(SP)

	EXG	A1,A0	* Save the filename address.
	LEA	PRMPT,A1	* Get the prompt address.
	JSR	P_STRNR	* Display the prompt. (io_util.X68)
	EXG	A0,A1	* Reset the filename address.
	JSR	P_RSTR	* Read the filename from the user. (io_util.X68)

	MOVEM.L	(SP)+,A0-A1
	RTS

	
*-----------------------------------------------------------
* Includes:
	INCLUDE 'file_util.X68'
	INCLUDE 'io_util.X68'
	
	
	
	
prmpt       dc.b    'wat is file name',0
filee       ds.b    1
	
data        ds.b    buffersize	


    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
