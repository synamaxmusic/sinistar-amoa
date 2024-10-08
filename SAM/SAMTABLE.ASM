;;      INCLUDE "../SAM/START.ASM"

;;===============================================================================
; EQUs to remove later
;TRAP   EQU     $E196           ;IRQ
;;===============================================================================

        PUSHORG ROMSAVE

SAMTABLES

;;      SUBTTL  CHARACTERISTICS DESCRIPTOR TABLES

;* null object
CNULL   FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     0               ;object mass
        FDB     0               ;first image descriptor
        FDB     KOBJECT         ;offscreen routine
;* player ship
CPLAYER FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     5               ;object mass
        FDB     IPLAYER         ;first image descriptor
        FDB     TRAP            ;offscreen routine                              ;;This gets patched over in FALS/LAST.SRC ($4BCF)
        FDB     VSCRON          ;onscreen routine
        FDB     TRAP            ;vector to leave-sector routine
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSWCLen         ;scanner workspace length
        FCB     1               ;scanner height
        FCB     1               ;scanner width
        FCB     $00,$00         ;bottom flavor scanner
        FCB     $00,$00         ;top flavor scanner
        FCB     $00,$00
        fcb     IQPlay          ;intelligence type
        FCB     40              ;percentage of screen spaces for fragments
        FDB     IPLAYFR         ;first fragment image descriptor
        fcb     0               ;* Base vibration block address
;* planetoid 1
CPLAN1  FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     60              ;object mass
        FDB     IPLAN1          ;first image descriptor
        FDB     SCROFF          ;offscreen routine
        FDB     VSCRON          ;onscreen routine
;       FDB     TRAP            ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        FDB     AMOALeaveSector ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSDPLen         ;scanner workspace length
        FCB     3               ;scanner height
        FCB     3               ;scanner width
        FCB     $AA,$AA         ;bottom flavor scanner
        FCB     $0A,$A0         ;top flavor scanner
        FCB     $0A,$A0
        fcb     IQPlan          ;intelligence type
        FCB     42              ;percentage of screen spaces for fragments
        FDB     IPLANFR         ;first fragment image descriptor
        fcb     VDPlan          ;* Base vibration block address
;* planetoid 2
CPLAN2  FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     50              ;object mass
        FDB     IPLAN2          ;first image descriptor
        FDB     SCROFF          ;offscreen routine
        FDB     VSCRON          ;onscreen routine
;       FDB     TRAP            ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        FDB     AMOALeaveSector ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSDPLen         ;scanner workspace length
        FCB     3               ;scanner height
        FCB     3               ;scanner width
        FCB     $AA,$AA         ;bottom flavor scanner
        FCB     $0A,$A0         ;top flavor scanner
        FCB     $0A,$A0
        fcb     IQPlan          ;intelligence type
        FCB     37              ;percentage of screen spaces for fragments
        FDB     IPLANFR         ;first fragment image descriptor
        fcb     VDPlan          ;* Base vibration block address
;* planetoid 3
CPLAN3  FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     20              ;object mass
        FDB     IPLAN3          ;first image descriptor
        FDB     SCROFF          ;offscreen routine
        FDB     VSCRON          ;onscreen routine
;       FDB     TRAP            ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        FDB     AMOALeaveSector ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSDPLen         ;scanner workspace length
        FCB     2               ;scanner height
        FCB     2               ;scanner width
        FCB     $AA,$AA         ;bottom flavor scanner
        FCB     $0A,$A0         ;top flavor scanner
        FCB     $0A,$A0
        fcb     IQPlan          ;intelligence type
        FCB     16              ;percentage of screen spaces for fragments
        FDB     IPLANFR         ;first fragment image descriptor
        fcb     VDPlan          ;* Base vibration block address
;* planetoid 4
CPLAN4  FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     50              ;object mass
        FDB     IPLAN4          ;first image descriptor
        FDB     SCROFF          ;offscreen routine
        FDB     VSCRON          ;onscreen routine
;       FDB     TRAP            ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        FDB     AMOALeaveSector ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSDPLen         ;scanner workspace length
        FCB     3               ;scanner height
        FCB     3               ;scanner width
        FCB     $AA,$AA         ;bottom flavor scanner
        FCB     $0A,$A0         ;top flavor scanner
        FCB     $0A,$A0
        fcb     IQPlan          ;intelligence type
        FCB     37              ;percentage of screen spaces for fragments
        FDB     IPLANFR         ;first fragment image descriptor
        fcb     VDPlan          ;* Base vibration block address
