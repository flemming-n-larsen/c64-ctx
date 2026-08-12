---
type: reference
domain: display-modes
granularity: atomic
summary: "Multi Resolution FLI: toggle multicolor per raster line to mix hires and multicolor regions."
keywords: [MRFLI, multi resolution, mixed resolution, per-line MCM]
---

## facts
- MRFLI (Multi Resolution FLI) mixes hires (SBM) and multicolor (MCBM) regions within the same 200-line display by switching `$D016` MCM bit per raster line alongside the standard FLI `$D018` cycling.
- Hires regions have 320-pixel-wide rows (2 colors per 8×1 cell via FLI); multicolor regions have 160-pixel-wide rows (4 colors per 8×1 cell via FLI).
- The MCM toggle is written into `$D016` on each raster line, in addition to the `$D018` and `$D011` YSCROLL writes.
- Introduced February 2010.

## sequence

1. Complete FLI setup as per [fli.md](fli.md) (allocate 8 screen RAM blocks, bitmap).
2. Allocate a per-line mode table (200 bytes): each byte = desired `$D016` value for that line (`$C8` for hires, `$D8` for multicolor).
3. In the per-line FLI loop:
   - Write `$D018` = `fli_table[line mod 8]` (screen RAM cycling).
   - Write `$D011` bits 2-0 = `line mod 8` (bad-line every line).
   - Write `$D016` = `mode_table[line]` (MCM bit on or off for this line).
4. Design bitmap artwork with hires patterns in some row groups and multicolor patterns in others; screen RAM color assignments follow the mode of each row.

## lookup

| register | hires line | multicolor line |
|---|---|---|
| `$D016` | `$C8` (MCM=0) | `$D8` (MCM=1) |
| `$D018` | cycles as per FLI table | cycles as per FLI table |
| `$D011` bits 2-0 | `line mod 8` | `line mod 8` |

### Color sources per line type

| line type | pixel `00` | pixel `01` / `1` | pixel `10` | pixel `11` |
|---|---|---|---|---|
| Hires | — | screen hi nibble (fg) | — | screen lo nibble (bg) |
| Multicolor | `$D021` | screen hi nibble | screen lo nibble | color RAM |

## constraints
- MCM toggle must align with the raster line being rendered; late writes produce a mixed hires/multicolor artifact.
- Same 23-cycle-per-line budget (PAL bad line); one extra `$D016` write reduces available cycles by ~6.
- Bitmap pixel patterns must be designed for the intended mode of each row; a multicolor bit pattern displayed in hires mode (or vice versa) produces incorrect colors.

## links
- effects: [fli.md](fli.md)
- effects: [ifli.md](ifli.md)
- graphics: [../graphics/screen-modes.md](../graphics/screen-modes.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources
- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
