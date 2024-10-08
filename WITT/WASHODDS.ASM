        PUSHORG ROMSAVE
;       SUBTTL  WASHODDS        ;The odds for a warrior to fire are determined.
;*****
;*
;* WASHODDS
;*      The Warrior shooting odds are determined from the difficulty factor.
;*      As the difficulty factor increases from 0 to 512, the odds increase
;*      from 1 in 5 to 1 in 1.
;*
;* Needs:
;*      WAgg = An aggression rating increasing from 0 to 255.
;*
;* Returns:
;*      CARRY CLEAR - Warrior may shoot this round.
;*      CARRY  SET  - Warrior may not shoot.
;*
;*****
        ROUTINE washodds
        pshs    A,B             ;* Save work registers
        clra                    ;* Use the aggression of the warrior's
        ldb     WAgg            ;*   difficulty factor to determine
        comb                    ;*   the odds in which to fire.  The odds
        andb    #$7F            ;*   of course, get better as the
        RPT     5,lsrb          ;*   difficulty factor goes up.
        incb                    ;* Compute a pseudo random
        addd    #OSEED2<<8      ;*   number for the odds of 0 to N.                     ;;Fixme was: addd  #OSEED2!<8
        jsr     rand8r          ;*   (N computed from WAgg, max. val. = 4)
        adda    #$FF            ;* Mark the carry bit clear to shoot.
        puls    A,B             ;* Restore work registers
        rts

        PULLORG ROMSAVE