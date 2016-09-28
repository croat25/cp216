*-----------------------------------------------------------
* Title      :a2q5
* Written by :Bruno Salapic	
* Date       :2015/month/day
* Description:q
*-----------------------------------------------------------
    
START:      org		$1000        ; first instruction of program

            move.l  login,d0
            move.l  login+4,d1
            add.l   #$20202020,d0
            
            move.l  d0,result
            move.l  d1,result+4

    		stop 		#$2700

* Put variables and constants here
login       dc.l    'SALA4460'
result      dc.l    ''

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
