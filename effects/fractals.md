---
type: reference
domain: effects
granularity: atomic
summary: "Render Julia and Mandelbrot sets with fixed-point iteration and lookup tables."
keywords: [fractals, Julia set, Mandelbrot, fixed point iteration]
---

## facts
- C64 fractal effects most commonly render Julia sets or Mandelbrot sets iteratively; each pixel's color is determined by how many iterations of `z = z² + c` it takes to escape (`|z|² ≥ 2`), up to a maximum iteration count.
- Fixed-point arithmetic with lookup tables (`sqrtbl`, `logtbl`, `exptbl`) replaces floating-point; all multiplication uses pre-computed square tables.
- Typical resolution is 72×56 pixels with 4 color levels; results are bit-packed (4 pixels per byte) into a framebuffer.
- Dynamic seed morphing (changing `c` each frame) animates between Julia set variants without restarting the render.

## sequence

1. Pre-compute lookup tables:
   - `sqrtbl` (256 bytes low + 256 bytes high): squares for fast `x² + y²` via `(x+y)² - (x-y)²` identity.
   - `logtbl` / `exptbl` (256 bytes each): logarithm and exponential approximations.
2. Allocate framebuffer (`$2800`–`$3000`), screen RAM (`$0400`), and color RAM (`$D800`).
3. For each pixel (x, y):
   - Initialize `real = cx`, `imag = cy` (pixel coordinates mapped to complex plane).
   - Iterate: `rsq = real²`, `isq = imag²`; if `rsq + isq ≥ 2.0` → escaped; else `imag = 2*real*imag + seed_imag`, `real = rsq - isq + seed_real`.
   - Map iteration count → color index (0–3); pack 4 colors per byte into framebuffer.
4. On frame boundary, write framebuffer to screen/color RAM via IRQ.
5. Each frame, increment `seed_real` and `seed_imag` slightly to animate the morph.

## lookup

| item | value | notes |
|---|---|---|
| Resolution | 72×56 pixels | ~4032 pixels per frame |
| Max iterations | 32 | Trade-off: quality vs. speed |
| Color levels | 4 | 2 bits per pixel, packed 4/byte |
| Framebuffer | `$2800`–`$3000` | 512 bytes |
| Square table | `sqrtbl` 512 bytes | Low/high byte halves |

| zero-page address | purpose |
|---|---|
| `$4B`–`$53` | Iteration state: iter, currx, curry, real, imag, rsq, isq |
| `$5C`–`$61` | Extended precision squares and seed values |
| `$62`–`$6C` | Pointer management and working variables |

## constraints
- 4032 pixels × ~50 cycles/pixel ≈ 200 000 cycles; one frame at PAL (19 656 cycles) is insufficient — the render spans multiple frames.
- IRQ-driven display (3 raster interrupt points) updates the screen while rendering continues in the background.
- Music integration requires reserving an IRQ slot; the music player is typically at `$1000` (init) / `$1003` (IRQ).
- All arithmetic must be integer; 16-bit fixed-point (8.8 or 4.12) is the practical range for C64 Julia/Mandelbrot.

## links

- effects: [rng.md](rng.md)
- concepts: [../concepts/optimization.md](../concepts/optimization.md)
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources

- codebase64.net: [Julia Fractal Morpher](https://codebase64.net/doku.php?id=base:julia_fractal_morpher) — CC BY-NC-SA 4.0
- codebase64.net: [Demo Programming — Fractals](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
