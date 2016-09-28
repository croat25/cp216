*-----------------------------------------------------------
* Program    : Assignment #1 ASCII test
* Written by : Dr. Nora Znotinas
* Description: check how ASCII data is stored
*-----------------------------------------------------------
START   ORG     $1000
        NOP
        STOP    #$2700 
* using bytes 
ERR1a   DC.B    'Error'
ERR1H   DC.B    $45,$72,$72,$6F,$72
ERR1I   DC.B    'E','r','r','o','r'
* using words
ERR2a   DC.W    'Error'
ERR2b   DC.W    'Erro'
ERR2H   DC.W    $45,$72,$72,$6F,$72
ERR2I   DC.W    'E','r','r','o','r' 
ERR2Ia  DC.W    'Err','or'       
* using longwords
ERR3a   DC.L    'Error'
ERR3b   DC.L    'Err'
ERR3H   DC.L    $45,$72,$72,$6F,$72
ERR3I   DC.L    'E','r','r','o','r'
ERR3Ia  DC.L    'Err','or' 

        END     START






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
