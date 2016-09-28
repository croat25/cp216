*-----------------------------------------------------------
* Title      :a_q_
* Written by :Bruno Salapic	
* Date       :2015/month/day
* Description:q
*-----------------------------------------------------------
    
START:      org		$1000        ; first instruction of program

            move.w  num1,d0
            move.w  num2,d1
            move.w  num3,d2
            move.w  num4,d3
            
            add.w   d0,d1
            move.w  d1,result
            
            add.w   d0,d2   
            move.w  d2,result2
            
            add.w   d0,d3
            move.w  d3,result3
            
    		stop 		#$2700

* Put variables and constants here

num1    dc.w        $162d
num2    dc.w        $e9d2
num3    dc.w        $e9d4
num4    dc.w        $e9d3

result      ds.w    1
result2     ds.w    1
result3     ds.w    1


    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
