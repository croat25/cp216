*-----------------------------------------------------------
* Title      :a3q3
* Written by :Bruno Salapic	
* Date       :2016/month/day
* Description:q



*************************************************************
* the count cannot be zero or more then 9 cause in the maunal it says
* it cant be anything other then 1-8 and it gives and error if u try

*-----------------------------------------------------------
    
 
START:      org		$1000        ; first instruction of program

            move.b  num1,d0
            
            
            ror.b   #2,d0
            move.b  d0,res
            

    		stop 		#$2700

* Put variables and constants here

num1    dc.b    %11001100    


pos1    dc.b    2


res     ds.b    1

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
