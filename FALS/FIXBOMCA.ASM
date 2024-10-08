;       Include [sam]Start
;       InclVer SAM,SiniStar.equ

FixBomCal.Src

;*              Fixes SiniBombs calling player ship in demo mode

        PushOrg $76A4           ;* Org over jump to 7686 (1$) in caller
        fdb     1$              ;* make it jump to our routine instead
        PullOrg

        PushOrg RomSav

1$      pshs    A               ;* Don't screw up callee
        lda     Temp+OCler
        cmpa    #06             ;* See if caller is sinibomb
        bne     2$              ;* if not just continue call

        tst     AMDemo          ;* See if we are in demo mode
        beq     2$              ;* if not, continue call
        puls    A
        jmp     $77C5           ;* else abort call

2$      puls    A
        jmp     $7686           ;* Go back to continue call

        PullOrg RomSav

;       Local