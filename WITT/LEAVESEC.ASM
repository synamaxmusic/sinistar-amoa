;===============================================================================
; EQUs to remove later
;LSSBomb        EQU     $5D2F
;LSSINI EQU     $5DBE
;LSWOCR EQU     $5D6A
;===============================================================================

        PUSHORG ROMSAVE
;*****
;*
;* LEAVESECTOR
;*
;* Needs:
;*      Y -> scanner workspace of object leaving sector
;*      U -> characteristics descriptor of object leaving sector
;*
;* Returns:
;*      Nothing
;*
;*****
;LeaveSector
;       pshs    X               ;* Save work register
;       leax    Y               ;* Y -> scanner workspace of object
;       jsr     [OKiVec,U]      ;* Kill object
;       puls    X,PC            ;* Restore work register and return
;
;       PULLORG ROMSAVE
;
;;* player ship
;       PUSHORG CPLAYER+OLSVEC
;       FDB     TRAP                    ;vector to leave-sector routine
;       PULLORG
;;* planetoid 1
;       PUSHORG CPLAN1+OLSVEC
;       FDB     LeaveSector             ;vector to leave-sector routine
;       PULLORG
;;* planetoid 2
;       PUSHORG CPLAN2+OLSVEC
;       FDB     LeaveSector             ;vector to leave-sector routine
;       PULLORG
;;* planetoid 3
;       PUSHORG CPLAN3+OLSVEC
;       FDB     LeaveSector             ;vector to leave-sector routine
;       PULLORG
;;* planetoid 4
;       PUSHORG CPLAN4+OLSVEC
;       FDB     LeaveSector             ;vector to leave-sector routine
;       PULLORG
;;* planetoid 5
;       PUSHORG CPLAN5+OLSVEC
;       FDB     LeaveSector             ;vector to leave-sector routine
;       PULLORG
;;*sinibomb
;       PUSHORG CSBOMB+OLSVEC
;       FDB     LSSBomb                 ;vector to leave-sector routine
;       PULLORG
;;* worker
;       PUSHORG CWORKER+OLSVEC
;       FDB     LeaveSector             ;vector to leave-sector routine
;       PULLORG
;;* warrior
;       PUSHORG CWARRIO+OLSVEC
;       FDB     LeaveSector             ;vector to leave-sector routine
;       PULLORG
;;* sinistar
;       PUSHORG CSINI+OLSVEC
;       FDB     LSSini                  ;vector to leave-sector routine
;       PULLORG
;;* crystal
;       PUSHORG CCRYSTA+OLSVEC
;       FDB     LeaveSector             ;vector to leave-sector routine
;       PULLORG
;;* worker with crystal
;       PUSHORG CWORKCR+OLSVEC
;       FDB     LSWoCr                  ;vector to leave-sector routine
;       PULLORG
;;* sinistar piece
;       PUSHORG CPIECE+OLSVEC
;       FDB     LeaveSector             ;vector to leave-sector routine
;       PULLORG

        INCLUDE "../WITT/LSSBOMB.ASM"           ;* Sinibomb leaving sector
        INCLUDE "../WITT/LSWOCR.ASM"            ;* Worker with crystal leaving sector
        INCLUDE "../WITT/LSSINI.ASM"            ;* Sinistar leaving sector