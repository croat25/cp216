*-----------------------------------------------------------
* Title      :a4q3
* Written by :Bruno Salapic	
* Date       :2016/month/day
* Description:the avg doesnt work idk #yolo
*-----------------------------------------------------------
    
START:      org		$1000
jumpin                    
begin            move.l  #100,d6
            move.l  #0,d5
                            
            lea     listlength,a1
            jsr     p_prmpt
            jsr     p_crlf
            cmp.l   #0,d1               ; load addresses
            ble     error1
            cmp.l   #10,d1
            bgt     error1              ; error checks
            
            move.b  d1,counter
            
            move.b  counter,d2
            subq.b  #1,d2
            move.b  d2,d3
            
            lea     list,a2
loop            lea     acceptable,a1           
            jsr     p_prmpt
            jsr     p_crlf
            
            cmp.l   #0,d1
            blt     error2
            cmp.l   #100,d1     ; if between 0-100
            bgt     error2
            
            cmp.l   d5,d1
            bge     minloop
backtomin
            cmp.l    d6,d1
            ble     maxloop     ; check min and max    
backtomax            
            add.w   d1,d4
            
            dbra    d2,loop     
            bra     printbackout
            
            
            
maxloop     move.l  d1,d6
            bra     backtomax            ; change max and min

minloop     move.   d1,d5
            bra     backtomin
            
            
error1       lea     listerr,a1
            jsr     p_str
            bra     begin           ;error message

error2      lea     rangeerr,a1
            jsr     p_str
            bra     loop
            
            

printbackout    move.l  d6,d1
                lea     min,a1
                jsr     p_num
                jsr     p_crlf
                
                move.l     d5,d1
                lea     max,a1
                jsr     p_num               ; prints
                jsr     p_crlf   

                move.b     counter,d7
                divu.w     d4,d7
                move.l  d4,d1
                lea     avg,a1              ;tricky
                jsr     p_num
                jsr     p_crlf
                
                
                lea     repeat,a1
                jsr     p_str
                jsr     read1ch             ; if contiune y/Y
                jsr     p_crlf
                cmp.b   #89,d1
                beq     jumpin
                cmp.b   #121,d1
                beq     jumpin
                bra     end
                     
                 
end    		stop 		#$2700
            include 'io_util.x68'
* Put variables and constants here
listlength  dc.b    'how long will the list be  1-10: ',0
acceptable  dc.b    'enter a number between 0-100: ',0
listerr     dc.b    ' error',0
rangeerr    dc.b    'error',0
min         dc.b    'the min is :',0
max         dc.b    'the max is :',0
avg         dc.b    'the avg is :',0
repeat      dc.b    ' wanna try again:',0
list        ds.b    10
counter     ds.b    1

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
