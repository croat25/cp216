*-----------------------------------------------------------
* Title      :a2q6
* Written by :Bruno Salapic	
* Date       :2015/month/day
* Description:q
*-----------------------------------------------------------
    
START:      org		$1000        ; first instruction of program
            move.b  bigend+3,d0     ;last 2 
            move.b  bigend+2,d1     ;byte 5-6
            move.b  bigend+1,d2     ;3-4
            move.b  bigend,d3   ;1-2
            
            move.b  d0,result
            move.b  d1,result+1
            move.b  d3,result+2
            move.b  d2,result+3
                     

    		stop 		#$2700

* Put variables and constants here
bigend      dc.l    $20160114
result      ds.l    1
    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
