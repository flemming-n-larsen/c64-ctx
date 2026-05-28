---
type: reference
domain: effects
granularity: atomic
---

## facts
- The C64 fire effect uses a custom character set where each character represents a 4×4 or 8×8 pixel intensity block.
- A heat buffer (one byte per screen cell) is updated each frame using a neighbor-average algorithm: each cell's new value is the average of itself and its neighbors, minus a cooling value.
- The heat value indexes a color gradient table; the corresponding character (or color) is written to screen RAM and/or color RAM.

## sequence

1. Define a custom charset with characters representing fire intensities (e.g., 16 chars from empty to full bright).
2. Point VIC-II `$D018` to the custom charset location; see [../tasks/custom-charset.md](../tasks/custom-charset.md).
3. Allocate a heat buffer: one byte per screen cell (40×25 = 1000 bytes), initialized to 0.
4. Each frame:
   - **Seed the bottom row:** write high heat values (e.g., 15) to the bottom row of the heat buffer with optional random variation; see [rng.md](rng.md).
   - **Propagate upward:** for each cell from bottom-1 to top, compute: `heat[x][y] = (heat[x-1][y+1] + heat[x][y+1] + heat[x+1][y+1] + heat[x][y+2]) / 4 - cooling`.
   - **Clamp** results to 0–15 (or 0–255 for larger palette).
5. Map heat values to screen chars and/or color RAM: `screen[cell] = char_table[heat[cell]]`, `color[cell] = color_table[heat[cell]]`.

## lookup
| item | typical value | notes |
|---|---|---|
| Heat buffer size | 1000 bytes (40×25) | One byte per screen cell |
| Heat levels | 0–15 | Maps to 16 chars and 16 colors |
| Cooling factor | 1–3 per frame | Higher = faster cooling, smaller flames |
| Bottom seed value | 15 (max heat) | Randomize ±1–2 for organic look |
| Custom charset block | Any VIC-accessible 2 KB | 16 chars × 8 bytes each = 128 bytes minimum |

## constraints
- The propagation loop (1000 cells × ~6 cycles/cell) costs ~6000 cycles per frame; the frame budget is ~63×312 = ~19656 cycles PAL. The loop uses ~30% of frame time.
- Heat buffer MUST be in RAM (not under ROM or I/O); place in `$C000`–`$CFFF` or other free RAM.
- Custom charset MUST be in the same VIC bank as screen RAM; see [../tasks/custom-charset.md](../tasks/custom-charset.md).
- The neighbor-average MUST wrap at screen edges or clamp to avoid reading garbage values.

## links
- effects: [rng.md](rng.md)
- tasks: [../tasks/custom-charset.md](../tasks/custom-charset.md)
- tasks: [../tasks/game-loop.md](../tasks/game-loop.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- colors: [../colors/INDEX.md](../colors/INDEX.md)
- memory: [../memory/map.md](../memory/map.md)

## sources
- codebase64.net: [Demo Programming — Fire Effects](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
