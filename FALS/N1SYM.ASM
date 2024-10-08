;****
;       INCLUDE "../SAM/START.ASM"

        PushOrg ROMSAVE

OWorker equ     0               ;* Offsets
OWarrior equ    1
DstMod  equ     $40             ;* Modifiers to calculate priorities
QuoMod  equ     $06             ;* This modifier uses the B fraction
DMoMax  equ     DstMod          ;* Maximum distance mod, given Dist**2
WrstPri equ     1               ;* Worst priority to consider
MUAD    equ     $F8             ;* Minimum uncondit. accept dist. mod. `
SintrP  equ     $FF-DMoMax      ;* SiniStar intercept mission priority
VibDamp equ     $02             ;* How much vibration is damped
RchMax  equ     $60             ;* Maximum Richter before shattering
MisVib  equ     $10             ;* Amount missile adds to vibration
CryDamp equ     10              ;* Crystal damping factor
CrProb  equ     $10             ;* Chance (/255) of tossing a crystal
MaxCrA  equ     10              ;* Number of seconds in maxium crystal age
CatPrb  equ     60              ;* Probability (/100 hex/sec)of catching crystal
;*                                offscreen if worker is close enough
;CryDis equ     $0C             ;* Distance in scanner scale of minimum

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CryDis  equ     $06             ;* Distance in scanner scale of minimum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;*                                for worker to catch crystal
;MinPrb equ     $B0             ;* Probability (/255 per sec) of trying to mine
;MinDis equ     $20             ;* Distance workers and warriors must be from

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MinPrb  equ     $70             ;* Probability (/255 per sec) of trying to mine
MinDis  equ     $14             ;* Distance workers and warriors must be from
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;*                                Planet to mine it offscreen - scanner coords
SwrPrb  equ     $10     ;* Probability of swarm in /255 per 4 sec ($10 = 1/min)
;*
MinFree equ     0600    ;* Max out population when freespace goes below 1.5K
;*                       This is minimum freespace allowed when creating things
;*
;*                      Attract mode equates
;*

SSize   equ     08      ;* Size between small lines
LSize   equ     0B      ;* Size between large lines
FirLin  equ     60      ;* First line on screen
LefEdg  equ     2C      ;* Left edge

;* Intelligence task - additions
        PushORG OMTLEN
OWSCON  rmb     2               ;* index to controlled workspaceO
;       PAD     OWIS,2
OWISSAV SET     *
        RMB     2
OWISLEN RMB     0
        PullOrg

;* Explosion intelligence task
        PushOrg OMtLen
OSWSA   rmb     2       ;* Screen WS Address of this explosion
OImNo   rmb     1       ;* Which image number we are now displaying
        PullOrg OExpLen

;* Equates for Caller routine

;* Scanner WS for Callees - additions
        PushOrg OSCLEN
OSCNIN  rmb     2               ;* Index of sleep task with intelligence
OIWScIn rmb     2               ;* Index to W/W secondary intelligence
OSCWCR  rmb     2               ;* Scanner WS of Caller index
OCALPRI rmb     1               ;* Priority of current call
OSCTYPT rmb     2               ;* Pointer to next WS of same type (W/W)
OSCSQI  rmb     2               ;* Pointer to next squadron member
OSCLDC  RMB     1       ;\      ;* Long Distance to Caller
OSCSDC  RMB     1       ;/      ;* Short Distance to Caller
OSFLANG rmb     1               ;* Flight angle
OSOFLAN rmb     1               ;* Old Flight angle
OSSQSIZ rmb     1               ;* Squadron size
OSMIS   rmb     1               ;* Mission type
OSSQPOS rmb     1               ;* Position of warrior in squadron.
OSANANG rmb     1               ;* Animation angle (for turret and shooting)
OSFAST  rmb     1               ;* Warrior Flight Angle STep change for aiming.
;       PAD     OSWW,6
OSWWSAV SET     *
        RMB     6
OSWWLEN RMB     0
        PullOrg

;* Scanner WS for Callers - additions
        PushOrg OSCLEN
OSCoCaI rmb     2               ;* Controlling Caller Intelligence index
OICScIn rmb     2               ;* Index to Callr secondary intelligence
OQUOTA  rmb     2               ;* Quota bytes for W/W on call
OCLELS  rmb     4               ;* Callee list - room for 6 callees
;       PAD     OSWC,2          * End of scanner ws of callers
OSWCSAV SET     *
        RMB     2
OSWCLEN RMB     0
        PullOrg

;*                      Intelligence WS for crystal secondary intelligence
        PUSHORG OWISSav         ;* Org at end of intelligence WS
OCrAge  rmb     1               ;* Crystal Age
        PULLORG OCrSILn         ;* Crystal Secondary Intelligence Length

;*                      Intelligence type table
        PushOrg 0
IQPlan  rmb     2               ;* Planetoid
IQPlay  rmb     2               ;* Player
IQSini  rmb     2               ;* Sinistar
IQSBomb rmb     2               ;* Sinibomb
IQCrys  rmb     2               ;* Crystals

;*              Callees should be last on the list - not currently in tables
IQWork  rmb     2               ;* Workers
IQWarr  rmb     2               ;* Warriors
        PullOrg

;*                      Vibration Block Offsets
        PushOrg 0
OSVibA  rmb     2               ;* Pointer to vibrating task
OSLVib  rmb     2               ;* Vibration that has been added in Long
OSSVib  rmb     2               ;* Vibration added to short velocity
OSRcht  rmb     1               ;* Richter scale - violence of vibration
        PullOrg OVBLen


;*                      Vibration Block Locations
        PushOrg OScLen          ;* Scanner WS end for dumb planets
VDPlan  rmb     OVBLen
;       PAD     OSDP,2          * Length of Dumb Planet scanner WS
OSDPSAV SET     *
        RMB     2
OSDPLEN RMB     0
        PullOrg
;*
        PushOrg OSWCLen         ;* Scanner WS end for callers
VCaller rmb     OVBLen
;       PAD     OSVC,2          * Length of Vibrating Caller Scan WS
OSVCSAV SET     *
        RMB     2
OSVCLEN RMB     0
        PullOrg

;* TEMP equates
        PushOrg 0
OCler   rmb     1               ;* Caller type
OClee   rmb     1               ;* Callee type
OCombo  rmb     1               ;* Combination of caller/callee codes
OQtaFct rmb     1               ;* Modified quota factor
OPriMod rmb     1               ;* Modified priority
OPriMax rmb     1               ;* Mod. priority with max distance add
OBstPri rmb     1               ;* Highest calling priority generated
OBstClee rmb    2               ;* Index of best callee found
OMoDst  rmb     1               ;* Modified distance factor
OurPri  rmb     1               ;* Priority of caller on this call
OHisDs  rmb     2               ;* Distance of callee being processed
OBstDs  rmb     2               ;* Distance from caller of best callee
OHisPri rmb     1               ;* Callee's actual prio with dist. mod.
        PullOrg

        PullOrg RomSave                                 ;;Fixme was: PullOrg RomSav (renaming RomSav to ROMSAVE for consistency)
