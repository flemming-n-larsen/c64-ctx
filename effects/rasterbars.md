---
type: reference
domain: effects
granularity: atomic
summary: "Colored bars drawn by rewriting the border and background color each raster line."
keywords: [rasterbars, color bars, raster splits, border color]
---

## facts
- Rasterbars write a sequence of color values to `$D020` (border) and/or `$D021` (background) once per raster line inside a raster IRQ handler.
- Each write takes effect on the current raster line, producing a colored horizontal bar.
- A table of colors indexed by line offset drives the bar pattern; the table is stepped through in sync with the raster counter.

## sequence

1. Set up raster IRQ at the first line of the bar region; see [../irq/raster-interrupt.md](../irq/raster-interrupt.md).
2. Inside the IRQ handler, load a pointer into the color table (index = current raster line − bar start line).
3. Write `color_table,X` to `$D020` and/or `$D021`.
4. Acknowledge `$D019`, increment line counter, set next `$D012` compare to current line + 1.
5. Chain IRQ to itself until the bar region ends, then restore the original next-frame IRQ.

**Tighter alternative (no chaining):** If the bar spans many lines, use a tight IRQ-driven loop that polls `$D012` directly and writes each line without RTI overhead.

## lookup
| register | purpose |
|---|---|
| `$D020` | Border color (bits 0–3) |
| `$D021` | Background color 0 (bits 0–3) |
| `$D012` | Raster line compare (set to next bar line) |
| `$D019` | IRQ status — write `$01` to acknowledge |

| bar position | typical raster range | notes |
|---|---|---|
| Upper border | `$08`–`$32` | Requires open border trick; see [open-borders.md](open-borders.md) |
| Display area | `$33`–`$FA` | Direct; no border trick needed |
| Lower border | `$FB`–`$12C` | Requires open border trick |

## constraints
- Writing `$D020`/`$D021` late in the line (after the visible pixels are drawn) affects the next line — writes MUST happen in the first few cycles of the target line.
- Bad lines steal 40 cycles; bars on bad lines may arrive late and produce a thin artifact; see [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md).
- For stable bar position, use [stable-raster.md](stable-raster.md) to eliminate ±1-line jitter.
- Color values are 0–15; upper nibble is ignored.

## links
- effects: [stable-raster.md](stable-raster.md)
- effects: [open-borders.md](open-borders.md)
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- colors: [../colors/INDEX.md](../colors/INDEX.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)
- concepts: [../concepts/screen-geometry.md](../concepts/screen-geometry.md)

## sources
- codebase64.net: [Demo Programming — Rasterbars](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