;* planetoid 5
CPLAN5  FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     90              ;object mass
        FDB     IPLAN5          ;first image descriptor
        FDB     SCROFF          ;offscreen routine
        FDB     VSCRON          ;onscreen routine
;       FDB     TRAP            ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        FDB     AMOALeaveSector ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSVCLen         ;scanner workspace length
        FCB     4               ;scanner height
        FCB     3               ;scanner width
        FCB     $AA,$AA         ;bottom flavor scanner
        FCB     $0A,$A0         ;top flavor scanner
        FCB     $0A,$A0
        fcb     IQPlan          ;intelligence type
        FCB     63              ;percentage of screen spaces for fragments
        FDB     IPLANFR         ;first fragment image descriptor
        fcb     VCaller         ;* Base vibration block address
;*sinibomb
CSBOMB  FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     1               ;object mass
        FDB     ISBOMB          ;first image descriptor                         ;;This gets patched over in WITT/FIXRISBO ($4C99)
        FDB     SCROFF          ;offscreen routine
        FDB     VSCRON          ;onscreen routine
        FDB     TRAP            ;vector to leave-sector routine
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSWCLen         ;scanner workspace length
        FCB     0               ;scanner height
        FCB     0               ;scanner width
        FCB     $99,$99         ;bottom flavor scanner
        FCB     $09,$90         ;top flavor scanner
        FCB     $09,$90
        fcb     IQSBomb         ;intelligence type
        FCB     0               ;percentage of screen spaces for fragments
        FDB     INULL           ;first fragment image descriptor
        fcb     0               ;* Base vibration block address
;* worker
CWORKER FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     1               ;object mass
        FDB     IWORKER         ;first image descriptor
        FDB     SCROFF          ;offscreen routine
        FDB     VSCRON          ;onscreen routine
;       FDB     TRAP            ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        FDB     AMOALeaveSector ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSWWLen         ;scanner workspace length
        FCB     1               ;scanner height
        FCB     1               ;scanner width
        FCB     $CC,$CC         ;bottom flavor scanner
        FCB     $0C,$C0         ;top flavor scanner
        FCB     $0C,$C0
        fcb     IQWork          ;intelligence type
        FCB     0               ;percentage of screen spaces for fragments
;* warrior
CWARRIO FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     2               ;object mass
        FDB     IWARRIO         ;first image descriptor
        FDB     SCROFF          ;offscreen routine
        FDB     VSCRON          ;onscreen routine
;       FDB     TRAP            ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        FDB     AMOALeaveSector ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSWWLen         ;scanner workspace length
        FCB     2               ;scanner height
        FCB     2               ;scanner width
        FCB     $BB,$BB         ;bottom flavor scanner
        FCB     $0B,$B0         ;top flavor scanner
        FCB     $0B,$B0
        fcb     IQWarr          ;intelligence type
        FCB     0               ;percentage of screen spaces for fragments
;* sinistar
CSINI   FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     0FF             ;object mass
        FDB     ISINI           ;first image descriptor
        FDB     SCROFF          ;offscreen routine
;       FDB     VSCRON          ;onscreen routine
;       FDB     TRAP            ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        IFNEXIST  MICA/BOBS.ASM
        RPT     2,NOP
        ELSE
        FDB     AMOASiniStun    ;onscreen routine
        ENDIF
        FDB     LSSINI          ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSVCLen         ;scanner workspace length
        FCB     6               ;scanner height
        FCB     6               ;scanner width
        FCB     $FF,$FF         ;bottom flavor scanner
        FCB     $0F,$F0         ;top flavor scanner
        FCB     $0F,$F0
        fcb     IQSini          ;intelligence type
        FCB     0               ;percentage of screen spaces for fragments
        FDB     INULL           ;first fragment image descriptor
        fcb     VCaller         ;* Base vibration block address
;* player shot
CPLSHOT FDB     8000            ;collision mask
        FDB     0000            ;my collision type bit
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     0               ;object mass
        FDB     IPLSHOT         ;first image descriptor
        FDB     KOBJECT         ;offscreen routine
;* warrior shot
CWARSHO FDB     8000            ;collision mask
        FDB     0000            ;my collision type bit
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     0               ;object mass
        FDB     IPLSHOT         ;first image descriptor
        FDB     KOBJECT         ;offscreen routine
;* crystal
CCRYSTA FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     1               ;object mass
        FDB     ICRYSTA         ;first image descriptor
        FDB     SCROFF          ;offscreen routine
        FDB     CRYON           ;onscreen routine
