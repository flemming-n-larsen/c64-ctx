---
type: reference
domain: concepts
granularity: atomic
---

## facts
- PAL visible area: 402 px wide × 292 px tall.
- Text display area: 320 × 200 px (40 × 25 chars), raster lines `$33`–`$FA`.
- Upper border: 43 raster lines; first visible raster = `$08`.
- Lower border: 49 raster lines; last visible raster = `$12C`.
- Left border: 48 px (6 chars); right border: 36 px (4.5 chars).
- Sprite Y-position `$07` places the sprite at the top of the visible area (not `$00`).
- NTSC timings differ and are not covered by this page.

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
| Sprite Y top | `$07` | Maps to raster `$08` (first visible line) |
| Sprite Y range | `$07`–`$07`+291 | To cover full visible height with sprites |

## constraints
- `$D012` holds raster bits 0–7; bit 8 of the raster counter is in `$D011` bit 7.
- Raster line `$00` is at the top of the frame, before visible area begins.
- Sprite Y=0 is above the visible screen; use Y=`$07` for the first visible row.
- These values are PAL-specific; NTSC has fewer lines (263 total vs 312) and different border heights.

## links
- io: [../io/vic-ii.md](../io/vic-ii.md)
- concepts: [vic-bad-lines.md](vic-bad-lines.md)
- effects: [../effects/open-borders.md](../effects/open-borders.md)

## sources
- codebase64.net: [Visible Area](https://codebase64.net/doku.php?id=vic:visible_area) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
