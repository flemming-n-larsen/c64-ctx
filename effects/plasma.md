---
type: reference
domain: effects
granularity: atomic
---

## facts
- A plasma effect produces smoothly flowing color patterns by computing a color index for each cell from the sum of two or more sine waves with different spatial frequencies and phase offsets.
- On the C64, the computation is done on a pre-built sine table; the result indexes a color palette written to color RAM or `$D020`/`$D021` via raster IRQ.
- FLI plasma (Flexible Line Interlace) produces finer vertical resolution by combining FLI screen mode with per-line color updates.

## sequence — character-mode plasma

1. Pre-compute a 256-byte sine table (values 0–15 or 0–255 scaled to color range).
2. Maintain two phase accumulators: `phase_x` (horizontal wave), `phase_y` (vertical wave).
3. Each frame:
   - For each screen row (0–24): compute `row_val = sine[phase_y + row * freq_y]`.
   - For each cell in the row (0–39): compute `color = (sine[phase_x + col * freq_x] + row_val) & 0x0F`.
   - Write `color` to color RAM: `$D800 + row*40 + col`.
4. Increment `phase_x` and `phase_y` by their respective speed values each frame.
5. Optionally write a solid character (e.g., `$A0` = filled block in screen codes) to screen RAM for a pure color field.

## sequence — rasterbar plasma (color RAM + $D020)

1. Use a raster IRQ per line across the display area; see [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md).
2. Each line: write `sine[(phase + line * freq) & 0xFF]` to `$D020` (border) and/or `$D021` (background).
3. Also write the computed color to color RAM for the cells on that line.
4. Increment phase each frame.

## lookup
| parameter | typical value | effect |
|---|---|---|
| Sine table size | 256 bytes | One full cycle |
| `freq_x` | 2–8 | Horizontal wave frequency |
| `freq_y` | 2–8 | Vertical wave frequency |
| Speed (phase increment) | 1–4 per frame | Animation speed |
| Color range | 0–15 | C64 palette |

| address | purpose |
|---|---|
| `$D800`–`$DBE7` | Color RAM (one nibble per cell) |
| `$D020` | Border color |
| `$D021` | Background color 0 |

## constraints
- Computing 1000 cells per frame (40×25 × ~10 cycles/cell) costs ~10 000 cycles — over 50% of the PAL frame budget; optimize with lookup tables and unrolled loops.
- Color RAM only stores 4 bits per cell; the plasma color MUST be masked to 0–15.
- FLI plasma requires per-line `$D018` bank switching and is significantly more complex; see [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md) for bad-line cycle impact.
- For rasterbar plasma, use [stable-raster.md](stable-raster.md) to keep color transitions from jittering.

## links
- effects: [stable-raster.md](stable-raster.md)
- effects: [rasterbars.md](rasterbars.md)
- effects: [fld.md](fld.md)
- effects: [rng.md](rng.md)
- tasks: [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- colors: [../colors/INDEX.md](../colors/INDEX.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)

## sources
- codebase64.net: [Demo Programming — Plasma](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
