*-----------------------------------------------------------
* Title      :a4q4
* Written by :Bruno Salapic	
* Date       :2016/month/day
* Description:q4
*-----------------------------------------------------------
    
START:      org		$1000        ; first instruction of program
jumpin            move.b  #0,d5
            lea     list,a2
loop            lea     entry,a1        ;load address and display and prompt
            jsr   p_prmpt
           
            move.b  d1,(a2)+
            cmp.l   #99,d1                  ;check to see if 99 to end program
            beq     end
            
            cmp.l   #-50,d1
            blt     error1
            cmp.l   #50,d1
            bgt     error1              ; if between -50 and 50
            add.b   #1,d5
            
            bra     loop
            
error1      lea     error,a1
            jsr     msg13               ;error message
            bra     loop      
            
end
            
looping           
            move.b     -(a2),d1
            lea     emptystr,a1
            jsr     p_num           ;printing
            jsr     p_crlf
            dbra    d5,looping
            
            lea     repeat,a1
                jsr     p_str
                jsr     read1ch
                jsr     p_crlf                  ; check to see if y/Y
                
                cmp.b   #89,d1
                beq     jumpin
                cmp.b   #121,d1
                beq     jumpin
                bra     end
            
            
    		stop 		#$2700

            include 'io_util.x68'
* Put variables and constants here
entry       dc.b    'enter numbers between -50 and 50 or 99 to end loop',0
error       dc.b    'error',0
repeat      dc.b    ' wanna try again:',0
emptystr    dc.b    ' ',0
list        ds.b    100
    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
