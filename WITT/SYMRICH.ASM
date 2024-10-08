;       SUBTTL  SYMRICH - Symbols for RICH
;       PAGE
;*****
;*
;*       SSSS  Y   Y  M   M  RRRR   IIIII   CCCC  H   H
;*      S       Y Y   MM MM  R   R    I    C      H   H
;*       SSS     Y    M M M  RRRR     I    C      HHHHH
;*          S    Y    M   M  R  R     I    C      H   H
;*      SSSS     Y    M   M  R   R  IIIII   CCCC  H   H
;*
;*****
        RADIX   10                                                                      ;;Need this for decimal

STBLESIZE equ   4               ;* Speed TaBLe Entry SIZe
AORBIT  EQU     10              ;* Attack (by warrior) orbit factor                     ;;Fixme was: AORBIT     EQU     10.
DORBIT  EQU     2               ;* Drifting worker orbit factor
IORBIT  EQU     6               ;* Inner (warrior mining) orbit factor
OORBIT  EQU     (IORBIT*4)/3    ;* Outer (worker pickup) orbit factor
XORBIT  EQU     1               ;* Sinistar explosion, ship orbit factor
SOrbit  EQU     $20     ;* The dist. at which workers w/crystals orbit sinistar.

SinDis  EQU     80      ;* The offscreen distance at which sinibombs detonate           ;;Fixme was: SinDis     EQU     80.

NITURRET        EQU     8       ;* The number of warrior images                         ;;Fixme was: NITURRET   EQU     8.
NIWORKER        EQU     16      ;* The number of worker images                          ;;Fixme was: NIWORKER   EQU     16.
NIPLSHOT        EQU     32      ;* The number of player shot images                     ;;Fixme was: NIPLSHOT   EQU     32.
NIWASHOT        EQU     32      ;* The number of warrior shot images                    ;;Fixme was: NIWASHOT   EQU     32.
NISBOMB         EQU     3       ;* The number of sinibomb images                        ;;Fixme was: NISBOMB    EQU     3.

;*OSqFac        EQU     4.              ;* Distance factor between squadron members.
;*OSQUAD        EQU     30.
;*OSQUACK       EQU     OSQUAD*3

WarpVel EQU     $0100           ;* Player warp (out) velocity after Sini-Kill.

        PUSHORG 0
OAccuracy       rmb     1       ;* Accuracy component of difficulty factor
OAgression      rmb     1       ;* Agression component of difficulty factor
OQuantity       rmb     1       ;* Quantity component of difficulty factor
;       PAD     ODF,1
ODFSAV  SET     *
        RMB     1
ODFLEN  RMB     0
        PULLORG

        PUSHORG 0
OSTBLD  rmb     2               ;* Distance to target
OSTBLS  rmb     2               ;* Speed appropriate for distance
OSTBLA  rmb     2               ;* Acceleration appropriate for distance
        PULLORG OSTBLZ          ;* Size of a speed table entry
;*****
;*
;* WARRIOR MISSION TABLE OFFSETS
;*
;*      These offsets correspond to entries in the Warrior Mission (WARRMIS)
;*      table.
;*
;*****
        PUSHORG 0
OMWADRIFT       rmb     2       ;* Mission of Warrior to Drift in Space
OMWAATTACK      rmb     2       ;* Mission of Warrior to Attack Player's Craft
OMWAMINE        rmb     2       ;* Mission of Warrior to Mine Planet(oid)
OMWaGuard       rmb     0
OMWATAIL        rmb     2       ;* Mission of Warrior to Tail (Guard) something
OMWAINT         rmb     2       ;* Mission of Warrior to Intercept something
OMWaBomb        rmb     2       ;* Mission of Player to bomb Sinistar in demo.
;       PAD     OMWa,(1*2)      ;* N*2 mission pad allows N additional missions.
OMWaSAV SET     *
        RMB     (1*2)
OMWaLEN RMB     0
        PULLORG
;*****
;*
;* WORKER MISSION TABLE OFFSETS
;*
;*      These offsets correspond to entries in the Worker Mission (WORKMIS)
;*      table.
;*****
        PUSHORG 0
OMWoDrift       rmb     2       ;* Mission of Worker to Drift in Space
OMWoTail        rmb     2       ;* Mission of Worker to Tail (Guard) something
OMWoIntercept   rmb     2       ;* Mission of Worker to Intercept something
OMWoCrystal     rmb     2       ;* Mission of worker to bring crystal to SINI
OMWoEvade       rmb     2       ;* Mission of Worker to abort current course
;       PAD     OMWo,(3*2)      ;* 3 mission pad
OMWoSAV SET     *
        RMB     (3*2)
OMWoLEN RMB     0
        PULLORG
;*****
;*
;* offsets fr`om Temp
;*
;*****
        PUSHORG 0               ;* Temp + These ...
TSinPos         rmb     2       ;* Storage for Sinistar OLPOS and OSPOS
TSinSPos        rmb     2       ;* Storage for Sinistar OSLPOS and OSSPOS
TFollow         rmb     2       ;* Storage for Caller of warrior.
;*OAngle        rmb     1       ;* The animation angle for warriors shooting.
        PULLORG

SCOLR   SET     $100            ;* No Color     ;;Fixme was: .$COLR

PWaShIn EQU     %00001111       ;* Warrior Shooting Inhibitor
PTHINK  EQU     %00100000       ;* Warrior should activate intelligence or not.
PWAIT   EQU     %01000000       ;* Squadron leader waiting for squad to build.
PSHOOT  EQU     %10000000       ;* Turret locked if set, clear to shoot if clear

;MaxSinOrbit    EQU     12      ;* Maximum orbital factor for Sinistar approach.        ;;Fixme was: MaxSinOrbit        EQU     12.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MaxSinOrbit     EQU     10      ;* Maximum orbital factor for Sinistar approach.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PSiniInhibit    EQU     PWaShIn ;* Sinistar personality uses the same bits.

DPower  EQU     2               ;* Distance scaling (in 4 pixels)

MaxDis  EQU     $7F             ;* The distance to the scanner edge.

Transform       EQU     $FC     ;* Distance mask for 4*4 pixel tolerance
;*                              ;*   at which workers deliver crystals.

;*****
;*
;* The following bits describe the controls in PANMASK
;*
;*      BIT  FUNCTION
;*      0 - Set to enable Fire button
;*      1 - Set to enable Sinibomb button
;*      2 - Set to enable Joystick
;*      3 - Set to enable Scrolling and display Stars
;*      4 - Set to enable Player 1 start button
;*      5 - Set to enable Player 2 start button
;*      6 - Unused
;*      7 - Unused
;*
;*****
        RADIX   16                                                                      ;;Switching back to hex