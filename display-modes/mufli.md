---
type: reference
domain: display-modes
granularity: atomic
summary: "Multicolor Underlayed FLI: multicolor sprites give three pixel colors each under FLI."
keywords: [MUFLI, MUIFLI, multicolor underlay, sprite underlay]
---

## facts
- MUFLI (Multicolor Underlayed FLI) uses multicolor sprites (`$D01C` bit set) as the underlay layer beneath an FLI bitmap, giving each sprite three pixel colors instead of one.
- Multicolor sprite pixel bits: `01` = `$D025` (shared), `10` = `$D026` (shared), `11` = `$D027+n` (per-sprite); `00` = transparent.
- Sprite pixel resolution in multicolor mode is 2× wide (12 px per sprite in normal width, 24 px double-wide).
- MUIFLI = MUFLI + IFLI frame alternation.
- MUCSUFLI variant: see [mucsufli.md](mucsufli.md) — uses full multicolor sprite underlay with explicit emphasis on the two shared colors.

## sequence

1. Complete FLI setup as per [fli.md](fli.md).
2. Set underlay sprites to multicolor mode: `$D01C` = bitmask of sprites used as underlay (e.g., `$FF` for all 8).
3. Set `$D01B` = same bitmask (sprites behind bitmap).
4. Enable sprites: `$D015` = bitmask.
5. Set shared sprite colors: `$D025` = color A, `$D026` = color B (used for all multicolor underlay sprites).
6. Set per-sprite colors: `$D027–$D02E` = one color per sprite (used for `11`-pixel areas).
7. Apply sprite-stretch per line (same as [ufli.md](ufli.md) sequence step 6) — write `$D017` and sprite pointers each raster line.
8. For MUIFLI: apply IFLI frame alternation on top (see [ifli.md](ifli.md)).

## lookup

| register | value | effect |
|---|---|---|
| `$D01C` | `$FF` | all sprites multicolor (3 colors each) |
| `$D01B` | `$FF` | all sprites behind bitmap |
| `$D025` | color 0–15 | shared multicolor sprite color A |
| `$D026` | color 0–15 | shared multicolor sprite color B |
| `$D027–$D02E` | color 0–15 | per-sprite color (pixel `11`) |

### Color layers (MUFLI MCBM)

| layer | source | colors |
|---|---|---|
| Background | `$D021` | 1 |
| FLI bitmap `01`/`10` | screen RAM per line | 2 per 8×1 row |
| FLI bitmap `11` | color RAM | 1 per cell |
| MCM sprite `01` | `$D025` | 1 shared |
| MCM sprite `10` | `$D026` | 1 shared |
| MCM sprite `11` | `$D027+n` | 1 per sprite column |

## constraints
- Multicolor sprite resolution is 2× wider than hires; effective sprite pixel width = 2 screen pixels.
- `$D025` and `$D026` are shared across ALL multicolor sprites; per-sprite differentiation comes only from `$D027+n`.
- Same 23-cycle-per-line CPU budget applies as FLI.

## links

- effects: [fli.md](fli.md)
- effects: [ufli.md](ufli.md)
- effects: [nufli.md](nufli.md)
- effects: [mucsufli.md](mucsufli.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources

- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
