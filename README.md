# sinistar-amoa
Reconstructed source code for the pre-release November 1982 version of Sinistar, revealed at AMOA.

## Differences between AMOA and final version

* [Sam's module diff](https://github.com/synamaxmusic/sinistar-amoa/commit/35c92be337903ce14fe813caffe498a8764c26b7)
* [Rich's module diff](https://github.com/synamaxmusic/sinistar-amoa/commit/c3ec656f8737ad9aefbac3b1d7098853347a8b08)
* [Noah's module diff](https://github.com/synamaxmusic/sinistar-amoa/commit/2eadcfbdc20671afb806bd36f330d66affff4f10)
* [RJ's module diff](https://github.com/synamaxmusic/sinistar-amoa/commit/af5b6b16cf2200bd046aab70f7a13e1ee38454b1)

### Sam's module

Bolded entries are files that have changed between versions.

### MESSAGE

* [SAM/MESSAGE.ASM](SAM/MESSAGE.ASM) (Routines for text output and for compressing/decompressing the 5x7 and 3x5 pixel font tables)
  * **[SAM/MESSEQU1.ASM](SAM/MESSEQU1.ASM) (Equates for allocating system-critical stuff like RAM, CMOS settings, watchdog, vectors, etc.)**
    * **[SAM/MESSEQU.ASM](SAM/MESSEQU.ASM) (Message equates for various system/diagnostic strings)**
  * [SAM/MESSEQU2.ASM](SAM/MESSEQU2.ASM) (Williams Electronics codepage equates)
  * **[SAM/PHRASE.ASM](SAM/PHRASE.ASM) (Strings and vectors for various messages like "INITIAL TESTS INDICATE", "BOOKKEEPING TOTALS", etc.)**

### EQUATES

* [SAM/EQUATES.ASM](SAM/EQUATES.ASM)
  * [SAM/START.ASM](SAM/START.ASM) (Sets up 6809 direct page register and sets ```RADIX``` to 16) 
    * [SAM/MACROS.ASM](SAM/MACROS.ASM) (Macros for assembly counters, pseudo opcodes, RNGs, multitasking, sound calls, and copyright strings)
      * [WITT/DISPLAY.ASM](WITT/DISPLAY.ASM) (Message display macros)
  * [SAM/S1.ASM](SAM/S1.ASM)
    * [SAM/SAMEQUAT.ASM](SAM/SAMEQUAT.ASM) (Assembly counters, hardware constants, game constants)
    * [SAM/SAMOFFSE.ASM](SAM/SAMOFFSE.ASM) (Offsets for object/task workspaces, "characteristics descriptors", etc.)
  * [FALS/N1.ASM](FALS/N1.ASM)
    * **[FALS/N1SYM.ASM](FALS/N1SYM.ASM) (Noah's equates and offsets needed for Sam's module)**
  * [WITT/R1.ASM](WITT/R1.ASM)
    * [WITT/SYMSAM.ASM](WITT/SYMSAM.ASM) (Rich's equates needed for Sam's module)

### IMAGE

* **[SAM/IMAGE.ASM](SAM/IMAGE.ASM) (Nearly all of the sprites are found here; ```ROMSAVE``` starts after image data)**


* [SAM/SAMS.ASM](SAM/SAMS.ASM)
  * [SAM/S2.ASM](SAM/S2.ASM)
    * **[SAM/SAMRAM.ASM](SAM/SAMRAM.ASM) (Ram allocation)**
    * [SAM/GROUND.ASM](SAM/GROUND.ASM) (end of grounded intelligence lists)
    * [WITT/TEXT.ASM](WITT/TEXT.ASM) (Text macro converts strings to Williams codepage and positions on screen)
    * [SAM/PANEL.ASM](SAM/PANEL.ASM) (control panel switch vector table)
    * [SAM/INITALL.ASM](SAM/INITALL.ASM) (Initialization routines)
    * [SAM/EXEC.ASM](SAM/EXEC.ASM) (Executive loop)
    * **[SAM/EXECJNK.ASM](SAM/EXECJNK.ASM) (miscellaneous exec stuff)**
    * **[SAM/TRASCOM.ASM](SAM/TRASCOM.ASM) (dynamic storage 'trash compacting' routines)**
    * [SAM/NEWTUNE.ASM](SAM/NEWTUNE.ASM) (Sound call routine)
    * [SAM/PLSHOOT.ASM](SAM/PLSHOOT.ASM) (player shooting)
    * [SAM/PIXCHK.ASM](SAM/PIXCHK.ASM) (pixel collision check routine)
    * [SAM/BOUNCE.ASM](SAM/BOUNCE.ASM) (bounce routine)
    * [SAM/ADDSCOR.ASM](SAM/ADDSCOR.ASM) (player score and sinibomb status display and change)
    * **[SAM/ADDPIEC.ASM](SAM/ADDPIEC.ASM) (add and subtract sinistar pieces)**
    * **[SAM/FRAGEXP.ASM](SAM/FRAGEXP.ASM) (fragment explosion)**
    * **[SAM/SCANNER.ASM](SAM/SCANNER.ASM) (scanner routines)**
    * [SAM/GETOBJ.ASM](SAM/GETOBJ.ASM) (screen list routines)
    * **[SAM/DRAWOBJ.ASM](SAM/DRAWOBJ.ASM) (display routines)**
    * **[SAM/SLEEP1.ASM](SAM/SLEEP1.ASM) (multitasking routines)**
    * [SAM/FUNCTION.ASM](SAM/FUNCTION.ASM) (Math functions)
    * **[SAM/TB13.ASM](SAM/TB13.ASM) (Utility routines)**
    * **[SAM/SAMTABLE.ASM](SAM/SAMTABLE.ASM) (tables for characteristics descriptors, sound effects, math functions, color palette, etc.)**
    * [SAM/IRQ.ASM](SAM/IRQ.ASM) (Interrupt routines)

### Rich's module

* [WITT/RICHS.ASM](WITT/RICHS.ASM)
  * **[WITT/R2.ASM](WITT/R2.ASM)**
    * **[WITT/SYMRICH.ASM](WITT/SYMRICH.ASM) (Rich's symbols)**
    * **[WITT/RAMRICH.ASM](WITT/RAMRICH.ASM) (Ram variables)**
    * **[WITT/INIRICH.ASM](WITT/INIRICH.ASM) (Initialization routines for RICH)**
      * [WITT/EMPTY.ASM](WITT/EMPTY.ASM) ("EMPTY" or bombs display)
        * [WITT/ZAPRTS.ASM](WITT/ZAPRTS.ASM) (Copyright checking RTS macro)
      * **[WITT/ANISINI.ASM](WITT/ANISINI.ASM) (Animate Sinistar)**
        * [WITT/SPEAK.ASM](WITT/SPEAK.ASM) (Speak macro)
        * **[FALS/SC1.ASM](FALS/SC1.ASM) (Speech Tunes)**
    * [WITT/DISP.ASM](WITT/DISP.ASM) (Message display routines)
      * [WITT/DISPE.ASM](WITT/DISPE.ASM) (Message to player erasing)
        * [WITT/ERASE.ASM](WITT/ERASE.ASM) (Message erasing intelligence)
    * **[WITT/COLLISIO.ASM](WITT/COLLISIO.ASM) (Collision effects)**
      * [SAM/COLLIDE.ASM](SAM/COLLIDE.ASM) (Collision macros)
      * **[WITT/DEATH.ASM](WITT/DEATH.ASM) (Player death routine)**
      * **[WITT/SUBPART.ASM](WITT/SUBPART.ASM) (Kill a part of the sinistar)**
    * [WITT/COPYRIGH.ASM](WITT/COPYRIGH.ASM) (EBCDIC copyright)
    * [WITT/DIFFICUL.ASM](WITT/DIFFICUL.ASM) (Difficulty factor tables)
    * **[WITT/KRSINI.ASM](WITT/KRSINI.ASM) (Sinistar Killing routine)**
      * [WITT/STBLIMP.ASM](WITT/STBLIMP.ASM) (Impulse engine speed table) [Gets patched over by ZSTBLIMP]
    * **[WITT/LEAVESEC.ASM](WITT/LEAVESEC.ASM) (Leaving sector vectors)**
      * **[WITT/LSSBOMB.ASM](WITT/LSSBOMB.ASM) (Sinibomb leaving sector)**
      * **[WITT/LSWOCR.ASM](WITT/LSWOCR.ASM) (Worker with crystal leaving sector)**
        * [WITT/ADDPART.ASM](WITT/ADDPART.ASM) (Build up the sinistar)
      * **[WITT/LSSINI.ASM](WITT/LSSINI.ASM) (Sinistar leaving sector)**
    * **[WITT/TABLES.ASM](WITT/TABLES.ASM) (Distance/Velocity tables)**
      * [WITT/STBLSBOM.ASM](WITT/STBLSBOM.ASM) (Sinibombs)
      * **[WITT/STBLSINI.ASM](WITT/STBLSINI.ASM) (Sinistar)**
      * **[WITT/STBLOSIN.ASM](WITT/STBLOSIN.ASM) (New Sinistar orbital approach  <<< Added by Noah >>>)**
      * [WITT/STBLMINE.ASM](WITT/STBLMINE.ASM) (Warriors mining)
      * [WITT/STBLL0.ASM](WITT/STBLL0.ASM) (Warriors leading)
      * [WITT/STBLW0.ASM](WITT/STBLW0.ASM) (Warriors following)
      * [WITT/STBLW1.ASM](WITT/STBLW1.ASM) (Warriors intercepting)
      * [WITT/STBLWORK.ASM](WITT/STBLWORK.ASM) (Workers circling player)
      * [WITT/STBLINT.ASM](WITT/STBLINT.ASM) (Workers picking up crystals)
      * [WITT/STBLHEAV.ASM](WITT/STBLHEAV.ASM) (Workers delivering crystals)
      * [WITT/STBLBOMB.ASM](WITT/STBLBOMB.ASM) (Player on demo bombing run)
    * **[WITT/WORKER.ASM](WITT/WORKER.ASM)**
      * [WITT/ANIWORK.ASM](WITT/ANIWORK.ASM) (Animate worker)
      * [WITT/DISTANCE.ASM](WITT/DISTANCE.ASM) (Distance Computations)
        * [WITT/GETLVX.ASM](WITT/GETLVX.ASM) (Velocity module for orbits)
      * [WITT/RETARGET.ASM](WITT/RETARGET.ASM) (Reposition Sinistar to center offset)
      * [WITT/UPDDTC.ASM](WITT/UPDDTC.ASM) (Update Distance to Caller)
      * [WITT/UPDFLANG.ASM](WITT/UPDFLANG.ASM) (Update Flight Angle)
      * **[WITT/VELOCITY.ASM](WITT/VELOCITY.ASM) (Velocity computations)**
        * [WITT/CHASE.ASM](WITT/CHASE.ASM) (Adjust a desired speed closer to the velocity of a moving target)
        * [WITT/LDYWCR.ASM](WITT/LDYWCR.ASM) (provides the object's caller's scanner workspace address)
    * **[WITT/WARRIOR.ASM](WITT/WARRIOR.ASM)**
      * [WITT/AIMWARR.ASM](WITT/AIMWARR.ASM) (Aiming to track moving target)
      * [WITT/ANIWARR.ASM](WITT/ANIWARR.ASM) (Animation)
      * [WITT/FOLLOW.ASM](WITT/FOLLOW.ASM) (Squadron leader targeting)
      * [WITT/SCREENCH.ASM](WITT/SCREENCH.ASM) (On/Off screen check)
      * **[WITT/SHOOT.ASM](WITT/SHOOT.ASM) (Warrior shooting routine)**
      * [WITT/THINK.ASM](WITT/THINK.ASM) (Animate/Intelligence check)
      * [WITT/WARRON.ASM](WITT/WARRON.ASM) (On Screen routine)
      * [WITT/WARROFF.ASM](WITT/WARROFF.ASM) (Warrior off screen routine)
      * [WITT/WASHODDS.ASM](WITT/WASHODDS.ASM) (Shooting odds computations)
      * [WITT/ZWASHODD.ASM](WITT/ZWASHODD.ASM)
    * **[WITT/SINIBOMB.ASM](WITT/SINIBOMB.ASM)**
    * **[WITT/SINI.ASM](WITT/SINI.ASM)**
    * **[WITT/STUBS.ASM](WITT/STUBS.ASM) (To fake Noah's stuff)**
* **[WITT/RICHS2.ASM](WITT/RICHS2.ASM) (not in AMOA build)**
  * **[WITT/BUTTON.ASM](WITT/BUTTON.ASM) (Button handling with Easter Egg routine)**

### Noah's module

* [FALS/NOAHS.ASM](FALS/NOAHS.ASM)
  * [FALS/N2.ASM](FALS/N2.ASM) (Noah's current version release of rmb and src)
    * [FALS/N1RAM.ASM](FALS/N1RAM.ASM)
    * **[FALS/N1ALL.ASM](FALS/N1ALL.ASM) (Vibration routines, Planetoid/Crystal logic, Calling Intelligence, Killing/Explosion subroutines, Difficulty adjustment code, Population tables)**
  * [FALS/N3.ASM](FALS/N3.ASM) (Final "characteristics descriptors" for all game objects)

### RJ's module

* [MICA/BOBS.ASM](MICA/BOBS.ASM)
  * [MICA/B1.ASM](MICA/B1.ASM)
    * [MICA/BOBEQUAT.ASM](MICA/BOBEQUAT.ASM) (Warrior/Player Explosion and High Score/Operator Message entry equates)
    * **[MICA/BOBOFFSE.ASM](MICA/BOBOFFSE.ASM)**
  * [MICA/B2.ASM](MICA/B2.ASM)
    * **[MICA/BOBRAM.ASM](MICA/BOBRAM.ASM)**
    * **[MICA/ZPLXQUE.ASM](MICA/ZPLXQUE.ASM) (Player Explosion Task Queuer)**
    * **[MICA/PLXTSK.ASM](MICA/PLXTSK.ASM) (Player Explosion Task)**
    * [MICA/ZWRXQUE.ASM](MICA/ZWRXQUE.ASM) (Warrior Exploding-Fragments Task Queuer)
    * [MICA/WRXTSK.ASM](MICA/WRXTSK.ASM) (Warrior Explosion Task)
    * **[MICA/ZSNXQUE.ASM](MICA/ZSNXQUE.ASM) (Sinistar Explosion Task Queuer)**
    * **[MICA/SNXTSK.ASM](MICA/SNXTSK.ASM) (Sinistar Explosion Task)**
    * **[MICA/ZZATTRAC.ASM](MICA/ZZATTRAC.ASM) (High Score To Date/Marquee Pages Task)**
    * **[MICA/MARQUEE.ASM](MICA/MARQUEE.ASM) (Marquee Page By Ken Lantz and Mike Metz) [Not included unless KENSMARQ is defined]**
    * **[MICA/ATTMSGS.ASM](MICA/ATTMSGS.ASM) (Attract Mode messages)**
    * **[MICA/STATUS.ASM](MICA/STATUS.ASM) (Status Page - Displayed at start of player turn)**
    * **[MICA/HSTDTE.ASM](MICA/HSTDTE.ASM) (High Score To Date Entry routine)**
    * **[MICA/HSTDIM.ASM](MICA/HSTDIM.ASM) (High Score Table of initials)**
    * **[MICA/ZGAMOVER.ASM](MICA/ZGAMOVER.ASM) (display game over in player window)**
    * **[MICA/ZZAMSINI.ASM](MICA/ZZAMSINI.ASM) (Attract Mode Demo)**
    * **[MICA/ZPNTSCRN.ASM](MICA/ZPNTSCRN.ASM) (clears out the system, sets up the information tasks, restarts the system)**

### Fixes

* **[WITT/AOE.ASM](WITT/AOE.ASM) (Final patches for AOE '83 show) [Only needed for PROMS define, otherwise not part of AMOA]**
  * [SAM/SAMFIXES.ASM](SAM/SAMFIXES.ASM)
    * [SAM/FIXLSSIN.ASM](SAM/FIXLSSIN.ASM) (fixes live sinistar leaving sector)
    * [SAM/FIXDAMPD.ASM](SAM/FIXDAMPD.ASM) (fixes player bounce damping during the attract mode demo)
    * [SAM/FIXSMASH.ASM](SAM/FIXSMASH.ASM) (fixes player getting smashed off the screen) [not used; replaced by FALS/LAST.ASM]
    * [SAM/FIXOPENT.ASM](SAM/FIXOPENT.ASM) (fixes operator entry system initialization)
    * [SAM/FIXPLUNI.ASM](SAM/FIXPLUNI.ASM) (fixes player starting position)
  * **[WITT/RICHFIXE.ASM](WITT/RICHFIXE.ASM) [PROMS define is located here]** 
    * [WITT/FIXBUTTO.ASM](WITT/FIXBUTTO.ASM) (FIREB version editing correction)
    * [WITT/FIXINIRI.ASM](WITT/FIXINIRI.ASM) (SINIB demo error and timing correction)
    * [WITT/FIXKRSIN.ASM](WITT/FIXKRSIN.ASM) (Dead man's warp correction)
    * [WITT/FIXRISBO.ASM](WITT/FIXRISBO.ASM) (Value error correction) [for Sinibomb sprite]
    * [WITT/ZSTBLIMP.ASM](WITT/ZSTBLIMP.ASM) (Impulse engine speed table tuned)
    * [WITT/ZSTBLBOM.ASM](WITT/ZSTBLBOM.ASM) (Demo bombing run speed table tuned)
  * [MICA/BOBFIXES.ASM](MICA/BOBFIXES.ASM)
  * [WITT/FIXSINI.ASM](WITT/FIXSINI.ASM)

### Diagnostic Test ROM ($F000)

* [SAM/DIAG.ASM](SAM/DIAG.ASM)
  * **[SAM/T13.ASM](SAM/T13.ASM) (F000 test rom for 'sinistar' with auditing and adjustments)**
* **[FALS/LAST.ASM](FALS/LAST.ASM) (Final patches for "revision 3" rom set) [Not included in AMOA]**

### Extras

* **[WITT/debug_utilities.ASM](WITT/debug_utilities.ASM) (Old and new debug routines and cheats, as well as new mods to reduce difficulty) [Fixed TAIL routine to make it work again with AMOA]**
  * [SAM/BARGRAPH.ASM](SAM/BARGRAPH.ASM) (Slightly modified version of Debug Bar Graphs)
    * [WITT/RICH.EQU](WITT/RICH.EQU) (Work file from Rich that has equates for Bar Graphs)
* [MICA/marquee_fix.ASM](MICA/marquee_fix.ASM) (This is a hack that restores the original MARQUEE title screen)
