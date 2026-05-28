---
type: reference
domain: effects
granularity: atomic
---

## facts
- The VIC-II provides 8 hardware sprites; a multiplexer recycles them mid-frame to display more than 8 sprites on screen.
- Sprites are sorted by Y position; the 8 hardware slots are assigned to the topmost 8 objects. As the raster passes each sprite, the slot is reassigned to the next object in the sorted list.
- Each reassignment requires updating: Y position, X position, pointer (`$07F8`+n), color (`$D027`+n), and MSB of X (`$D010`) via a raster IRQ at the handoff line.

## sequence

1. Each frame: sort all logical sprites by Y coordinate (insertion sort is fast for small counts).
2. Assign the 8 hardware slots to the first 8 logical sprites (topmost).
3. Write initial positions, pointers, colors, and `$D015` enable mask.
4. Set raster IRQ at the Y position of the 9th logical sprite (first handoff).
5. **In each handoff IRQ:**
   - Identify which hardware slot(s) have passed below their assigned logical sprite.
   - Reassign each freed slot to the next unassigned logical sprite.
   - Write new Y, X, pointer, color, and X-MSB for reassigned slots.
   - Set next IRQ at the Y position of the next handoff.
6. Repeat until all logical sprites are displayed or raster reaches the bottom.

## lookup
| register | purpose |
|---|---|
| `$D000`–`$D00F` | Sprite X (even) and Y (odd) positions, sprites 0–7 |
| `$D010` | Sprite X MSB (bit per sprite; set if X ≥ 256) |
| `$D015` | Sprite enable (bit per sprite) |
| `$D027`–`$D02E` | Sprite colors 0–7 |
| `$07F8`–`$07FF` | Sprite pointers (screen RAM base + `$03F8`; 64-byte block index) |

| timing constraint | value |
|---|---|
| Lines between sprites | ≥ 2 lines recommended for reliable handoff |
| Cycles per slot reassignment | ~20–30 cycles for Y+X+pointer+color writes |
| Max logical sprites | Unlimited in theory; practical limit ~32 at 50 Hz on PAL |

## constraints
- The handoff IRQ MUST fire before the raster reaches the new sprite's Y position — fire at Y−2 or earlier.
- X MSB (`$D010`) is shared across all 8 sprites; update atomically when reassigning slots with X ≥ 256.
- Sprite pointer addresses assume screen RAM at `$0400`; adjust base if screen RAM is relocated.
- Two logical sprites on the same Y line can share a hardware slot only if they have the same X and glyph — otherwise use adjacent Y offsets.
- Combine with [dysp.md](dysp.md) for moving sprites between frames.

## links
- effects: [dysp.md](dysp.md)
- effects: [stable-raster.md](stable-raster.md)
- tasks: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- tasks: [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- memory: [../memory/map.md](../memory/map.md)

## sources
- codebase64.net: [Demo Programming — Sprite Multiplexer](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
