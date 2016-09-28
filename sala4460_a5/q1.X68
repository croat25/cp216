*-----------------------------------------------------------
* Title      :5q1
* Written by :bruno sala4460
* Date       :feburary something
* Description: meh
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
        move.b  #4,d6
        lea     newlist,a0
        lea     list,a2                         ; load addresses 
loop    lea     prmpt,a1
        jsr     p_prmpt
        bra     addtolist                   ; prompt user
        jsr     p_crlf2

addtolist      move.b    d1,(a2)+                   ; add to list
            dbra     d6,loop
            
secondline  lea     prmpt2,a1
            jsr     p_prmpt                     ; second prompt window
            jsr     p_crlf2
            bra     check
  
check       cmp.b   #1,d1
            beq     printlist                       
            cmp.b   #2,d1                           ; check wat user wishes to do
            beq     timetoadd
            cmp.b   #3,d1
            beq     end
            bra     error
        
printlist   lea     list,a2
            move    #3,d4                                   ; printing 
            move.b  (a2)+,d1
            lea     blank,a1
            jsr     p_num
loop3            move.b  (a2)+,d1
            lea     comma,a1
            jsr     p_num
            dbra    d4,loop3
            clr     d4
            jsr     p_crlf2
            bra     secondline 

error     lea     lol,a1
                jsr     p_str
            lea     list,a2                           ; print error prmopt again
                 bra    secondline

timetoadd   lea     list,a2
            lea     howmany,a1
            jsr     p_prmpt
            cmp     #5,d5
            bgt     error
            move    d1,d5
            sub     #1,d5
loopyolo    move.b  (a2)+,d3
            add     d3,d4
            dbra    d5,loopyolo
        
printingans cmp     #255,d4
            bgt     error
            move    d4,d1
            lea     ans,a1
            jsr     p_num
            jsr     p_crlf2
            clr     d4                      ; print
            bra     secondline
bigger      lea     big,a1
            jsr     p_str
            bra     secondline    


end    SIMHALT             ; halt simulator
    include 'io_util.x68'
* Put variables and constants here
prmpt   dc.b    'enter in 1 of the 5 numbers between 1-255: ',0
prmpt2  dc.b    'enter in 2 to use sum function or 1 to print list or 3 to end session: ',0
howmany dc.b    'how many elements would u like to add: ',0
big     dc.b    'exceeds 255 try again: ',0
lol     dc.b    ' i said errrRAWRRRRRRR ',0
list    ds.b    5
ans     dc.b    ' ans is : ',0
newlist ds.b    5
comma   dc.b    ', ',0
blank   dc.b    '',0

add     dc.b    1
    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
