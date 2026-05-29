---
type: reference
domain: concepts
granularity: atomic
---

## facts
- A **bad line** is any raster line Y in the display window where `(Y AND $07) == YSCROLL` and DEN=1 (`$D011` bit 4).
- On a bad line, VIC-II halts the CPU and steals ~40 cycles to fetch the 40 character codes for that character row.
- Remaining CPU cycles per raster line: ~23 (PAL, 63 total) or ~25 (NTSC, 65 total) on bad lines vs. ~63/~65 on normal lines.
- Display window: raster lines 48-247 (200 lines). With YSCROLL=3 (default), bad lines fall at 51, 59, 67, … one per character row = 25 bad lines per frame.
- Sprite DMA steals additional cycles (independent of bad lines) on every raster line a sprite occupies; cycles stolen scale with the number of enabled sprites.
- Setting DEN=0 (`$D011` bit 4 = 0) suppresses all bad lines; the display window shows border color, but sprites remain visible.
- PAL border lines (0-47, 248-311) are never bad lines; full ~63 cycles are always available there.

## lookup

| need | read | notes |
|---|---|---|
| `$D011` YSCROLL (bits 2-0) and DEN (bit 4) | [../io/vic-ii.md](../io/vic-ii.md) | YSCROLL sets which sub-line within a character row triggers a bad line |
| Raster line position (`$D011` bit 7 + `$D012`) | [../io/vic-ii.md](../io/vic-ii.md) | Use to time YSCROLL changes between lines |
| CPU cycle counts per instruction | [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md) | Only ~23 (PAL) cycles available on bad lines for tight loops |
| Raster interrupt setup | [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md) | Fire IRQ before the bad line to change YSCROLL in time |

## constraints

- Cycle-exact code running inside the display window MUST account for bad lines; 40 cycles are unavailable on each bad line.
- The bad line condition is evaluated at the START of the raster line; YSCROLL MUST be changed before that line begins — typically in a raster IRQ firing on the previous line.
- Changing YSCROLL mid-frame to a value that does not match `(Y AND $07)` for the upcoming line suppresses that bad line but vertically shifts the display by 1 pixel; this is the basis of FLD (Flexible Line Distance) effects.
- YSCROLL changes between bad lines shift character row alignment; unintended changes produce visible glitches.
- Sprite DMA costs are additive: a line with both a bad line steal and active sprite fetches loses more than 40 cycles.
- PAL frame budget (text mode, no sprites): 312 lines × 63 cycles − 25 bad lines × 40 stolen = ~18,656 cycles available per frame.

## techniques — avoiding or working around bad lines

### 1. YSCROLL suppression (per-line)
Fire a raster IRQ on line N−1. Write `$D011` with YSCROLL bits 2-0 set to any value ≠ `(N AND $07)`. Line N is no longer a bad line — the CPU gets the full ~63 cycles. Restore YSCROLL afterward to prevent permanent display shift. Requires cycle-exact IRQ placement (see stable raster below).

### 2. FLD — Flexible Line Distance
Apply YSCROLL suppression to multiple consecutive bad lines via a raster IRQ per line. With each suppressed bad line the character row is not advanced, stretching vertical row spacing. Used in vertical-scroller effects and row-distance manipulation. Restoring YSCROLL on a later line resumes normal character advancement.

### 3. DEN=0 — sprite-only display
Clear `$D011` bit 4 (DEN=0) for the entire frame or a region. No bad lines occur; the display window shows border color. Sprites are unaffected and remain visible. Gives full ~63 cycles on every line and is the standard strategy for effects that only use sprites, raster bars, or a plain background.

### 4. Border area scheduling
PAL lines 0-47 (top border) and 248-311 (bottom border): no display window active, no bad lines, full ~63 cycles each. ~64 lines × 63 cycles ≈ 4,000 free cycles per frame. Schedule bulk computation, table updates, or effect setup in these regions to leave display-area cycles for timing-sensitive work.

### 5. Stable raster IRQ (prerequisite for techniques 1-2)
A standard raster IRQ does not land at a known cycle within the line. The **double-IRQ** technique resolves this:
1. First IRQ fires on the target line (rough alignment).
2. Handler immediately re-arms the raster compare for the same or next line and returns.
3. Second IRQ fires within a predictable narrow window.
4. NOP padding after the second entry point aligns execution to the exact cycle.
Without a stable raster, YSCROLL writes may land after VIC-II has already evaluated the bad line condition, making suppression unreliable.

## links

- VIC hub: [../vic/INDEX.md](../vic/INDEX.md)
- VIC timing: [../vic/timing.md](../vic/timing.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- raster interrupt: [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md)
- CPU instruction cycles: [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md)
- concepts index: [INDEX.md](INDEX.md)

## sources

- local route: [../sources/INDEX.md](../sources/INDEX.md)
- upstream: [mist64/c64ref src/c64io](https://github.com/mist64/c64ref/tree/master/src/c64io)