;       FDB     TRAP            ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        FDB     AMOALeaveSector ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSWCLen         ;scanner workspace length
        FCB     0               ;scanner height
        FCB     0               ;scanner width
        FCB     $00,$00         ;bottom flavor scanner
        FCB     $00,$00         ;top flavor scanner
        FCB     $00,$00
        fcb     IQCrys          ;intelligence type                              ;;Fixme was: fcb IQCrystal
        FCB     0               ;percentage of screen spaces for fragments
        FDB     INULL           ;first fragment image descriptor
        fcb     0               ;* Base vibration block address
;* worker with crystal
CWORKCR FDB     8000            ;collision mask
        FDB     0000            ;my collision type
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     2               ;object mass
        FDB     IWORKER         ;first image descriptor
        FDB     SCROFF          ;offscreen routine
        FDB     WORKON          ;onscreen routine
        FDB     TRAP            ;vector to leave-sector routine
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSWWLen         ;scanner workspace length
        FCB     1               ;scanner height
        FCB     1               ;scanner width
        FCB     $CC,$CC         ;bottom flavor scanner
        FCB     $0C,$C0         ;top flavor scanner
        FCB     $0C,$C0
        fcb     IQWork          ;intelligence type
        FCB     0               ;percentage of screen spaces for fragments
;* piece of sinistar
CPIECE  FDB     8000            ;collision mask
        FDB     0000            ;my collision type bit
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     0               ;object mass
        FDB     IMANGLE         ;first image descriptor
        FDB     TRAP            ;offscreen routine
        FDB     TRAP            ;onscreen routine
;       FDB     TRAP            ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        FDB     AMOALeaveSector ;vector to leave-sector routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        fdb     0               ;* Index to scanner object CD Table
        fcb     OSCLEN          ;scanner workspace length
        FCB     1               ;scanner height
        FCB     1               ;scanner width
        FCB     $F0,$00         ;bottom flavor scanner
        FCB     $0F,$00         ;top flavor scanner
        FCB     $00,$00
        fcb     0               ;intelligence type
        FCB     0               ;percentage of screen spaces for fragments
;* exploding object
CEXPLO  FDB     8000            ;collision mask
        FDB     0000            ;my collision type bit
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     0               ;object mass
        FDB     0               ;first image descriptor
        FDB     TRAP            ;offscreen routine
;* fragment
CFRAGME FDB     8000            ;collision mask
        FDB     0000            ;my collision type bit
        FCB     0               ;collision type
        FDB     TRAP            ;* Vector to initialization routine
        FDB     TRAP            ;* Vector to killing routine
        FCB     0               ;object mass
        FDB     IPLSHOT         ;first image descriptor
        FDB     KOBJECT         ;offscreen routine

;;      SUBTTL  TUNE TABLES

;* tunes:
;*
;*      .IPRIO  <priority #>            interupts a lower priority tune (1-$3F)
;*                                      MUST start tune
;*      .PRIO   <priority #>            set tune priority (1-$3F)
;*      .SOUND  <sound #>               play sound (1-$3F)
;*      .TIME   <# of ticks>            sleep (1-$FF)
;*      .REPEAT <# of repeats>,<address> branches to address n times then falls
;*                                       through (1-$3F),(*-7F< < *+7F)
;*      .STOP                           MUST terminate sound

;* bounce
QBOUNCE _IPRIO  10                              ;;Fixme was: .IPRIO     10
        _SOUND  14                              ;;Fixme was: .SOUND     14
        _PRIO   2                               ;;Fixme was: .PRIO      2
        _TIME   03                              ;;Fixme was: .TIME      03
        _STOP                                   ;;Fixme was: .STOP

;* player firing
QFIRE   _IPRIO  13
        _SOUND  11
        _PRIO   12
        _TIME   10
        _STOP

;* bang
QSBomX
QBANG   _IPRIO  28
        _SOUND  0C
        _PRIO   20
        _TIME   10
        _PRIO   18
        _TIME   20
        _STOP

;* warrior firing
QWFIRE  _IPRIO  21
        _SOUND  12
        _PRIO   10
        _TIME   10
        _PRIO   8
        _TIME   10
        _STOP

;* player dieing
QPlDie  _IPRIO  38
        _SOUND  07              ;* Sound of player ship being shot.
        _PRIO   39
        _TIME   0C
        _SOUND  08
        _PRIO   39
        _TIME   80
        _STOP

;* worker grabing crystal
QWorkCr _IPRIO  21
        _SOUND  15              ;* Sound of worker grabbing crystal.
        _PRIO   1A
        _TIME   20
        _STOP

