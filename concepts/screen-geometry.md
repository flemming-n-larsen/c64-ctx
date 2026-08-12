---
type: reference
domain: concepts
granularity: atomic
summary: "PAL display dimensions, raster line ranges, border extents, and sprite placement."
keywords: [screen geometry, border extents, raster ranges, visible area, display window]
---

## facts
- PAL visible area: 402 px wide × 292 px tall.
- Text display area: 320 × 200 px (40 × 25 chars), raster lines `$33`–`$FA`.
- Upper border: 43 raster lines; first visible raster = `$08`.
- Lower border: 49 raster lines; last visible raster = `$12C`.
- Left border: 48 px (6 chars); right border: 36 px (4.5 chars).
- Sprite Y coordinates are not raster-line numbers: for a normal-height sprite, Y=`$1E` (30 decimal) is the first partially visible position and Y=`$32` (50 decimal) is the first position where all 21 rows fit in the standard display area.
- The common NTSC 6567R8/8562 frame has 263 raster lines at 65 cycles per line; PAL 6569/8565 has 312 lines at 63 cycles per line.

## lookup
| region | raster start | raster end | height | notes |
|---|---|---|---|---|
| Top of visible area | `$08` | `$32` | 43 lines | Upper border |
| Text display | `$33` | `$FA` | 200 lines | 25 char rows |
| Bottom of visible area | `$FB` | `$12C` | 49 lines | Lower border |

| dimension | value | notes |
|---|---|---|
| Visible width | 402 px | Including left+right borders |
| Visible height | 292 px | Including top+bottom borders |
| Text width | 320 px | 40 columns × 8 px |
| Text height | 200 px | 25 rows × 8 px |
| PAL opened-top-border sprite Y | `$07` | Aligns the sprite's first row with visible raster `$08`; this does not apply while the normal top border masks sprites |
| First partially visible normal sprite | `$1E` | 30 decimal; upper border still covers part of the sprite |
| First fully visible normal sprite | `$32` | 50 decimal; all 21 rows fit in the standard display area |

### frame timing by VIC-II family

| video family | common chips | total raster lines | cycles/line | cycles/frame | frame rate |
|---|---|---:|---:|---:|---:|
| NTSC-M | 6567R8, 8562 | 263 | 65 | 17,095 | ~59.8 Hz |
| PAL-B | 6569, 8565 | 312 | 63 | 19,656 | ~50.1 Hz |

- Early NTSC 6567R56A timing is different: 262 lines, normally 64 cycles per line, with 65 cycles on lines 0–7.
- The 320 × 200 text matrix is common to PAL and NTSC, but border/overscan geometry and the available CPU time outside the display are not interchangeable.

## constraints
- `$D012` holds raster bits 0–7; bit 8 of the raster counter is in `$D011` bit 7.
- Raster line `$00` is at the top of the frame, before visible area begins.
- Sprite Y=0 is above the standard display area. With the normal border active, a normal-height sprite first appears partially at Y=`$1E` and fits fully at Y=`$32`; vertically expanded sprites begin partial visibility at Y=`$09`. With the PAL top border opened, Y=`$07` aligns the sprite's first row with visible raster `$08`.
- The 402 × 292 visible-area and border measurements above are PAL-specific; NTSC code MUST use the variant timing table instead of reusing PAL border limits.
- Raster IRQs at line 263 or above are PAL-only on the common 6567R8/8562 NTSC chips.

## links

- io: [../io/vic-ii.md](../io/vic-ii.md)
- concepts: [vic-bad-lines.md](vic-bad-lines.md)
- effects: [../effects/open-borders.md](../effects/open-borders.md)

## sources

- codebase64.net: [Visible Area](https://codebase64.net/doku.php?id=vic:visible_area) — CC BY-NC-SA 4.0
- VIC-II variant timing: [../vic/variants.md](../vic/variants.md)
- original manual: [Commodore 64 Programmer's Reference Guide — Programming Graphics](https://www.commodore.ca/manuals/c64_programmers_reference/c64-programmers_reference_guide-03-programming_graphics.pdf)
