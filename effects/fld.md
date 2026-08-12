---
type: reference
domain: effects
granularity: atomic
summary: "Scroll vertically by inserting blank raster lines through bad-line suppression."
keywords: [FLD, flexible line distance, vertical scroll, bad line suppression]
---

## facts
- FLD (Flexible Line Distance) smoothly scrolls the display vertically by inserting extra blank raster lines between character rows using the bad-line suppression trick.
- A bad line occurs when `raster & 7 == YSCROLL ($D011 bits 0–2)`; suppressing bad lines by changing YSCROLL mid-frame prevents VIC-II from fetching character data, leaving the previous row on screen one line longer.
- Repeating this each raster line effectively stretches the display downward, shifting all content below by one pixel per suppressed bad line.

## sequence

1. Set up a raster IRQ at the start of the region to be scrolled.
2. Each frame, compute target scroll offset (0–7 pixels for sub-char scroll, or more for multi-char scroll).
3. For each raster line in the scroll region, inside the IRQ:
   - Write a YSCROLL value to `$D011` that does NOT match `raster & 7` (suppresses the bad line).
   - This holds the previous character row on-screen for one extra line.
4. After inserting the desired number of extra lines, restore a YSCROLL that matches the current raster to re-enable normal display fetch.
5. Combine with `$D011` bits 0–2 for sub-char fine-scroll within the 0–7 range.

## lookup
| register | bits | purpose |
|---|---|---|
| `$D011` | 0–2 | YSCROLL — bad line occurs when `raster & 7 == YSCROLL` |
| `$D011` | 3 | 24/25-row mode |
| `$D011` | 7 | Raster line bit 8 (MSB) |
| `$D012` | 0–7 | Current raster line (bits 0–7) |

| scroll pixels | bad lines suppressed | effect |
|---|---|---|
| 0 | 0 | No scroll |
| 1–7 | 1–7 per frame | Sub-character smooth scroll |
| 8+ | 8+ per frame | Multi-character scroll (rare; distorts display) |

## constraints
- Each suppressed bad line costs 40 cycles of CPU time that would have been stolen — cycle budget is temporarily restored for those lines.
- FLD MUST be applied at the correct raster position; applying it too late produces a torn line.
- Combining FLD with [scrolltext.md](scrolltext.md) character coarse-scroll allows pixel-perfect vertical scrolling.
- FLD below the display area (in the bottom border) requires the open-borders trick; see [open-borders.md](open-borders.md).
- The effect is CPU-intensive on the IRQ side; plan cycle budget accordingly.

## links
- effects: [stable-raster.md](stable-raster.md)
- effects: [scrolltext.md](scrolltext.md)
- effects: [open-borders.md](open-borders.md)
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources
- codebase64.net: [Demo Programming — FLD](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
