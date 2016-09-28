*-----------------------------------------------------------
* Title      :a7q4
* Written by :Bruno Salapic	
* Date       :2016/month/day
* Description:q
*-----------------------------------------------------------
START:	ORG	        $1000	    ;Start of program area
beginning        lea        sb,a0
        
        jsr         oneway
        
        jsr         sb_dsp
        lea         prmpt,a1
        jsr         p_str
        jsr         getnum
        
        cmp         #0,d1
        beq         end
        cmp         #1,d1
        beq         invert
        bra         beginning
        cmp         #2,d1
        beq         flipped
        
invert        
        move.l      #sb_w*sb_h,d7
        jsr         sb_dsp1
        
        bra         beginning
        
flip    jsr         sb_clr
        move.l    #sb_w*sb_h,d7
        jsr     flipped
end     STOP        #$2700


        
        



        
        



 * Draw b
oneway        move.l      #175,d1
        move.l      #100,d2
        move.l      #10,d3
        move.l      #125,d5
        move.l     #$0000FF00,d4
        jsr         h_line
        
        move.l      #50,d1
        move.l      #100,d2
        move.l      #10,d3
        move.l      #500,d5
        move.l      #$00FF0000,d4
        jsr         v_line
        
        move.l      #175,d1
        move.l      #225,d2
        move.l      #10,d3
        move.l      #375,d5
        move.l      #$00FF0000,d4
        jsr         v_line
        
        move.l      #295,d1
        move.l      #100,d2
        move.l      #10,d3
        move.l      #135,d5
        move.l      #$000000ff,d4
        jsr         h_line
        
        *draw        s
        move.l      #175,d1
        move.l      #300,d2
        move.l      #10,d3
        move.l      #125,d5
        move.l      #$0000FF00,d4
        jsr         h_line
        
        move.l      #175,d1
        move.l      #300,d2
        move.l      #10,d3
        move.l      #60,d5
        move.l      #$00FF0000,d4
        jsr         v_line
        
        move.l      #235,d1
        move.l      #300,d2
        move.l      #10,d3
        move.l      #125,d5
        move.l      #$0000FF00,d4
        jsr         h_line
        
        move.l      #235,d1
        move.l      #425,d2
        move.l      #10,d3
        move.l      #60,d5
        move.l      #$00FF0000,d4
        jsr         v_line
        
         move.l      #295,d1
        move.l      #300,d2
        move.l      #10,d3
        move.l      #135,d5
        move.l      #$0000FF00,d4
        jsr         h_line
        
                
        * Draw Random Diagonal
        move.l      #550,d1
        move.l      #100,d2
        move.l      #10,d3
        move.l      #110,d5
        move.l      #$0000FF00,d4
        jsr         dl
        
        move.l      #200,d1
        move.l      #550,d2
        move.l      #10,d3
        move.l      #110,d5
        move.l      #$00FF0000,d4
        jsr         dl
        
        move.l      #300,d1
        move.l      #550,d2
        move.l      #10,d3
        move.l      #110,d5
        move.l      #$000000FF,d4
        jsr         dl
        rts
        
        
        
flipped        move.l      #175,d1
        move.l      #540,d2
        move.l      #630,d3
        move.l      #125,d5
        move.l     #$0000FF00,d4
        jsr         h_line
        
        move.l      #290,d1
        move.l      #540,d2
        move.l      #10,d3
        move.l      #500,d5
        move.l      #$00FF0000,d4
        jsr         v_line
        
        move.l      #465,d1
        move.l      #415,d2
        move.l      #10,d3
        move.l      #375,d5
        move.l      #$00FF0000,d4
        jsr         v_line
        
        move.l      #345,d1
        move.l      #540,d2
        move.l      #10,d3
        move.l      #135,d5
        move.l      #$000000ff,d4
        jsr         h_line
        
        *draw        s
        move.l      #465,d1
        move.l      #340,d2
        move.l      #10,d3
        move.l      #125,d5
        move.l      #$0000FF00,d4
        jsr         h_line
        
        move.l      #465,d1
        move.l      #340,d2
        move.l      #10,d3
        move.l      #60,d5
        move.l      #$00FF0000,d4
        jsr         v_line
        
        move.l      #405,d1
        move.l      #340,d2
        move.l      #10,d3
        move.l      #125,d5
        move.l      #$0000FF00,d4
        jsr         h_line
        
        move.l      #235,d1
        move.l      #425,d2
        move.l      #10,d3
        move.l      #60,d5
        move.l      #$00FF0000,d4
        jsr         v_line
        
         move.l      #295,d1
        move.l      #300,d2
        move.l      #10,d3
        move.l      #135,d5
        move.l      #$0000FF00,d4
        jsr         h_line
        
                
        * Draw Random Diagonal
        move.l      #550,d1
        move.l      #100,d2
        move.l      #10,d3
        move.l      #110,d5
        move.l      #$0000FF00,d4
        jsr         dl
        
        move.l      #200,d1
        move.l      #550,d2
        move.l      #10,d3
        move.l      #110,d5
        move.l      #$00FF0000,d4
        jsr         dl
        
        move.l      #300,d1
        move.l      #550,d2
        move.l      #10,d3
        move.l      #110,d5
        move.l      #$000000FF,d4
        jsr         dl
        rts

        
        
        
        
 
