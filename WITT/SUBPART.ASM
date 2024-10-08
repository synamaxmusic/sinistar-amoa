;       INCLVER RICH,display            * Message display macros
;       INCLVER RICH,Speak              * Speak macro

;===============================================================================
; EQUs to remove later
;KABOOM EQU     $6C6D   ;STUBS
;===============================================================================

        PUSHORG ROMSAVE
;       SUBTTL  SUBPART
;*****
;*
;* SUBPART
;*      Destroy a piece of the sinistar.  The calling routine is responsible
;*      for determining whether or not it is appropriate to invoke this
;*      routine.  For example, the Sinistar should be invulnerable out of
;*      the sector.  Also, Sinibombs must either collide on-screen with the
;*      Sinistar or be close enough, in-sector, to validly call SUBPART.
;*
;*      This routine will however, perform all the neccessary checking as
;*      to the state of the Sinistar's build-up.
;*
;* Calls:
;*      subpiece
;*
;* Needs:
;*      [SinIndex] -> scanner workspace of the sinistar
;*
;* Returns:
;*      Nothing
;*
;*****
        ROUTINE subpart
        pshs    A,B,X,Y         ;* Save work regsiters
        ldd     PiecePtr        ;* If there are
        cmpd    #PieceTbl       ;*   pieces left to the sinistar
        bne     SUBPA2S         ;*   then kill a piece off.                     ;;Fixme was: bne 2$ (Had to convert local
                                                                                ;;labels to global because of PHRASE macro)
;***
;* Check for invalid call of subpart when there is no part of the Sinistar
;* built up yet some routine wants to blow up a piece.
;***
        ldd     Finish          ;* If the sinistar
        cmpd    #Alive          ;*   is alive but no pieces left,
        lbne    SUBPA99S        ;*   then the Sinistar dies!
;***
;* The Sinistar is alive, but there are no pieces left, this is a KILL!
;***
        tst     SinGrave        ;* If the Sinistar is dying,
        bne     SUBPA99S        ;*   then exit.
;***
;* The death must be marked here because KaBoom performs a delayed KRSini call.
;***
        inc     SinGrave        ;* Mark the Sinistar dead.
        jsr     KaBoom          ;* Else, perform the expected kill
        ldd     #$7000          ;* Score
        jsr     addscore        ;*   15,000
        ldd     #$8000          ;*   points
        jsr     addscore        ;*   for finishing off the Sinistar!
        bra     SUBPA99S

SUBPA2S jsr     subpiece        ;* Destroy a part of the sinistar
        SPEAK   8               ;* Start a scream on each hit!
;***
;* Stun the Sinistar by zeroing its velocity.
;***
        ldy     [SinIndex]      ;* Y -> Sinistar scanner workspace
        clra                    ;* Zero the velocity of the Sinistar ...
        ldx     OSSCWSA,Y       ;* If the Sinistar is not on screen
        beq     SUBPA3S         ;*   then there is no screen object to affect.
;***
;* Stun the Sinistar
;***
        ldd     OLVEL,X         ;* Cut the LONG
        RPT     1,asra,rorb     ;*   screen velocity
        std     OLVEL,X         ;*   in half.
        ldd     OSVEL,X         ;* Cut the SHORT
        RPT     1,asra,rorb     ;*   screen velocity
        std     OSVEL,X         ;*   in half.
SUBPA3S lda     OSLVEL,Y        ;* Cut the LONG
        asra                    ;*   scanner velocity
        sta     OSLVEL,Y        ;*   in half.
        ldb     OSSVEL,Y        ;* Cut the SHORT
        asrb                    ;*   scanner velocity
        stb     OSSVEL,Y        ;*   in half.
;***
;* The screen is flashed when a piece of the Sinistar explodes.  Since the
;* Sinistar can be offscreen, the intensity of the flash is made to correspond
;* to the distance at which the Sinistar is from the player (roughly).
;***
        lda     OSCLDC,Y        ;* Get the LONG and the
        ldb     OSCSDC,Y        ;*   SHORT distances to the player
        asra                    ;*   scaled down to
        asrb                    ;*   7 bits of accuracy.
        ora     #1              ;* For the multiply to work, zero values
        orb     #1              ;*   are rounded up.
        mul                     ;* Now a range of 0 to 65025 is established.
        RPT     5,asra          ;* Scale this down to a distance of
        bne     SUBPA4S         ;*   1 to 7 which happens to be the
        inca                    ;*   color range from dim red to bright red
SUBPA4S sta     PCRAM           ;*   for exploding a piece of the sinistar!
        DISPLAY GREY
;       PHRASE  GREY,35,SINIBOMB,ATTACK

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        PHRASE  GREY,35,SINIBOMBS,ATTACK        ;; AMOA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        PHRASE  GREY,35,DAMAGED,TARGET
        ldd     #$500           ;* Score points
        jsr     addscore        ;*   for destroying part of the Sinistar!
SUBPA99S puls   A,B,X,Y         ;* Restore work registers
        rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ROMSAVE SET     *               ;; Save the current address

        ORG     PHRSAV          ;; Jump over to PHRSAV to save our pointers
;       FDB     _SINIBOMB       ;; ALREADY DEFINED IN COLLISIO.ASM
        FDB     _ATTACK
        FDB     _DAMAGED
        FDB     _TARGET

PHRSAV  SET     *               ;; Mark the new address for PHRSAV to add
                                ;; more phrases later

        ORG     ROMSAVE         ;; Back to our regularly scheduled programming...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        PULLORG ROMSAVE