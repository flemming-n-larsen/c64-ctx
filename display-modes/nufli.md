---
type: reference
domain: display-modes
granularity: atomic
summary: "New Underlayed FLI: six double-wide hires sprites give flicker-free color mixing."
keywords: [NUFLI, NUIFLI, flicker free, double-wide sprites]
---

## facts
- NUFLI (New Underlayed FLI) achieves flicker-free color mixing by using 6 double-wide hires sprites beneath the FLI bitmap, eliminating the need for IFLI frame alternation.
- 6 double-wide (`$D01D`) sprites each cover 48 px wide; positioned at columns 4–39 they cover the full non-bug display area (cols 4–39 = 288 px, leaving the FLI bug columns 0–3 uncovered).
- Sprite-stretching: `$D017` Y-expand and sprite pointer registers are updated every other raster line, making each sprite data row display for exactly 1 raster line of pixel height.
- Color model: 2 shared multicolor sprite colors (`$D025`, `$D026`) + 1 per-sprite hires color (`$D027+n`) + 2 FLI bitmap colors (01/10) = effectively 3 independent colors per 8×2 px area, flicker-free.
- NUFLI renders at full 320×200 with 3 colors per 8×2 area; IFLI flickered to achieve ~128 perceived colors; NUFLI trades some color count for a stable image.
- NUIFLI = NUFLI + IFLI frame alternation for even more perceived colors, at the cost of flicker.

## sequence

1. Complete FLI setup as per [fli.md](fli.md).
2. Allocate 6 sprite data blocks (each 64 bytes × number of virtual rows needed); each block must be 64-byte aligned in the VIC bank.
3. Set 6 double-wide hires sprites behind bitmap:
   - `$D01D` = `$3F` (sprites 0–5 double-wide; sprites 6–7 unused)
   - `$D01B` = `$3F` (sprites 0–5 behind background)
   - `$D01C` = `$00` (hires sprites; no multicolor sprite mode for the underlay)
   - `$D015` = `$3F` (enable sprites 0–5)
4. Set sprite X positions to cover columns 4–39 (pixel positions ~56–344):
   - Sprite 0 X = 56, sprite 1 X = 104, … sprite 5 X = 296 (each spans 48 px double-wide).
   - Write MSBs to `$D010` for any X > 255.
5. Set sprite Y positions = any value; Y position is overridden by per-line stretch below.
6. Set shared sprite multicolors: `$D025` = color A, `$D026` = color B (these are the two shared underlay colors across all 6 sprites).
7. Set per-sprite colors: `$D027`–`$D02C` = one color per sprite (the "11-pixel" hires color for each sprite column).
8. **Per-line stretch loop** (inside FLI per-line loop, every 2 lines):
   - Write `$D017` = `$00` (turn off Y expand for active stretch) then `$3F` (turn on) to advance sprite display one row.
   - Update 6 sprite pointers (`sprite_ptr_base + 0..5`) to the next row of sprite data.
   - This creates a new 2-line "slice" of sprite data each pair of raster lines.
9. Prepare NUFLI artwork with a converter that encodes FLI bitmap (2 colors/cell/line) + sprite layer (2 shared + per-sprite color) as the underlay.

## lookup

### NUFLI sprite configuration

| register | value | effect |
|---|---|---|
| `$D015` | `$3F` | enable sprites 0–5 |
| `$D017` | `$00` / `$3F` alternating | Y-expand off/on per pair of raster lines (sprite stretch) |
| `$D01B` | `$3F` | sprites 0–5 behind bitmap |
| `$D01C` | `$00` | hires sprite mode (not multicolor) |
| `$D01D` | `$3F` | sprites 0–5 double-wide |
| `$D025` | color 0–15 | shared underlay color A (pixel `01` in multicolor sprite) |
| `$D026` | color 0–15 | shared underlay color B (pixel `10` in multicolor sprite) |
| `$D027–$D02C` | color 0–15 | per-sprite underlay hires color |

### Horizontal coverage

| sprite | X position | px range | cols covered |
|:---:|:---:|---|---|
| 0 | 56 | 56–103 | ~cols 4–8 |
| 1 | 104 | 104–151 | ~cols 9–14 |
| 2 | 152 | 152–199 | ~cols 15–20 |
| 3 | 200 | 200–247 | ~cols 21–26 |
| 4 | 248 | 248–295 | ~cols 27–32 |
| 5 | 296 | 296–343 | ~cols 33–39 |

### Color layers (NUFLI MCBM)

| pixel area | colors available |
|---|---|
| FLI bitmap | 2 per 8×1 px row (screen RAM high/low nibble) |
| Sprite underlay | 2 shared (`$D025`/`$D026`) + 1 per-sprite column (`$D027+n`) |
| Background | `$D021` (color `00`) |

## constraints
- Sprite-stretching writes (`$D017` + pointer) must occur within each 2-line window; CPU budget is still ~46 free cycles per 2-line pair (2 × 23).
- The FLI bug columns (0–3, leftmost ~24 px) have no sprite coverage; this region is typically handled as a decorative border strip or left as the FLI bug artifact.
- `$D01C` MUST be `$00` for NUFLI; setting multicolor on the underlay sprites changes the color model significantly (see [mufli.md](mufli.md)).
- Sprite data requires 200 ÷ 2 = 100 "rows" of 6 × 3 bytes each per 8-px-wide sprite block — approximately 1800 bytes of sprite data total.
- NUIFLI adds IFLI frame alternation on top; requires two complete NUFLI datasets and doubles the artwork complexity.

## sources

- c64-wiki.com: [NUFLI](https://www.c64-wiki.com/wiki/NUFLI) — GFDL
- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- effects: [fli.md](fli.md)
- effects: [ifli.md](ifli.md)
- effects: [ufli.md](ufli.md)
- effects: [mufli.md](mufli.md)
- effects: [mucsufli.md](mucsufli.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- tasks: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- graphics: [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md)
