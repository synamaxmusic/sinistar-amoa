;       SUBTTL  INIRICH - Initialization routines for RICH
;       PAGE
;       INCLVER RICH,table              * ORG Macro
;;      INCLUDE "../SAM/START.ASM"

;===============================================================================
; EQUs to remove later
;AniSC  EQU     $5433   ;ANISINI
;Copyright EQU  $5956
;DISPE  EQU     $55A0
;ERASE  EQU     $55D4
;ANISCF EQU     $5550   ;ANISINI
;ADDBOMB        EQU     $567E   ;COLLISIO
;AMSINI EQU     $6C59   ;STUBS
;DEATH  EQU     $5832   ;DEATH
;EMPTY  EQU     $52F5
;===============================================================================

        PUSHORG ROMSAVE
;*****
;*
;* ExeVect .....        Hooks routine to occur every frame
;* GamVect .....        Hooks routine to occur every game start
;* IAMVect .....        Hooks routine to occur attract mode start
;* IniVect .....        Hooks routine to occur every player ship start
;* PlaVect .....        Hooks routine to occur every player-up start (once/game/player)
;* PowVect .....        Hooks routine to occur every machine power-up start
;*
;*****
;       SUBTTL  EXEVECT - Routines occuring each frame.
;*****
;*      EEEEE  X   X  EEEEE  V   V  EEEEE   CCCC  TTTTT
;*      E       X X   E      V   V  E      C        T
;*      EEEE     X    EEEE   V   V  EEEE   C        T
;*      E       X X   E       V V   E      C        T
;*      EEEEE  X   X  EEEEE    V    EEEEE   CCCC    T
;*****
        VECTOR  ExeVect         ;* On each frame of animation
        jsr     AniSC           ;* Animate Sinistar for speech calls
        rts
;***
;*      The characteristics descriptor of the sinibomb will find the
;*      current image descriptor pointing at the RAM area for an image.
;***
        PUSHORG CSBomb+OFiDesc
        fdb     RISBomb+1+2     ;* First Image Descriptor
        PULLORG

;*****
;*
;* VECTOR EXEVECT
;*      Every frame.
;*
;*      The sinibomb animation is handled by the executive as follows:
;*      A pointer to the "current" image descriptor is updated in RAM.
;*      Also, the first part of the image descriptor is updated (the second
;*      half remains constant in each descriptor) to point to the new image.
;*
;* Returns:
;*      U,X,Y destroyed
;*
;*****
        VECTOR  ExeVect         ;* On each frame of animation.
        tst     InBombs         ;* If there bombs to animate
        bne     .2S             ;*   then animate them.
        rts                     ;* Else, do nothing.
.2S     ldx     #RISBomb        ;* X -> RAM image information block
;***
;* The animation will change every other frame
;***
        inc     ,X+             ;* The first RISBomb byte is a switch set to
        ble     .1S             ;*   -1 (increments to 0) for the animation to
        clr     -1,X            ;*   change images, next time the 0 increments
        dec     -1,X            ;*   to 1 and the image is not changed, then the
        rts                     ;*   switch is reset to the -1 state.

.1S     ldy     0,X             ;* Y -> "current" image descriptor
        leay    OILen,Y         ;* Y -> "next" image descriptor
        cmpy    #(ISBomb+(NISBomb*OILen))
        blt     IEVBomb         ;* If there is one, then use that new image.
        ldy     #ISBomb         ;* Else, Y -> the "first" image descriptor
IEVBomb sty     ,X++            ;* Save the new image pointer and descriptor.
        leax    8,X             ;* X -> RAM image area
        ldy     2,Y             ;* Y -> "new" image to be copied
        ldb     #(3*5)
.1S     lda     ,Y+
        sta     ,X+
        decb
        bgt     .1S
        rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        VECTOR  ExeVect
AMOAINI
        RTS

        TST     $8504           ;; uh, what? (is this supposed to be $9896, AMDemo?)
        BEQ     .2S
        LDA     RAPTIME         ;; Similar code would ultimately end up in WITT/BUTTON.SRC
        BEQ     .2S
        DEC     RAPTIME
        BNE     .2S
        JSR     PLSHOOT
        LDA     RAPRATE
        CMPA    #$0A
        BCC     .1S
        ADDA    #$00
        STA     RAPRATE
