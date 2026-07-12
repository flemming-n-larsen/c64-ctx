---
type: reference
domain: display-modes
granularity: atomic
---

## facts
- SH (Super HiRes), AH (Advanced HiRes), and IH (Interlaced HiRes) are hires bitmap techniques that exceed the apparent 320×200 resolution or color density without the FLI layer.
- SH / AH: use pixel-shift dithering or multi-layer tricks on a standard SBM (320×200) frame; the "super/advanced" designation reflects improved per-cell color utilization rather than a new VIC-II trick.
- IH: alternates two SBM frames offset horizontally by 1 pixel (XSCROLL toggle), producing perceived ~640-pixel horizontal resolution; identical in mechanism to SHI (see [shfli.md](shfli.md)).
- These modes require stable raster IRQ for frame alternation (IH/SHI) but do NOT require per-line `$D018` writes (no FLI component).
- Introduced: SH January 1991; AH December 1996; IH date not listed.

## sequence — IH (most commonly implemented)

1. Prepare two hires SBM bitmaps (A and B) with pixels offset by 1 horizontal pixel.
2. Set up stable raster IRQ at line `$00` for frame detection.
3. Each frame: toggle `$D016` XSCROLL between `$C8` (XSCROLL=0) and `$C9` (XSCROLL=1).
4. Each frame: write `$D018` to select the corresponding bitmap/screen RAM dataset (A or B).

## sequence — SH / AH (pixel-shift dithering)

1. Use standard SBM with 2-color-per-cell layout.
2. Design bitmap with deliberate dithering patterns (checkerboard, diagonal stripes) to create perceived intermediate colors.
3. No per-line register writes required; effect is purely artistic/algorithmic.

## lookup

| variant | base mode | frame alternation | FLI | key technique |
|---|---|:---:|:---:|---|
| SH | SBM hires | no | no | pixel dithering patterns |
| AH | SBM hires | no | no | advanced dithering / color assignment |
| IH | SBM hires | yes | no | XSCROLL horizontal frame offset |

## constraints
- IH flicker: same as SHI/IFLI (25 fps per half-image, PAL).
- SH/AH are artistic/algorithmic techniques; no special register sequence beyond standard SBM setup.
- For SH/AH with FLI, see [shfli.md](shfli.md).

## links
- effects: [shfli.md](shfli.md)
- effects: [ifli.md](ifli.md)
- graphics: [../graphics/screen-modes.md](../graphics/screen-modes.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources
- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
