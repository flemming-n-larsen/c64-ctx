---
type: reference
domain: sid
granularity: reference
summary: "NTSC A440 note-to-register values, calibrated for the common 6567R8."
keywords: [NTSC frequency table, NTSC notes, 6567R8, A440]
---

## facts
- This table is calibrated to A4 = 440 Hz on the common NTSC C64 with VIC `6567R8`.
- Codebase64 notes that machines with VIC `6567R56A` need slightly different values, but this table is still a usable approximation for many purposes.
- NTSC register values are slightly larger than PAL values for the same target pitch because the NTSC machine clock is higher.
- Each octave is exactly 2× the register value of the previous octave.

## lookup

Write `FREQLO` to voice 1 `$D400`, `FREQHI` to voice 1 `$D401`.
For voices 2/3 add offset `+7` / `+14`.

| Note | Oct 0  | Oct 1  | Oct 2  | Oct 3  | Oct 4  | Oct 5  | Oct 6  | Oct 7  |
|------|--------|--------|--------|--------|--------|--------|--------|--------|
| C    | `$010C` | `$0218` | `$0431` | `$0862` | `$10C4` | `$2188` | `$430F` | `$861E` |
| C#   | `$011C` | `$0238` | `$0471` | `$08E2` | `$11C3` | `$2386` | `$470C` | `$8E18` |
| D    | `$012D` | `$025A` | `$04B4` | `$0969` | `$12D1` | `$25A3` | `$46A3` | `$8B46` |
| D#   | `$013F` | `$027E` | `$04FC` | `$09F8` | `$13F0` | `$27E0` | `$4FBF` | `$9F7F` |
| E    | `$0152` | `$02A4` | `$0548` | `$0A90` | `$151F` | `$2A3F` | `$547D` | `$A8FB` |
| F    | `$0166` | `$02CC` | `$0598` | `$0B30` | `$1661` | `$2C61` | `$5984` | `$B307` |
| F#   | `$017B` | `$02F7` | `$05ED` | `$0BDB` | `$17B6` | `$2F6B` | `$5ED6` | `$BDAC` |
| G    | `$0192` | `$0324` | `$0648` | `$0C8F` | `$191E` | `$323D` | `$647A` | `$C8F4` |
| G#   | `$01AA` | `$0354` | `$06A7` | `$0D4E` | `$1A9D` | `$353A` | `$6A73` | `$D4E7` |
| A    | `$01C3` | `$0386` | `$070C` | `$0E19` | `$1C32` | `$3864` | `$70C8` | `$E18F` |
| A#   | `$01DE` | `$03BC` | `$0778` | `$0EF0` | `$1DDF` | `$3BBE` | `$777D` | `$EEFA` |
| B    | `$01FA` | `$03F5` | `$07E9` | `$0FD3` | `$1FA6` | `$3F4C` | `$7E97` | `$FD2F` |

## constraints
- `6567R56A` machines use a different raster geometry, so these values are not exact A440 there.
- Write `FREQLO` before `FREQHI` to avoid transient glitches on some SID revisions.
- The highest `B` in octave 7 stays within 16 bits on NTSC (`$FD2F`), unlike the PAL A440 table where octave-7 `B` overflows.

## links
- PAL frequency table: [frequency-table.md](frequency-table.md)
- frequency calculation: [frequency-calculation.md](frequency-calculation.md)
- SID registers: [registers.md](registers.md)
- SID index: [INDEX.md](INDEX.md)

## sources
- codebase64.net: [NTSC Frequency Table](https://codebase64.net/doku.php?id=base:ntsc_frequency_table) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
