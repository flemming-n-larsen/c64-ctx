---
type: reference
domain: effects
granularity: atomic
summary: "3D wireframe and filled polygons: projection, depth sort, scanline fill."
keywords: [vectors, 3D polygons, wireframe, painter's algorithm, scanline fill]
---

## facts
- C64 vector effects render 3D polygon objects (wireframe or filled) by projecting 3D vertices to 2D screen coordinates, sorting faces by Z depth, then drawing edges or filling spans.
- Filled polygon rendering uses a scanline algorithm: for each horizontal line between Y_min and Y_max of a polygon, calculate the X span and fill it.
- Sprite-based vector effects use hardware sprites as pre-rotated polygon segments, avoiding costly bitmap writes entirely.
- A fast bitmap fill clears the screen in ~87 raster lines using speedcode; the character-based variant modifies individual 8×8 charset definitions and updates screen RAM.

## sequence — filled polygon (bitmap)

1. **Rotate**: apply pre-computed sin/cos tables to rotate vertex positions; project to 2D with perspective divide (`screen_x = x * focal / z`).
2. **Sort faces**: order faces back-to-front (painter's algorithm) by average Z of their vertices.
3. **For each face**, use scanline fill:
   - Find Y_min and Y_max vertices; sort vertices by Y.
   - Walk left and right edges simultaneously, tracking X position per scanline.
   - For each scanline: fill from X_left to X_right in three parts:
     - Start chunk (partial 8-bit block): mask and OR into bitmap byte.
     - Middle chunks (full bytes): write `$FF`.
     - End chunk (partial 8-bit block): mask and OR.
4. **Clear** previous frame's bitmap before rendering new frame (speedcode clear).

## sequence — sprite vectors

1. Pre-render each face orientation as a sprite shape.
2. Position hardware sprites to assemble the polygon from sprite segments.
3. Use sprite multiplexer to handle more than 8 segments; see [sprite-multiplexer.md](sprite-multiplexer.md).

## lookup

| operation | technique | notes |
|---|---|---|
| Start/end partial blocks | Bitmask table (7 entries: `$80`, `$40`…`$01`) | One mask per bit offset |
| Middle blocks | `STA address,y` sequence | Speedcode: no loop overhead |
| Fast clear | Speedcode: ~87 raster lines | Pre-generated unrolled stores |
| Sin/cos tables | 256-byte tables | 1 cycle per lookup vs. many for calculation |

| register | typical role |
|---|---|
| A | Pattern/mask operations |
| X | Horizontal position counter |
| Y | Vertical counter and table index |

## constraints
- Scanline fill speed depends on average polygon width; wide polygons benefit most from speedcode middle fills.
- Painter's algorithm requires face sorting each frame (~O(n log n)); with few faces (≤16), a simple insertion sort is fast enough.
- Sprite-based vectors avoid bitmap writes but are limited to sprite resolution (24×21 pixels per hardware sprite); visual quality is lower.
- Bitmap must be in the current VIC bank and not overlapping I/O or ROM; see [../concepts/memory-banking.md](../concepts/memory-banking.md).

## sources

- codebase64.net: [Filling the Vectors](https://codebase64.net/doku.php?id=base:filling_the_vectors) — CC BY-NC-SA 4.0
- codebase64.net: [Drivecalc Vectors](https://codebase64.net/doku.php?id=base:drivecalc_vectors) — CC BY-NC-SA 4.0
- codebase64.net: [Sprite Vectors](https://codebase64.net/doku.php?id=base:spritevectors) — CC BY-NC-SA 4.0
- codebase64.net: [Demo Programming — Vectors](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- effects: [sprite-multiplexer.md](sprite-multiplexer.md)
- effects: [stable-raster.md](stable-raster.md)
- concepts: [../concepts/optimization.md](../concepts/optimization.md)
- concepts: [../concepts/memory-banking.md](../concepts/memory-banking.md)
- tasks: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- graphics: [../graphics/screen-modes.md](../graphics/screen-modes.md)
