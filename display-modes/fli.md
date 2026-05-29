---
type: reference
domain: effects
granularity: atomic
---

## facts
- FLI (Flexible Line Interpretation) re-reads screen RAM color data on every raster line instead of every 8 lines.
- Normally VIC-II fetches screen RAM once per character row (bad line = every 8 lines); FLI forces a bad line on every display line.
- Forcing bad lines: CPU writes `$D011` YSCROLL bits = `raster_line mod 8` each line so the bad-line condition is always true.
- Color change per line: CPU writes `$D018` each line to point screen RAM to a different 1 KB block (8 blocks × 1000 bytes = 8000 bytes total).
- Most common form: multicolor bitmap (MCBM, `$D016` MCM=1, `$D011` BMM=1); achieves per-line changes to colors `01` and `10` per 8×8 cell.
- FLI bug: leftmost 12 pixels (cols 0–1) always show bright gray — VIC has already fetched that data before the CPU can write `$D018`; painting colorful graphics in this column is considered expert-level.

## sequence

1. Select a VIC bank with no char-ROM hole for the screen RAM area. Bank 1 (`$4000–$7FFF`) or bank 3 (`$C000–$FFFF`) are clean; bank 0/2 have a char-ROM shadow at offset `$1000`.
2. Allocate within the VIC bank:
   - 8 screen RAM blocks at offsets `$0000`, `$0400`, `$0800`, `$0C00`, `$1400`, `$1800`, `$1C00`, `$2400` (skip `$1000` in bank 0/2) — or in a clean bank use `$0000`–`$1C00` straight.
   - Bitmap at offset `$2000` (8000 bytes). Set `$D018` bit 3 = 1 for bitmap-at-`$2000`; bits 2-1 are ignored in bitmap mode.
3. Enable MCBM: `$D011` = `$3B` (BMM=1, DEN=1, RSEL=1, YSCROLL=3); `$D016` = `$D8` (MCM=1, CSEL=1).
4. Set up a stable raster IRQ at line `$33` (top of display area); see [stable-raster.md](../effects/stable-raster.md).
5. **Per-line FLI loop** (lines `$33`–`$FA`, 200 lines): inside the handler or a tight polling loop:
   - Write `$D018` = `fli_table[line mod 8]` (cycles through the 8 screen RAM blocks).
   - Write `$D011` bits 2-0 = `line mod 8` (forces bad line every line; preserve bits 7-3).
   - Write `$D019` = `$01` (acknowledge IRQ).
   - Set `$D012` = `current_line + 1` for the next IRQ, or use a polling-loop variant.
6. At line `$FB` (below display area): restore `$D011` to normal YSCROLL value.

**Tight polling alternative (preferred for cycle accuracy):**  
Enter a tight loop at line `$33`; poll `$D012`; on each new line write `$D018` and `$D011` directly, then spin until the next line. This avoids IRQ entry/exit overhead on lines where every CPU cycle counts (23 free cycles per bad line on PAL).

## lookup

### `$D018` table — bitmap at offset `$2000` in VIC bank

| `line mod 8` | `$D018` | screen RAM offset | screen RAM address (bank 1 example) |
|:---:|:---:|---|---|
| 0 | `$08` | `$0000` | `$4000` |
| 1 | `$18` | `$0400` | `$4400` |
| 2 | `$28` | `$0800` | `$4800` |
| 3 | `$38` | `$0C00` | `$4C00` |
| 4 | `$48` | `$1000` | `$5000` |
| 5 | `$58` | `$1400` | `$5400` |
| 6 | `$68` | `$1800` | `$5800` |
| 7 | `$78` | `$1C00` | `$5C00` |

### Color sources per pixel pair (MCBM + FLI)

| pixel bits | color source | per-line changeable? |
|---|---|---|
| `00` | `$D021` background color 0 | yes — write per line in IRQ |
| `01` | screen RAM high nibble | yes — FLI changes screen RAM block each line |
| `10` | screen RAM low nibble | yes — FLI changes screen RAM block each line |
| `11` | color RAM `$D800+cell` | no — color RAM is static (one write per frame max) |

### Memory layout summary

| region | size | location (bank 1 example) |
|---|---|---|
| Screen RAM blocks 0–7 | 8 × 1000 = 8000 bytes | `$4000–$5FFF` |
| Bitmap | 8000 bytes | `$6000–$7F3F` |
| Color RAM | 1000 bytes | `$D800–$DBE7` (fixed, not in VIC bank) |

## constraints
- Every display line becomes a bad line; CPU has only 23 free cycles per line (PAL 63 − 40 stolen = 23).
- The `$D018` write MUST complete before VIC starts the bad-line screen RAM fetch for that line; late writes produce color artifacts.
- FLI bug (leftmost ~12 px) is unavoidable; design art to hide it or use it as a visual border strip.
- Bank 0 and bank 2: screen RAM block 4 (offset `$1000`) MUST NOT be used — VIC reads char ROM there instead of RAM.
- `$D011` bit 3 (DEN) MUST remain 1 during FLI; writing `$00` to `$D011` blanks the display.
- 8 FLI blocks × 1000 bytes = exactly 8000 bytes — same size as the bitmap; both fit in a 16 KB bank with careful placement.

## links
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- effects: [ifli.md](ifli.md)
- effects: [ufli.md](ufli.md)
- effects: [nufli.md](nufli.md)
- effects: [stable-raster.md](../effects/stable-raster.md)
- graphics: [../graphics/screen-modes.md](../graphics/screen-modes.md)
- graphics: [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md)
- tasks: [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)

## sources
- codebase64.net: [FLI](https://codebase64.net/doku.php?id=base:fli) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
