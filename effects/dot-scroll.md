---
type: reference
domain: effects
granularity: atomic
summary: "A field of dots flying toward the viewer from a precomputed perspective table."
keywords: [dot scroll, 3D dots, perspective table, speedcode generation]
---

## facts
- A 3D dot scroll renders a field of dots flying toward the viewer using pre-calculated perspective trajectories stored in a PLOTS table.
- Each dot has a (X, Y, Z) coordinate; X and Y are projected to screen position, Z controls speed (closer dots move faster).
- On C64, the dots are plotted into a bitmap; speedcode (unrolled write routines) is generated at runtime to achieve sufficient throughput.
- Bit shifting via `ASL`/`ROL` advances each dot along its trajectory each frame.

## sequence

1. Pre-calculate a PLOTS table (~1024 entries) of screen positions and bit masks for the full trajectory of each dot.
2. Generate speedcode at load time: a sequence of `EOR address,x` / `LDA / STA` pairs, one per dot per frame position, written into a buffer at `$4000`.
3. Each frame:
   - Execute the speedcode buffer to EOR (toggle) all dot pixels into the bitmap.
   - Advance each dot's position index in the PLOTS table.
   - Synchronize to raster line `$C8` before updating to avoid tearing.
4. When a dot reaches the end of its trajectory, wrap back to the origin point.

## lookup

| address | purpose |
|---|---|
| `$2000` | Bitmap display area |
| `$4000`–`$7D03` | Speedcode buffer (generated unrolled plot/clear routines) |
| `~$1000` | PLOTS table (trajectory coordinates) |
| `$20`–`$7F` zero page | 8 character shift buffers + vector registers |

| register | purpose |
|---|---|
| `$D012` | Raster sync — wait for line `$C8` before frame update |
| A | Data values and pixel mask |
| X | Bit position and loop counters |
| Y | Byte offset and row calculations |

## constraints
- Speedcode generation trades memory for speed; the unrolled buffer can occupy 12–16 KB.
- Illegal opcode `ANX ($8B)` is used in some implementations for combined bit-extraction; this is 6510-specific.
- Bitmap addressing: Y-position → byte offset by `LSR A` (÷8) for row; X-position masked with `AND #$F8` for byte, `AND #$07` for bit.
- The 8-frame scroll cycle before advancing the character position is a common pacing choice; adjust for speed.

## links
- effects: [stable-raster.md](stable-raster.md)
- concepts: [../concepts/optimization.md](../concepts/optimization.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- graphics: [../graphics/screen-modes.md](../graphics/screen-modes.md)

## sources
- codebase64.net: [3D Dot Scroll](https://codebase64.net/doku.php?id=base:3d_dot_scroll) — CC BY-NC-SA 4.0
- codebase64.net: [Demo Programming — 3D Dot Scroll](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
