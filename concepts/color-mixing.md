---
type: reference
domain: concepts
granularity: atomic
---

## facts
- The VIC-II hardware palette is fixed at 16 colors; all color expansion techniques use software or timing tricks to create the perception of more colors.
- Five fundamental techniques underlie all unofficial C64 display modes: raster color changes, the FLI per-line trick, frame interlacing, sprite underlay layers, and spatial dithering.
- Techniques can be combined; names of unofficial modes encode their combination (e.g., NUIFLI = New Underlay + Interlaced + FLI).

## lookup

### The 7 fundamental techniques

| # | technique | key mechanism | effective colors | flicker |
|:---:|---|---|:---:|:---:|
| 1 | Raster color changes | Write `$D021`/`$D020`/color RAM mid-frame in raster IRQ | 16/band | no |
| 2 | FLI per-line | Write `$D018` + `$D011` YSCROLL each raster line; forces VIC bad line every line | 16 independent pairs/raster line | no |
| 3 | Frame interlacing | Alternate 2–3 complete frames; eye blends colors between frames | ~128 (IFLI), ~200–300 (TRIFLI) | yes |
| 4 | Sprite underlay | Hires or multicolor sprites behind bitmap add independent color planes | +2–4 colors/area (UFLI/NUFLI) | no |
| 5 | Spatial dithering | Checkerboard/stripe bitmap patterns perceived as blended color | ~120 intermediate shades | no |
| 6 | ALM (Alternate Line Method) | Even raster lines use Color A, odd lines Color B — same luma cluster only | ~7 pairs (common VIC-II), more on first revision | no |
| 7 | DCM (Dynamic Chequerboard Method) | Single-pixel chequerboard swapped A↔B every frame via raster IRQ | ~120 perceived blends, spatially localised | yes (subtle) |

### Effective color count comparison

| mode / technique | effective colors/screen | flicker | notes |
|---|:---:|:---:|---|
| Standard (SCM / SBM) | 16 | no | hardware limit |
| Raster color split | 16 per horizontal band | no | different set per band |
| FLI | 16 pairs per raster line | no | colors `01`/`10` change every line |
| FLI + `$D021` writes (XFLI) | + 1 more per line | no | third per-line changeable color |
| IFLI | ~128 perceived | yes | 25 fps per half-frame (PAL) |
| TRIFLI | ~200–300 perceived | yes | 16.7 fps per sub-frame (PAL) |
| UFLI | FLI + 2–3 colors/area | no | sprite underlay adds extra layer |
| NUFLI | 3 colors per 8×2 px | no | flicker-free; replaces IFLI for many uses |
| Spatial dither | ~120 perceived shades | no | works in any mode; distance-dependent |

### Technique 1 — Raster color changes

- Write `$D021`, `$D020`, `$D022`–`$D024`, or color RAM entries during the raster IRQ handler while the beam is drawing.
- Color changes take effect on the current raster line; write early in the line for full-line effect.
- Used by rasterbars (`$D020`), DYCP (color RAM per char row), ECI (`$D021`–`$D024` per frame).
- See [../effects/rasterbars.md](../effects/rasterbars.md), [../effects/dycp.md](../effects/dycp.md).

### Technique 2 — FLI (`$D018` per-line)

- VIC-II reads screen RAM once per character row (every 8 lines) during a bad line.
- FLI forces a bad line every raster line by writing `$D011` YSCROLL = `raster_line mod 8` each line.
- Simultaneously writes `$D018` to point screen RAM to one of 8 different 1 KB blocks → 8000 bytes of per-line color data.
- Effect: colors `01` and `10` (in MCBM) or the two cell colors (in SBM) can be different on every raster line.
- FLI bug: leftmost ~12 px (cols 0–1) always show `$FF` (bright gray) due to VIC prefetch timing.
- See [../display-modes/fli.md](../display-modes/fli.md).

### Technique 3 — Frame interlacing

- Two (or three) complete display frames alternate every PAL field (50 Hz total; 25 fps per sub-frame for 2-frame, 16.7 fps for 3-frame).
- Frame phase detected at raster `$00`; `$D016` XSCROLL toggled 0↔1 to shift pixel phase by 1, selecting a different screen RAM column and thus a different color dataset.
- Human visual persistence merges the alternating frames into a perceived blend.
- 2-frame (IFLI): ~128 perceived color combinations. 3-frame (TRIFLI): ~200–300.
- Flicker is visible, especially on LCD displays; NUFLI was developed to eliminate this for static images.
- See [../display-modes/ifli.md](../display-modes/ifli.md), [../display-modes/trifli.md](../display-modes/trifli.md).

### Technique 4 — Sprite underlay

