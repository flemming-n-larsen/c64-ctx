---
type: reference
domain: effects
granularity: atomic
summary: "Per-line horizontal warp of a graphic by driving the memory pointers from a sine table."
keywords: [FPP, stretcher, flexible pixel position, horizontal warp]
---

## facts
- FPP (Flexible Pixel Position), also called Stretcher, creates per-line horizontal displacement of a graphic by combining FLI bank-switching with sine-wave offsets applied to `$D018` and `$D016`.
- The effect is an extension of the tech-tech/swinging technique applied within a scrolling display: each raster line can independently select a different pre-shifted character buffer.
- A `chartab` table holds the `$D018` value for each raster line; the FPP routine modifies `chartab` each frame by writing sine-derived offsets, producing wave, stretch, swing, and rotation shapes.

## sequence

1. Set up an AFLI or FLI display with a per-line `$D018` table (`chartab`) at a fixed address (e.g., `$8F00`).
2. Build sine lookup tables (`sinus`, `sinus2`) for wave shapes.
3. Each frame before the display IRQ fires:
   - Clear `chartab` to the base `$D018` value.
   - Read animation counter from zero-page; index into the sine table.
   - For each line, compute `chartab[line] = base_d018 + sine_offset[counter + line]`.
   - Increment and wrap the animation counter.
4. The raster IRQ reads `chartab[current_line]` and writes it to `$D018` on every line.
5. Optionally apply a separate fine-pixel offset via `$D016` XSCROLL for sub-8-pixel alignment.

## lookup

| address | purpose |
|---|---|
| `$D018` | Character/bitmap pointer — switched per line |
| `$D016` bits 0–2 | XSCROLL pixel offset (0–7) |
| `$D011` bits 0–2 | YSCROLL — set to `raster mod 8` to force bad line |
| `$8F00` | `chartab` — per-line `$D018` values |
| `$9000`–`$9500` | Sine tables |
| `$62`–`$64`, `$68` | Zero-page animation counters |

## constraints
- FPP requires FLI-style timing (bad line on every raster line); cycle cost is the same as FLI.
- The `chartab` update MUST complete before the raster IRQ starts reading it; schedule the update in a VBLANK or early top-border IRQ.
- Modifying `chartab` while it is being consumed produces visible tearing; use double-buffering or restrict updates to the blanked portion.
- See FLI bad-line cycle impact: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md).

## links

- effects: [swing.md](swing.md)
- effects: [stable-raster.md](stable-raster.md)
- effects: [fld.md](fld.md)
- display-modes: [../display-modes/fli.md](../display-modes/fli.md)
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)

## sources

- codebase64.net: [FLI-FPP Scroller](https://codebase64.net/doku.php?id=base:fli-fpp-scroller) — CC BY-NC-SA 4.0
- codebase64.net: [Demo Programming — FPP (Stretcher)](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
