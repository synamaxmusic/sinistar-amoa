;;      INCLUDE "../SAM/START.ASM"

;;      SUBTTL  UTILITY ROUTINES
TB13


;*
;*      STANDARD EQUATES
;*
OPPOS1  EQU     $47             ;HEIGHT OF OPERATOR MESSAGE LINE #1
OPPOS2  EQU     $3C             ;HEIGHT OF OPERATOR MESSAGE LINE #2

        PUSHORG ROMSAVE

        RADIX   10                                                      ;;Fixme: Moved RADIX 10 down past PUSHORG so it will override the RADIX 16 in the macro.
;*
;*      READ PIA2 INTO REG.A (CONVERT TO LEFT-RIGHT, UP-DOWN)
;*       BIT 0 = UP     STANDARD ROBOTRON,SPLAT,BUBBLES JOYSTICK FORMAT
;*       BIT 1 = DOWN
;*       BIT 2 = LEFT
;*       BIT 3 = RIGHT
;*       BIT 4 = FIRE
;*       BIT 5 = BOMB
;*
APIA2   PSHS    B
        LDA     PIA3    ;READ FIRE & SINI BOMB
        ANDA    #3      ;IN UPPER BITS 4 & 5
        ASLA
        ASLA
        ASLA
        ASLA
        LDB     PIA2    ;READ 7 POSITION JOYSTICK
        BITB    #$20    ;X DIRECTION, JOYSTICK CENTERED?
        BNE     .50S    ; BR=YES
        ORA     #%1000  ;ASSUME RIGHT DIRECTION
        BITB    #$80    ;TEST DIRECTION BIT
        BNE     .50S    ; BR=ASSUMPTION CORRECT
        EORA    #%1100  ;USE OTHER DIRECTION
.50S    BITB    #$02    ;Y DIRECTION, JOYSTICK CENTERED?
        BNE     .100S   ; BR=YES
        ORA     #%0001  ;ASSUME UP DIRECTION
        BITB    #$08    ;TEST DIRECTION BIT
        BNE     .100S   ; BR=ASSUMPTION CORRECT
        EORA    #%0011  ;USE OTHER DIRECTION
.100S   PULS    B,PC
;*
;* CMOS MOVE: DESTINATION=Y, SOURCE=X, COUNT=B
;*
CMOSMV  PSHS    A       ;NEED A
.1S     LDA     ,X+     ;GET SOURCE
        EXG     X,Y     ;SWAP
        JSR     WCMOSA  ;RITE IT
        EXG     X,Y     ;SWAP BACK
        DECB            ;DONE?
        BNE     .1S     ;NO,LOOP
        PULS    A,PC    ;RETURN CLEAN
;*
;* INIT CMOS: SAVES STATE
;*
CMINIS  PSHS    X,Y,D   ;SAVE STATE                     ;;Fixme was: CMINI$
        LDX     #DEFALT ;POINT TO ROM
        LDY     #CMOS   ;POINT TO DESTINATION
        LDB     #DEFSIZ ;LENGTH
        BSR     CMOSMV  ;MOVE THEM ALL
        PULS    X,Y,D,PC ;ALL DONE

;*
;*
;* DEFAULT HERE FOR NOW
;*
DEFALT  FCB     $30     ;FIRST EXTRA SHIP AT
        FCB     $30     ;ADDITIONAL POINTS PER EXTRA SHIP                       ;; This was originally $05 in SAM/DEFAULT.SRC.  Reducing this in the service menu will make it easier to get extra ships
        FCB     $03     ;SHIPS PER GAME
        FCB     $05     ;DIFFICULTY OF PLAY
        FCB     $01     ;CONTINUOUS FIRE
        FCB     $01     ;HIGH SCORE TO DATE ALLOWED
        FCB     $03     ;CSELCT
        FCB     $01     ;SLOT1M
        FCB     $04     ;SLOT2M
        FCB     $01     ;SLOT3M
        FCB     $01     ;CUNITC
        FCB     $00     ;CUNITB
        FCB     $00     ;MINUNT
        FCB     $00     ;FACTORY SETTINGS
        FCB     $00     ;CLEAR AUDIT TOTALS
        FCB     $00     ;CLEAR HSTD
        FCB     $00     ;AUTOCYCLE
