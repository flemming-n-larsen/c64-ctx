---
type: reference
domain: effects
granularity: atomic
---

## facts
- HCB (Half Char Bitmap) splits each 8×8 character cell into two independent 8×4 regions by designing a custom charset where the top and bottom halves encode distinct graphic elements.
- No per-line raster tricks required; the illusion of finer vertical color resolution comes from thoughtful charset design.
- Each half-cell (8×4) uses the same color pair as the full cell (screen RAM + color RAM for SCM, or the multicolor set for MCCM), so the trick is purely visual — not a hardware color change.
- True per-cell color independence within a half-cell requires a separate screen code per half, which means the charset must be designed so each unique combination of top/bottom graphics uses its own character index.
- Introduced October 2008 as a resolution/color trick that works within the standard character modes.

## sequence

1. Design a custom charset where character shapes use only the top 4 rows (bits 0–3 of rows 4–7 = 0) for "top half" characters, and only the bottom 4 rows (bits 0–3 of rows 0–3 = 0) for "bottom half" characters.
2. Assign unique character indices to each useful top/bottom graphic combination.
3. Copy charset to RAM; disable CHAREN (`$0001` bit 2 = 0) and point `$D018` char base to the new charset.
4. Fill screen RAM and color RAM as normal.
5. No raster IRQ or per-line writes needed — standard SCM or MCCM display.

## lookup

| cell rows | used for | color |
|---|---|---|
| rows 0–3 | top half graphic | screen RAM + color RAM (same as full cell) |
| rows 4–7 | bottom half graphic | screen RAM + color RAM (same as full cell) |

## constraints
- Color resolution is NOT independently changed per half-cell by hardware; the same screen/color RAM byte drives both halves.
- Effective vertical resolution improvement is visual only — useful for text and simple graphics, not photo-quality images.
- Custom charset limits usable characters; a 256-entry charset can encode ~128 unique top/bottom combinations.
- For true per-line color independence, FLI ([fli.md](fli.md)) is required.

## links
- effects: [fli.md](fli.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- tasks: [../tasks/custom-charset.md](../tasks/custom-charset.md)
- graphics: [../graphics/screen-modes.md](../graphics/screen-modes.md)

## sources
- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
