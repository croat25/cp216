*-----------------------------------------------------------
* Title      :a4q5
* Written by :Bruno Salapic	
* Date       :2016/month/day
* Description:q
*-----------------------------------------------------------
    
START:      org		$1000        ; first instruction of program
            add     #4,d7
lol         jsr     p_crlf 
            clr     d0
            clr     d1
            clr     d2
            clr     d3  
            clr     d4  
            clr     d5
            clr     d6
            clra     a2
                  
understart  lea     user,a1
            jsr     msg2        ;load adress display
            
            move.w  usersize,d3         ;size of first 4 characters
            subq.b  #1,d3
            lea     usere,a2
loop        jsr     read1ch
            
            cmp.b  #$0D,d1      ;read characters if not 8 long then error
            beq     error1
            move.b  d1,(a2)+
            dbra    d3,loop

            jsr     read1ch
            cmp.b  #$0d,d1
            bne     error1
            
            lea     usere,a2
            move.w  #3,d3
loop3            move.b  (a2)+,d4
            cmp.b  #65,d4
            blt     error1
            cmp.b   #90,d4
            ble     loop2
            cmp.b   #97,d4          ; see if its a charcter
            blt     error1
            cmp.b   #122,d4
            bgt     error1
loop2      
            dbra    d3,loop3
            
            move.w  #3,d3
            
            
loop4       move.b  (a2)+,d4
            cmp.b   #48,d4
            blt     error1          ;test to see if number
            cmp.b   #57,d4
            bgt     error1
            
            dbra    d3,loop4
            
            jsr     p_crlf
            clr     d1
            jsr     echo            ;echo 
            
            
            
loop9            lea     password,a1
            jsr     msg2
            clr     number
            move.w  passwordsize,d3         ;password portion of size
            
            lea     pass,a2
loop7            jsr     read1ch
            cmp.b   #$0d,d1
            beq     loop6
            lea     star,a1                 ;display stars instead
            jsr     msg2
            addq.b  #1,number
            move.b  d1,(a2)+
            dbra    d3,loop7
            

            jsr     read1ch 
            cmp.b   #$0d,d1
            bne     error2
            
loop6       move.b  number,d4
            cmp.b   #8,d4                       
            blt     error2
            bra     end
            

error1      lea     error,a1
            jsr     msg2
            jsr     p_crlf
            bra     understart      ; errors

error2      lea     error,a1
            jsr     msg2
            jsr     p_crlf
            bra     loop9
                             
end            dbra    d7,lol
    		stop 		#$2700
    		include     'io_util.x68'
user        dc.b    'enter in a valid string like the question asks: ',0
password    dc.b    'enter the password dumby: ',0
star        dc.b    '*',0
error       dc.b    'error fifo',0
usersize    dc.w    8
passwordsize    dc.w    12
                                        ;stuff
usere    ds.b    8
pass        ds.b    12
number       ds.b    1

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
