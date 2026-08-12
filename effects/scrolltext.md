---
type: reference
domain: effects
granularity: atomic
summary: "Horizontal, vertical and sine scrollers built on hardware fine-scroll plus char shifting."
keywords: [scroller, scrolltext, fine scroll, sine scroller, greetings]
---

## facts
- Hardware fine-scroll shifts the display left by 0–7 pixels using `$D016` bits 0–2 (horizontal) or up by 0–7 pixels using `$D011` bits 0–2 (vertical).
- Coarse scroll (8-pixel step) is achieved by copying the screen RAM buffer one character column left/up and decrementing the fine-scroll counter back to 7.
- Sprite-based scrollers move sprite X positions for sub-pixel precision; useful when char resolution is too coarse.

## sequence — horizontal character scroller

1. Each frame: decrement fine-scroll counter (`$D016` bits 0–2). Start at 7, count down to 0.
2. When counter reaches 0: reset counter to 7 and perform a coarse shift — copy screen RAM columns left by 1 (40 bytes per row, shift each row).
3. Write new character from the message string into the rightmost column.
4. Advance message pointer.
5. Write updated fine-scroll value to `$D016` (preserve bits 3–7: `$C0` | fine_value for 40-col mode).

## sequence — vertical character scroller

1. Each frame: decrement `$D011` bits 0–2 (YSCROLL) from 7 to 0.
2. When YSCROLL reaches 0: reset to 7; copy screen RAM rows up by 1 (1000 bytes, shift 40 columns × 25 rows).
3. Fill the bottom row with new characters.
4. Write updated YSCROLL to `$D011` (preserve bits 3–7: `$1B` | yscroll_value).

## sequence — sine scroller (sprite-based)

1. Drive 8 sprites across the screen, each displaying one character glyph (custom charset).
2. Each frame: update each sprite's X position (`$D000`, `$D002`, …) from a sine table.
3. Advance the phase offset each frame to animate the wave.
4. Update sprite Y positions if vertical wave is also desired.

## lookup
| register | bits | purpose |
|---|---|---|
| `$D016` | 0–2 | Horizontal fine-scroll (0=shifted 0px, 7=shifted 7px left) |
| `$D016` | 3 | Multi-color mode toggle |
| `$D016` | 4 | 38/40-column mode |
| `$D011` | 0–2 | Vertical fine-scroll (YSCROLL) |
| `$D011` | 3 | 24/25-row mode |

## constraints
- `$D016` writes affect the horizontal scroll for the entire screen; partial-screen scrollers require per-line IRQ writes.
- Coarse shift copies 1000 bytes for full screen; partial scrollers (one text row) copy 40 bytes.
- Fine-scroll value 0 and value 8 produce the same visual result — use 0–7 only.
- Sine scroller with sprites requires custom char data in a VIC-accessible RAM bank; see [../tasks/custom-charset.md](../tasks/custom-charset.md).
- For stable scroll on every raster line, combine with [stable-raster.md](stable-raster.md).

## links
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- tasks: [../tasks/custom-charset.md](../tasks/custom-charset.md)
- tasks: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- effects: [stable-raster.md](stable-raster.md)
- effects: [fld.md](fld.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources
- codebase64.net: [Demo Programming — Scrolling Text](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
