;       INCLVER RICH,table              ;* ORG Macro

        PUSHORG ROMSAVE

        RADIX   10

;       TABLE   stblintercept           ;* Workers without crystals
stblintercept
        fdb     (1536),(65<<4),asrd3                    ;;Fixme was: fdb (1536.),(65.!<4),asrd3
        fdb     (0080),($0300),asrd4                    ;;Fixme was: (0080.),($0300),asrd4
        fdb     (0064),($02C0),asrd4                    ;;Fixme was: (0064.),($02C0),asrd4
        fdb     (0048),($0240),asrd3                    ;;Fixme was: (0048.),($0240),asrd3
        fdb     (0032),($0200),asrd3                    ;;Fixme was: (0032.),($0200),asrd3
        fdb     (0008),($0100),asrd2                    ;;Fixme was: (0008.),($0100),asrd2
        fdb     (0000),($00C0),asrd1                    ;;Fixme was: (0000.),($00C0),asrd1
;       PAD     (8.-((*-stblintercept)/OSTBLZ))*OSTBLZ  ;* Pad entries
        RMB     (8-((*-stblintercept)/OSTBLZ))*OSTBLZ
;       ENDTBL

        RADIX   16

        PULLORG ROMSAVE