---
type: reference
domain: display-modes
granularity: atomic
summary: "Advanced FLI: smarter color cell assignment to reduce errors at FLI block boundaries."
keywords: [AFLI, advanced FLI, IAFLI, AIFLI, color cell assignment]
---

## facts
- AFLI (Advanced FLI) improves upon basic FLI by using a more sophisticated color cell assignment algorithm that minimizes visible color errors across the FLI block boundaries.
- Standard FLI applies one `$D018` block per raster line; AFLI optimizes which color data goes into each of the 8 screen RAM blocks to reduce visible banding.
- IAFLI = AFLI + IFLI frame alternation (interlaced AFLI).
- AIFLI = Advanced Interlaced FLI; closely related to IAFLI; both combine advanced color assignment with frame alternation.
- Implementation mechanism is identical to FLI at the register level; the difference is in the artwork encoding / conversion algorithm.

## sequence

1. Identical to [fli.md](fli.md) register sequence: per-line `$D018` cycling, bad-line forcing via `$D011` YSCROLL.
2. AFLI distinction: the 8 screen RAM blocks are filled using an advanced algorithm that spreads color error across the 8-row FLI cycle rather than assigning colors independently per row; requires a specialized AFLI converter tool.
3. For IAFLI/AIFLI: add IFLI frame alternation on top per [ifli.md](ifli.md).

## lookup

Register sequence is identical to [fli.md](fli.md) `$D018` table and [ifli.md](ifli.md) frame alternation.

| variant | base | frame alt | advanced color |
|---|---|:---:|:---:|
| AFLI | FLI | no | yes |
| IAFLI | FLI | yes | yes |
| AIFLI | FLI | yes | yes |

## constraints
- All FLI register constraints apply; see [fli.md](fli.md).
- Artwork requires AFLI-aware conversion software; standard FLI converters produce standard (non-AFLI) block assignment.
- IAFLI and AIFLI are functionally equivalent at the register level; differences may be in specific converter implementations.

## sources

- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- effects: [fli.md](fli.md)
- effects: [ifli.md](ifli.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- graphics: [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md)
