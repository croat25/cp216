*-----------------------------------------------------------
* Title      :a8q1
* Written by :Bruno Salapic	
* Date       :2016/marc/13
* Description:q
*-----------------------------------------------------------
    
START:      org		$1000        ; first instruction of program
beginning

try
startover            clr      d1
            clr     d2
            clr     d3
            clr     d4                  ----clrs
            clr     d5
            clr     d6
             
            
            
            
            
      lea     printstr,a1
            jsr     p_strnr
            jsr     p_rstr
                                        
            move    d1,d4
            cmp     #0,d4                   ---print str to user
            beq     end
            sub     #1,d4
            lea     startposition,a1
            jsr     p_strnr
            jsr     readnum
            move.b      d1,d2
            sub     #1,d2
            lea     endposition,a1
            JSR     p_strnr                     --get info from user
            jsr     readnum
            move    d1,d3
            sub     #1,d3
            cmp     d3,d4
            
            blt     error3
            
            sub     d3,d4
rot13            
next            move.b  (a1)+,d5
           *
            cmp     #0,d2
            dbeq    d2,output
            *
            cmp     #57,d5                  --see if number or special character
            blt     output
            
donttouch   cmp     #78,d5
            blt     lowloop            
            
            cmp     #90,d5
            blt     subtractalpha
            cmp     #110,d5                     --high alpha
            ble     next6
back2            
            
            cmp     #122,d5
            ble     subtractbeta
next222     cmp     #122,d5                 -low alpha
            bgt        output
                 


output        move    d5,d1
                moveq   #6,d0
                trap    #15                 ---output
                dbra    d4,rot13

end         stop    #$2700

error3      lea     er1,a1
            jsr     p_strnr                         --error
            jsr     p_crlf
            clr     d0
            bra     try



lowloop     move        #13,d7
looplow            cmp         #65,d5
            beq         jumptoz
back            sub         #1,d5
            sub         #1,d7
            cmp         #0,d7               -low alpha wrap
            beq         output
            bra     looplow 


subtractalpha   sub     #13,d5
                bra     output            ----subtract

subtractbeta   sub     #13,d5
                bra     next222             ----subtract

jumptoz    move     #122,d6
                sub     d1,d6
                add     d6,d1
                bra     back            ---wrap to z
next6       sub     #19,d5
            bra     output
            
            
                                      
          include     "io_util.x68"
            
er1         dc.b    'newb error ',0            
printstr    dc.b    'enter a string: ',0
startposition   dc.b    'enter were u would like  to start the encryption',0
endposition     dc.b    'enter in the length of encryption',0

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