.1S     STA     RAPTIME
.2S     RTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;       SUBTTL  GAMVECT - Routines occuring each game start.
;*****
;*       GGGG   AAA   M   M  V   V  EEEEE   CCCC  TTTTT
;*      G      A   A  MM MM  V   V  E      C        T
;*      G GGG  AAAAA  M M M  V   V  EEEE   C        T
;*      G   G  A   A  M   M   V V   E      C        T
;*       GGG   A   A  M   M    V    EEEEE   CCCC    T
;*****
        VECTOR  GamVect         ;* On each game start
        jsr     Copyright       ;* Get some random value in D
        std     ASCPtr          ;*   and save it for confusion.
;*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                ;; More BUTTON.SRC code...
        lda     #1              ;* Zap the court check
        sta     WECheck         ;*   variable to help prevent detection.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        rts

;       SUBTTL  IAMVECT - Routines occuring each attract mode start.
;*****
;*      IIIII   AAA   M   M  V   V  EEEEE   CCCC  TTTTT
;*        I    A   A  MM MM  V   V  E      C        T
;*        I    AAAAA  M M M  V   V  EEEE   C        T
;*        I    A   A  M   M   V V   E      C        T
;*      IIIII  A   A  M   M    V    EEEEE   CCCC    T
;*****
        VECTOR  IAMVect         ;* At initial attract mode,
;***
;* The attract mode is run twice.  The first time the attract mode is
;* started, AMDemo will be marked to demonstrate the game.  The system
;* will restart and the demo will eventually terminate.  Then, the
;* attract mode is entered the second time and AMDemo is marked not to
;* demonstrate the system.  Instead, the marquis page is started.
;*
;* If AMDemo != 0, then start demonstration.
;* If AMDemo == 0, then mark AMDemo != 0 and start marquis page.
;***
        tst     AMDemo          ;*   if the demo is to run,
        beq     .1S             ;*   then start it up ...
;***
;* Put the system into demo mode (AMDemo != 0)
;***
        jsr     StartDemo       ;* Fake the Player 1 button hit.                ;; This gets modified by SAM/FIXDAMPD.ASM ($5156)
;       NEW_SLEEP Task1,.2S,OMTLen+4 ;* Start player damping task
;       CLRD                    ;* Zero previous player
;       std     OMTLen,X        ;*   l velocity and
;       std     OMTLen+2,X      ;$   s velocity save
        jmp     Starts          ;* Sieze control of the system.                 ;; This gets modified by SAM/FIXDAMPD.ASM ($5167)
;***
;* Do not demo the system (AMDemo == 0)
;***
.1S     inc     AMDemo          ;* Else, mark the demonstration for later
        rts                     ;*   and run the marquis.
;***
;* Player damping for attract mode task
;***
;.2S    LDX     #WPLAYER        ;* Get current player
;       LDD     OLVEL,X         ;*   l velocity and
;       ADDD    OMTLEN,Y        ;*   add it to previous l velocity
;       ASRA                    ;* Divide by two
;       RORB                    ;*   to compute average
;       STD     OLVEL,X         ;* Change player l velocity to average
;       STD     OMTLEN,Y        ;*   and save for next damping
;       LDD     OSVEL,X         ;* Get current player s velocity and
;       ADDD    OMTLEN+1,Y      ;*   add it to previous s velocity              ;; This gets modified by SAM/FIXDAMPD.ASM ($517C)
;       ASRA                    ;* Divide by two
;       RORB                    ;*   to compute average
;       STD     OSVEL,X         ;* Change player s velocity to average
;       STD     OMTLEN+2,Y      ;*   and save for next damping
;       SLEEP   LOOP            ;* Sleep 1

        ;SUBTTL INIVECT - Routines occuring each player ship start.
;*****
;*      IIIII  N   N  IIIII  V   V  EEEEE   CCCC  TTTTT
;*        I    NN  N    I    V   V  E      C        T
;*        I    N N N    I    V   V  EEEE   C        T
;*        I    N  NN    I     V V   E      C        T
;*      IIIII  N   N  IIIII    V    EEEEE   CCCC    T
;*****
        VECTOR  IniVect         ;* On each turn start
        clr     InStun          ;* Clear Sinistar stun.
;       lda     #-1             ;* Turn off the
;       sta     InImpulse       ;*   impulse engines at turn start.
        clr     PlaGrave        ;* Remove grave marker.  Player is reborn.
        clr     SinGrave        ;* Remove grave marker.  Sinistar is reborn.
        clr     RapTime         ;* Turn off machine gun.
;***
;*      Randomize worker and warrior orbits
;***
        New_Sleep       Task256,.100S
        rts

