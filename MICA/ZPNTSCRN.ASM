

        PUSHORG ROMSAVE

        ROUTINE PNTSCRN
;******************************************************************************
;* PNTSCRN
;*   clears out the system, sets up the information tasks, restarts the system

        JSR     SYSTINI
        NEW_SLEEP       TASK1,.PN255S,OTIMER
        NEW_SLEEP       TASK1,NATMSG,OMTLEN+1   ;NATMSG
        NEW_SLEEP       TASK1,CDTask,OMTLEN+1   ;DCREDITS
        JMP     STARTS


.PN255S PSHS    Y                                                               ;;Fixme was: 255$       PSHS    Y

        LDA     #%00110011      ;Allow Player 1/2, Fire and Sinibomb buttons
        STA     PANMASK

        JSR     CLRSCR

        LDA     PMEMCTL         ;Turn off DMA-inhibit
        PSHS    A
        ANDA    #~$4                                                            ;;Fixme was: ANDA       #!N4
        STA     PMEMCTL
        STA     MEMCTL

        LDX     #PNTIMT         ;Image Addresses Table
        LDY     #PNTSCT         ;Screen Position Table

.PNTS1S LDU     ,X++            ;Get next image address                         ;;Fixme was: 1$ LDU     ,X++
        BEQ     .PN100S         ;Done when zero
        LDD     ,U++            ;Get size
        EORA    #4
        EORB    #4
        STD     $CA06
        LDD     ,U++            ;Get image data address
        STD     $CA02
        LDD     ,Y++            ;Get screen location
        STD     $CA04
        LDA     #$0E
        STA     $CA00
        BRA     .PNTS1S


.PN100S TEXT    $80,$60                                                         ;;Fixme was: 100$       TEXT    $80,$60
        PHRASE  PINK,35,PLANETOIDS
        WORD    BLUE,35,5
        WORD    SILVER,35,POINTS
        TEXT    $72,$60
        PHRASE  PINK,35,WORKER
        WORD    BLUE,35,150
        WORD    SILVER,35,POINTS
        TEXT    $64,$60
        PHRASE  PINK,35,CRYSTALS                                                ;;Fixme was: PHRASE     PINK,35,CRYSTAL
        WORD    BLUE,35,200
        WORD    SILVER,35,POINTS
        TEXT    $56,$60
        PHRASE  PINK,35,WARRIOR
        WORD    BLUE,35,500
        WORD    SILVER,35,POINTS
        TEXT    $48,$60
        PHRASE  PINK,35,SINISTAR,PIECES                                         ;;Fixme was: PHRASE     PINK,35,SINISTAR,PIECE
        WORD    BLUE,35,500
        WORD    SILVER,35,POINTS
        TEXT    $37,$3E
        PHRASE  RED,68,DESTROY,THE,SINISTAR
        TEXT    $31,$59
        PHRASE  BLUE,68,15000
        WORD    SILVER,68,POINTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ROMSAVE SET     *               ;; Save the current address

        ORG     PHRSAV          ;; Jump over to PHRSAV to save our pointers

        FDB     _5
        FDB     _POINTS
        FDB     _150
        FDB     _200
        FDB     _500
        FDB     _15000


PHRSAV  SET     *               ;; Mark the new address for PHRSAV to add
                                ;; more phrases later

        ORG     ROMSAVE         ;; Back to our regularly scheduled programming...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        PULS    A,Y             ;Fetch DMA inhibit and workspace pointer
        STA     PMEMCTL         ;Restore DMA
        STA     MEMCTL

        RADIX   10                                                              ;;(decimal value ahead)
        LDD     #(60*7)                                                         ;;Fixme was: LDD        #(60.*7.)
        RADIX   16                                                              ;;(back to hex)
        JSR     TIMER
        JMP     IAMODE


PNTIMT  FDB     IPLAN2,IWORKER
        FDB     ICRYSTAL,IWARRIOR,IBARREL,S1L                                   ;;Patched over in BOBFIXES ($8E15) "THIS TINY LITTLE PATCH changes the Crystal Image from the yucky yellow"
        FDB     0
PNTSCT  FDB     $7C3A,$7140
        FDB     $6544,$543D,$5945,$473E

IBARREL FDB     $0201,.1S
.1S     FCB     $42,$20                                                         ;;Fixme was: 1$         FCB     $42,$20

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  The following is a list of patches that appear in AMOA but were later
;;  moved to their final location.

AMOASiniInhibit
        LDD     FINISH
        CMPD    #ALIVE
        BNE     .1S
        RTS

.1S     JSR     Sinhibit
        JMP     LSSINI+3

AMOASiniOrbit
        NOP
                                        ;; The following code was later moved to WITT/SINI.ASM
.100S   lda     OSPERS,Y
        anda    #PSiniInhibit
        beq     .102S
        ldb     SiniOrbit               ;* Set orbital directon.
        cmpa    #MaxSinOrbit
        ble     .101S
        lda     #MaxSinOrbit
.101S   jsr     getlodistance
        ldx     #StblOSini
        rts
.102S   jsr     getldistance
        ldx     #STblSinistar                                                           ;;Fixme was: ldx  #STblSini
        rts

AMOASiniOrbit2
        NOP

.200S   lda     OSPERS,Y
        anda    #PSiniInhibit
        beq     .202S
        ldb     SiniOrbit
        cmpa    #MaxSinOrbit
        ble     .201S
        lda     #MaxSinOrbit
.201S   jsr     getsodistance
        ldx     #StblOSini
        rts
.202S   jsr     getsdistance
        ldx     #STblSinistar
        rts

AMOAIRSini
;*                                      ;; The following code was later moved to FALS/N1ALL.ASM
;*                              This section from RICH
        RANDOM  OSEED1,BYTE
        anda    #~(PSiniInhibit)
        ora     #MaxSinOrbit
        sta     OSPERS,X
;*
;*
        jsr     Vibzer                  ;* Zero out its vibration block
        rts

;***
;*      Update the scanner velocity (short)
;***
AMOAUpdateScanVEL                       ;; This section later appears in WITT/VELOCITY.ASM
        tstb                    ;* Only round up if B is positive
        bmi     .3S             ;*   else, round down.
        orb     #1              ;* < Patched over >
.4S     addb    0,Y             ;* < Patched over >
        RTS
                                        ;; This ANDB instruction shows up in WITT/WARRON.ASM
.3S     andb    #%11111110      ;*   (only even number missions allowed
        BRA     .4S

;* Bomb Sinistar
AMOASiniStun                            ;; This section later appears in WITT/COLLISIO.ASM
        lda     InStun          ;* Accumulate
        adda    #2              ;*   more time that
        sta     InStun          ;*   the Sinistar is stunned.

                                        ;; This instruction comes from WITT/WARRON.ASM
        jmp     VScrOn          ;* Perform the remaining screen on jobs.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        PULLORG ROMSAVE