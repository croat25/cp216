*-----------------------------------------------------------
* Title      :a4q2
* Written by :Bruno Salapic	
* Date       :2016/month/day
* Description:q
*-----------------------------------------------------------
    
START:      org		$1000        ; first instruction of program
loop            clr.b   d7
           
            clr     d1
            clr     d0
            lea     entry,a1
            jsr     msg2
            jsr     p_crlf
            move.b  range,d7
            lea     string,a2
            
            
            jsr     read1ch
            jsr     p_crlf
            cmp.b   #35,d1
            beq     end
            cmp.b   #47,d1
            ble     otheryo
            cmp.b   #57,d1
            ble     numberyo
            cmp.b   #65,d1
            ble     otheryo
            cmp.b   #90,d1
            ble     upperyo
            cmp.b   #96,d1
            ble     otheryo
            cmp.b   #122,d1
            ble     loweryo
            cmp.b   #126,d1
            ble     otheryo
            
            
otheryo     lea     otherp,a1
            jsr     p_crlf
            jsr     p_str
            
            bra     loop
numberyo    lea     numberp,a1
            jsr     p_str
            jsr     p_crlf
            bra     loop

upperyo     lea     upperp,a1
            jsr     p_str
            jsr     p_crlf
            bra     loop

loweryo     lea     lowerp,a1
            jsr     p_str
            jsr     p_crlf
            bra     loop       
            
            
            
            
            
end    		stop 		#$2700
            include 'io_util.x68'
* Put variables and constants here
string      dc.b    1
range       dc.b    0
entry       dc.b    'enter in a character swag or # to stop cause thats the twitter life',0
upperp      dc.b    'its an uppercase letter',0
lowerp      dc.b    'its a lowercase letter',0
numberp     dc.b    'a number has been choose',0
otherp      dc.b    'something crazy like mr.potato ',0
    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
