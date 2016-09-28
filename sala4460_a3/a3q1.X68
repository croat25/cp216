*-----------------------------------------------------------
* Title      :q1
* Written by :bruno salapic
* Date       :idk   
* Description:q1 yolo
*-----------------------------------------------------------
leds    equ $e00010             ; initiate stuff
switches    equ $e00012
        
START:  ORG    $1000                ; first instruction of program
        move.b  patt,d0
top     move.b  d0,leds                 ;move patt to display in leds
        ror.b   #1,d0
        move.l  #$3fffff,d1
loop    sub.l   #1,d1               ; rotate that sucker
        bne     loop
        
        bra     top

    SIMHALT             ; halt simulator

* Put variables and constants here
patt    dc.b    %01011001
    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
