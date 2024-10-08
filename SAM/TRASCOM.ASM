;;      INCLUDE "../SAM/START.ASM"

        PUSHORG ROMSAVE

;;      SUBTTL  DYNAMIC STORAGE 'TRASH COMPACTING' ROUTINES

;* special trash compact after process or collision
SPTRASH STX     TEMP            ;save X for collision > uses A,B,U
        BSR     TRASCOM         ;trash compact storage  save none, uses A,B,X,U
        LDX     TEMP            ;restore X for collision
        LDU     SAVSTK          ;get where stack was pointing
        CLRD                    ;zero stack save
        STD     SAVSTK
        JMP     U               ;go to where you belong

;* trash compact one block or more if low
TRASCOM LDX     TRASBUB         ;get trash compactor bubble  > uses A,B,X,U
        CMPX    #DYNEND         ;is trash compactor off?
        BLO     .1S
        LDX     LDEAL           ;yes?, get lowest trash block
        CMPX    #DYNEND         ;is there new trash?
        BHS     .6S
        LEAX    -ODYNOVH,X      ;yes?, point to start of trash block
        STX     TRASBUB         ;set trash compactor bubble
        LDD     X               ;get size of new trash
        LEAU    D,X             ;compute end of trash bubble
        STU     TRASEND         ;save end of trash bubble
        ADDD    FREE            ;add to free space
        STD     FREE
        LDA     #-1             ;set lowest de-allocated block to high address
        STA     LDEAL
.1S     STX     DDEST           ;set dma destination
        LDU     TRASEND         ;no?, get end of trash bubble
.2S     CMPU    HIGHBUB         ;finished compacting?
        BHS     .3S
        LDA     OINDEX+ODYNOVH,U ;is next block de-allocated?
        BNE     .4S
        LDD     U               ;yes?, get size of de-allocated block
        LEAU    D,U             ;skip to next one
        ADDD    FREE            ;add to free space
        STD     FREE
        BRA     .2S
.3S     STX     HIGHBUB         ;save new high bubble
        LDD     #DYNEND         ;turn off trash compactor
        STD     TRASBUB
        BRA     .6S
.4S     STU     DSOUR           ;set dma source
        LDD     TRASBUB         ;compute new workspace address
        ADDD    #ODYNOVH
        STD     [OINDEX+ODYNOVH,U] ;change index for moving workspace
        LDD     U               ;get size of block to move
        LEAX    D,X             ;advance trash compactor bubble
        STX     TRASBUB
        LEAU    D,U             ;advance trash compactor bubble end
        STU     TRASEND
        TSTA                    ;too much for dma? TEMPORARY
        BEQ     .5S
        SWI                     ;TEMPORARY TRAP
.5S     LDA     #1!4            ;* * * TEMPORARY FOR DMA BUG                    ;;Fixme was: LDA  #1!X4
        EORB    #4              ;* * * TEMPORARY FOR DMA BUG
        STD     DHIGH
        LDA     PMEMCTL         ;write inhibit off
        PSHS    A
        ANDA    #~$4                                                            ;;Fixme was: ANDA #!N4
        STA     PMEMCTL
        STA     MEMCTL
        LDB     #DSCY           ;move data
        STB     DCTRL
        PULS    A               ;write inhibit on
        STA     PMEMCTL
        STA     MEMCTL
.6S     LDA     FREE            ;need more space?
        BPL     .7S
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                ;; AMOA edit
        LDA     #$3F
        STA     PCRAM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        LDX     LDEAL           ;yes?, get lowest trash block
        CMPX    #DYNEND         ;is there new trash?
        LBLO    TRASCOM
        SWI                     ;* * *TEMPORARY TRAP out of dynamic storage ram
.7S     RTS

        PULLORG ROMSAVE