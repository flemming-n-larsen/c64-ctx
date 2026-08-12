---
type: reference
domain: display-modes
granularity: atomic
summary: "Permanent Raster Split: a stable per-frame split showing two independent display regions."
keywords: [PRS, raster split, screen split, status bar, split screen]
---

## facts
- PRS (Permanent Raster Split) maintains a stable screen split every frame by writing different `$D011`, `$D016`, or `$D018` values at a fixed raster line, effectively showing two independently configured display regions on the same screen.
- Any VIC-II register can be split: mode (text/bitmap), scroll position, screen RAM base, column count, color registers.
- Requires a stable raster IRQ at the split line every frame; see [stable-raster.md](../effects/stable-raster.md).
- Common uses: status bar in a different mode below a game area, combining text and bitmap regions, two-display-area demo effects.
- Introduced February 2011 as a formalized technique, though the underlying split has been used informally since the early C64 era.

## sequence

1. Configure the top display region (the default startup state): set `$D011`, `$D016`, `$D018`, color registers as desired for the top area.
2. Set up a stable raster IRQ at the first line of the bottom region (the split line).
3. In the IRQ handler:
   - Write new values to any registers that should differ in the bottom region: `$D011` (mode/scroll), `$D016` (column/scroll), `$D018` (screen RAM / char base), `$D020`/`$D021` (colors).
   - Acknowledge `$D019` = `$01`.
4. Set a second IRQ at the first line of the top region for the next frame (or line `$00`).
5. In the restore IRQ handler: write back the top-region register values.

## lookup

### Registers commonly split

| register | typical split use |
|---|---|
| `$D011` | switch mode (bitmap top, text bottom); change YSCROLL or RSEL |
| `$D016` | change column count or XSCROLL at split |
| `$D018` | different screen RAM / char base in each region |
| `$D020` | different border color per region |
| `$D021` | different background color per region |

### Example: bitmap top + text status bar bottom

| region | raster lines | `$D011` | `$D016` | `$D018` |
|---|---|---|---|---|
| Bitmap area | `$33`–`$D8` | `$3B` (BMM=1) | `$C8` | `$78` (screen `$1C00`, bitmap `$2000`) |
| Status bar | `$D9`–`$FA` | `$1B` (BMM=0) | `$C8` | `$15` (screen `$0400`, char ROM) |

## constraints
- The split write MUST happen before VIC starts rendering the first line of the new region; writes during HBLANK at the split line are safe.
- Stable raster IRQ is required to prevent ±1-line jitter at the split boundary; see [stable-raster.md](../effects/stable-raster.md).
- `$D018` changes take effect at the next bad line; a mid-row split may show a partial transition in the first character row below the split.
- Changing mode mid-frame (e.g., bitmap to text) is valid; changing to an illegal mode (ECM+BMM) blanks that region.

## links
- effects: [stable-raster.md](../effects/stable-raster.md)
- effects: [rasterbars.md](../effects/rasterbars.md)
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- graphics: [../graphics/screen-modes.md](../graphics/screen-modes.md)

## sources
- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
