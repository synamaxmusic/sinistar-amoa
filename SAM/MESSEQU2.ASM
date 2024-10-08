CEND    EQU     $80     ;;Fixme was: END EQU $80 (had to rename)
C0      EQU     $00
C1      EQU     $01
C2      EQU     $02
C3      EQU     $03
C4      EQU     $04
C5      EQU     $05
C6      EQU     $06
C7      EQU     $07
C8      EQU     $08
C9      EQU     $09
CSPC    EQU     $0A
CA      EQU     $0B
CB      EQU     $0C
CC      EQU     $0D
CD      EQU     $0E
CE      EQU     $0F
CF      EQU     $10
CG      EQU     $11
CH      EQU     $12
CI      EQU     $13
CJ      EQU     $14
CK      EQU     $15
CL      EQU     $16
CM      EQU     $17
CN      EQU     $18
CO      EQU     $19
CP      EQU     $1A
CQ      EQU     $1B
CR      EQU     $1C
CS      EQU     $1D
CT      EQU     $1E
CU      EQU     $1F
CV      EQU     $20
CW      EQU     $21
CX      EQU     $22
CY      EQU     $23
CZ      EQU     $24
CBARRW  EQU     $25
CEQU    EQU     $26
CDASH   EQU     $27     ;;Fixme was: CDSH  EQU  $27 (Renaming so MICA/ZZATTRAC.ASM can use this)
CQUE    EQU     $28
CEXC    EQU     $29
CBRKL   EQU     $2A
CBRKR   EQU     $2B
CSQOT   EQU     $2C
CCMMA   EQU     $2D
CPER    EQU     $2E

;**** OFFSETS FOR SMALL FONT SPECIAL ****
CTHOU   EQU     $2F     ;SMALL FONT ONLY!!!!
CCURSR  EQU     $30

;**** OFFSETS FOR LARGE FONT SPECIAL ****
CSLSH   EQU     $2F
CAMP    EQU     $30
CDQOT   EQU     $31
CCOLN   EQU     $32
CCURS   EQU     $33
CCNARW  EQU     $34


;*****  TEXT EQUATES   *****

TXROMK  EQU     $00     ;'ALL ROMS OK','RAM TEST FOLLOWS','PRESS ADVANCE TO EXIT'
TXRAMK  EQU     $01     ;'NO RAM ERRORS DETECTED'
TXCMOK  EQU     $02     ;'NO CMOS RAM ERRORS DETECTED'
TXCMER  EQU     $03     ;'CMOS RAM ERROR'
TXCMDR  EQU     $04     ;'CMOS RAM ERROR','OR WRITE PROTECT FAILURE','.....'
TXCMT   EQU     $05     ;'COLOR RAM TEST','VERTICAL BARS INDICATE ERROR'
TXSWTS  EQU     $06     ;'SWITCH TEST'
TXBOOK  EQU     $07     ;'BOOKKEEPING TOTALS'
TXADJT  EQU     $08     ;'GAME ADJUSTMENTS'
TXBADJ  EQU     $09     ;'USE 'MOVE' TO SELECT ADJUSTMENT'
;*                      ;'USE 'CREDIT' BUTTONS TO CHANGE THE VALUE'
;*                      ;'PRESS ADVANCE TO EXIT'
TXIMES  EQU     $0A     ;'ADJUSTMENT FAILURE'
;*                      ;'RESTORE FACTORY SETTINGS'
;*                      ;'BY OPENING FRONT DOOR OR TABLE TOP'
;*                      ;'AND TURNING GAME ON AND OFF'
TXREST  EQU     $0B     ;'FACTORY SETTINGS RESTORED'
TXBKRS  EQU     $0C     ;'BOOKKEEPING TOTALS CLEARED'
TXRESM  EQU     $0D     ;'HIGH SCORE TABLE RESET'

;;==============================================================================

        CODEPAGE WILLIASCII
        CHARSET '0',$00
        CHARSET '1',$01
        CHARSET '2',$02
        CHARSET '3',$03
        CHARSET '4',$04
        CHARSET '5',$05
        CHARSET '6',$06
        CHARSET '7',$07
        CHARSET '8',$08
        CHARSET '9',$09
        CHARSET '\32',$0A       ;;Space
        CHARSET 'A',$0B
        CHARSET 'B',$0C
        CHARSET 'C',$0D
        CHARSET 'D',$0E
        CHARSET 'E',$0F
        CHARSET 'F',$10
        CHARSET 'G',$11
        CHARSET 'H',$12
        CHARSET 'I',$13
        CHARSET 'J',$14
        CHARSET 'K',$15
        CHARSET 'L',$16
        CHARSET 'M',$17
        CHARSET 'N',$18
        CHARSET 'O',$19
        CHARSET 'P',$1A
        CHARSET 'Q',$1B
        CHARSET 'R',$1C
        CHARSET 'S',$1D
        CHARSET 'T',$1E
        CHARSET 'U',$1F
        CHARSET 'V',$20
        CHARSET 'W',$21
        CHARSET 'X',$22
        CHARSET 'Y',$23
        CHARSET 'Z',$24
;       CHARSET 'CBARRW'        EQU     $25
;       CHARSET 'CEQU'  EQU     $26
        CHARSET '-',$27
;       CHARSET 'CQUE'  EQU     $28
        CHARSET '!',$29
        CHARSET '(',$2A
        CHARSET ')',$2B
        CHARSET '\H',$2C        ;;Apostrophe
        CHARSET ',',$2D
        CHARSET '.',$2E