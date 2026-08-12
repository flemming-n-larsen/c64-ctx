---
type: reference
domain: display-modes
granularity: atomic
summary: "Tri-Interlaced FLI: three rotating frames for roughly 200-300 perceived colors."
keywords: [TRIFLI, tri interlace, three frame rotation]
---

## facts
- TRIFLI (Tri Interlaced FLI) extends IFLI from 2 alternating frames to 3 rotating frames (A → B → C → A …).
- Each frame is a complete FLI dataset; the three frames cycle at approximately 16.7 fps each on PAL (50 Hz ÷ 3).
- Three-frame blending allows more perceived color combinations: up to 16³ = 4096 theoretical triplet combinations; practically ~200–300 visually distinct mixed colors.
- Higher perceived color count than IFLI, but more severe flicker (1/3 frame rate per sub-image vs. 1/2 for IFLI).
- Introduced January 2010.

## sequence

1. Prepare 3 complete FLI datasets (A, B, C): each has 8000 bytes of screen RAM blocks + a shared bitmap.
2. Set up frame counter (3-state cycle: 0, 1, 2) updated at raster line `$00` each frame.
3. At the start of each frame (before display line `$33`):
   - Set `$D016` XSCROLL to the frame-phase value (0, 1, or 2 cycles through `$C8`, `$C9`, `$CA` for slight pixel-phase differences; or keep XSCROLL constant and only vary the screen RAM pointer).
4. Per-line FLI loop: write `$D018` = `fli_table_[A|B|C][line mod 8]` depending on `frame_counter`.
5. Artwork prepared with a three-frame color encoding tool.

## lookup

| frame | `$D016` XSCROLL | screen RAM dataset | approximate fps (PAL) |
|:---:|:---:|:---:|:---:|
| A | `$C8` | dataset A | 16.7 |
| B | `$C9` | dataset B | 16.7 |
| C | `$CA` | dataset C | 16.7 |

### Memory requirement

| region | size |
|---|---|
| Screen RAM datasets A + B + C | 3 × 8000 = 24000 bytes |
| Bitmap (shared) | 8000 bytes |
| Total | 32000 bytes (2 × 16 KB VIC banks) |

## constraints
- 32 KB of display data spans two VIC banks; bank switching or careful placement required.
- Flicker is more pronounced than IFLI (16.7 fps vs. 25 fps per sub-image); more visible on CRT and worse on LCD.
- Three-frame encoding requires TRIFLI-specific conversion tools.
- All FLI per-line constraints apply; see [fli.md](fli.md).

## links

- effects: [fli.md](fli.md)
- effects: [ifli.md](ifli.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- graphics: [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md)

## sources

- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
