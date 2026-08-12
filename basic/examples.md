---
type: reference
domain: basic
granularity: examples
summary: "Complete short runnable BASIC V2 listings, as typed."
keywords: [BASIC examples, runnable listings, sample programs]
---

## facts
- Each program below is a complete, runnable BASIC V2 listing as typed.
- Programs assume default power-on state: BASIC + KERNAL + I/O visible (`$0001` = `$37`), screen RAM at `$0400`, screen pointer register `$D018` = `21`.
- Hardware register addresses cited (`53272`/`$D018`, `53280`/`$D020`, `53281`/`$D021`, `54272`/`$D400`) match the local I/O pages; do not re-derive them here.
- Each example carries a `route:` line pointing to the local reference pages that ground its facts.

## lookup
| topic | section anchor | route |
|---|---|---|
| print text | [#print-text](#print-text) | [program-structure.md](program-structure.md), [io.md](io.md) |
| border/background colors | [#border-background-colors](#border-background-colors) | [graphics-sound.md](graphics-sound.md), [../io/vic-ii.md](../io/vic-ii.md), [../colors/palette.md](../colors/palette.md) |
| read key | [#read-key](#read-key) | [io.md](io.md), [../charset/petscii.md](../charset/petscii.md), [../tasks/read-keyboard.md](../tasks/read-keyboard.md) |
| simple tone | [#simple-tone](#simple-tone) | [graphics-sound.md](graphics-sound.md), [../sid/registers.md](../sid/registers.md) |
| DATA + SYS loader | [#data-sys-loader](#data-sys-loader) | [machine-code-bridge.md](machine-code-bridge.md), [../memory/map.md](../memory/map.md) |

## examples

### print-text
```
10 PRINT "HELLO WORLD"
20 PRINT "LINE 2"
```
route: [program-structure.md](program-structure.md), [io.md](io.md)

### border-background-colors
```
10 POKE 53280,0
20 POKE 53281,6
30 PRINT CHR$(147);"BLACK BORDER / BLUE BACKGROUND"
```
route: [graphics-sound.md](graphics-sound.md), [../io/vic-ii.md](../io/vic-ii.md), [../colors/palette.md](../colors/palette.md)

Notes: `53280`/`$D020` is the border color register; `53281`/`$D021` is the background color register; `CHR$(147)` is the PETSCII clear-screen control code. Values `0` and `6` are palette indices `COL_BLACK` and `COL_BLUE`.

### read-key
```
10 PRINT "PRESS ANY KEY"
20 GET A$ : IF A$="" THEN 20
30 PRINT "KEY=";A$;" ASC=";ASC(A$)
```
route: [io.md](io.md), [../charset/petscii.md](../charset/petscii.md), [../tasks/read-keyboard.md](../tasks/read-keyboard.md)

Notes: `GET` reads the keyboard buffer non-blockingly and returns an empty string when no key is pending; line 20 polls until a key arrives. `ASC` returns the PETSCII code of the first character.

### simple-tone
```
10 S = 54272
20 POKE S+24,15
30 POKE S+5,9 : POKE S+6,0
40 POKE S+1,30 : POKE S,0
50 POKE S+4,17
60 FOR T=1 TO 600 : NEXT
70 POKE S+4,16
```
route: [graphics-sound.md](graphics-sound.md), [../sid/registers.md](../sid/registers.md)

Notes: `S = 54272` is `$D400`, the SID base. `S+24` (`$D418`) sets master volume to `15`. `S+5`/`S+6` are voice 1 ATDCY/SUREL; values `9,0` give a short attack/decay with zero sustain/release. `S`/`S+1` are voice 1 frequency lo/hi; `30,0` sets a mid-range pitch. `S+4` is voice 1 control: `17` = `%00010001` (triangle waveform `bit 4` + gate `bit 0` on); `16` clears the gate to start the release phase.

### data-sys-loader
```
10 FOR I=0 TO 8 : READ B : POKE 49152+I,B : NEXT
20 SYS 49152
30 DATA 169,0,141,32,208,141,33,208,96
```
route: [machine-code-bridge.md](machine-code-bridge.md), [../memory/map.md](../memory/map.md), [../io/vic-ii.md](../io/vic-ii.md)

Notes: `49152` = `$C000`, a 4 KiB RAM block outside BASIC's working area, safe across `NEW`. The 9 `DATA` bytes assemble to `LDA #$00 / STA $D020 / STA $D021 / RTS` — set border and background to black, then return to BASIC. `SYS` calls the machine-code routine at the given address.

## constraints
- Examples assume default `$0001` banking (`$37`) with BASIC + KERNAL + I/O visible; programs that bank out I/O before these `POKE`s will not affect VIC-II or SID.
- Examples assume default screen RAM at `$0400` (`POKE 53272,21`); if screen RAM has been relocated, restore with `POKE 53272,21` before running.
- Programs SHOULD be re-typed via direct-mode `NEW` before each test to clear prior variables and program state.
- The SID example uses voice 1; allow the tone to terminate via the final gate-off write (`POKE S+4,16`) before chaining other audio so the envelope releases cleanly.
- The `DATA` loader writes to `$C000` — outside BASIC's working RAM — so the machine code survives `NEW` and BASIC variable growth, but is overwritten by any later cartridge or program that uses `$C000-$CFFF`.
- Programs MUST be entered as BASIC V2 only; no extended (BASIC 3.5/7.0) commands are used or assumed.

## links

- [io.md](io.md)
- [graphics-sound.md](graphics-sound.md)
- [keywords.md](keywords.md)
- [functions.md](functions.md)
- [variables.md](variables.md)
- [errors.md](errors.md)
- [../colors/palette.md](../colors/palette.md)
- [../charset/petscii.md](../charset/petscii.md)
- [../charset/screen-codes.md](../charset/screen-codes.md)
- [../tasks/read-keyboard.md](../tasks/read-keyboard.md)
- [../tasks/sprite-display.md](../tasks/sprite-display.md)
- [../memory/map.md](../memory/map.md)

## sources

- BASIC index: [INDEX.md](INDEX.md)
- program structure: [program-structure.md](program-structure.md)
- machine-code bridge: [machine-code-bridge.md](machine-code-bridge.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- SID registers: [../sid/registers.md](../sid/registers.md)
- Upstream: C64 Programmer's Reference Guide (Commodore Business Machines, 1982) — adapted, not copied; register addresses cross-checked against mist64/c64ref `src/c64io`. AI-summarized; each example is an original short program.
