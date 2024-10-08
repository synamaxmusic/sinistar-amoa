;;      SUBTTL  BASSAVE
;;      PAGE
;*****
;*
;*      BBBB    AAA    SSSS   SSSS   AAA   V   V  EEEEE
;*      B   B  A   A  S      S      A   A  V   V  E
;*      BBBB   AAAAA   SSS    SSS   AAAAA  V   V  EEEE
;*      B   B  A   A      S      S  A   A   V V   E
;*      BBBB   A   A  SSSS   SSSS   A   A    V    EEEEE
;*
;*****
        PUSHORG BASSAVE
        PULLORG BASSAVE

;;      SUBTTL  PLAYSAVE
;*****
;*
;*      PPPP   L       AAA   Y   Y   SSSS   AAA   V   V  EEEEE
;*      P   P  L      A   A   Y Y   S      A   A  V   V  E
;*      PPPP   L      AAAAA    Y     SSS   AAAAA  V   V  EEEE
;*      P      L      A   A    Y        S  A   A   V V   E
;*      P      LLLLL  A   A    Y    SSSS   A   A    V    EEEEE
;*
;*****
        PUSHORG PlaySav
DTime   rmb     2       ;* Difficulty Timer
Pop     rmb     21      ;*((CDTEnd-ScoCdt)*3)/2 * Pop. of sector - each 3 bytes
;*                                corresponds to a C.D. - first byte is
;*                                current Population, next two are desired pop.
WAgg    rmb     2               ;* Warrior aggression factor
SiniKills       rmb     1       ;* The number of Sinistars killed.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PLUWPF  RMB     1               ;Add the PlayerUpWarpFlag to the player's RAM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        PULLORG PlaySav

;;      SUBTTL  RAMSAVE
;*****
;*
;*      RRRR    AAA   M   M   SSSS   AAA   V   V  EEEEE
;*      R   R  A   A  MM MM  S      A   A  V   V  E
;*      RRRR   AAAAA  M M M   SSS   AAAAA  V   V  EEEE
;*      R  R   A   A  M   M      S  A   A   V V   E
;*      R   R  A   A  M   M  SSSS   A   A    V    EEEEE
;*
;*****
        PUSHORG RamSav                                                  ;;Fixme was: PUSHORG    RamSave (It's important to note that RAMSAVE and RAMSAV are different)
KeyClee
KeyWorker       rmb     2               ;* Keystone for workers
KeyWarrior      rmb     2               ;* Keystone for Warriors
;*
ASCPtr  rmb     2               ;* Pointer to the current animation data.
ASCInt  rmb     1               ;* The interuptabilty flag. (clear to int.)
ASCTime rmb     1               ;* The time remaining for further animation.
;*
OvPlAng rmb     1               ;**
OvLVel  rmb     2               ;* Storage for KRSini
OvSVel  rmb     2               ;**
InWarp  rmb     1               ;* NON-ZERO when the player is in warp.
;*
KenChk  rmb     1               ;* Copyright violation when NON-ZERO.
WECheck rmb     1               ;* Williams Electronics invocation.
;*
SiniOrbit       rmb     1       ;* Orbiting direction for Sinistar.
WorkOrbit       rmb     1       ;* Orbiting direction for workers.
WarrOrbit       rmb     1       ;* Orbiting direction for warriors.
;*
InBombs         rmb     1       ;* Number of sinibombs in flight.
InStun          rmb     1       ;* Sinistar stun timer.
PlaGrave        rmb     1       ;* Player grave marker while dead.
SinGrave        rmb     1       ;* Sinistar grave marker while dead.
;*
;InImpulse      rmb     1       ;* The following timeline applies to the
;***                            *   player warp out sequence:
;*      Sinistar dies.
;*      + Warp sequence begins. Impulse engines carry player toward Sinistar.
;*      |
;*      + Player reaches Sinistar, it explodes, Scotty gives Warp 7.
;*      |
;*      + New zone is entered, player slows down.
;*      |
;*      + End of warp sequence.
;***
;HSTDMRQ        RMB     1               ;Flag set when HSTD/Marquee page is displayed
        PULLORG RamSav                                                  ;;Fixme was: PULLORG  RamSave (this was messing up Noah's RAM stuff)

;       SUBTTL  SRAMSAVE
;*****
;*
;*       SSSS  RRRR    AAA   M   M   SSSS   AAA   V   V  EEEEE
;*      S      R   R  A   A  MM MM  S      A   A  V   V  E
;*       SSS   RRRR   AAAAA  M M M   SSS   AAAAA  V   V  EEEE
;*          S  R  R   A   A  M   M      S  A   A   V V   E
;*      SSSS   R   R  A   A  M   M  SSSS   A   A    V    EEEEE
;*
;*****
        PUSHORG SRAMSAV
;***
;*      The RAM image for the animated bomb must be in STATIC RAM where
;*      the access time is fast enough to perform the image DMA.
;***
RISBomb rmb     1+2+8+(3*5)     ;* Exec changable descriptor for SiniBombs.
        PULLORG SRAMSav                                                         ;;Fixme was:    PULLORG SRAMSave