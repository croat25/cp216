*-----------------------------------------------------------
* Title      :q2
* Written by :bruno salapic
* Date       :idk
* Description:swag
*-----------------------------------------------------------
leds    equ $e00010             ;initaite stuff
switches    equ $e00012
        
START:  ORG    $1000                ; first instruction of program
top        move.b  switches,leds            ;move switches to leds and branch
        
        
        bra     top

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
