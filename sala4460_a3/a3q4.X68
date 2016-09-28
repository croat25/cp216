*-----------------------------------------------------------
* Title      :q4
* Written by :bruno salapic 
* Date       :idk
* Description:swag q4
*-----------------------------------------------------------
 
leds    equ $e00010
switch  equ $e00012
push    equ $e00014         ; initiate stuff on hardware

START:           ORG    $1000
                  ; first instruction of program

   
        move.b  #$00,leds           ; move things for leds to be off
    
loop    move.b  push,d2
        not     d2                      
        cmp.b   comp,d2
        bne     top                     ;when switch is hit it displays
        bra     loop
top     move.b  switch,d0
        move.b  d0,leds                 ;swag
        
        bra     loop      

    SIMHALT             ; halt simulator

* Put variables and constants here
comp    dc.b    $0
    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
