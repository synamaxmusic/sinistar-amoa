;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                                                                            *
;*                                                                            *
;*      BBBB    OOO   BBBB   RRRR    AAA   M   M      V   V   11    77777     *
;*      B   B  O   O  B   B  R   R  A   A  MM MM      V   V  1 1        7     *
;*      BBBB   O   O  BBBB   RRRR   AAAAA  M M M      V   V    1       7      *
;*      B   B  O   O  B   B  R   R  A   A  M   M       V V     1      7       *
;*      BBBB    OOO   BBBB   R   R  A   A  M   M        V    11111    7       *
;*                                                                            *
;*          S     I     N     I     S     T     A     R           17          *
;*                                                                            *
;*       A game by Sam Dicker, Noah Falstein, Richard Witt and Bob Mical      *
;*               Copyright (c) 1983 by Williams Electronics Inc.              *
;*                                                                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

BOBRAM
        PUSHORG SRAMSAV
RAMHSC  RMB     HSENTCT*SCRSIZ  ;Grab a block of Ram HSTD table
RAMLSC  EQU     RAMHSC+((HSENTCT-1)*SCRSIZ)     ;Pointer to the lowest score
        PULLORG SRAMSAV



        PUSHORG RAMSAV          ;Grab a byte of RAM                                     ;;Fixme was: PUSHORG    RAMSAVE
HSTDFLG RMB     1               ;  for the HSTD slave-task completion flag
HSLEN1  RMB     2               ;High Score Last Entry Locations 1
HSLEN2  RMB     2               ;                                 and 2
HSRLN1  RMB     2               ;High Score Last Entry RAM Locations 1
HSRLN2  RMB     2               ;                                     and 2


MARQC1  RMB     $0010           ;Cleverly-named variable used by Lantz/Metz Marq        ;;Fixme was: C1 RMB     $0010 (This conflicts with C1 in the MESSAGE block, renaming to MARQC1)
DISSIZ  RMB     1               ;HSTD Variable DESCRIBING DISPLAY SIZE
MARQCNT RMB     2
DISCLR  RMB     1               ;Display routines color saver

;* Rich has this declaration  22 March 1983
;*HSTDMRQ       RMB     1       ;Flag set when HSTD/Marquee page is displayed

OPENRTN RMB     2               ;Holds return address from OPENT routine
        PULLORG RAMSAV                                                                  ;;Fixme was: PULLORG    RAMSAVE


        PUSHORG PLAYSAV                                                                 ;;Fixme was: PUSHORG    PLAYSAVE
;PLUWPF RMB     1               ;Add the PlayerUpWarpFlag to the player's RAM
        PULLORG PLAYSAV                                                                 ;;Fixme was: PULLORG    PLAYSAVE


;* This stuff isn't RAM, but Sam asked me to move it out of my B1.SRC file
;*   and this was the most reasonable place to keep it.
CMOSHSC EQU     CMSCOR          ;HSTD CMOS High Score entry
CMOSLSC EQU     CMOSHSC+((HSENTCT-1)*SCRSIZ) ;Low Score entry
CMOSOPE EQU     CMOSHSC+(HSENTCT*SCRSIZ)
CMOSO2  EQU     CMOSOPE+OPENLEN*2
CMOSSD  EQU     CMOSO2+OPENLEN*2  ;Reserve 1 byte
CMOSNXT EQU     CMOSSD+1        ;Dummy variable, next available CMOS