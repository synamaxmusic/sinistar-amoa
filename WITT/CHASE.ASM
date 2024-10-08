        PUSHORG ROMSAVE
;*****
;*
;* CHASE
;*      Adjust a desired speed closer to the velocity of a moving target.
;*
;* Needs:
;*      D =  the relative desired speed of the craft
;*      X -> the speed table for the craft (top entry contains its limitations)
;*      Y = the speed of the target
;*
;* Returns:
;*      D = the adjusted desirable speed of the craft
;*
;*****
        ROUTINE Chase
        pshs    D,Y             ;* Save the assumed desired speed
        tfr     Y,D             ;* Convert the 8-bit scanner
        tsta
        blt     .10S            ;* If the target and the
        tst     0,S             ;*   craft are moving in
        blt     .88S            ;*   the positive direction,
        addd    ,S++            ;* Then, add the assumed desired speed
        cmpd    OSTBLS,X        ;* Compare new speed against max. craft speed
        ble     .99S            ;*   to make sure that the new speed
        ldd     OSTBLS,X        ;*   isn't faster than the craft's capability.
        bra     .99S
;*
.10S    tst     0,S             ;* If the target and the craft
        bge     .88S            ;*   are both moving in the negative
        addd    ,S++            ;*   direction, then add the desired speed
        pshs    D               ;* Save it
        ABSD                    ;* Make it positive and compare
        cmpd    OSTBLS,X        ;*   the new speed against max. craft speed
        ble     .88S            ;*   to make sure that the new speed
        CLRD                    ;*   isn't faster than the craft's maximum
        subd    OSTBLS,X        ;*   capability (in the negative direction).
        std     0,S             ;* Replace the saved value with the maximum
.88S    puls    D               ;* Restore the assumed desired speed unchanged.
.99S    puls    Y               ;* Restore work registers.
        rts

        PULLORG ROMSAVE