;       FCB     $00     ;SET ATTRACT MODE MESSAGE                               ;; Not in AMOA
DEFSIZ  EQU     *-DEFALT

ADVSC   JSR     MAKCHK  ;DO THE CHECKSUM
        JSR     CLRSCR
.2S     LDA     PIA0
        BITA    #2
        BNE     .2S     ;WAIT FOR RELEASE
.3S     LDA     SPECFN+3 ;CLEAR AUDITS??
        ANDA    #$F
        BEQ     .4S
        CLR     SPECFN+3
        JSR     MAKCHK
        JSR     CLRSCR
        JSR     AUDCK4  ;CLEAR THE AUDIT TOTALS AND PRINT THE MESSAGE.
        LDA     #40
        JSR     NAPV
.4S     LDA     SPECFN+5 ;CHECK AUDIT MESSAGE
        ANDA    #$F
        BEQ     .6S     ;NOT THERE
        CLR     SPECFN+5
        BSR     MAKCHK
        BSR     RSHS    ;GO AND DO IT
;* * *  JSR     RSHSV   ;GO AND DO IT
        LDA     #$40
        JSR     NAPV
.6S     ;LDA    SPECFN+9 ;OPERATOR MESSAGE
;       ANDA    #$F     ;LOOK AT RELEVANCE
;       BEQ     .5S
;       CLR     SPECFN+9
;       BSR     MAKCHK
;* * *  JSR     CLRSCR  ;CLEAR THE SCREEN
;* * *  LDA     #TXSETA
;* * *  JSR     TEXT68  ;PRINT A PROMPTING MESSAGE
;       BSR     OPENT   ;GET THE OPERATOR MESSAGE
;* * *  LDA     $20
;* * *  JSR     NAPV
;* * *  JSR     OPCHK   ;FORM THE CHECK BYTE
;* * *  LDX     #OMESUM ;POINT
;* * *  JSR     WCMOSA  ;AND STORE IT.
;.5S
;* * *  LDA     SPECFN+11 ;ENTER GOD'S NAME??
;* * *  ANDA    #$F
;* * *  BEQ     8$
;* * *  CLR     SPECFN+11
;* * *  BSR     MAKCHK
;* * *  JSR     CLRSCR  ;CLEAR THE SCREEN
;* * *  LDA     #TXSETG
;* * *  JSR     TEXT68  ;PRINT A PROMPTING MESSAGE
;* * *  JSR     GODSET  ;GO AND DO IT
;* * *  JSR     MKGODC  ;MAKE GODS CHECK BYTE
;* * *8$
        LDA     SPECFN+7 ;AUTO CYCLE
        ANDA    #$F
        BEQ     .9S
        CLR     SPECFN+7
        BSR     MAKCHK
        BSR     FSCHK
        JMP     AUTOCY
.9S
        BSR     FSCHK
        BRA     CKCMOS

FSCHK   LDA     SPECFN+1
        ANDA    #$F     ;FACTORY SETTINGS??
        BEQ     .33S
        INC     ADJSUM
        INC     ADJSUM  ;BASH THE CHECK BYTE...THIS WILL RESTORE.
        CLR     SPECFN+1 ;AND UNDO IT
.33S    RTS

MAKCHK  PSHS    X,A
        BSR     FCHK    ;FIND THE NEW CHECKSUM.
        LDX     #ADJSUM
        JSR     WCMOSA
        PULS    X,A,PC

RSHS    NOP             ;reset high score table
        NOP
        RTS

;OPENT  NOP             ;operator message entry         ;; Missing in AMOA
;       NOP
;       RTS

