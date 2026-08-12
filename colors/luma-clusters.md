---
type: reference
domain: colors
granularity: lookup
summary: "Which VIC-II color pairs share a luma step and therefore mix without visible banding."
keywords: [luma clusters, banding, dithering, ALM, DCM, color mixing]
---

## facts
- The VIC-II outputs luma as a discrete analog voltage; each color maps to one of a fixed number of steps, not a continuous brightness scale.
- The most common revision (6569 R5 and later) produces **9 distinct luma levels** — 7 of which are shared by a pair of colors, 2 by a single color each (Black and White).
- The first revision produced only **5 coarser luma levels**, so more colors shared each step; this gives more valid same-cluster mixing pairs.
- Colors within the same luma cluster can be combined via ALM or DCM without visible horizontal striping on PAL output.
- Colors from different clusters produce a luma mismatch visible as horizontal banding on real hardware and accurate emulators.

## lookup

### Common revision — 9 luma levels

| luma level | colors |
|:---:|---|
| 0 | `COL_BLACK` (`$0`) |
| 8 | `COL_BLUE` (`$6`), `COL_BROWN` (`$9`) |
| 10 | `COL_RED` (`$2`), `COL_DARK_GRAY` (`$B`) |
| 12 | `COL_PURPLE` (`$4`), `COL_ORANGE` (`$8`) |
| 15 | `COL_MEDIUM_GRAY` (`$C`), `COL_LIGHT_BLUE` (`$E`) |
| 16 | `COL_GREEN` (`$5`), `COL_LIGHT_RED` (`$A`) |
| 20 | `COL_CYAN` (`$3`), `COL_LIGHT_GRAY` (`$F`) |
| 24 | `COL_YELLOW` (`$7`), `COL_LIGHT_GREEN` (`$D`) |
| 32 | `COL_WHITE` (`$1`) |

### First revision — 5 luma levels

| luma level | colors |
|:---:|---|
| 0 | `COL_BLACK` (`$0`) |
| 8 | `COL_BLUE` (`$6`), `COL_BROWN` (`$9`), `COL_RED` (`$2`), `COL_DARK_GRAY` (`$B`) |
| 16 | `COL_PURPLE` (`$4`), `COL_ORANGE` (`$8`), `COL_MEDIUM_GRAY` (`$C`), `COL_LIGHT_BLUE` (`$E`), `COL_GREEN` (`$5`), `COL_LIGHT_RED` (`$A`) |
| 24 | `COL_CYAN` (`$3`), `COL_LIGHT_GRAY` (`$F`), `COL_YELLOW` (`$7`), `COL_LIGHT_GREEN` (`$D`) |
| 32 | `COL_WHITE` (`$1`) |

The first revision offers larger clusters (up to 6 colors per step), yielding more valid same-cluster mixing pairs for ALM and spatial dithering.

## constraints
- Cross-cluster color mixing MUST be avoided for ALM; banding will be visible on CRT and PAL-accurate emulators.
- DCM (frame-swapped chequerboard) can mix across cluster boundaries because temporal blending partially masks luma mismatches, but same-cluster pairs still produce cleaner results.
- Cluster membership varies by chip revision; SHOULD verify on the target revision or emulate with Pepto/Colodore palette settings.

## links

- palette: [palette.md](palette.md)
- color mixing techniques: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- VIC-II: [../io/vic-ii.md](../io/vic-ii.md)

## sources

- Pepto colorvic model: https://www.pepto.de/projects/colorvic/
- Kodiak64 luma-driven graphics: https://kodiak64.co.uk/blog/luma-driven-graphics-on-c64
