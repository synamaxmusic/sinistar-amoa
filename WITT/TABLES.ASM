;       INCLVER RICH,table              ;* Data table macros
;*
        INCLUDE "../WITT/STBLSBOM.ASM"          ;* Sinibombs
        INCLUDE "../WITT/STBLSINI.ASM"          ;* Sinistar
        INCLUDE "../WITT/STBLOSIN.ASM"          ;* Sinistar  <<< Added by Noah >>>
;*
        INCLUDE "../WITT/STBLMINE.ASM"          ;* Warriors mining
        INCLUDE "../WITT/STBLL0.ASM"            ;* Warriors leading
        INCLUDE "../WITT/STBLW0.ASM"            ;* Warriors following
        INCLUDE "../WITT/STBLW1.ASM"            ;* Warriors intercepting
;*
        INCLUDE "../WITT/STBLWORK.ASM"          ;* Workers circling player
        INCLUDE "../WITT/STBLINT.ASM"           ;* Workers picking up crystals
        INCLUDE "../WITT/STBLHEAV.ASM"          ;* Workers delivering crystals
;*
;       INCLUDE "../WITT/STBLBOMB.ASM"          ;* Player on demo bombing run
;*
        PUSHORG ROMSAVE

tables
;*****
;*
;* SPEED TABLES
;*
;*      STBLJUGGERNAUT  Speed Table for the JUGGERNAUT when attacking.
;*      STBLMINER ....  Speed Table for a WARRIOR craft when mining.
;*      STBLGUARD..     Speed Table for a WARRIOR craft when guarding.
;*      STBLWORKER ...  Speed Table for a WORKER craft.
;*
;*      Each entry in this table is composed of a 16-bit distance measured
;*      in pixels and a 16-bit speed measured in nano-pixels/16msec. whichi
;*      on tasklist 16 comes out to pixels per second.  Both the
;*      acceleration and deceleration use this table (see newvelOCITY).
;*      This is followed by the 16-bit address of the acceleration routine
;*      to be used in achieving the desired speed.
;*
;*      The entries are arranged in order of decreasing distances, terminating
;*      with a zero (0) distance entry.  There may be any number of entries
;*      within a table as long as the last entry is a zero (i.e. smallest
;*      possible) distance entry.
;*
;*      The top entry in the table contains the maximum speed of the craft.
;*      This is used by the velocity update routines UPDLVEL and UPDSVEL.
;*      There is also an acceleration routine here which is used as the default
;*      acceleration (e.g. warrior squadron leaders chasing across the screen
;*      use this entry).
;*
;*      Accelerations may be made different for various crafts by creating
;*      an alternate table with adjusted distances at which to change speeds.
;*      The speeds may normally be entered in a decreasing fashion as cor-
;*      responds to the decreasing distances.  This represents a typical
;*      deceleration (or acceleration) in our universe.  Note however, that
;*      by entering a non-zero speed for the zero (last) distance entry,
;*      the craft will not "home in" and stop, but rather it will "home in"
;*      and collide (intercept?) in a "hit and run" fashion.
;*
;*      STBLMINER -     Speed table for Warriors when mining.
;*                      This table descibes speed changes which are somewhat
;*                      different for an approach toward a planetoid versus
;*                      an approach toward an enemy (player) craft.  While
;*                      the top speed of the warrior craft remains the same,
;*                      a zero velocity is desired at some distance (96 pixels)
;*                      from the target to "keep back" while mining.  When the
;*                      warrior gets too close, the negative speed entries tell
;*                      it to "back away".
;*
;*      The tables here are padded via PAD for non-production patching.
;*      When VERSION == FINAL there will not be any padding.
;*
;*****

;***
;*      Warrior lead pilot attack plan table.
;***
waptbl
        fdb     stblL0          ;* Plan 0 - attack and fly past
        fdb     stblW1          ;* Plan 1 - track and attack
        fdb     stblW2          ;* Plan 2 - suicide intercept
        fdb     stblminer       ;* Plan 3 - just like mining
;***
;*      Single warrior pilot attack plan #2.
;*      Suicide intercept player.
;***

        RADIX   10

stblW2
        fdb     (4000<<3),(140<<4),asrd4
        fdb     (192<<3),(35<<4),asrd4
        fdb     (160<<3),(30<<4),asrd4
        fdb     (128<<3),(26<<4),asrd4
        fdb     (096<<3),(21<<4),asrd3
        fdb     (064<<3),(11<<4),asrd2
        fdb     (000<<3),(04<<4),asrd1