.100S   FRANDOM OSEED1,BYTE
        sta     workorbit       ;* Change the worker orbit
        sta     warrorbit       ;*   and the warrior orbit.
        SLEEP   HERE            ;* Twelve
        SLEEP   HERE            ;*   seconds
        SLEEP   HERE            ;*   later ...
        FRANDOM OSEED1,BYTE
        sta     workorbit       ;* Change the worker orbit again
;*      but not warrorbit       ;*   but not the warrior orbit this time.
        SLEEP   HERE            ;* Twelve
        SLEEP   HERE            ;*   seconds
        SLEEP   .100S           ;*   later, repeat.
;*****
;*
;* VECTOR INIVECT
;*      This is part of the PLAYER TURN initialization.
;*
;*      The image descriptor for the first SiniBomb image is copied into
;*      RAM where the characteristics descriptor for said SiniBomb (which
;*      lies in ROM) will look for the current display image (also stored
;*      in ROM).  The animation routine changes the image address in this
;*      RAM descriptor in order to achieve animation.
;*
;*      Yes, it would be nice if the image descriptor where in ROM.  That
;*      can be changed on the next release.
;*
;* Returns:
;*      U,X,Y destroyed.
;*
;*****
;       LOCAL
        VECTOR  IniVect
        ldx     #RISBomb+1+2
        ldy     #ISBomb         ;* Y -> the "first" image descriptor
        ldu     0,Y
        stu     ,X++
        ldu     #RISBomb+1+2+8
        stu     ,X++
        ldu     4,Y
        stu     ,X++
        ldu     6,Y
        stu     ,X++
        ldx     #RISBomb+1      ;* X -> RAM image descriptor block
        jsr     IEVBomb         ;* Initialize the animation.
;*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        JSR     EMPTY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        jsr     dispe           ;* Erase the player message area
;*
        clr     SiniSector      ;* Sinistar sector flag.
        clr     InWarp          ;* Player is not warping.
        clr     InBombs         ;* No bombs are alive.
;*
        clr     MesgTime                ;* Mark no messages displayed
        dec     MesgTime                ;*   and the display already erased.
        New_Sleep       Task64,Erase    ;* Start the message eraser.
;*
        clr     ASCTime         ;* Zero the wait time on pending animation.
        clr     ASCInt          ;* Mark the next animation OK to run.
        ldx     #AniSCF         ;* Initialize the Sinistar
        stx     ASCPtr          ;*   animation to a closed mouth.
;*
;       Routine ZAPSini
ZAPSini tst     KenChk
        bpl     ADemo           ;* Continue IniVect
        New_Sleep       Task1,.100S
        bra     ADemo           ;* Continue IniVect

.100S   jsr     SubPiece
        SLEEP   LOOP

;***
;* The start of each turn is checked for demo mode.
;***
;       Routine ADemo
ADemo   tst     AMDemo          ;*   if the system is not in demo mode
        beq     .99S            ;*   then exit.
;***
;*      Only the current ship will play.
;***
.1S     lda     Ships           ;* In demo mode, the ship count must be
        beq     .2S             ;*   zeroed no matter what the normal
        ldb     #DCNS+DWBL      ;*   game start number of ships is.
        jsr     UpShips         ;* So, all the ships are
        dec     Ships           ;*   erased and counted off.
        bra     .1S             ;* No book-keeping is done on demo ships.
;***
;*      Start with half the bombbay full.  The crystals that are picked up
;*      will show bombs in the second half of the display to be easily seen.
;*      Originally, the bombbay was empty and the transition from EMPTY to
;*      a bomb display was very obvious, but did not allow much demonstration
;*      of the attack on the Sinistar.
;***
.2S     ;jsr    AddBombs        ;* Begin with sinibombs
;       inca                    ;*   in the bombbay for the demo attack.
;       cmpa    #(MaxBombs/2)   ;* Note that half the bombbay is full so that
                                                                                ;;(patched over in MICA/BOBFIXES.ASM) ($525E)
;       blt     .2S             ;*   crystal pickups are obviously making bombs.
;*
        New_Sleep       Task1,.100S,OTimer      ;* Start watchdog task.
        New_Sleep       Task1,CDTask            ;* Start credits display.
        New_Sleep       Task2,AMSini,OMTLEN+4   ;* Start Bob's Sini Task
        RADIX   10
