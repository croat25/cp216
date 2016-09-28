*-----------------------------------------------------------
* Title      :a5q2
* Written by :bruno salapic
* Date       :some feburary thing
* Description:idk
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
        lea     count1,a0
        lea     words1,a1
        jsr     getwords
        clr     d5
        clr     d4
        lea     count2,a0               ; load addresss
        lea     words2,a1
        jsr     getwords
        clr     d5
        clr     d4
        lea     count3,a0
        lea     words3,a1
        jsr     getwords
        bra     end
        
       
        
        
getwords    movem.l a1,-(sp)
            lea     entry,a1            ; swag points
            jsr     p_str
            move    #9,d4
           
            movem.l (sp)+,a1
            

loop        jsr     msg2                        get stuff 
            tst.b   d1
            beq     next
            add     #1,d5
            add     d1,a1
            dbra    d4,loop  
next        move    d5,(a0)                     ; return how many in list
            move    d5,d4
            move    d4,d1
            lea     there,a1
            jsr     p_num
            
             
        rts

                           
                
        
        

end    SIMHALT             ; halt simulator
        include     'io_util.x68'
* Put variables and constants here
words1      ds.w    10
words2      ds.w    10
words3      ds.w    10
entry        dc.b    'enter in words like u never done it before',0
there       dc.b    'there are : ',0
count1      ds.w    1
count2      ds.w    1
count3      ds.w    1
    END    START        ; last line of source







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
