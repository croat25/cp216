*-----------------------------------------------------------
* Title      :a3q6
* Written by :bruno salapic
* Date       :idk
* Description:the check on works if u hold the button down 
*               it doesnt stay on it goes back to c idk dont have time 
*               to fix it 
                            
*-----------------------------------------------------------
display    equ $e00000
display1    equ $e00002
display2    equ $e00004
display3    equ $e00006
display4    equ $e00008         ;display u know
display5    equ $e0000a
display6    equ $e0000c
display7    equ $e0000e


leds        equ $e00010
switch      equ $e00012     ;self explanatory
but         equ $e00014

  
        ORG    $1000
START:                  ; first instruction of program
new        move.b  #%1101101,display
        move.b  #%0000000,display1
        move.b  #%0000000,display2  
        move.b  #%0000000,display3          ;setting the displays u know
        move.b  #%0000000,display4
        move.b  #%0000000,display5
        move.b  #%0000000,display6
        move.b  #%0000000,display7
        
        move.b  #$00,leds           ;setting the leds to 00000000 u know
        
loop    
        move.b  switch,d0               ;storing number u know
        move.b  d0,leds
        cmp.b   #%11111110,but          
        beq     store
        bra loop                ;that branch life
        
store  move.b  #%0111001,display
        
swag       move.b   switch,d1
       cmp.b    #%01111111,but          ;seeing if buttons are pushed
       beq      new
       cmp.b   #%11111110,but           ; if so do some other stuff
       beq     check
       bra      store
       
check   cmp.b   d0,d1
        bgt     high                ; comepare to orginal number input u think
        blt     low
        beq     same
        
high    move.b  #%1110110,display
        bra     swag
low     move.b  #%0111000,display       ; display if its high low or equal
        bra     swag
same    move    #%1111001,display
        bra     swag

   
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here
count   dc.b    0

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
