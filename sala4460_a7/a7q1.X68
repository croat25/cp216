*-----------------------------------------------------------
* Title      :a_q_
* Written by :Bruno Salapic	
* Date       :2015/month/day
* Description:q
*-----------------------------------------------------------
    
START:      org		$1000        ; first instruction of program
again          lea     prmpt,a1
            jsr     p_str
            jsr     getnum
            jsr     p_crlf
            
            cmp     #1,d1
            beq     first          empty cluster
            cmp     #2,d1
            beq     second
            cmp     #3,d1
            beq     third
            cmp     #4,d1               ---- wat disk number
            beq     fourth
            cmp     #5,d1                   
            beq     fifth
            cmp.b   #6,d1
            bge     again
            bra     tasknumber
            
            
tasknumber     lea      prmpt2,a1
                jsr     p_str
                jsr     getnum
                jsr     p_crlf
            cmp     #1,d1
            beq     sr1          empty cluster
            cmp     #2,d1
            beq     sr2
            
            
            
            
            cmp     #3,d1
            beq     stopping
            bra     again
             
            
            
stopping            stop 		#$2700  

first         lea       disk1,a0
              bra       tasknumber
second          lea     disk2,a0
                bra       tasknumber
                    
third         lea       disk3,a0                    ---wat task number
              bra       tasknumber
fourth          lea     disk4,a0
                bra       tasknumber
fifth         lea       disk5,a0
              bra       tasknumber
               

sr1          
            move.b  #0,d4
loop
movetable            move.b  (a0)+,d1
            
undermove            move.b  #8,d7
            move.b  #%10000000,d5
back        cmp     #0,d7
            beq     movetable               -- use and to see if its empty cluster or not
            
            move.b  d1,d6
            
            and.b   d6,d5
            
            cmp     d6,d5
            blt     yolo
            cmp     d6,d5
            beq     endofclusteryolo
            
yolo        add     #1,d4
           
           
            lsr     #1,d5
yoloswag           
            dbra     d7,back
                   

    		move.b  #0,d3
    		clr     d7
    		bra     endofcluster
    		
    		
end            move.b  (a0)+,d1
endofcluster  
            
            move.b  #8,d7
            move.b  #%00000000,d5
back2            cmp     #0,d7
            beq     end                                         ---------- useless part
            move.b  d1,d6
            and.b   d6,d5
            cmp     d6,d5
            beq        swag
            add     #1,d3
            
            bra     endend
            
swag        
            add     #1,d3
               
            lsr     #1,d5
            dbra     d7,back2

endend      
            
            bra     again
              
            
                
            



endofclusteryolo    move    #0,d7
                    cmp     d6,d5
                    move      d4,d1
                    lea     prmpt3,a1
                    jsr     p_str                   ---print
                    jsr     readnum
                    jsr     p_crlf
                    bra     again
                    beq     yoloswag
                    add     #1,d4
                    bra     yoloswag
                    
                    
                    
                    
sr2          
            move.b  #0,d4
loop1
movetable1            move.b  (a0)+,d1
            
undermove1            move.b  #8,d7
            move.b  #%10000000,d5
back1        cmp     #0,d7
            beq     movetable1    --------initiaze using and to see if empty cluster
            
            move.b  d1,d6
            
            and.b   d6,d5
            
            cmp     d6,d5
            blt     yolo1              ---- and cmp to see if empty or not
            cmp     d6,d5
            beq     endofcluster1
            
yolo1        add     #1,d4
                                                            
           
            lsr     #1,d5
yoloswag1           
            dbra     d7,back1
                   

    		move.b  #0,d3
    		clr     d7
    		bra     endofcluster1
    		
    		
end1            move.b  (a0)+,d1
endofcluster1  
            
            move.b  #8,d7
            move.b  #%00000000,d5
back21            cmp     #0,d7
            beq     end1
            move.b  d1,d6
            and.b   d6,d5
            cmp     d6,d5                                           -check to see set of empty cluster
            beq        swag1
                       
            add     #1,d3
            
            bra     endend1            
swag1        
            add     #1,d3                           -keep track of how many clusters in a row are empty
wowoza               
            lsr     #1,d5
            dbra     d7,back21

endend1      
            move       d3,d1
            lea     prmpt4,a1
            jsr     p_str
            jsr     readnum             ----print
            jsr     p_crlf
            bra     again

endofclusteryolo1    move    #0,d7
                    cmp     d6,d5
                   
                    beq     yoloswag1
                    add     #1,d4
                    bra     yoloswag1
* Put variables and constants here
            include     'io_util.x68'

choosedisk      dc.b    'choose a disk number 1-5 ',0
choose          dc.b     'choose task',0
            
prmpt3      dc.b    'the first empty cluster is',0            
prmpt       dc.b    'enter in disk value',0
prmpt2          dc.b    'enter in task number 1 first first empty cluster 2 for set of cluster 3 to terminate',0
prmpt4      dc.b        'the first empty set of clusters is ',0

listempty        ds.b    256
listfull         ds.b       256

row     equ     2
cols     equ     4
Bitmap  EQU    *
Disk1   DC.L   $FFFFFF00,$0FC8FEDF,$00001111,$22223333
        DC.L   $FFFFFFFF,$FFFF000F,$FF000000,$00000000
Disk2   DC.L   $FFFFFFFF,$FFFFFF00,$00000000,$FFFF8000
        DC.L   $0F021234,$00004321,$00001111,$22223333
Disk3   DC.L   $FF800000,$00FFFFFF,$FFFFFFFF,$22003333
        DC.L   $00000000,$F8007FF0,$0000AAAA,$FF004660
Disk4   DC.L   $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
        DC.L   $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
Disk5   DC.L   $00000000,$00000000,$00000000,$00000000
        DC.L   $00000000,$00000000,$00000000,$00000000
        
        
        
    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
