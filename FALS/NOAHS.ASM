;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                                                                            *
;*                                                                            *
;*      N   N   OOO    AAA   H   H  ''   SSSS         V   V   11    77777     *
;*      NN  N  O   O  A   A  H   H  ''  S             V   V    1       7      *
;*      N N N  O   O  AAAAA  HHHHH   '   SSS          V   V    1      7       *
;*      N  NN  O   O  A   A  H   H          S          V V     1     7        *
;*      N   N   OOO   A   A  H   H      SSSS            V    11111   7        *
;*                                                                            *
;*          S     I     N     I     S     T     A     R           17          *
;*                                                                            *
;*         A game by Noah Falstein, Rich Witt, Sam Dicker and Bob Mical       *
;*               Copyright (c) 1982 by Williams Electronics Inc.              *
;*                                                                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;SINISTAR.EQU SET *

;       INCLUDE [SAM]tSTART
;       NLIST
;       INCLVER NOAH,NOAHS.SET  ;* Equates extracted from SAM and RICH
;       INCLVER NOAH,NOAHS.SYM
;       LIST

;       INCLVER NOAH,N0         ;* Check for replacement symbols
;*                      ;This doesn't work, so I'm assembling it separately

;*      INCLVER NOAH,N1
        INCLUDE "../FALS/N2.ASM"
        INCLUDE "../FALS/N3.ASM"

;LEVEL  SET     1                       ;* For Sinistar.Equ
;       ENDTEST
;       END