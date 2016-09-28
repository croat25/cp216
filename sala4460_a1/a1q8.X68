
*-----------------------------------------------------------
* Program    : Assignment #1 base program
* Written by : Dr. Nora Znotinas
* Description: subtract two numbers
* Input: num1, num2
* Output: answer
* Registers: D0, D1 - store input so num1/2 not trashed
*-----------------------------------------------------------
START   ORG     $1000


        MOVE.b  num1,D0         ;get first value
        not.b   d0
        move.b  d0,answer
        

        MOVE.b  num1,D0   
        MOVE.b   num2,D1 ;get second value
        and.b   d0,d1
        move.b  d1,ans2
        
        MOVE.b  num1,D0   
        MOVE.b   num2,D1 ;get second value
        or.b    d0,d1
        move.b  d1,ans3
        
        MOVE.b  num1,D0   
        MOVE.b   num2,D1 ;get second value
        eor.b    d0,d1
        move.b  d1,ans4
              ; and store result
        STOP    #$2700
        
num1    DC.b    $1
num2    DC.b    $4
answer  DS.b    1
ans2    ds.b    1
ans3    ds.b    1
ans4    ds.b    1
        END     START
*-----------------------------------------------------------
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
