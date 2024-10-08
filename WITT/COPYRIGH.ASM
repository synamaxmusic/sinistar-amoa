        PUSHORG ROMSAVE
;       SUBTTL  COPYRIGHT
;*****
;*
;* COPYRIGHT
;*      This routine provides an EBCDIC copyright message:
;*      "COPYRIGHT (C) 1982 WILLIAMS ELECTRONICS, INC." which is also
;*      a 6809 subroutine.
;*
;*      Unfortunately, the stupid BSO assembler forces the instruction
;*      sbcb    00,U    to assemble as
;*      sbcb    ,U      which has a different post-byte.
;*      So, this and the direct page reference are hard coded as FCB's
;*      but will still disassemble and execute as normal 6809 code.
;*
;* Needs:
;*      U -> somewhere
;*
;* Returns:
;*      D = smashed
;*
;*****
copyright
        addd    #$D6D7          ;* COP
        eorb    [-3639,U]       ;*    YRIG
        eorb    #$E3            ;*       HT
        nega                    ;*
        tsta                    ;* (
        addd    #$5D40          ;*  C)
        cmpb    $F9F8           ;* 198
        sbcb    $40E6           ;*    2 W
        adcb    #$D3            ;*      IL
        FCB     $D3,$C9         ;*        LI            addd D_P+$C9
        cmpb    #$D4            ;*          AM
        FCB     $E2,$40         ;*            S         sbcb +00,U
        bitb    #$D3            ;* EL
        bitb    #$C3            ;*   EC
        addd    [-292B,U]       ;*     TRON
        adcb    #$C3            ;*        IC
        sbcb    $0B,S           ;*          S,
        nega                    ;*
        adcb    #$D5            ;* IN
        addd    #$4B00          ;*   C.
        rts

        PULLORG ROMSAVE