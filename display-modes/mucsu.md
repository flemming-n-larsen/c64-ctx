---
type: reference
domain: effects
granularity: atomic
---

## facts
- MUCSU (Multicolor Sprite Underlay) places multicolor sprites behind any standard display mode (character or bitmap) to add extra color layers without FLI.
- MCI (Multicolor Interlace) alternates two multicolor character mode frames per PAL field to blend perceived colors.
- Both are simpler than FLI variants: MUCSU requires no per-line `$D018` writes; MCI requires frame alternation but not per-line updates.

## sequence — MUCSU

1. Choose base display mode (mode 0 SCM, mode 1 MCCM, or mode 2 SBM).
2. Set `$D01C` = bitmask of sprites to be multicolor underlay.
3. Set `$D01B` = same bitmask (sprites behind display area).
4. Enable: `$D015` = bitmask.
5. Set `$D025`, `$D026` (shared MCM sprite colors), `$D027+n` (per-sprite colors).
6. Position and size sprites to cover the target display region.
7. Optionally stretch sprites per raster line (see [ufli.md](ufli.md) sprite-stretch sequence) for full vertical coverage.

## sequence — MCI (Multicolor Interlace)

1. Enable multicolor character mode: `$D011` bits 6,5 = 0; `$D016` bit 4 = 1 (MCM=1).
2. Prepare two screen RAM datasets (A/B) with different screen codes or color RAM values.
3. Set up frame alternation IRQ at line `$00`; swap screen RAM pointer (`$D018` bits 7-4) or swap color RAM values each frame.
4. Optionally toggle `$D016` XSCROLL bit to shift pixel phase (same as IFLI principle).

## lookup

| register | value | effect |
|---|---|---|
| `$D01B` | sprite bitmask | sprites behind display area |
| `$D01C` | sprite bitmask | sprites in multicolor mode |
| `$D025` | color | MCM sprite shared color A |
| `$D026` | color | MCM sprite shared color B |

## constraints
- MUCSU has no FLI; the base display mode determines per-cell color resolution.
- MCI flicker applies at 25 fps per frame; same XSCROLL toggle technique as IFLI.
- Per-sprite color `$D027+n` is the `11`-pixel color; `$D025`/`$D026` are shared across all MCM sprites.

## links
- effects: [fli.md](fli.md)
- effects: [mufli.md](mufli.md)
- effects: [ifli.md](ifli.md)
- tasks: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources
- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
