---
type: reference
domain: game
granularity: recipe
summary: "Tile map data layout using 8-bit block indices, and how to draw it."
keywords: [tile maps, tiles, block indices, level data, map drawing]
---

## facts
- Map data uses 8-bit block indices; maximum 256 distinct tile blocks per map. Cadaver/Covert Bitops (Rant 4).
- Recommended block size is 4×4 characters — tradeoff between memory use and graphical variety. Cadaver/Covert Bitops (Rant 4).
- Block dimensions SHOULD be a power of 2 so tile-to-address multiplication reduces to shifts. Cadaver/Covert Bitops (Rant 4).
- Map rows are stored sequentially in memory top-to-bottom; row start addresses are precalculated in a lookup table to avoid runtime multiplication. Cadaver/Covert Bitops (Rant 4).
- World coordinate method v2 encodes object positions as: high byte = block index, low byte = pixel position within block (3 bits subpixel, 5 bits within-block character offset). Background collision check then reduces to a single high-byte map lookup. Cadaver/Covert Bitops (Rant 4).

## sequence
1. Load tile block index from map buffer at `(block_col, block_row)`.
2. Multiply block index by block byte size (16 for 4×4 tiles = left-shift 4).
3. Add block data base address → source pointer.
4. Compute screen destination: use row_lut[block_row] + block_col×4.
5. Copy 4 rows × 4 bytes from block data to screen RAM.
6. For color RAM: use `lda charcolortable,y / sta colormem,x` lookup instead of shifting — one lookup per byte, avoids full color-shift cost.
7. Repeat for all visible blocks (typically one new column or row per scroll step, not full redraw).

## lookup
| coordinate method | position encoding | bg-collision cost | sprite-display cost | known games |
|---|---|---|---|---|
| screen coords | pixel offset from screen top-left | high — no direct map link | fast | Turrican |
| world coords v1 | 16-bit pixel from map origin | slow — requires offset subtract | straightforward | Metal Warrior 1–2 |
| world coords v2 | high=block index, low=pixel within block | fast — high byte IS map index | requires bit rotation | Metal Warrior 3, BOFH |

## constraints
- Block size MUST be a power of 2 or runtime multiplication will dominate the tile-draw budget.
- Row start addresses MUST be precomputed in a lookup table; runtime multiply per row exceeds the draw budget.
- Color memory SHOULD use per-block color lookup rather than full-screen shifting; during horizontal scroll only 1 in 4 columns changes, reducing color-RAM writes by ~75%. Cadaver/Covert Bitops (Rant 4).
- Objects SHOULD use world-coords v2 encoding when background collision speed is critical; screen-coord objects exhibit erratic boundary behavior and require hardcoded off-screen responses.

## links

- game: [scrolling.md](scrolling.md)
- memory: [../memory/map.md](../memory/map.md)
- vic: [../vic/INDEX.md](../vic/INDEX.md)
- io: [../io/color-ram.md](../io/color-ram.md)
- concepts: [../concepts/screen-geometry.md](../concepts/screen-geometry.md)

## sources

- [https://codebase64.net/doku.php?id=base:rant4](https://codebase64.net/doku.php?id=base:rant4) — Cadaver/Covert Bitops, "Rant 4: Multidirectional Scrolling and Game World" — CC BY-NC-SA 4.0