;* worker delivering crystal
QWorkSi _IPRIO  21
        _SOUND  19              ;* Sound of worker delivering crystal.
        _PRIO   20
        _TIME   09
        _STOP

;* player releasing sinibomb
QSFire  _IPRIO  24
        _SOUND  10              ;* Sound of sinibomb being launched.
        _PRIO   20
        _TIME   10
        _PRIO   12
        _TIME   0FF
        _STOP

;* player picking up a crystal
QPlayCr _IPRIO  21
        _SOUND  1C
        _PRIO   18
        _TIME   20
        _STOP

;* player earning a new ship
QNEWSHI _IPRIO  38
        _SOUND  3
        _PRIO   30
        _TIME   20
        _PRIO   18
        _TIME   20
        _STOP

;* message displayed to player.
QMesg   _IPRIO  21
        _SOUND  01              ;* Sound of Message being Displayed.
        _PRIO   20
        _TIME   30
        _STOP

QPlStr  _IPRIO  38
        _SOUND  1B              ;* Sound to alert player turn is starting
        _PRIO   30
        _TIME   30
        _PRIO   18
        _TIME   88
        _STOP

QGamEnd _IPRIO  38
        _SOUND  19              ;* Tough Luck end of game sound
        _PRIO   30
        _TIME   $FF
        _STOP

;* crystal flashing
QCRYFLA _IPRIO  12
        _SOUND  18
        _PRIO   10
        _TIME   40
        _STOP

;* coin
QCOIN   _IPRIO  3F
        _SOUND  $0F             ;* I HUNGER
        _PRIO   3E
        _TIME   60
        _STOP

;       SUBTTL  FUNCTION TABLES

;* joystick conversion
JOYSWI  FCB     6,4,0,2,4,0,2,0

;* joystick rectangular to polar conversion
JOYRTP  FDB     0000,0D00,3200,7200
        FDB     0D40,1920,3F13,7F0D
        FDB     3240,3F2D,6620,7F18
        FDB     7240,7F33,7F28,7F20

;* 100/X
INVTBL  EQU     *-1
        FCB     0FF,080,055,040,033,02B,025
        FCB     020,01C,01A,017,015,014,012,011
        FCB     010,00F,00E,00D,00D,00C,00C,00B
        FCB     00B,00A,00A,00A,009,009,009,008
        FCB     008

;* sine table (one quadrant)
SINETBL FCB     000,003,006,009,00C,00F,012,015
        FCB     018,01B,01E,021,024,027,02A,02D
        FCB     030,033,036,039,03B,03E,041,043
        FCB     046,049,04B,04E,050,052,055,057
        FCB     059,05B,05E,060,062,064,066,067
        FCB     069,06B,06C,06E,070,071,072,074
        FCB     075,076,077,078,079,07A,07B,07B
        FCB     07C,07D,07D,07E,07E,07E,07E,07E

;* quadrant table for angle to sine cosine conversion
QUADTBL FCB     %00111111,%00000000,%00000000,0
        FCB     %01000000,%11111111,%00000000,0
        FCB     %10111111,%11111111,%11111111,0
        FCB     %11000000,%00000000,%11111111

;* rectangle to angle conversion
FRECTAN FCB     000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000
        FCB     040,020,012,00E,00A,008,006,004,004,004,002,002,002,002,002,002
        FCB     040,02E,020,01A,012,00E,00E,00A,00A,008,008,006,006,006,004,004
        FCB     040,032,026,020,01C,018,012,010,00E,00E,00A,00A,00A,008,008,008
        FCB     040,036,02E,024,020,01C,01A,016,012,010,00E,00E,00E,00E,00A,00A
        FCB     040,038,032,028,024,020,01E,01A,018,016,012,010,010,00E,00E,00E
        FCB     040,03A,032,02E,026,022,020,01E,01C,01A,018,016,012,010,010,00E
        FCB     040,03C,036,030,02A,026,022,020,01E,01C,01A,018,018,016,012,012
        FCB     040,03C,036,032,02E,028,024,022,020,020,01C,01A,01A,018,016,016
        FCB     040,03C,038,032,030,02A,026,024,020,020,020,01E,01C,01A,018,018
        FCB     040,03E,038,036,032,02E,028,026,024,020,020,020,01E,01C,01A,01A
        FCB     040,03E,03A,036,032,030,02A,028,026,022,020,020,020,01E,01C,01C
        FCB     040,03E,03A,036,032,030,02E,028,026,024,022,020,020,020,01E,01C
        FCB     040,03E,03A,038,032,032,030,02A,028,026,024,022,020,020,020,01E
        FCB     040,03E,03C,038,036,032,030,02E,02A,028,026,024,022,020,020,020
        FCB     040,03E,03C,038,036,032,032,02E,02A,028,026,024,024,022,020,020

