;;      INCLUDE "../SAM/START.ASM"
;       INCLVER SAM,Sinistar.equ
;       INCLUDE "../WITT/DISPLAY.ASM"           ;* Message display macros

;===============================================================================
; EQUs to remove later

;===============================================================================

        PUSHORG ROMSAVE
;*****
;*
;* DISP
;*      This routine corrects the screen address for the diplayed PHRASE.
;*      The WORD macro never calls this routine since it writes to the
;*      'next' screen address.  Phrases, however, must re-select the correct
;*      side and position of the screen based on which player is 'up'.
;*
;* Bugs:
;*      This routine replaces any current message immediately.  Thus, messages
;*      may live for a maximum time (that's good) but do not live for any
;*      minimum time (that's bad).
;*
;* Needs:
;*      X = (LONG!<8+SHORT) screen address.
;*      ScoreAddr = the 8-bit SHORT screen address offset for the message
;*
;* Returns:
;*      X = (LONG!<8+SHORT)+ScoreAddr for screen address.
;*      MesgTime = 4 seconds max. posting time (marked for the ERASE process)
;*
;*****
;       ROUTINE disp
DISP    pshs    A,X             ;* Save work register
        lda     #4              ;* Mark this message as newly
        sta     MesgTime        ;*   appearing on the display.
        lda     2,S             ;* The SHORT position of the
        adda    ScoreAddr       ;*   message is controlled by
        sta     2,S             ;*   ScoreAddr.
        puls    A,X             ;* Restore work register
        rts

        PULLORG ROMSAVE

        INCLUDE DISPE.ASM                       ;* Message to player erasing
        ;INCLVER        RICH,erase              ;* Message erasing intelligence