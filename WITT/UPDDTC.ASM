        PUSHORG ROMSAVE
;*****
;*
;* UPDDTC
;*      Update the Distance To Caller for the calling process.
;*
;* UPDDTP
;*      Update the Distance To Player for the intelligence process.
;*
;*      10/14/82 A special check has been added so that if the caller is
;*      the Sinistar, the SINILN and SINISN offsets are added so that the
;*      distance is computed to the next Sinistar piece.
;*
;* Needs:
;*      Y -> Scanner workspace of the craft
;*      SININDEX - 16-bit location containing the Sinistar workspace pointer.
;*
;* Returns:
;*      OSDLDC,Y = The new unsigned 8-bit absolute value of the long
;*                 distance between the craft and the caller target.
;*      OSDSDC,Y = The new unsigned 8-bit absolute value of the short
;*                 distance between the craft and the caller target.
;*
;*      The registers are unchanged, but the condition codes are affected.
;*
;* Bugs:
;*      This routine is WRONG for Sinibombs which should refer to the CURRENT
;*      piece of the Sinistar, not the NEXT piece.  (RAW 1/24/83)
;*
;*****
        ROUTINE upddtp
        pshs    A,B,X
        ldx     [PlaIndex]      ;* X -> scanner workspace of target [PlaIndex]
        bra     upddc
;*
        ROUTINE upddtc
        pshs    A,B,X           ;* Save work registers
        ldx     [OSCWCR,Y]      ;* X -> scanner workspace of target
;*
        ROUTINE upddc
        clra
        cmpx    SININDEX        ;* The special case of the Sinistar requires
        bne     .1S             ;*   that the target be offset by the location
        lda     SINILN,X        ;*   of a piece of itself.
.1S     adda    OSLPOS,X        ;* Determine the absolute value
        cmpa    OSLPOS,Y        ;*   of the long scanner distance
        blt     .2S             ;*   between the craft and the
        suba    OSLPOS,Y        ;*   target.  Since the
        bra     .3S             ;*   coordinate values
.2S     lda     OSLPOS,Y        ;*   are 8-bit and unsigned,
        suba    OSLPOS,X        ;*   this requires subtracting low from high.
.3S     sta     OSCLDC,Y        ;* Save the distance for use by the caller.

        clra
        cmpx    SININDEX        ;* The special case of the Sinistar requires
        bne     .11S            ;*   that the target be offset by the location
        lda     SINISN,X        ;*   of a piece of itself.
.11S    adda    OSSPOS,X        ;* Determine the absolute value
        cmpa    OSSPOS,Y        ;*   of the short scanner distance
        blt     .12S            ;*   between the craft and the
        suba    OSSPOS,Y        ;*   target.  Since the
        bra     .13S            ;*   coordinate values
.12S    lda     OSSPOS,Y        ;*   are 8-bit and unsigned,
        suba    OSSPOS,X        ;*   this requires subtracting low from high.
.13S    sta     OSCSDC,Y        ;* Save the distance for use by the caller.
        puls    A,B,X           ;* Restore work registers
        rts

        PULLORG ROMSAVE