;       SUBTTL  MISCELLANEOUS TABLES

;* crystal animation routine table
CRYTBL  FDB     CRY1ANI,CRY2ANI,CRY3ANI,CRY4ANI

;* star color table (color intensity from 33-66)
STARTBL FCB     0CC,066,099,055,0DD,0CC,066,099,055,0DD

;* crystal color table (color intensity from 50-100)
CRYSTBL FCB     01,02,03,04,05,09,0D,0F

;* sinistar piece table
PIECETB FDB     S1L,270B
        FDB     S1R,2717
        FDB     S2L,2504
        FDB     S3L,1700
        FDB     S2R,2522
        FDB     S3R,1724
        FDB     S4R,0E24
        FDB     S4L,0E00
        FDB     S5L,0204
        FDB     S6L,0011
        FDB     S6R,0017
        FDB     S5R,0220
ALIVE
        FDB     JAWR,061C
        FDB     CHEEKL,1009
        FDB     CHIN,0615
        FDB     JAWL,060D
        FDB     EYEL,1809
        FDB     CHEEKR,101B
        FDB     EYER,1816
        FDB     NEZ,1013
PIECEND

;* sinistar animation piece table
ANIMTBL FDB     AMOUT1,060C
        FDB     AEYE1,1A0C
        FDB     AMOUT2,060C
        FDB     AEYE2,1A0C
        FDB     AMOUT3,060C
        FDB     AEYE3,1A0C
ANIMEND

;* sinistar image descriptor
ISINI   FDB     SINIHIG<<8+SINIWID,SINIMAG,SINICLI,SINILCE<<8+SINISCE   ;;Fixme was: ISINI      FDB     SINIHIG!<8+SINIWID,SINIMAG,SINICLI,SINILCE!<8+SINISCE
        FCB     0

;* scanner velocity initialization table
SCIVELT FCB     -1,0
        FCB     0,0
        FCB     0,-1
        FCB     0,1
        FCB     1,-1
        FCB     1,1
        FCB     -1,1
        FCB     -1,-1
        FCB     1,0
ESCIVEL EQU     *

;* index to player scanner workspace
PLAINDE FDB     SPLAYER

;* clipping object scroll on screen vectors
CSCRON  FDB     CONTOP          ;scroll onto top edge of screen
        FDB     CONBOT          ;scroll onto bottom edge of screen
        FDB     CONRIG          ;scroll onto right edge of screen
        FDB     CONLEF          ;scroll onto left edge of screen

;* non-clipping scroll on screen vectors
NSCRON  FDB     NONTOP          ;scroll onto top edge of screen
        FDB     NONBOT          ;scroll onto bottom edge of screen
        FDB     NONRIG          ;scroll onto right edge of screen
        FDB     NONLEF          ;scroll onto left edge of screen

;* collision 1/2 matrix (must assemble before collision handling routines)
CLTABLE RPT     NCOLLIS*(NCOLLIS+1)/2,FDB TRAP                  ;;Fixme was: CLTABLE    RPT     NCOLLIS*(NCOLLIS+1)/2,<FDB TRAP>

;* color palette
        RADIX   8
;*              bgr      #    intensity color
PALETTE FCB     000     ;0        0     black
        FCB     377     ;1      100     white
        FCB     277     ;2       92     cream
        FCB     256     ;3       76     salmon pink*
        FCB     255     ;4       70     tan grey
        FCB     244     ;5       60     grey
        FCB     232     ;6       46     blue-grey
        FCB     000     ;7        ?     special effect
        FCB     000     ;8        ?     special effect
        FCB     311     ;9       53     blue-intense
        FCB     120     ;A       24     dark grey
        FCB     113     ;B       32     dark purple
        FCB     005     ;C       43     burgundy
        FCB     007     ;D       60     red
        FCB     000     ;E        ?     special effect
        FCB     067     ;F       80     yellow
        RADIX   16

;* zone color table
ZCOLTBL FCB     $00             ;void zone
        FCB     $DD             ;worker zone
        FCB     $BB             ;warrior zone
        FCB     $66             ;planetoid zone

        PULLORG ROMSAVE
