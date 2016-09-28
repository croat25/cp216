*-----------------------------------------------------------
* Title      :a5q3
* Written by :bruno salapic
* Date       :something feburary
* Description:idk
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
        clr     d7
        lea     index,a3
        lea     countlist,a0            ;load address
        lea     list,a2   
        lea     entry,a1
        jsr     p_str                   ; print str message
        jsr     p_crlf2
        
        
        
input       jsr     readchar2
            cmp.b   #$0d,d1                 ; get charactter by character
            beq     check
            add     #1,d2
            move    d1,d6                   ; keep track
            move    d1,(a2)+
            add     #1,d7
            bra     input               ; branch until beq executes

check       cmp     #0,d2
            beq     end
            move    d7,(a0)+
            clr     d2                  ; check to see if its only a carrage return without other characters in 
            clr     d7
            add     #1,d3
            bra     input 
                           
  

end        lea      list,a2
           lea      countlist,a0            ; return pointers
           
           move     #0,d4
loop       
           
           move     (a0)+,d5            
           subq     #1,d5
           
loop2      move      (a2)+,d1
           
            jsr     displaychar                 ; display character by charcter with a comma
            dbra     d5,loop2
            add     #1,d4
            cmp.b    d3,d4
            beq      exit
next        lea     comma,a1
            jsr     p_str2
            
            
            
            bra     loop        
        

exit   SIMHALT             ; halt simulator
        include     'io_util.x68'
* Put variables and constants here
entry       dc.b    'please enter a word',0
list        ds.b    200
list1       ds.b    18
count      ds.b    200              ; stufff
countlist   ds.b    200
index       ds.b    200
empty       dc.b    ' ',0
comma       dc.b    ',',0
    END    START        ; last line of source








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