FCHK    PSHS    B,X,Y
        LDX     #CMOS
        LDY     #ENDADJ
        BSR     FCHKS
        PULS    B,X,Y,PC

FCHKS   STY     XTEMP                                   ;;Fixme was: FCHK$
        CLRA
FCHK1   LDB     ,X+
        ANDB    #$F
        PSHS    B
        ADDA    ,S+
        CMPX    XTEMP
        BNE     FCHK1
        ADDA    #$37    ;FUDGE FACTOR
        RTS

CKADJ   BSR     FCHK
        PSHS    A
        LDX     #ADJSUM
        JSR     RCMOSA
        CMPA    ,S+
        RTS

CKCMOS
;* * *  BSR     OPTST   ;CHECK OPERATOR MESSAGE
        BSR     CKADJ   ;CHECK ADJ
        BEQ     .4S
        LDA     #WDATA
        STA     WDOG
        JSR     CMINIS                                  ;;Fixme was: CMINI$
        LDA     #WDATA
        STA     WDOG
        BSR     MAKCHK
        LDA     #WDATA
        STA     WDOG
        JSR     CLRSCR  ;CLEAR THE SCREEN
        LDA     #WDATA
        STA     WDOG
        BSR     AUDCHK  ;CHECK FOR FAULTY AUDITS
;* * *  JSR     CHKHSV  ;CHECK FOR FAULTY HIGH SCORES
;* * *  JSR     CKHSV   ;NOW VALIDATE
        BSR     CKADJ
        BEQ     .5S
        LDA     #TXIMES ;TELL THE OPERATOR WHAT IS GOING ON.
.1S     JSR     TEXT68
.2S     LDA     #WDATA
        STA     WDOG
        LDA     PIA0    ;CHECK
        BITA    #2
        BEQ     .2S     ;NOT PRESSED CONTINUE TO HANG
.3S     JMP     INITALL ;START HIM UP
.4S
;* * *  JSR     CKHSV   ;FIX UP THE HIGH SCORE AREA AND RETURN
        BRA     .3S
.5S     LDA     #TXREST
        BRA     .1S

AUDCHK  LDX     #SLOT1
        LDB     #4      ;FOUR BAD BYTES IN AUDIT AREA AFTER RESET IS ENOUGH.
.2S     LDA     ,X+     ;GET A BYTE
        ANDA    #$F
        CMPA    #9      ;HEX???
        BLS     .1S     ;NOPE
        DECB            ;ONE MORE
        BEQ     AUDCK4
.1S     CMPX    #ENDBOK+6 ;DONE??
        BNE     .2S
        RTS

AUDCK4  LDA     #TXBKRS
        JSR     TEXT68  ;PRINT IT
        LDX     #SLOT1
.5S     CLR     ,X+     ;AND CLEAR EM.
        CMPX    #ENDBOK+6
        BNE     .5S
        RTS

;*
;* CMOS PRIMITIVE FOR READING
;*
RCMOSA  LDA     1,X     ;GET LSB
        ANDA    #$0F    ;LEAVE ONLY LS
        PSHS    A       ;SAVE IT
        LDA     ,X++    ;GET MSB + AUTO INC
        ASLA
        ASLA
        ASLA
        ASLA            ;SHIFT LS TO MSB
        ADDA    ,S+     ;GET LSB + FIX STACK
        RTS             ;BYE
;*
;* READ CMOS INTO D POINTED TO BY X: A=X,X+1; B=X+2,X+3
;*
RCMOSD  BSR     RCMOSA  ;GET THE FIRST BYTE+FALL THRU FOR 2ND
;*
;* READ CMOS INTO B POINTED TO BY X
;*
RCMOSB  PSHS    A       ;SAVE A
        BSR     RCMOSA  ;GET IN A
        TFR     A,B     ;PUT IT IN B
        PULS    A,PC    ;DONE