- Sprites rendered behind the bitmap layer (`$D01B` priority bit = 1) are visible through `00`-pixel areas of the bitmap.
- Hires underlay sprites (UFLI): each sprite contributes 1 independent color from `$D027+n`.
- Multicolor underlay sprites (MUFLI/NUFLI): sprites use 3 colors: `$D025` (shared A), `$D026` (shared B), `$D027+n` (per-sprite); pixels wider than hires.
- NUFLI: 6 double-wide hires sprites with per-line pointer updates (sprite stretching) cover columns 4–39; flicker-free.
- Sprites always draw over the BORDER color regardless of `$D01B`; no open-border trick needed for sprites in border regions (only needed to show display-area content there).
- See [../display-modes/ufli.md](../display-modes/ufli.md), [../display-modes/nufli.md](../display-modes/nufli.md).

### Technique 5 — Spatial dithering

- Alternating pixel patterns (e.g., checkerboard of color A and color B) are perceived as an intermediate color at normal viewing distance.
- Works in any display mode; no raster timing required.
- Effective for smooth gradients in artwork; approximately 120 perceived shades from 16 palette colors.
- Combined with FLI: dithered bitmap pixels with per-line FLI color changes give very dense apparent color ranges.

### Technique 6 — ALM (Alternate Line Method)

- Fill even horizontal raster lines with Color A and odd lines with Color B; both colors MUST be from the same VIC-II luma cluster.
- The eye blends the two hues at normal viewing distance, producing an intermediate perceived color — analogous to spatial dithering but oriented horizontally.
- No raster timing is required; static bitmap data in alternating rows is sufficient.
- Constraint: cross-cluster pairs produce visible horizontal banding on real hardware and PAL-accurate emulators; see [../colors/luma-clusters.md](../colors/luma-clusters.md) for valid pairs.
- The first-revision VIC-II's 5 coarser luma steps allow more valid ALM pairs than the common 9-step revision.

### Technique 7 — DCM (Dynamic Chequerboard Method)

- A single-pixel chequerboard pattern places Color A on even pixels and Color B on odd pixels; the pattern swaps A↔B every frame via a raster IRQ handler.
- Frame-rate temporal blending partially masks luma mismatches, so DCM can mix colors from **different** luma clusters more successfully than ALM — though same-cluster pairs still produce cleaner results.
- Example swap kernel (two adjacent color RAM or bitmap bytes):
  ```asm
  LDY $7DB0      ; load even-pixel color
  LDX $7DB0+1   ; load odd-pixel color
  STY $7DB0+1   ; write even → odd position
  STX $7DB0     ; write odd → even position
  ; repeat for further pairs in the row
  ```
- Effective color range is similar to frame interlacing (~C(16,2) perceived blends) but spatially localised per pixel rather than screen-wide.
- See [../colors/luma-clusters.md](../colors/luma-clusters.md).

### Sprites in border regions

- **Top/bottom border**: set sprite Y position into border raster range (`< $33` or `> $FA`); sprites display naturally since they always render over the border color.
- **Side borders**: set sprite X position < `$18` (left) or > `$157` (right, requires 9-bit X via `$D010` MSB); sprites draw over the side border color without any border trick.
- **Display content in border**: to show bitmap/text content (not sprites) in the border requires the open-border trick; see [../effects/open-borders.md](../effects/open-borders.md).

## constraints
- Raster color changes MUST happen within the active visible portion of the raster line; writes after the right edge affect the next line.
- FLI bad-line forcing leaves only 23 CPU free cycles per line (PAL); per-line code MUST fit within this budget.
- Frame interlacing flicker SHOULD be treated as a design constraint; artwork intended for IFLI must be evaluated on CRT or accurate emulator.
- Sprite underlay `$D01B` affects sprite vs. display-area priority only; sprite vs. border priority is always "sprite in front."
- Spatial dithering effectiveness degrades at close viewing distance; intended for artwork viewed at ~0.5–1 m on CRT.

## links
- luma clusters: [../colors/luma-clusters.md](../colors/luma-clusters.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- official modes: [../graphics/screen-modes.md](../graphics/screen-modes.md)
- unofficial modes: [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md)
- FLI: [../display-modes/fli.md](../display-modes/fli.md)
- IFLI: [../display-modes/ifli.md](../display-modes/ifli.md)
- NUFLI: [../display-modes/nufli.md](../display-modes/nufli.md)
- open borders: [../effects/open-borders.md](../effects/open-borders.md)
- bad lines: [vic-bad-lines.md](vic-bad-lines.md)
- screen geometry: [screen-geometry.md](screen-geometry.md)

## sources
- codebase64.net: [FLI](https://codebase64.net/doku.php?id=base:fli) — CC BY-NC-SA 4.0
- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- c64-wiki.com: [NUFLI](https://www.c64-wiki.com/wiki/NUFLI) — GFDL
- kodiak64.co.uk: [Luma-driven graphics on C64](https://kodiak64.co.uk/blog/luma-driven-graphics-on-c64) — ALM and DCM techniques
- aaronbell.com: [Secret colours of the Commodore 64](https://www.aaronbell.com/secret-colours-of-the-commodore-64/) — equal-brightness constraint for frame-alternation mixing
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
