---
type: reference
domain: display-modes
granularity: atomic
summary: "Underlayed FLI: hires sprites behind the FLI bitmap add independent colors."
keywords: [UFLI, UIFLI, underlayed FLI, sprite underlay, sprite stretch]
---

## facts
- UFLI (Underlayed FLI) adds a layer of hires sprites positioned behind the FLI bitmap to contribute additional independent colors per display area.
- Sprites rendered behind the bitmap (`$D01B` priority bit set) are visible wherever the bitmap shows color `00` (the `$D021` background color pair).
- Each sprite contributes its own color from `$D027+n`; with 8 sprites across the screen, up to 8 additional color values are available in the underlay layer.
- UIFLI = UFLI + IFLI frame alternation; alternates two UFLI frames for blended underlay colors.

## sequence

1. Complete FLI setup as per [fli.md](fli.md).
2. Position sprites horizontally to cover the full 320 px display width:
   - 8 hires sprites, each 24 px wide at 1× scale; or fewer double-wide (`$D01D`) sprites covering more columns.
   - Set sprite X positions (`$D000`, `$D002`, … `$D00E`) to cover columns 24–343 (left to right); use `$D010` for MSB of any X > 255.
   - Set sprite Y positions (`$D001`, …) to 0 — sprites span the full vertical range using Y-stretch (step 3).
3. Enable all sprites: `$D015` = `$FF`.
4. Set all sprites behind bitmap: `$D01B` = `$FF` (priority = behind background).
5. Disable multicolor on underlay sprites: `$D01C` = `$00` (hires sprites for UFLI; use `$FF` for MUFLI variant).
6. **Per-line sprite stretch** (inside FLI per-line loop): write `$D017` (sprite Y expand) to control which sprite data row is shown on this raster line; write sprite pointers (`$07F8–$07FF` or equivalent for active VIC bank) to advance the sprite data pointer per line.
7. Set sprite colors: `$D027–$D02E` = one color per sprite (these are the underlay colors visible in `00`-pixel areas).
8. For UIFLI: additionally apply IFLI frame alternation (see [ifli.md](ifli.md)) with two complete UFLI datasets.

## lookup

### Sprite layer registers

| register | value | effect |
|---|---|---|
| `$D015` | `$FF` | enable all 8 sprites |
| `$D01B` | `$FF` | all sprites behind display area (underlay) |
| `$D01C` | `$00` | hires sprites (UFLI); set `$FF` for multicolor underlay (MUFLI) |
| `$D01D` | `$FF` | double-width sprites (optional; 48 px wide each) |
| `$D017` | varies per line | Y expand: controls which sprite data row is shown on this raster line |
| `$D027–$D02E` | color 0–15 | per-sprite underlay color |

### Horizontal sprite coverage (8 hires sprites, 1× width)

| sprite | X position | columns covered |
|:---:|:---:|---|
| 0 | 24 | px 24–47 |
| 1 | 48 | px 48–71 |
| … | … | … |
| 7 | 192 | px 192–215 |

Full 320 px coverage needs 14 sprites (not possible with 8); typical UFLI covers a central band and uses the FLI bitmap in remaining columns.

### Color layers (UFLI MCBM)

| pixel bits | source | notes |
|---|---|---|
| `00` | sprite underlay color (`$D027+n`) where sprite is present; else `$D021` | sprite must be at that X/Y position |
| `01` | screen RAM high nibble (per FLI line) | FLI-driven |
| `10` | screen RAM low nibble (per FLI line) | FLI-driven |
| `11` | color RAM `$D800+cell` | static |

## constraints
- Only 8 hardware sprites; they cannot cover the full 320 px without tricks; the FLI bug columns (leftmost ~12 px) typically have no sprite coverage.
- Sprite data MUST be 64-byte aligned in the VIC bank; pointer = sprite_base / 64 written to `$07F8+n`.
- Per-line `$D017` and pointer writes consume additional CPU cycles on top of the FLI budget; PAL has only 23 nominal bus-free cycles per bad line, with possible BA lead-in stall — extremely tight.
- Sprites with `$D01B` bit set are behind display foreground pixels; an active screen border still has priority, so border extension requires [open-borders.md](../effects/open-borders.md).
- UIFLI requires two full UFLI datasets: 2 × (8000 screen + 8000 sprite) bytes; plan VIC bank layout carefully.

## links

- effects: [fli.md](fli.md)
- effects: [ifli.md](ifli.md)
- effects: [nufli.md](nufli.md)
- effects: [mufli.md](mufli.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- tasks: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources

- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