* Parameters:
*  D1.L - Y position
*  D2.L - X position
*  D3.L - Line width
*  D4.L - Line length
*  D5.L - Line colour
*  A0   - Screen Buffer
* 
h_line  movem.l     d1-d7/a0,-(SP)
        move.l      d1,d7           ;Preserve Y-Coordinate
        lsl.l       #2,d1           
        mulu        #sb_w,d1         ;Set Y-Coordinate (multi by buffer length)
        adda.l      d1,a0
        lsl.l       #2,d2           
        move.l      d3,d1           ;Counter for width
        
h_draw  tst.b       d1
        beq         h_dsp           ;Draw pixel since one 1 length
        adda.l      d2,a0
        move.l      d5,d0
        
h_loop  tst.b       d0
        beq         h_width
        move.l      d4,(a0)+
        sub.l       #1,d0
        bne         h_loop
        
h_width sub.l       #1,d1
        move.l      #sb_w,d0
        lsl.l       #2,d0
        move.l      d5,d6
        lsl.l       #2,d6
        add.l       d2,d6
        sub.l       d6,d0
        adda.l      d0,a0
        bra         h_draw
        
h_dsp   add.l       d7,d3
        mulu        #sb_w*4,d5
        suba.l      d3,a0
        move.l      #sb_w,d6
        move.l      #sb_w*sb_h,d7               
        movem.l     (SP)+,d1-d7/a0
        rts

* Parameters:
*  D1.L - Y position
*  D2.L - X position
*  D3.L - Line width
*  D5.L - Line length
*  D4.L - Line colour
*  A0   - Screen Buffer
* 
* Variables:
*   
* Returns:
* 
v_line  movem.l     d1-d7/a0,-(SP)
        move.l      d1,d7           ;Preserve Y-Coordinate
        lsl.l       #2,d1           
        mulu        #SB_H,d1         ;Set Y-Coordinate (multi by buffer length)
        adda.l      d1,a0
        lsl.l       #2,d2           
        move.l      d5,d1           ;Counter for width
        
v_draw  tst.b       d1
        beq         v_dsp           ;Draw pixel since one 1 length
        adda.l      d2,a0
        move.l      d3,d0
        
v_loop  tst.b       d0
        beq         v_len
        move.l      d4,(a0)+
        sub.l       #1,d0
        bne         v_loop
        
v_len   sub.l       #1,d1
        move.l      #SB_W,d0
        lsl.l       #2,d0
        move.l      d3,d6
        lsl.l       #2,d6
        add.l       d2,d6
        sub.l       d6,d0
        adda.l      d0,a0
      
        bra         v_draw
        
v_dsp   add.l       d7,d5
        mulu        #sb_w*4,d5
        suba.l      d5,a0
        move.l      #sb_w,d6
        move.l      #sb_w*sb_h,d7               
        movem.l     (SP)+,d1-d7/a0
        rts
*--------------------------------------------------------------------
* Subroutine to draw diagonal line
dl      movem.l     d1-d7/a0,-(sp)
        move.l      d1,d7           ;Preserve Y-Coordinate
        lsl.l       #2,d1           
        mulu        #sb_h,d1        ;Set Y-Coordinate (multi by buffer length)
        adda.l      d1,a0
        lsl.l       #2,d2           
        move.l      d5,d1           ;Counter for width
        
dld     tst.b      d1
        beq         dldispla          ;Draw pixel since one 1 length
        adda.l      d2,a0
        move.l      d3,d0
        
dlloop  tst.b       d0
        beq         dllen
        move.l      d4,(a0)+
        sub.l       #2,d0
        bne         dlloop
        
dllen   add.l       #1,d1
        move.l      #sb_w,d0
        lsl.l       #2,d0
        move.l      d3,d6
        lsl.l       #2,d6
        add.l       d2,d6
        sub.l       d6,d0
        adda.l      d0,a0
        bra         dld
        
dldispla add.l       d7,d5
        mulu        #sb_w*4,d5
        suba.l      d5,a0
        move.l      #sb_w,d6
        move.l      #sb_w*sb_h,d7       
        movem.l     (sp)+,d1-d7/a0
        rts



        INCLUDE     'io_util.x68'
        
        INCLUDE     'buffer.x68'
prmpt    dc.b   'enter 0 to terminate and 1 to invert',0

        END	        START	    ;End of program and entry









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
