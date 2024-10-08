;       PAGE
;*****
;*
;*       SSSS  Y   Y  M   M   SSSS   AAA   M   M
;*      S       Y Y   MM MM  S      A   A  MM MM
;*       SSS     Y    M M M   SSS   AAAAA  M M M
;*          S    Y    M   M      S  A   A  M   M
;*      SSSS     Y    M   M  SSSS   A   A  M   M
;*
;*      These equates are available for part one of the Sinistar assembly
;*      which is assembled as SAMS.  Only those equates needed by that part
;*      of the assembly are included here.
;*
;*****
        IFNDEF  LEVEL
LEVEL   SET     0
        ENDIF

;* Color nibbles
BLACK           EQU     $00
;;BLUE          EQU     $99     ;;(Already defined in PHRASE.ASM)
BLUEGREY        EQU     $66
BURGANDY        EQU     $CC
CREAM           EQU     $22
GREY            EQU     $AA
PINK            EQU     $33
PURPLE          EQU     $BB
;;RED           EQU     $DD     ;;(Already defined in PHRASE.ASM)
TANGREY         EQU     $44
WHITE           EQU     $11
YELLOW          EQU     $FF

;;===============================================================================
SILVER          EQU     $55     ;; This EQU instruction (which only exists in BOBS.EQU)
                                ;;   was not originally defined here,
                                ;;   but is referenced in MICA/STATUS.ASM
;;===============================================================================

        RADIX   10              ;;(needed to add this)
CIRCLE  EQU     256             ;* There are 256 degrees in our circles.

MAXBOMB EQU     20              ;* The max. num. of bombs the player can hold.
        RADIX   16              ;;(needed to add this)