;       ldd     #(40*60)/2                      ;*   which will run for         ;;Fixme was: ldd #(40.*60.)/2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ldd     #(45*60)/2                      ;*   which will run for         ;;Fixme was: ldd #(40.*60.)/2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                                                ;;(patched over first by WITT/FIXINIRI.ASM,
                                                                                ;; and then again by MICA/BOBFIXES.ASM) ($5279)
        RADIX   16
        std     OMTLen,X                        ;*   40 seconds
;       CLRD                                                                    ;;CLRB and STD instructions both get patched over ($527E)
;       std     OMTLen+2,X
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        CLR     OMTLen+2,X
        CLR     OMTLen+3,X
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.99S    rts
;***
;*      This is the demo watchdog timer.
;***
.100S   lda     #%00111001      ;* During the demo, the start buttons and       ;;(patched over in WITT/FIXINIRI.ASM) ($5283)
        sta     PanMask         ;*   star scrolling must work.  Fire for HSTD.
        RADIX   10
        ldd     #(45*60)        ;* Allow the system to run                      ;;Fixme was: ldd #(45.*60.)
                                                                                ;;(patched over in MICA/BOBFIXES.ASM) ($5287)
        RADIX   16
        jsr     Timer           ;*   for 45 seconds.
        JMP     DEATH           ;end demo
;***
;*      During the demonstration, this is the credit display task.
;***
;       ROUTINE CDTask
CDTask  lda     NPlayer         ;* During the credit display
        clr     NPlayer         ;*   DCREDITS must think this is player #0.
        jsr     DCredits        ;* Display the credits on each wake-up.
        sta     NPlayer         ;* Restore the actual player number (#1).
        SLEEP   LOOP

;       SUBTTL  PLAVECT - Routines occuring each new player start.
;*****
;*      PPPP   L       AAA   V   V  EEEEE   CCCC  TTTTT
;*      P   P  L      A   A  V   V  E      C        T
;*      PPPP   L      AAAAA  V   V  EEEE   C        T
;*      P      L      A   A   V V   E      C        T
;*      P      LLLLL  A   A    V    EEEEE   CCCC    T
;*****
        VECTOR  PlaVect         ;* On each player's game start
;       jsr     empty           ;* Make player's bomb bay empty
;       rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        NOP
        NOP
        RTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;       SUBTTL  POWVECT - Routines occuring each machine power-up.
;*****
;*      PPPP    OOO   W   W  V   V  EEEEE   CCCC  TTTTT
;*      P   P  O   O  W   W  V   V  E      C        T
;*      PPPP   O   O  W W W  V   V  EEEE   C        T
;*      P      O   O  W W W   V V   E      C        T
;*      P       OOO    W W     V    EEEEE   CCCC    T
;*****
        VECTOR  PowVect         ;* On each power-up
        clra                    ;* The attract mode is marked to
        sta     AMDemo          ;*   start with the marquis page.
;*
        CLRD                    ;* Initialize the
        std     ASCPtr          ;*   Animate Speech Call Pointer to nowhere.
;*
        pshs    X,U             ;* Save work registers
        LDX     #0
        LDD     #$EF
        STA     KENCHK
.1S     LEAX    2,X
        ADDA    #$10
        BMI     .3S
        LDU     D,X
        CMPU    .100S,X
        ORCC    #$0A
        ANDCC   #$DE
        BNE     .2S
        ORCC    #$0B
.2S     TST     KENCHK
        BCS     .1S
        BGT     .1S
        INCB
        STB     KENCHK
        BCC     .1S
.3S     PULS    X,U             ;* Restore work registers
;*
        rts

;*      TABLE
        fdb     $5269                           ;;The first four bytes spell out "Rich"
.100S   fdb     $6368                           ;;in ASCII.
KenTbl  fdb     $6A00           ;* U
        fdb     $0000           ;* U
;       fdb     $FDA0           ;* U
;       fdb     $9700           ;* U
;       fdb     $45F1           ;* U
;       fdb     $4234           ;* U
;       fdb     $A7BD           ;* U
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        FDB     $0F4A
        FDB     $622F
        FDB     $3910
        FDB     $40EE
        FDB     $EAA7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        fdb     $5769                           ;;These last four bytes spell out "Witt"
        fdb     $7474                           ;;in ASCII.
;*      ENDTBL

        PULLORG ROMSAVE

        INCLUDE "../WITT/EMPTY.ASM"             ;* "EMPTY" or bombs display.
        INCLUDE "../WITT/ANISINI.ASM"           ;* Animate Sinistar