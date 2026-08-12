---
type: reference
domain: effects
granularity: atomic
summary: "Warp a logo with independent per-row vertical and horizontal sine displacement."
keywords: [distortion, DYPP, tech-tech, sine warp, logo distortion]
---

## facts
- Graphics distortion warps a bitmap or FLI logo by applying independent per-row Y (vertical) and X (horizontal) sine displacements.
- The Y-displacement (DYPP — Dynamic Y Pixel Position) moves each character row up or down; the X-displacement (tech-tech) shifts each row left or right.
- On FLI bitmaps, DYPP precision is typically reduced to every 2nd multicolor pixel; only three row states exist (up, straight, down) to avoid color clashes from FLI's interconnected bitmap/color structure.

## sequence — DYPP (vertical distortion)

1. Pre-render the logo in a FLI bitmap with enough padding rows above and below to absorb ±1-pixel displacement.
2. Build a sine table for vertical offsets (values −1, 0, +1 for restricted FLI variant; wider range for hires).
3. Each frame, for each character segment (26 segments across the logo width):
   - Read `row_offset = sine_y[frame_counter + segment]`.
   - Select the pre-rendered variant for this row position (up / straight / down).
   - Write the appropriate `$D018` value for that segment's row in the FLI table.
4. Advance `frame_counter` each frame.

## sequence — combined DYPP + tech-tech (X+Y distortion)

1. Apply DYPP first (modulate vertical row selection via `$D018` / `$D011`).
2. Apply tech-tech second: for each line, compute `x_offset = sine_x[frame_counter + line]` and write `$D016` XSCROLL (0–7) plus select the appropriate pre-shifted bank via `$D018` bits 7–4.

## lookup

| register | role |
|---|---|
| `$D011` bits 0–2 | YSCROLL — force bad line per line for DYPP |
| `$D016` bits 0–2 | XSCROLL — per-line pixel-level X offset |
| `$D018` bits 7–4 | Screen bank — selects pre-shifted column copy for X displacement |
| `$D018` bits 3–0 | Char/bitmap base — selects pre-shifted row copy for Y displacement |
| `$D020` | Border color (used as timing marker during development) |
| `$01` | CPU port — bank switch between `$34`/`$36`/`$37` |

## constraints
- Combining DYPP and tech-tech requires FLI-style per-line IRQ for both `$D011` and `$D018` updates on every raster line.
- Restricting DYPP to ±1 pixel avoids color clashes but limits visual amplitude; wider distortion requires hires (non-FLI) bitmaps.
- 26 character segments × 3 displacement variants = 78 pre-rendered data sets; memory cost is significant.
- Sprites may be needed to mask the FLI bug artifact at column 0.

## sources

- codebase64.net: [FLI Floffy](https://codebase64.net/doku.php?id=base:fli_floffy) — CC BY-NC-SA 4.0
- codebase64.net: [Demo Programming — Graphics Distortion](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- effects: [swing.md](swing.md)
- effects: [fpp.md](fpp.md)
- effects: [stable-raster.md](stable-raster.md)
- display-modes: [../display-modes/fli.md](../display-modes/fli.md)
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)
