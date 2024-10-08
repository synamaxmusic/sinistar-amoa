;       MESSG   "                       DEFINING DISPLAY"
;       NLIST
;*****
;*
;* DISPLAY
;*
;*      This begins any text which may be displayed via a PHRASE macro
;*      invocation.  WORD macro calls may follow PHRASE calls (but there
;*      must be at least one.
;*
;*      These calls destroy the A, B and X registers.
;*
;*****
DISPLAY MACRO   CO
;       BLIST
        TEXT    $7A,$00
        IF "CO"="RED"                   ;;Fixme was: IFIDN <CO>,<RED>
        LDA     #30
        ELSEIF "CO"="YELLOW"            ;;Fixme was: IFIDN <CO>,<YELLOW>
        LDA     #20
        ELSEIF "CO"="GREY"              ;;Fixme was: IFIDN <CO>,<GREY>
        LDA     #10
        ELSE
        LDA     #CO
        ENDIF
;       ENDIF
;       ENDIF
        jsr     tdispe
;       NMLIST
SDISP   SET     disp                    ;;Fixme was: .$DISP
        ENDM
;       LIST
;       INCLVER RICH,TEXT               ;* The TEXT, PHRASE and WORD macros.