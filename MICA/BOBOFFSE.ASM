;       INCLUDE [SAM]START
;       INCLVER SAM,SINISTAR.EQU

;* These define the offsets into the Player Explosion fragment table
        PUSHORG 0

OPXPSP  RMB     2               ;Fragment screen position
OPXPMM  RMB     2               ;Fragment momentum (velocity)

        PULLORG OPXPSZ

;* These define the offsets into the Player Explosion Task RAM space
        PUSHORG OMTLEN

OPXPCK  RMB     1               ;Pick index for which image to display
OPXALV  RMB     1               ;Count for number of turns that task is alive
OPXOTB  RMB     PXPPCT*OPXPSZ*PXPWVS    ;Fragment table

        PULLORG OPXRRQ

;* These define the offsets into the Warrior Explosion fragment table
        PUSHORG 0

OWXPSP  RMB     2               ;Fragment screen position
OWXPMM  RMB     2               ;Fragment momentum (velocity)

        PULLORG OWXPSZ

;* These define the offsets into the Warrior Explosion Task RAM space
        PUSHORG OMTLEN

OWXPCK  RMB     1               ;Pick index for which image to display
OWXALV  RMB     1               ;Count for number of turns that task is alive
OWXOTB  RMB     WRXPCT*OWXPSZ   ;Fragment table

        PULLORG OWXRRQ

;* These define the offsets into the Sinistar Explosion Task RAM space
        PUSHORG OMTLEN

OSXIVL  RMB     1               ;Explosion Increment Value
OSXALV  RMB     1               ;Turns that Explosion Stays Alive
OSXIPT  RMB     2               ;Pointer to the Sinistar RAM image

        PULLORG OSXRRQ



;* These are for the High Score To Date master task
        PUSHORG OTIMER

OHSMP1  RMB     2
OHSMP2  RMB     2
OHSMFLG RMB     1

;OHSMNP RMB     1
        PULLORG OHSMMR



;* These are for the High Score To Date slave task
        PUSHORG OTIMER

OHSCPS  RMB     1
OHSCLT  RMB     1

OHSTPTR RMB     2
OHSPSCR RMB     2

OHSBNC  RMB     1
OHSETM  RMB     1

OHSRTN  RMB     2

OHSINIT RMB     OPENLEN

;OHSESZ RMB     1
;OHSPPR RMB     2
;OHSBADR        RMB     2
        PULLORG OHSTDMR


        PUSHORG 0
OPEXPOS RMB     2
OPEXVEL RMB     2
        PULLORG

        PUSHORG OMTLEN
OPEXCTR RMB     1
OPEXWSP RMB     PLEXWSZ*PLEXWCT*4
        PULLORG OPEXTSZ