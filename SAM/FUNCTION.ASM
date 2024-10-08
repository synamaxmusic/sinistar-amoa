;;      INCLUDE "../SAM/START.ASM"

;;===============================================================================
; EQUs to remove later
;frectan        EQU     $4E98   ;SAMTABLE
;QUADTBL        EQU     $4E89   ;SAMTABLE
;SINETBL        EQU     $4E49   ;SAMTABLE
;;===============================================================================

        PUSHORG ROMSAVE

;;      SUBTTL  MATH FUNCTIONS

FUNCTIONS

;*****
;*
;* RECTANG
;*      Rectangular to angle conversion.
;*
;* History:
;*      Written by Sam.  Rich required the work registers to be saved 9/22/82.
;*
;* Needs:
;*      A = LONG distance
;*      B = SHORT distance
;*
;* Returns:
;*      A = Signed angle.  A full circle is 256 degrees.
;*
;*****
RECTANG pshs    B,X             ;* Save work registers
        STD     --S
        BPL     .1S
        NEGA
.1S     TSTB
        BPL     .2S
        NEGB
.2S     BITA    #$F0
        BEQ     .3S
        LSRA
        LSRB
        BITA    #$F0
        BNE     .2S
.3S     BITB    #$F0
        BEQ     .4S
        LSRA
        LSRB
        BITB    #$F0
        BNE     .3S
.4S     STA     -S
        RPT     4,ASLB
        ADDB    S+
        leax    frectan,PCR     ;* X -> FRECTAN table
        ABX
        LDA     X
        LDB     S+
        BPL     .5S
        NEGA
        ADDA    #$80
.5S     LDB     S+
        BPL     .6S
        NEGA
.6S     puls    B,X,PC          ;* Restore work registers nad return

;*****
;*
;* SMUL8
;*      Signed 8-bit multiply.
;*
;* Needs:
;*      A = Signed 8-bit multiplier
;*      B = Signed 8-bit multiplicand
;*
;* Returns:
;*      D = Signed 16-bit product.
;*
;*****
smul8
        pshs    A,B             ;* Save signed values
        tsta                    ;* Let A be
        bpl     .1S             ;*   the absolute value
        nega                    ;*   of A.
.1S     tstb                    ;* Let B be
        bpl     .2S             ;*   the absolute value
        negb                    ;*   of B.
.2S     mul                     ;* Multiply (unsigned).
        tst     ,S+             ;* If A was originally
        bpl     .3S             ;*   negative,
        NEGD                    ;*   then negate the product.
.3S     tst     ,S+             ;* If B was originally
        bpl     .4S             ;*   negative,
        NEGD                    ;*   then negate the product.
.4S     rts

;******
;*
;* SINCOS
;*      Determine the sine and cosine of a signed angle.
;*      (Here, a circle consists of 256 degrees.)
;*
;* Needs:
;*      A = Angle in 1/256ths of a circle.
;*
;* Returns:
;*      A = sine(angle)
;*      B = cosine(angle)
;*
;*****
SINCOS  PSHS    A,X,U           ;save angle and registers
        ANDA    #%11000000      ;get quadrant
        RPT     4,LSRA          ;adjust to lookup on quadtant table
        LDU     #QUADTBL        ;get address of quadrant table in U
        LEAU    A,U             ;point to entry for this quadrant
        LDX     #SINETBL        ;get address of sine table in X
        PULS    A               ;get angle in A
        EORA    U               ;adjust to lookup cosine
        LDB     A,X             ;get cosine in B
        EORB    1,U             ;give cosine correct sign
        EORA    #%00111111      ;adjust to lookup sine
        LDA     A,X             ;get sine in A
        EORA    2,U             ;give sine correct sign
        PULS    X,U,PC          ;restore register and return

;* ranged random byte           ;pass seedoffset in A, range B, returns number A
RAND8R  PSHS    B               ;> uses A,B
        BSR     RAND8           ;save none, uses A,B
        PULS    B
        MUL
        RTS

;* random byte                  pass seedoffset in A, returns number in A
RAND8B  PSHS    B               ;> uses A
        BSR     RAND8           ;save none, uses A,B
        PULS    B,PC

;* random word                  ;pass seedoffset in A, returns number in D
RAND8   PSHS    X               ;> uses A,B
        LDX     #SEEDS
        LEAX    A,X
        LDA     X
        ASLA
        EORA    X
        ASLA
        ASLA
        LDD     X
        ROLB
        ROLA
        STD     X
        BNE     .1S
        SWI                     ;* * *TEMPORARY TRAP
.1S     PULS    X,PC

;* set a list value from A      pass value in A, list addr in word after call
SETA    PSHS    D,X,U           ;save all regs > uses none
        CLRB                    ;zero B
        BRA     SETD1           ;uses A,B,X,U

;* set a list value from D      pass value in D, list addr in word after call
SETD    PSHS    D,X,U           ;save all regs > uses none
SETD1   LDX     6,S             ;get address of list address in X
        LDU     [X]             ;get master variable address in U
        LEAX    -1,X            ;get address of list address - 1 in X
        SUBD    U               ;get change in master variable in D
        BGE     .1S             ;raise or lower?
        BSR     LOWER           ;lower master and slaves, save X, uses D,U
        BRA     .2S
.1S     BSR     RAISE           ;raise master and slaves, save X, uses D,U
.2S     LEAX    3,X             ;advance return address
        STX     6,S
        PULS    D,X,U,PC        ;return