;*
;* WRITE TO CMOS PRIMITIVE
;*
WCMOSA  PSHS    A       ;SAVE WHATS TO BE WRITTEN
        STA     1,X     ;SAVE LSB
        LSRA            ;SHIFT MS TO LS
        LSRA
        LSRA
        LSRA
        STA     ,X++    ;SAVE MSB AND AUTO INC
        PULS    A,PC    ;DONE
;*
;* WRITE CMOS FROM D TO X: A=X,X+1; B=X+2,X+3
;*
WCMOSD  BSR     WCMOSA  ;DO IT AND FALL THRU FOR 2ND
;*
;* WRITE CMOS FROM B TO X
;*
WCMOSB  PSHS    A       ;SAVE A
        TFR     B,A     ;MOVE B TO A
        BSR     WCMOSA  ;FAKE IT
        PULS    A,PC    ;DONE

;*
;* AUDIT: COUNT=A, COUNTER=B (1-7)
;*
AUD1S   PSHS    D,X     ;SAVE STATE                     ;;Fixme was: AUD1$
        LDA     #$01    ;BUMP BY COUNT OF 1
        BRA     AUD2
AUDS    PSHS    D,X     ;SAVE STATE                     ;;Fixme was: AUD$
AUD2    TST     AMDEMO  ;no audits in attract mode demo
        BNE     AUD3
        ANDB    #$0F    ;LIMIT TO 0-F
        ASLB            ;MAKE INTO 4X
        PSHS    B
        ASLB
        ADDB    ,S+     ;6X
        LDX     #CMOS-4+$100 ;POINT TO START-6  (CREDITS TAKES UP 2)
        ABX             ;GET THE CORRECT DESTINATION
        BSR     RCMOSB
        PSHS    B
        BSR     RCMOSB
        PSHS    B
        BSR     RCMOSB
        PSHS    B
        ADDA    ,S
        DAA
        STA     ,S
        LDA     1,S
        ADCA    #0
        DAA
        STA     1,S
        LDA     2,S
        ADCA    #0
        DAA
        LEAX    -6,X
        BSR     WCMOSA
        PULS    B
        PULS    A
        BSR     WCMOSD
        PULS    A
AUD3    PULS    D,X,PC  ;CLEAN UP
;*

;*
;*
;* ACRED: ADDS A CREDITS TO TOTAL CREDITS; 99 MAX
;*
ACRED   PSHS    A,X     ;SAVE
        ADDA    CREDIT  ;GET PRESENT
        DAA             ;HUMANIZE
        BCC     .1S     ;NO OVERFLOW
        LDA     #$99    ;YES, STAY AT 99
.1S     STA     CREDIT  ;SAVE NEW COUNT
        LDX     #CREDST ;BACKUP CREDITS
        JSR     WCMOSA
        LDX     #$106D  ;erase credit display without dma
        LDA     #2
.2S     LDB     #$26
.3S     CLR     D,X
        DECB
        BPL     .3S
        DECA
        BPL     .2S
        PULS    X,A,PC  ;GO BACK CLEAN
;*
;* COIN SLOT ROUTINES
;*
COINR   PSHS    D,X     ;SAVE STATE
        LDB     #$03    ;3RD TOTALS(RIGHT COIN)
        BRA     COINS   ;HANDLE BELOW                   ;;Fixme was: COIN$
COINC   PSHS    D,X     ;SAVE STATE
        LDB     #$02    ;2ND TOTALS(CENTER COIN)
        BRA     COINS   ;HANDLE BELOW
