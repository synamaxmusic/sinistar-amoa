
;       INCLUDE [SAM]START
;       INCLVER SAM,SINISTAR.EQU

        PUSHORG ROMSAVE

;******************************************************************************
;*
;* PLAYER EXPLOSION TASK
;*
;* Entry: Y points to task workspace

PLXTSK  LDA     OPXPCK,Y        ;A <- the image pick value
        INCA                    ;Else get index to next image
        ANDA    #PXPWVS-1       ;(Wrap around to zero if necessary)
        STA     OPXPCK,Y        ;Save new index

.10S    ASLA                    ;Turn index into word index
        LDX     #PLXITB         ;Get the address of the image addresses tables
        LDX     A,X             ;X <- address of the image
        STX     DSOUR           ;Save this to the DMA for the draw-loop below
        LDD     #PLXISZ         ;Get the constant size of the image
        EORA    #4              ;  and set it up for
        EORB    #4              ;  the screwy DMA output
        STD     DHIGH           ;  (Why did they do this to us?)

        LDB     OPXALV,Y        ;Get number of turns this task has been awake
        ASRB                    ;  to select how many of the piece-waves to move
        INCB                    ;  Start a new wave every second turn,
        CMPB    #PXPWVS         ;  don't let the number of waves exceed the
        BLE     .20S            ;  maximum number of waves created
        LDB     #PXPWVS         ;  If greater then set to the maximum
.20S    LDA     #PXPPCT         ;Get the piece-per-wave count
        MUL                     ;Multiply to get the total number of pieces to
        PSHS    B               ;  move and then save this number on the stack

        LEAX    OPXOTB,Y        ;X <- address of the first entry in the
;*                                   task object table

.30S    LDA     ,S
        CMPA    #PXPPCT*PXPWVS/2
        BNE     .31S
        LDA     OPXALV,Y
        ANDA    #4
        LSRA
        NOP
        LDU     #PXPALT
        LDU     A,U
        STU     DSOUR
.31S    LDD     OPXPSP,X        ;Get the screen position for this fragment
        BEQ     .50S            ;If zero then this fragment is off-screen
        STD     DDEST           ;Else write this destination to the DMA
        CLR     DCONS           ;Clear the DMA Constant for a zero write
        LDA     #$12            ;DMA
        STA     DCTRL           ;  away!

        LDA     OPXPSP,X        ;Restore the top half of the screen position
        ADDD    OPXPMM,X        ;Mix in the momentum of this fragment
        CMPA    #SCRNLH-2       ;Stir gently, abandon all hope if off-screen
        BHI     .40S
        CMPB    #SCRNSH
        BHI     .40S

        STD     OPXPSP,X        ;Now D has the new screen position.  Save it to
        STD     DDEST           ;  both the task workspace and the DMA
        LDA     #$0E            ;Now draw this next fragment
        STA     DCTRL
        BRA     .50S            ;Go do next

.40S    CLR     OPXPSP,X        ;Mark this fragment as
        CLR     OPXPSP+1,X      ;  off-screen

.50S    LEAX    OPXPSZ,X        ;Advance X to point to next fragment entry
        DEC     ,S              ;Decrement the number of pieces we want to move
        BNE     .30S            ;  and go do another if there's more to do

        LEAS    1,S             ;Clean up stack

        INC     OPXALV,Y        ;Increment how many turns these fragments have
        LBMI    DIE             ;  been moving and while less than 128 continue
;*                                 else go die now

.60S    SLEEP   LOOP            ;Go back to sleep, wake again at top of routine


PLXITB  FDB     PLXIM0,PLXIM1,PLXIM2,PLXIM3     ;Addresses of the images

PLXIM0  FCB     $00,$00         ;Image 0
        FCB     $0C,$00
        FCB     $00,$00

PLXIM1  FCB     $C0,$C0         ;Image 1
        FCB     $0F,$00
        FCB     $C0,$C0

PLXIM2  FCB     $0F,$00         ;Image 2
        FCB     $F6,$F0
        FCB     $0F,$00

PLXIM3  FCB     $60,$60         ;Image 3
        FCB     $0B,$00
        FCB     $60,$60

PXPALT  FDB     PXPAL0,PXPAL1

PXPAL0  FCB     $00,00
        FCB     $0F,00
        FCB     $00,00

PXPAL1  FCB     $00,00
        FCB     $0D,00
        FCB     $00,00

;******************************************************************************
;*
;* PLAYER EXTRA-EXPLOSION TASK
;*   This is the Player Explosion Extra Effects Task
;*
;* Entry: Y points to task workspace

