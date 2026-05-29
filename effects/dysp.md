---
type: reference
domain: effects
granularity: atomic
---

## facts
- DYSP (Dynamic Y-position Sprites) repositions sprites mid-frame by updating their Y coordinates (`$D001`, `$D003`, …) inside a raster IRQ, giving the illusion of more than one vertical position per sprite per frame.
- The extreme version (sprite stretching) moves a sprite's Y position one raster line at a time, making a single sprite appear to span many lines with a stretched glyph.
- A cycle-count table drives the timing: each entry stores how many cycles to wait before writing the next Y position.

## sequence — sprite Y repositioning

1. Sort active sprites by their desired Y position.
2. Set up a raster IRQ at the Y position of the first sprite.
3. In the IRQ: write `$D001`/`$D003`/… for the relevant sprite(s); set next IRQ at the next sprite's Y.
4. Chain IRQs until all sprites are positioned for this frame; restore for next frame.

## sequence — sprite stretching

1. Set `$D001` (sprite 0 Y) to the top of the stretch zone.
2. Use a stable raster IRQ (see [stable-raster.md](stable-raster.md)) running every raster line.
3. Each line: increment `$D001` by 1 (following the raster), keeping the sprite at the current line.
4. The sprite glyph rows are re-fetched each time `$D001` changes, so the same rows repeat — stretching the image.
5. Build a cycle table for each line that gives the exact delay between IRQ entry and the Y write.

## lookup
| register | purpose |
|---|---|
| `$D001` | Sprite 0 Y position |
| `$D003` | Sprite 1 Y position |
| `$D005` | Sprite 2 Y position |
| `$D007` | Sprite 3 Y position |
| `$D009` | Sprite 4 Y position |
| `$D00B` | Sprite 5 Y position |
| `$D00D` | Sprite 6 Y position |
| `$D00F` | Sprite 7 Y position |
| `$D015` | Sprite enable register (bit per sprite) |
| `$D017` | Sprite Y-expand (doubles sprite height) |

| Y value | screen position |
|---|---|
| `$07` | Top of visible area (raster `$08`) |
| `$FF` | Bottom of display area |
| `$00`–`$06` | Above visible area |

## constraints
- Each sprite Y write MUST arrive within the correct raster line or the sprite jumps unexpectedly.
- Stretching requires [stable-raster.md](stable-raster.md) — unstable raster causes stretch artifacts.
- Cycle tables MUST account for bad lines (40 stolen cycles); pre-compute entries for bad-line and non-bad-line rasters separately.
- Sprite Y-expand (`$D017`) doubles vertical size using the hardware, complementing software stretch.
- For more than 8 simultaneous sprites, combine with [sprite-multiplexer.md](sprite-multiplexer.md).

## links
- sprites: [../sprites/INDEX.md](../sprites/INDEX.md)
- sprite techniques: [../sprites/advanced.md](../sprites/advanced.md)
- sprite setup: [../sprites/display.md](../sprites/display.md)
- effects: [stable-raster.md](stable-raster.md)
- effects: [sprite-multiplexer.md](sprite-multiplexer.md)
- tasks: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources
- codebase64.net: [Demo Programming — DYSP](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
