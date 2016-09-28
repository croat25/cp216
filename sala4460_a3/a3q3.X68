*-----------------------------------------------------------
* Title      :q3
* Written by :bruno salapi
* Date       :idk
* Description:q3
*-----------------------------------------------------------
leds    equ $e00010             ;things being iniaitate
button    equ $e00014
        
START:  ORG    $1000                ; first instruction of program
top       not button                
        
        move.b  button,leds         ; buttons to leds display
       
        bra     top         ; that branch lyfe

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
