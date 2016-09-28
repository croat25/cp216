*-----------------------------------------------------------
* Title      :a2q4
* Written by :Bruno Salapic	
* Date       :2016/month/day
* Description:q
*-----------------------------------------------------------
    
START:      org		$1000        ; first instruction of program
            move.b  input,d0
            move.b  input+2,d1
            move.b  input+4,d2
            move.b  input+6,d3
            
            move.b  d0,first
            move.b  d1,first+1
            move.b  d2,first+2
            move.b  d3,first+3
            
            move.b  input+1,d0
            move.b  input+3,d1
            move.b  input+5,d2
            move.b  input+7,d3
            
            move.b  d0,sec
            move.b  d1,sec+1
            move.b  d2,sec+2
            move.b  d3,sec+3
            
            move.b  input1,d0
            move.b  input1+2,d1
            move.b  input1+4,d2
            move.b  input1+6,d3
            
            move.b  d0,first1
            move.b  d1,first1+1
            move.b  d2,first1+2
            move.b  d3,first1+3
            
            move.b  input1+1,d0
            move.b  input1+3,d1
            move.b  input1+5,d2
            move.b  input1+7,d3
            
            move.b  d0,sec1
            move.b  d1,sec1+1
            move.b  d2,sec1+2
            move.b  d3,sec1+3
            
            move.b  input2,d0
            move.b  input2+2,d1
            move.b  input2+4,d2
            move.b  input2+6,d3
            
            move.b  d0,first2
            move.b  d1,first2+1
            move.b  d2,first2+2
            move.b  d3,first2+3
            
            move.b  input2+1,d0
            move.b  input2+3,d1
            move.b  input2+5,d2
            move.b  input2+7,d3
            
            move.b  d0,sec2
            move.b  d1,sec2+1
            move.b  d2,sec2+2
            move.b  d3,sec2+3
            
    		stop 		#$2700

* Put variables and constants here

input   dc.l    'FeRaEsDy'
first   ds.l    ' '
sec     ds.l    ' '

input1   dc.b    'F',$65,'R',$61,'E',$73,'D',$79
first1   ds.l    ' '
sec1     ds.l    ' '
input2   dc.b    'F',$65,'R',$61,' ',$73,'D',$79
first2   ds.l    ' '
sec2     ds.l    ' '

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
