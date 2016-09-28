*-----------------------------------------------------------
* Program    : Assignment #1 q5
* Written by : Dr. Nora Znotinas
* Description: subtract two numbers
* Input: num1, num2
* Output: answer
* Registers: D0, D1 - store input so num1/2 not trashed
*-----------------------------------------------------------
START   ORG     $1000
        MOVE.b  num1,D0         ;get first value
        MOVE.b  num2,D1         ;get second value
        SUb.b  D0,D1           ; subract the numbers
        MOVE.b  D1,answer       ; and store result
        STOP    #$2700
num1    DC    $12003425
num2    Dc    $4512374A
answer  DS    1
        END     START
*-----------------------------------------------------------

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