;* change a list value from A   pass change in A, list addr in word after call
CHGA    PSHS    D,X,U           ;save all regs > uses none
        CLRB                    ;zero B
        BRA     CHGD1           ;uses A,B,X,U

;* change a list value from D   pass change in D, list addr in word after call
CHGD    PSHS    D,X,U           ;save all regs > uses none
CHGD1   LDX     6,S             ;get address of list address in X
        LEAX    -1,X            ;get address of list address - 1 in X
        TSTA                    ;raise or lower?
        BPL     .1S
        BSR     LOWER           ;lower master and slaves, save X, uses D,U
        BRA     .2S
.1S     BSR     RAISE           ;raise master and slaves, save X, uses D,U
.2S     LEAX    3,X             ;advance return address
        STX     6,S
        PULS    D,X,U,PC        ;return

;* raise a list value           pass change in D, addr of list address - 1 in X
RAISE   PSHS    X               ;save regs > uses D,U
        LDX     1,X             ;get list address in X
        LDU     X               ;get master variable address in U
        ADDB    1,U             ;add lower byte of change to master variable
        STB     1,U
        ADCA    #0              ;add carry to upper byte of change
        BEQ     .4S             ;change zero?, done
        PSHS    A               ;save upper byte of change
        ADDA    U               ;add upper byte of change to master variable
        CMPA    U               ;check for clip
        BGE     .5S
        LDD     #$7FFF          ;yes, raise it to the limit
        SUBA    U
        LEAS    1,S             ;restore regs
        PULS    X               ;start routine again
        BRA     RAISE
.5S     STA     U
        LEAX    2,X             ;advance list to first slave coefficient
.1S     LDA     S               ;multiply upper byte of change (+)
        LDB     X               ;with slave coefficient (signed)
        BEQ     .3S             ;zero coeffient terminates list
        MUL
        BPL     .2S             ;check sign of coefficient
        SUBA    S               ;negative, correct multiply
        ASLB                    ;double product
        ROLA
        BSR     LOWER           ;lower slave and its slaves, save X, uses D,U
        LEAX    3,X             ;advance to next slave
        BRA     .1S             ;repeat
.2S     ASLB                    ;positive, double product
        ROLA
        BSR     RAISE           ;raise slave and its slaves, save X, uses D,U
        LEAX    3,X             ;advance to next slave
        BRA     .1S             ;repeat
.3S     LEAS    1,S             ;restore stack
.4S     PULS    X,PC            ;return

;* lower a list value           pass change in D, addr of list address - 1 in X
LOWER   PSHS    X               ;save regs > uses D,U
        LDX     1,X             ;get list address in X
        LDU     X               ;get master variable address in U
        ADDB    1,U             ;add lower byte of change to master variable
        STB     1,U
        ADCA    #0              ;add carry to upper byte of change
        BEQ     .4S             ;change zero?, done
        PSHS    A               ;save upper byte of change
        ADDA    U               ;add upper byte of change to master variable
        CMPA    U               ;check for clip
        BLE     .5S
        LDD     #$8000          ;yes, lower it to the limit
        SUBA    U
        LEAS    1,S             ;restore regs
        PULS    X               ;start routine again
        BRA     LOWER
.5S     STA     U
        LEAX    2,X             ;advance list to first slave coefficient
.1S     LDA     S               ;multiply upper byte of change (-)
        LDB     X               ;with slave coefficient (signed)
        BEQ     .3S             ;zero coeffient terminates list
        MUL
        BPL     .2S             ;check sign of coefficient
        SUBA    S               ;negative, correct multiply
        SUBA    X               ;correct for negative upper byte of change
        ASLB                    ;double product
        ROLA
        BSR     RAISE           ;raise slave and its slaves, save X, uses D,U
        LEAX    3,X             ;advance to next slave
        BRA     .1S             ;repeat
.2S     SUBA    X               ;positive, correct for negative change
        ASLB                    ;double product
        ROLA
        BSR     LOWER           ;lower slave and its slaves, save X, uses D,U
        LEAX    3,X             ;advance to next slave
        BRA     .1S             ;repeat
.3S     LEAS    1,S             ;restore stack
.4S     PULS    X,PC            ;return

;*****
;*
;* Arithmetic Shifts for the D register (N bits)
;*
;*      asrd7 - Shift D right 7 bits    (Divide by 128)
;*      asrd6 - Shift D right 6 bits    (Divide by 64)
;*      asrd5 - Shift D right 5 bits    (Divide by 32)
;*      asrd4 - Shift D right 4 bits    (Divide by 16)
;*      asrd3 - Shift D right 3 bits    (Divide by 8)
;*      asrd2 - Shift D right 2 bits    (Divide by 4)
;*      asrd1 - Shift D right 1 bit     (Divide by 2)
;*      asrd0 - Shift D right 1 bit     (Divide by 1)
;*
;* Needs:
;*      D = the value to scale up or down.
;*
;* Returns:
;*      D = (D >> N-Bits) for right shifts or
;*          (D << N-Bits) for left shifts.
;*
;*****
        ROUTINE shifts
asrd7
        asra            ;* Signed division.
        rorb
asrd6
        asra
        rorb
asrd5
        asra
        rorb
asrd4
        asra
        rorb
asrd3
        asra
        rorb
asrd2
        asra
        rorb
asrd1
        asra
        rorb
asrd0
        rts

        PULLORG ROMSAVE