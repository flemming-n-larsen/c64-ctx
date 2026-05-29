---
type: reference
domain: game
granularity: recipe
---

## facts
- VIC-II fine-scroll registers: `$D011` bits 2–0 = YSCROLL (0–7 pixels), `$D016` bits 2–0 = XSCROLL (0–7 pixels). Cadaver/Covert Bitops (Rant 4).
- Fine scroll range is 0–7; when the value wraps, screen memory must shift by one character row or column (coarse scroll step). Malcolm Bamber (4 Ways Scroll).
- Shifting full screen memory costs more than half a frame's rastertime; distribute across multiple frames or use doublebuffering. Cadaver/Covert Bitops (Rant 4).
- Doublebuffering with source index X and destination index Y reduces all 8 scroll directions to the same copy loop — only the initial index values differ. Cadaver/Covert Bitops (Rant 4).
- Color memory shift costs ~20–21 raster lines; on NTSC split the update: upper half during lower-screen display, lower half during blanking. Cadaver/Covert Bitops (Rant 4).
- 8-directional scroll (used in Turrican, Navy Seals): scroll registers idle at 3 or 4 (center), never at boundary values; gives one full cycle to react before next coarse step. Cadaver/Covert Bitops (Rant 4).
- Free-directional scroll: registers need not idle at center; supports up to 4 pixels/frame; two frame types: (1) add speed + clamp, (2) on wrap: shift + draw + color + swap. Cadaver/Covert Bitops (Rant 4).

## sequence
1. Add scroll speed to XSCROLL or YSCROLL register value (software variable).
2. If value still in 0–7: write to `$D016`/`$D011` and finish.
3. On wrap: clamp to opposite boundary (0→7 or 7→0).
4. Shift screen memory one character in the scroll direction.
5. Draw the newly exposed tile column or row at the screen edge (see [tilemaps.md](tilemaps.md)).
6. Update color RAM for the new column/row using block-color lookup table.
7. Swap doublebuffer pointer (`$D018` or VIC bank select).
8. Advance map-edge pointer (block coordinate + subpixel offset).

**IRQ-driven stage split (4-ways scroll, Malcolm Bamber):**
1. IRQ fires at YSCROLL step 3 (up) or 4 (down): increment UDFLAG, move map pointer or copy screen.
2. IRQ fires at YSCROLL step 5 (up) or 2 (down): draw new tile at top or bottom edge.
3. IRQ fires at YSCROLL step 7 (up) or 0 (down): copy color map lines (alternating even/odd via UDFLAG).

## lookup
| direction | register | idle value | coarse trigger | screen shift direction | new data drawn at |
|---|---|---|---|---|---|
| scroll left | `$D016` XSCROLL | 3 or 4 | decrement wraps below 0 | right→left (shift cols left) | leftmost column |
| scroll right | `$D016` XSCROLL | 3 or 4 | increment wraps above 7 | left→right (shift cols right) | rightmost column |
| scroll up | `$D011` YSCROLL | 3 or 4 | decrement wraps below 0 | down→up (shift rows up) | top row |
| scroll down | `$D011` YSCROLL | 3 or 4 | increment wraps above 7 | up→down (shift rows down) | bottom row |

## constraints
- Screen memory MUST NOT be shifted in a single pass during active display; split across frames or restrict to blanking period.
- Color memory SHOULD be updated with a per-block lookup table, not shifted byte-by-byte; only 1 in 4 columns changes per horizontal scroll step.
- IRQ code MUST only write VIC registers and play music; scrolling (memory shift) belongs in the frame-update layer — see [frameskip.md](frameskip.md).
- NTSC builds MUST split color memory updates across the frame boundary to stay within the ~20-line blanking window.
- Doublebuffer swap MUST occur before the raster reaches the top of the visible area to avoid tearing.

## links
- game: [tilemaps.md](tilemaps.md)
- game: [frameskip.md](frameskip.md)
- effects: [../effects/fld.md](../effects/fld.md)
- effects: [../effects/scrolltext.md](../effects/scrolltext.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- irq: [../irq/INDEX.md](../irq/INDEX.md)
- concepts: [../concepts/screen-geometry.md](../concepts/screen-geometry.md)

## sources
- [https://codebase64.net/doku.php?id=base:rant4](https://codebase64.net/doku.php?id=base:rant4) — Cadaver/Covert Bitops, "Rant 4: Multidirectional Scrolling and Game World" — CC BY-NC-SA 4.0
- [https://codebase64.net/doku.php?id=base:4_ways_scroll](https://codebase64.net/doku.php?id=base:4_ways_scroll) — Malcolm Bamber, "4 Ways Scroll" — CC BY-NC-SA 4.0
- [../sources/INDEX.md](../sources/INDEX.md)
