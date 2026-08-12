---
type: reference
domain: effects
granularity: atomic
summary: "Give each character column its own color by writing color RAM once per raster line."
keywords: [DYCP, dynamic color per char, color scroller, per-column color]
---

## facts
- DYCP (Dynamic Y-scroll Color Per character, also called "Dynamic Color Per line") gives each character column its own color by writing to color RAM (`$D800`+) once per raster line inside a raster IRQ.
- The VIC-II reads color RAM at the start of each character row (bad line); writing new colors between character rows makes each row display in a different color.
- Combining DYCP with a horizontal sine scroll on the text produces the classic "wobble scroller" demo effect.

## sequence

1. Set up a raster IRQ at the first line of each character row (every 8 lines in the display area, starting at raster `$33`).
2. In the IRQ handler, write the desired color value to each cell in the current row's color RAM (`$D800 + row*40` through `$D800 + row*40 + 39`).
3. Acknowledge `$D019`, set `$D012` to the next character row start (current + 8), chain IRQ.
4. On the last row, restore `$D012` to the first character row for the next frame.
5. Drive the color index through a sine table, phase-shifted per column, for smooth color cycling.

## lookup
| address range | purpose |
|---|---|
| `$D800`–`$DBE7` | Color RAM (1000 bytes, one nibble per screen cell) |
| `$D800 + row×40` | Start of color RAM for character row `row` (0–24) |
| `$D012` | Set to `$33 + row×8` to trigger IRQ at start of each char row |
| `$D019` | Write `$01` to acknowledge raster IRQ |

| character row | raster line (PAL) |
|---|---|
| Row 0 | `$33` |
| Row 1 | `$3B` |
| … | … (+8 per row) |
| Row 24 | `$F3` |

## constraints
- Color RAM writes MUST complete before the bad line at the start of the next character row; otherwise VIC-II reads stale colors.
- Writing 40 color bytes per row takes ~120–160 cycles; this is tight within 8 raster lines (504 cycles PAL) alongside IRQ overhead.
- On bad lines, VIC-II steals 40 cycles; the 40-byte write loop SHOULD be placed after the bad line has finished.
- Color RAM only stores the lower 4 bits (color 0–15); upper nibble is ignored.
- Combining with [scrolltext.md](scrolltext.md) sine scroll requires careful cycle-budget planning.

## links

- effects: [stable-raster.md](stable-raster.md)
- effects: [scrolltext.md](scrolltext.md)
- effects: [rasterbars.md](rasterbars.md)
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)
- colors: [../colors/INDEX.md](../colors/INDEX.md)

## sources

- codebase64.net: [Demo Programming — DYCP](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