COINL   PSHS    D,X     ;SAVE STATE
        LDB     #$01    ;1ST TOTALS(LEFT COIN)
        ROUTINE COINS
        LDA     AMDEMO  ;save attract mode demo flag
        PSHS    A
        CLR     AMDEMO  ;flag as not in attract mode demo so audits get recorded
        TUNE    QCOIN   ;say "I hunger!"
        JSR     AUD1S   ;BUMP COUNT BY 1                ;;Fixme was: AUD1$
        ASLB    ;DOUBLE FOR CMOS
        LDX     #SLOT1M-2 ;POINT TO START-2
        ABX             ;REMOVE OFFSET
        JSR     RCMOSB  ;GET CORRECT SLOT X
        BSR     BCDHEX  ;CONVERT TO BINARY
        LDA     BUNITS  ;GET PRESENT BONUS UNITS
        PSHS    B       ;AND ADD PRESENT COUNT TO IT
        ADDA    ,S
        STA     BUNITS  ;UPDATE
        LDA     CUNITS
        ADDA    ,S+     ;GET PRESENT
        STA     CUNITS  ;UPDATE
        LDX     #MINUNT ;GET MINIMUM UNITS
        JSR     RCMOSB  ;FROM CMOS
        BSR     BCDHEX  ;WORK IN BINARY
        PSHS    B       ;FOR CBA
        CMPA    ,S+     ;ENOUGH?
        BCS     .2S     ;YES, GIVE IT
        LDX     #CUNITC ;HOW MANY?
        JSR     RCMOSB  ;GET IT
        BSR     BCDHEX  ;CONVERT TO HEX
        BSR     DIVAB   ;SAVE REMAINDER IN B
        PSHS    A       ;SAVE COUNT TO BE AWARDED FOR A WHILE
        STB     CUNITS  ;SAVE REMAINDER
        LDX     #CUNITB ;BONUS REQUIRES HOW MANY?
        JSR     RCMOSB  ;IN B
        LDA     BUNITS  ;GET BONUS SO FAR
        BSR     BCDHEX  ;CONVERT TO BINARY
        BSR     DIVAB   ;DIVIDE
        TSTA            ;ANY YET?
        BEQ     .1S     ;NO
        CLR     CUNITS  ;YES, RESET ANY EXTRA
        CLR     BUNITS
.1S     ADDA    ,S+     ;GET OTHER CREDITS EARNED
        DAA             ;HUMANIZE
        LDB     #$04    ;BUMP TOTPDC
        JSR     AUDS    ;BY THE COUNT PAID FOR          ;;Fixme was: AUD$
        JSR     ACRED   ;ADD TO CREDITS COUNTER
.2S     PULS    A       ;restore attract mode demo flag
        STA     AMDEMO
        PULS    D,X,PC  ;CLEAN + GO
;*
;* DIVAB: A/B, REMAINDER IN B
;*
DIVAB   PSHS    B       ;SAVE
        TSTB            ;ANY?
        BNE     .1S     ;YES, HANDLE
        CLRA            ;NO, SET TO 0
        PULS    B,PC    ;CLEAN RETURN
.1S     EXG     A,B     ;FOR DAA
        LDA     #$99    ;START-1
.2S     ADDA    #$01    ;NEXT
        DAA             ;HUMANIZE
        SUBB    ,S      ;TAKE AWAY N
        BCC     .2S     ;LOOP TILL OVERFLOW
        ADDB    ,S+     ;ADD REMAINDER + FIX STACK
        RTS             ;BTE

;*
;*BCD-HEX CONVERT
;*A=BCD-HEX
BCDHEX  PSHS    A
        CLRA
.1S     CMPB    #$10
        BLO     .2S
        ADDA    #10
        SUBB    #$10
        BRA     .1S
.2S     PSHS    B
        ADDA    ,S+
        TFR     A,B
        PULS    A,PC
;*
;*HEX-BCD CONVERT
;*A=HEX-BCD
HEXBCD  PSHS    B
        TFR     A,B
        CLRA
.1S     CMPB    #10
        BLO     .2S
        ADDA    #$10
        DAA
        SUBB    #10
        BRA     .1S
.2S     PSHS    B
        ADDA    ,S+
        DAA
        PULS    B,PC
;*
;* * *
        RADIX   16
;* * *  END
        PULLORG ROMSAVE