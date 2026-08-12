---
type: reference
domain: display-modes
granularity: atomic
summary: "Interlaced FLI: two alternating FLI frames blending to roughly 128 perceived colors."
keywords: [IFLI, interlaced FLI, flicker, perceived colors]
---

## facts
- IFLI (Interlaced FLI) alternates two complete FLI frames every PAL field to blend perceived colors.
- Frame A and frame B each show different screen RAM color data at the same pixel position; the eye merges them into a mixed hue.
- Frame phase is toggled by flipping `$D016` XSCROLL bit 0 between 0 and 1 each frame; this shifts the bitmap 1 pixel horizontally so VIC reads a different screen RAM column, effectively swapping between the two datasets.
- Requires two full FLI screen RAM datasets (A and B), each 8000 bytes.
- Effective perceived color count: up to ~128 visually distinct mixes from the 16-color palette (16 × 16 combinations, many indistinct).
- Heavy flicker: each half-frame is shown 25 times/second (PAL); visible on CRT but severe on LCD.
- NUIFLI and UIFLI are interlaced variants of NUFLI and UFLI respectively.

## sequence

1. Set up FLI as per [fli.md](fli.md); allocate two datasets (A and B) of 8 × 1000 screen RAM blocks each.
2. Allocate a single shared bitmap (8000 bytes); both frames share the same pixel shapes, only screen RAM (colors) differ.
3. Frame detection: at raster line `$00` IRQ, read a frame-parity counter and flip it (0→1→0 each frame).
4. Per-frame: write `$D016` XSCROLL bit 0 = `frame_parity` (toggles between `$D8` and `$D9` for MCM mode).
5. Per-line FLI loop (same as [fli.md](fli.md) sequence step 5): write `$D018` = `fli_table_A[line mod 8]` or `fli_table_B[line mod 8]` depending on `frame_parity`.
6. Encode colors: for each 8×2 pixel area, choose color pair for frame A and color pair for frame B so the blended result approximates the target hue.

## lookup

### Frame alternation registers

| register | frame A | frame B | effect |
|---|---|---|---|
| `$D016` | `$D8` (XSCROLL=0) | `$D9` (XSCROLL=1) | shifts VIC column read by 1 px, selecting different screen RAM row |
| `$D018` per line | `fli_table_A[line mod 8]` | `fli_table_B[line mod 8]` | points to dataset A or B screen RAM blocks |

### Memory layout

| region | size | notes |
|---|---|---|
| Screen RAM dataset A | 8000 bytes | 8 × 1 KB blocks for frame A |
| Screen RAM dataset B | 8000 bytes | 8 × 1 KB blocks for frame B |
| Bitmap (shared) | 8000 bytes | same pixels for both frames |
| Color RAM | 1000 bytes | static; affects color `11` in MCBM |

Total display data: 24000 bytes (two screen RAM datasets + bitmap).

### Perceived color blending principle

| frame A color pair | frame B color pair | perceived result |
|---|---|---|
| white (1) | black (0) | medium gray |
| light blue (14) | dark blue (6) | medium blue |
| any X | same X | no blend — same color both frames |

The C64 16-color palette has uneven luminance steps; blending produces best results between colors of similar hue but different brightness.

## constraints
- Total memory requirement (24 KB display data) requires a VIC bank with no char-ROM holes; bank 1 (`$4000`) or bank 3 (`$C000`) recommended.
- XSCROLL toggle MUST happen before the first display line of the frame; any late write shifts only part of the screen.
- Flicker is inherent and cannot be eliminated — NUFLI was developed specifically to solve this; see [nufli.md](nufli.md).
- Same per-line CPU budget applies as FLI: 23 nominal bus-free cycles per PAL bad line, with possible BA lead-in stall.
- Encoding two-frame color pairs for artwork requires specialized conversion tools; direct viewing of single frames looks incorrect.

## links

- effects: [fli.md](fli.md)
- effects: [nufli.md](nufli.md)
- effects: [ufli.md](ufli.md)
- effects: [stable-raster.md](../effects/stable-raster.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- graphics: [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)

## sources

- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
