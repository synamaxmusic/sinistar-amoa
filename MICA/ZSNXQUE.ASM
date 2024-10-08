
;       INCLUDE [SAM]START
;       INCLVER SAM,SINISTAR

        PUSHORG ROMSAVE

        ROUTINE SNXQUE                          ;; Sam references this label in AMOA

        ROUTINE KABOOM
;*****************************************************************************
;*
;* SINISTAR EXPLOSION TASK QUEUER
;*
;* ENTRY: X points to SINISTAR image descriptor

        PSHS    D,X,Y,U

        RADIX   10                                                              ;;(Got some decimal values ahead)

        SPEAK   9               ;Kill Sinispeech (roar queued elsewhere)        ;;Fixme was: SPEAK  9.


;* fixes SNXQUE by hooking it into SUBPART(KABOOM) instead of SUBPIECE,
;*  sets sinistar out of sector flag to prevent multiple KRSINI's
;*  and disables player death during BOBS explosion

        LDA     #-1             ;flag sinistar as out of sector
        STA     SINISECTOR
        INC     DEATHFLAG       ;disable player death
        jsr     IniSini         ;* To clean out the SiniStar image


;       NEW_SLEEP TASK4,SNXTSK,OMTLEN+1  ;Awaken the Sinistar explosion task
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        NEW_SLEEP TASK4,SNXTSK,OMTLEN+2  ;Awaken the Sinistar explosion task
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        RANDOM  OSEED1,8,0      ;Get a random value from 0 to 7
        LDY     #SININT         ;Y <- address of the explosion increments table
        LDB     A,Y             ;Get this increment
        STB     OMTLEN,X        ;  and save into the task workspace

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        LDB     #$0F            ;Get one selection of background color
        STB     5,X
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        NEW_SLEEP       TASK4,SNXBFT,OMTLEN+1   ;Make Flasher Task
        LDA     #(60*3)/4                       ;Let live for 2 seconds         ;;Fixme was: LDA  #(60.*3)/4
        STA     OMTLEN,X


        NEW_SLEEP       TASK2,SNXWBM,OMTLEN+1   ;Make Warrior Boom Task
        LDA     #14                             ;Have it make n booms           ;;Fixme was: LDA  #14.
        STA     OMTLEN,X

;       TST     PLAGRAVE        ;Test if player is dead already
;       BEQ     .4S             ;  and branch if not
;       INC     PLUWPF          ;  else set warp flag
;
;.4S    JSR     KRSINI          ;Do KRSINI here

        PULS    D,X,Y,U,PC      ;That's all for now, folks

        RADIX   16                                                              ;;(back to hex)

;******************************************************************************
;* This is the Sinistar Explosion Background Flash Task
SNXBFT  ;TST    INIMPULSE       ;If we're still InImpulse
;       BNE     .1S             ;  then go flash one more time
        LDA     OMTLEN,Y        ;Decrement Alive Counter
        DECA
        LBEQ    DIE             ;  and DIE when done
        STA     OMTLEN,Y
.1S     LDB     #$3F            ;Get one selection of background color (yellow)
        ASRA                    ;  and
        BCC     .2S             ;  every second time
        LDB     #$07            ;  use the other selection (red)
.2S     STB     PCRAM           ;Flash the background
        SLEEP   LOOP            ;Wait for another opportunity to serve

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SNXWBM  DEC     OMTLEN,Y        ;COUNTDOWN
        LBEQ    DIE
        LDX     [SININDEX]      ;Get Sinistar scanner WS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;******************************************************************************
;* This is the Warrior Booms task
;SNXWBM LDX     [SININDEX]      ;Get Sinistar scanner WS                        ;;Fixme was: LDX  [SININD]
        LDX     OSSCWSA,X       ;Get screen workspace address
        BEQ     .3S             ;If zero then not onscreen, so do wait

        LDD     OBOTTOM,X       ;Temporarily adjust
        PSHS    D               ;  the screen location.  Save it first,
        ADDD    #$0A12          ;  then add an offset
        STD     OBOTTOM,X       ;  to center the explosions better
        JSR     WRXQUE          ;Go queue up a warrior explosion
        PULS    D               ;Restore the original location
        STD     OBOTTOM,X

;       DEC     OMTLEN,Y        ;COUNTDOWN
;       LBEQ    DIE

.3S     SLEEP   LOOP



;******************************************************************************
SININT  FCB     $00,$FF,$DE,$EF,$22,$11,$CD,$BC


        PULLORG ROMSAVE