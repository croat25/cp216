*-----------------------------------------------------------
* Title      :bruno salapic 
* Written by :a3q5
* Date       :idk
* Description:q5 its in the assigments
*-----------------------------------------------------------
leds    equ $e00010
switch  equ $e00012             ; setting my hardware not software
butt    equ $e00014
    
        ORG    $1000
START:                  ; first instruction of program

top        move.b  #$00,leds        ; setting leds to zero
        
        
potato        cmp.b     #%11111110,butt     ; seeeing if buttons are pushed
        beq        brakelight
        
        
        cmp.b   #%00000001,switch
        beq     rightturn
                                        ; if buttons are pushed do stuff
        cmp.b   #%00000010,switch
        beq     leftturn
        cmp.b   #%00000000,switch
        beq     top    
        bra     potato
brakelight  move.b  #%11100111,leds
            nop                         ;brake light
            bra     potato
            
leftturn    cmp.b       #%11111110,butt
            beq         rightplusbrake      ;left turn without brake
            move.b    #%00000100,leds
            move.l  #$31ffff,d3             
loop        sub.l   #$1,d3
            bne     loop
            cmp.b       #%11111110,butt
            beq         rightplusbrake      ;hardcoded  pretty much
            move.b  #%00000110,leds         ; idk how to do it anyother way
            move.l  #$31ffff,d3             
loop2        sub.l   #$1,d3
            bne     loop2
            move.b  #%00000111,leds
            move.l  #$31ffff,d3             
loop3        sub.l   #$1,d3
            bne     loop3
            
            cmp.b   #%11111110,butt
            beq     leftplusbrake            
            bra     potato


rightturn   cmp.b       #%11111110,butt
            beq         rightplusbrake
            move.b    #%00100000,leds
            move.l  #$31ffff,d2             
loop4        sub.l   #$1,d2                     ;same thing as above but for rightwith no lights
            bne     loop4
            cmp.b       #%11111110,butt
            beq         rightplusbrake
            move.b  #%01100000,leds
            move.l  #$31ffff,d2             
loop5        sub.l   #$1,d2
            bne     loop5
            cmp.b       #%11111110,butt
            beq         rightplusbrake
            move.b  #%11100000,leds
            move.l  #$31ffff,d2             
loop6        sub.l   #$1,d2
            bne     loop6
            cmp.b   #%11111110,butt
            beq     rightplusbrake 
            bra     potato
            
            
            
leftplusbrake    move.b    #%11100100,leds
            move.l  #$31ffff,d3             
loop7        sub.l   #$1,d3
            bne     loop7
            move.b  #%11100110,leds
            move.l  #$31ffff,d3             
loop8        sub.l   #$1,d3
            bne     loop8               ;left with brakes active
            move.b  #%11100111,leds
            move.l  #$31ffff,d3             
loop9        sub.l   #$1,d3
            bne     loop9
                       
            bra     leftturn

rightplusbrake    move.b    #%00100111,leds
            move.l  #$31ffff,d3             
loop10        sub.l   #$1,d3
            bne     loop10
            move.b  #%01100111,leds
            move.l  #$31ffff,d3             
loop11        sub.l   #$1,d3
            bne     loop11
            move.b  #%11100111,leds
            move.l  #$31ffff,d3             
loop12        sub.l   #$1,d3
            bne     loop12              ;right with brakes active
                       
            bra     rightturn

      
    SIMHALT             ; halt simulator

* Put variables and constants here
left    dc.b    %00000100
right   dc.b    %00000001
brake   dc.b    %00000010           ; those this ©¨

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