;PLEXTRA        LDX     #WPLAYER        ;Get pointer to player workspace
;       LDX     OBOTTOM,X       ;  and get screen address of player
;       LEAX    $102,X
;       LDA     #PLEXWCT        ;Get wave count (for looping)
;       PSHS    A,X             ;Save these on the stack
;
;       LEAX    OPEXWSP,Y       ;Get pointer to workspace of first piece
;
;
;.5S    LDA     #2              ;Loop on A
;.10S   DECA                    ;  for values 1,0,-1
;
;       LDB     #6              ;Loop on B
;.20S   SUBB    #3              ;  for values 3,0,-3
;
;       PSHS    D               ;Save this offset
;       ADDD    3,S             ;Add it to the screen position
;       STD     OPEXPOS,X       ;Save as this piece's starting position
;
;       RANDOM  OSEED1,8        ;Get random LONG velocity from 0 to 3           ;;Fixme was: RANDOM     OSEED1,8.
;       ASRA
;       BCC     .25S
;       NEGA
;.25S   STA     OPEXVEL,X
;
;       RADIX   10
;       RANDOM  OSEED2,12       ;Get random SHORT velocity from 0 to 5          ;;Fixme was: RANDOM     OSEED2,12.
;       RADIX   16
;       ASRA
;       BCC     .26S
;       NEGA
;.26S   STA     OPEXVEL+1,X
;
;       LEAX    4,X             ;Advance X to next workspace
;
;       PULS    D               ;Restore offset
;       TSTB                    ;Has B bottomed out yet?
;       BPL     .20S
;       TSTA                    ;Has A bottomed out yet?
;       BPL     .10S
;
;       DEC     ,S              ;Loop on waves
;       BNE     .5S
;       LEAS    3,S
;
;       LDA     #PLEXTMR        ;Get count for drawing the pieces
;       STA     OPEXCTR,Y
;
;       SLEEP   HERE
;
;;* The remainder of this task draws the pieces
;;      LOCAL
;
;       DEC     OPEXCTR,Y       ;Countdown
;       BPL     .11S            ;  and stay alive until less than zero          ;;Fixme was: BPL  10$
;       JSR     PCLRSCR         ;  else clear the screen
;       JMP     DIE             ;  and Die
;
;.11S   LDD     #$0505          ;Get image size (1 by 1) EOR-ed for DMA fix     ;;Fixme was: 10$  LDD   #$0505
;       STD     $CA06           ;  and write it to DMA control
;
;       LDD     #PLEXIMG        ;Get pointer to image
;       STD     $CA02           ;  and write it to DMA control
;
;       LDA     OPEXCTR,Y       ;Fetch the timer value for use as offset into
;       ASRA                    ;  Special Effects color table.  Divide by 2 to
;       LDU     #PLEXEE         ;  use each entry twice.  Get the color from
;       LDA     A,U             ;  the table and save it to the PCRAM location
;       STA     PCRAM+$7
;
;       LDX     #PLEXWSZ*PLEXWCT        ;Get total pieces to move
;
;       LEAU    OPEXWSP,Y       ;Get pointer to first piece's workspace
;
;.30S   LDD     OPEXPOS,U       ;Get position of this piece
;       ADDD    OPEXVEL,U       ;Add the velocity
;       TSTA
;       BMI     .40S            ;  and skip when offscreen in LONG direction
;       CMPB    #$F0            ;  and skip when we're about to wrap around
;       BHI     .40S
;       STD     OPEXPOS,U       ;Save as new position
;       STD     $CA04           ;Write it to DMA control
;
;       LDA     #$0E            ;Get write byte
;       STA     $CA00           ;  and draw this dot!
;
;.40S   LEAU    4,U             ;Advance to next piece workspace
;       LEAX    -1,X
;       BNE     .30S            ;  and loop until done
;
;       SLEEP   LOOP            ;Sleep
;
;;* This is the one-byte image of the dot, specifying color 7
;PLEXIMG        FCB     $70
;
;;* Table of colors for special effect color 7
;;*              bbgggrrr       Color bits
;PLEXEE FCB     %00000000
;       FCB     %01001000
;       FCB     %10010001
;       FCB     %11001010
;       FCB     %10000100
;       FCB     %01000110
;       FCB     %00000111
;       FCB     %00010111
;       FCB     %01100111
;       FCB     %10101111
;       FCB     %11111111
;       FCB     %11111111



        PULLORG ROMSAVE