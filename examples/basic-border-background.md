---
type: reference
domain: examples
granularity: example
---

## facts
- Complete BASIC V2 program changing border (`$D020` / `53280`) and background (`$D021` / `53281`) colors.
- Assumes default power-on state: `$0001` = `$37` (BASIC + KERNAL + I/O visible), screen RAM at `$0400`.
- Color values are palette indices `0-15`; see [../colors/palette.md](../colors/palette.md).

## examples

### listing
```
10 POKE 53280,0
20 POKE 53281,6
30 PRINT CHR$(147);"BLACK BORDER / BLUE BACKGROUND"
40 GET A$ : IF A$="" THEN 40
50 POKE 53280,14
60 POKE 53281,6
```

### run
- Type `RUN` in direct mode after entering the listing.
- The screen clears (`CHR$(147)`), border becomes black (`0`), background blue (`6`); press any key to switch the border to light blue (`14`).

## lookup
| element | address | meaning | route |
|---|---:|---|---|
| `53280` | `$D020` | VIC-II border color, low nybble | [../io/vic-ii.md](../io/vic-ii.md) |
| `53281` | `$D021` | VIC-II background color #0, low nybble | [../io/vic-ii.md](../io/vic-ii.md) |
| `CHR$(147)` | — | PETSCII clear-screen control code | [../charset/control-codes.md](../charset/control-codes.md) |
| color `0` | — | `COL_BLACK` palette index | [../colors/palette.md](../colors/palette.md) |
| color `6` | — | `COL_BLUE` palette index | [../colors/palette.md](../colors/palette.md) |
| color `14` | — | `COL_LIGHT_BLUE` palette index | [../colors/palette.md](../colors/palette.md) |

## constraints
- The program MUST run with default `$0001` banking (I/O visible); a prior `POKE 1,53` (I/O banked out) makes the `POKE`s update RAM at `$D020`/`$D021` instead of VIC-II registers.
- Only the low nybble of `$D020`/`$D021` is used; values `16-255` wrap (e.g. `POKE 53280,16` displays as color `0`).
- `GET` returns immediately with `A$=""` when no key is pending; line 40 polls until a key arrives.

## links
- BASIC graphics/sound: [../basic/graphics-sound.md](../basic/graphics-sound.md)
- BASIC examples reference: [../basic/examples.md](../basic/examples.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- Colors palette: [../colors/palette.md](../colors/palette.md)
- PETSCII control codes: [../charset/control-codes.md](../charset/control-codes.md)
- example index: [INDEX.md](INDEX.md)

## sources
- BASIC graphics/sound: [../basic/graphics-sound.md](../basic/graphics-sound.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- Colors palette: [../colors/palette.md](../colors/palette.md)
- local route: [../sources/INDEX.md](../sources/INDEX.md)
