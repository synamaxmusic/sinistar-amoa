        PUSHORG ROMSAVE
;*****
;*
;* THINKCHK
;*      The THINK CHECK routine indicates whether or not it is safe to 'think'
;*      (continue the intelligence routine) based on a flipping bit in the
;*      personality byte of the intelligence's scanner workspace.
;*
;* Changes to V9:
;*      PTHINK bit in OSPERS made to correspond to CARRY BIT in returned CC.
;* Changes to V13:
;*      Thinking always occurs when on screen.
;*
;* Needs:
;*      Y -> scanner workspace for this task
;*      OSPERS,Y = the pseudo random personality for this task
;*              PTHINK = the think/nothink bit in OSPERS
;*
;* Returns:
;*      OSPERS,Y will have the PTHINK bit flipped.
;*      CARRY CLEAR - means the intelligence may think
;*      CARRY  SET  - means the intelligence should not think
;*
;*****
        ROUTINE Think
        pshs    A,U             ;* Save work registers.
        lda     OSPERS,Y        ;* The personality controls the think tasklist.
        ldu     OSSCWSA,Y       ;* If the object is on the screen
        bne     .1S             ;*   then "think" this time for sure!
        bita    #PTHINK         ;* Else, think when the personality
        bne     .2S             ;*   is clear to think (next time).
.1S     ora     #PTHINK         ;* It is clear to think this time
        sta     OSPERS,Y        ;*   but not next time, so mark it unable
        puls    A,U             ;*   to do think the next time it wakes.
        andcc   #~(CARRY)       ;* Mark the return clear to think.              ;;Fixme was: andcc  #!N(CARRY)
        rts

.2S     anda    #~(PTHINK)      ;* Clear for thinking the next time,            ;;Fixme was: anda   #!N(PTHINK)
        sta     OSPERS,Y        ;*   this intelligence wakes up.
        puls    A,U             ;* Restore the work registers.
        orcc    #CARRY          ;* Mark the return unable to think.
        rts

        PULLORG ROMSAVE