;       PAD     (10.-((*-stblW2)/OSTBLZ))*OSTBLZ        ;* Pad entries
        RMB     (10-((*-stblW2)/OSTBLZ))*OSTBLZ
;***
;*      Warrior guarding in orbit. (TASKLIST 16)
;***
stblguard
;*      fdb     (192<<3),(1120),asrd4
;*      fdb     (160<<3),(0480),asrd3
;*      fdb     (128<<3),(0416),asrd2
;*      fdb     (096<<3),(0336),asrd2
;*      fdb     (064<<3),(0240),asrd2
;*      fdb     (048<<3),(0176),asrd1
;*      fdb     (032<<3),(0128),asrd1
;*      fdb     (016<<3),(0064),asrd1
;*      fdb     (000<<3),(0000),asrd1
;*
        fdb     (4000<<3),(2000),asrd4
        fdb     (400<<3),(0528),asrd3
        fdb     (192<<3),(0448),asrd2
        fdb     (160<<3),(0368),asrd2
        fdb     (128<<3),(0328),asrd2
        fdb     (096<<3),(0248),asrd2
        fdb     (064<<3),(0128),asrd1
        fdb     (032<<3),(0048),asrd1
        fdb     (000<<3),(0000),asrd1
;       PAD     (10.-((*-stblguard)/OSTBLZ))*OSTBLZ     ;* Pad entries
        RMB     (10-((*-stblguard)/OSTBLZ))*OSTBLZ

;****
;*
;* FLIGHT FORMATIONS
;*
;*      SQLOFFSETS -    A table of offsets indicating which formation
;*                      patterns a group of crafts will fly in.  When
;*                      X -> a selected entry in the table, then the
;*                      instructions:
;*                              tfr     X,D     * D -> table entry
;*                              addd    0,X     * D -> formation pattern.
;*                      will establish D as a pointer to the formation data.
;*
;*      2$, 3$, etc. -  These are the formation patterns for a squadron of
;*                      2 crafts, 3 crafts, etc.  Each pattern consists of
;*                      information for the 2nd through Nth craft in the
;*                      pattern (i.e. the squadron leader is not included
;*                      in the pattern, but rather, the pattern describes
;*                      the flight positions for all other crafts, based
;*                      on the squadron leader's position).
;*
;*                      The pattern information is a byte which describes
;*                      the angle away from the squadron leader, at which
;*                      the craft will fly.  The angles are based on a
;*                      circle of 256 arcs.
;*
;****
sqloffsets
        fdb     .2S             ;* Offset of 2 craft formation pattern
        fdb     .3S             ;* Offset of 3 craft formation pattern
        fdb     .4S             ;* Offset of 4 craft formation pattern
        fdb     .5S             ;* Offset of 5 craft formation pattern
;***
;* 2 craft formation
;***
.2S     fcb     (circle*8/16)           ;* Craft B's angle off squadron leader A                        ;;Fixme was: 2$ fcb     +(circle*8./16.)
;***
;* 3 craft formation
;***
.3S     fcb     (circle*8/16)           ;* Craft B's angle off squadron leader A                        ;;Fixme was: 3$ fcb     +(circle*8./16.)
        fcb     (circle*12/16)          ;* Craft C's angle off squadron leader A                        ;;Fixme was:    fcb     +(circle*12./16.)
;***
;* 4 craft formation
;***
.4S     fcb     (circle*8/16)           ;* Craft B's angle off squadron leader A                        ;;Fixme was: 4$ fcb     +(circle*8./16.)
        fcb     (circle*12/16)          ;* Craft C's angle off squadron leader A                        ;;Fixme was:    fcb     +(circle*12./16.)
        fcb     (circle*10/16)          ;* Craft D's angle off squadron leader A                        ;;Fixme was:    fcb     +(circle*10./16.)
;***
;* 5 craft formation
;***
.5S     fcb     (circle*8/16)           ;* Craft B's angle off squadron leader A                        ;;Fixme was: 5$ fcb     +(circle*8./16.)
        fcb     $40                     ;* Craft C's angle off squadron leader A                        ;;Fixme was:    fcb     -(circle*12./16.) (Macroassembler AS doesn't do signed numbers?!)
        fcb     (circle*8/16)           ;* Craft D's angle off squadron leader A                        ;;Fixme was:    fcb     +(circle*8./16.)
        fcb     $40                     ;* Craft E's angle off squadron leader A                        ;;Fixme was:    fcb     -(circle*12./16.) (Macroassembler AS doesn't do signed numbers?!)

        RADIX   16

        PULLORG ROMSAVE