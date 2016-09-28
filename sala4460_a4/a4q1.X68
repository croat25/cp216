*-----------------------------------------------------------
* Title      :a4q1
* Written by :Bruno Salapic	
* Date       :2016/month/day
* Description:idk
*-----------------------------------------------------------
    
START:      org		$1000        ; first instruction of program

            lea     prompting,a1        ;lea the address  to read character at atime
            jsr     msg2
            move.b  range,d7
            lea     string,a2
            
loop            jsr     read1ch
            move.b  d1,(a2)+
            cmp     #13,d1
            beq     end
            add.b   #1,d5               ; do my magic trick here
            dbra   d7,loop
            

            add.b   #1,d4
            bra     loop        
            
                                        ;display the length back to display #swag
end         lea     final,a1
                      
            move.b  d5,d1
            jsr     p_num
    		stop 		#$2700

* Put variables and constants here
            include 'io_util.x68'
            
string      ds.b    255
range       ds.b    255            
prompting   dc.b    'enter in a string of characters',0
final       dc.b    'there are :',0
us1         dc.b    1
    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
