*-----------------------------------------------------------
* Title      :a2q1
* Written by :Bruno Salapic	
* Date       :2016/01/19
* Description:q
*-----------------------------------------------------------
    
START:      org		$1000        ; first instruction of program

            move.b  num1,d0
            move.b  num2,d1
            move.b  num3,d2
            move.b  num4,d3
            
            sub.b   d0,d1
            move.b  d1,result
            
            move.b  num2,d1
            
            sub.b   d1,d2
            move.b  d2,result2
            
           
            
            sub.b   d0,d3
            move.b  d3,result3

    		stop 		#$2700

* Put variables and constants here

num1    dc.b        $25
num2    dc.b        $55
num3    dc.b        $32
num4    dc.b        $25
result  ds.b        1
result2  ds.b       1
result3  ds.b       1

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
