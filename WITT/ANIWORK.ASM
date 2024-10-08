        PUSHORG ROMSAVE
;       SUBTTL  ANIWORKER       Workers are animated given some angle.
;*****
;*
;* ANIWORKER
;*      Animate the WORKER based on angle of flight.
;*
;* Needs:
;*      A =  angle at which to aninmate craft
;*      Y -> scanner workspace of the craft
;*
;* Returns:
;*      Nothing.
;*
;*****
aniworker
        pshs    A,B,Y           ;* Save work registers
        ldy     OSSCWSA,Y       ;* Y -> object workspace of craft.
        beq     .99S            ;* If not on screen, then don't animate.
        lda     0,S             ;* Round off the
        adda    #(CIRCLE/(NIWORKER*2))  ;*   animation angle.
;       IFN     NIWORKER-16.
;       messg   * Please correct the RPT number for the change in NIWORKER
;       CLIST
;       ELSE
        RPT     4,asra          ;* There are 15 possible images
;       ENDIF
        adda    #(NIWORKER/2)   ;*   from 0 through 15.
        ldb     #OILEN          ;* Multiply this times the length of an image
        mul                     ;*   descriptor and add this to the image base
        addd    #IWORKER        ;*   so D -> the correct animation image.
        std     ONIDESC,Y       ;* Let the executive change images.
        ldd     #chgobj         ;*   by giving it the new image descriptor
        std     ODRWVEC,Y       ;*   and the "CHAnge OBJect" routine address.

.99S    puls    A,B,Y           ;* Restore work register
        rts

        PULLORG ROMSAVE