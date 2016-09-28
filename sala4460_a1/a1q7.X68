*-----------------------------------------------------------
* Program    : Assignment #1 q5
* Written by : Dr. Nora Znotinas
* Description: subtract two numbers
* Input: num1, num2
* Output: answer
* Registers: D0, D1 - store input so num1/2 not trashed
*-----------------------------------------------------------
START   ORG     $1000
        MOVE.l  num1,D0         ;get first value
        MOVE.l  num2,D1         ;get second value
        
        SUb.b  D0,d1           ; subract the numbers
        MOVE.l  D1,answer
        
        move.l  num1,d2
        move.l  num2,d1
         SUb.w  D2,D1          ; subract the numbers
        MOVE.l  d1,answer2
        
        move.l  num1,d3
        move.l  num2,d1
         SUb.l  D3,D1           ; subract the numbers
        MOVE.l  D1,answer3
        
        STOP    #$2700
num1    DC.W    $1402
num2    DC.W    $5612
answer  DS.l    1
answer2  ds.l    1
answer3 ds.l    1
        END     START
*-----------------------------------------------------------


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
