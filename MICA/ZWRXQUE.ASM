;       INCLUDE [SAM]START
;       INCLVER SAM,SINISTAR

        PUSHORG ROMSAVE

;*******************************************************************************
;*
;* WARRIOR EXPLODING-FRAGMENTS TASK QUEUER
;*
;* Entry: X points to the WARRIOR ship object workspace
        ROUTINE WRXQUE

        PSHS    D,X,Y,U

        LDD     FREE            ;Test for enough free memory for the task
        CMPD    #2*(OWXRRQ+ODYNOVH)     ;and
        BLT     WRXXIT          ;       exit without creating the task if not

        TFR     X,U             ;U <- pointer to Image Descriptor
        NEW_SLEEP TASK2,WRXTSK,OWXRRQ   ;Create the WARRIOR explosion task

        CLR     OWXALV,X        ;Clear the WARRIORX turns-alive counter
        LDA     #WRXICT
        STA     OWXPCK,X

        LEAY    OWXOTB,X        ;Y <- address of the fragments table

        LDD     SSVEL
        ADDD    OSVEL,U
        LSLB
        ROLA
        PSHS    A

        LDD     SLVEL
        ADDD    OLVEL,U
        LSLB
        ROLA
        PSHS    A

;*      LDA     OLVEL,U         ;Get LONG/SHORT velocity of warrior
;*      LDB     OSVEL,U         ;  and
;*      PSHS    D               ;  save on stack

        LDD     OBOTTOM,U       ;D <- screen position of the WARRIOR ship
        PSHS    D               ;Save on stack

        LDA     #WRXPCT         ;Get the total number of fragments to create
        PSHS    A               ;  and save this on the stack

;* This loop picks at random the velocity vector and starting position
;*   displacement for each fragment
        RADIX   10
WRXPLP  RANDOM  OSEED2,15,-7    ;Random SHORT velocity of -7 to 7               ;;Fixme was: WRXPLP     RANDOM  OSEED2,15.,-7
        RADIX   16
        PSHS    A
        RANDOM  OSEED1,7,-3     ;Random LONG velocity of -3 to 3
        PULS    B               ;Restore SHORT velocity
        ADDA    3,S
        ADDB    4,S
        STD     OWXPMM,Y        ;Save it into this table entry
        BEQ     WRXPLP          ;If momentum is zero, try again

        RANDOM  OSEED1,4        ;Now, get a SHORT position offset
        ASLA                    ;Multiply by 2
        PSHS    A
        RANDOM  OSEED2,4        ;Get the LONG offset
        PULS    B               ;Restore short
        ADDD    1,S             ;Add the screen position
        STD     OWXPSP,Y        ;Save this fragment's screen position

        LEAY    OWXPSZ,Y        ;Advance Y to the next entry

        DEC     ,S              ;Decrement the fragment count
        BNE     WRXPLP          ;While not zero set up another fragment

        LEAS    5,S             ;Else reset stack

WRXXIT  PULS    D,X,Y,U,PC      ;   and split



        PULLORG ROMSAVE