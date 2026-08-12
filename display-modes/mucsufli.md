---
type: reference
domain: display-modes
granularity: atomic
summary: "Multicolor sprite underlay beneath an FLI bitmap, with the simpler MUCSUH base."
keywords: [MUCSUFLI, MUCSUH, sprite underlay FLI, shared sprite colors]
---

## facts
- MUCSUFLI (Multicolor Sprite Underlay FLI) is the full combination of multicolor sprites as an underlay layer beneath an FLI bitmap, emphasizing the use of both shared sprite colors (`$D025`, `$D026`) for color richness.
- MUCSUH = same multicolor sprite underlay principle without FLI — applied to a standard hires bitmap (SBM) instead.
- Both use `$D01C` to enable multicolor mode per sprite and `$D01B` to set sprites behind the bitmap.
- MUCSUFLI adds FLI per-line `$D018` cycling on top of MUCSUH.

## sequence — MUCSUH (no FLI, simpler base)

1. Set bitmap mode: `$D011` = `$3B` (BMM=1), `$D016` = `$C8` (MCM=0 — hires bitmap).
2. Set sprites to multicolor underlay: `$D01C` = `$FF`, `$D01B` = `$FF`, `$D015` = `$FF`.
3. Set `$D025`, `$D026` (shared sprite colors), `$D027–$D02E` (per-sprite colors).
4. Position sprites to cover the display area; stretch using `$D017` per raster line.
5. No per-line `$D018` write needed (no FLI component).

## sequence — MUCSUFLI (add FLI)

Steps 1–4 as MUCSUH, then:
5. Add FLI per-line loop: write `$D018` and `$D011` YSCROLL each raster line per [fli.md](fli.md).
6. Screen RAM now changes per line (FLI), giving per-line screen RAM colors in addition to the multicolor sprite underlay.

## lookup

| register | value | effect |
|---|---|---|
| `$D01B` | `$FF` | all sprites behind bitmap |
| `$D01C` | `$FF` | all sprites multicolor |
| `$D015` | `$FF` | all sprites enabled |
| `$D025` | color | shared MCM sprite color A |
| `$D026` | color | shared MCM sprite color B |
| `$D027–$D02E` | color per sprite | per-sprite MCM color |

## constraints
- MUCSUH has lower per-line CPU overhead than MUCSUFLI (no FLI loop required).
- All constraints from [mufli.md](mufli.md) and [fli.md](fli.md) apply to their respective components.

## links
- effects: [fli.md](fli.md)
- effects: [mufli.md](mufli.md)
- effects: [nufli.md](nufli.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources
- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
