---
type: reference
domain: display-modes
granularity: atomic
---

## facts
- SHFLI (Super HiRes FLI) and its variants (SHI, SHIFLI, SHIFXL) achieve sub-pixel or multi-frame pixel tricks on top of the FLI base technique to exceed the apparent 320×200 resolution or color density.
- SHI (Super HiRes Interlace): alternates two hires SBM frames offset by 1 pixel horizontally; the eye perceives an effective horizontal resolution of ~640 pixels (2× interleaved).
- SHFLI: SHI with FLI per-line color cycling added.
- SHIFLI: SHFLI + full IFLI-style frame alternation — the most complex variant.
- SHIFXL (eXtra Large): SHIFLI extended to a wider display area using the open-border trick (`effects/open-borders.md`).
- All variants require cycle-exact stable raster IRQs and extremely tight per-line code.

## sequence — SHI (base of all super-hires variants)

1. Prepare two hires SBM bitmaps (A and B): bitmap A has pixels at even X, bitmap B has pixels shifted 1 px right.
2. Set up frame alternation (same as IFLI): toggle `$D016` XSCROLL between 0 and 1 each PAL frame.
3. Frame A: display bitmap A (XSCROLL=0); frame B: display bitmap B (XSCROLL=1).
4. The eye perceives both frames blended → apparent 640-pixel horizontal resolution (at the cost of 25 fps per half-image and flicker).

## sequence — SHFLI (add FLI per-line color)

5. Add FLI per-line loop on top of SHI: write `$D018` and `$D011` each raster line per [fli.md](fli.md).
6. Each frame has its own set of FLI screen RAM blocks.

## sequence — SHIFXL (extend to border)

7. Apply open-border trick per [open-borders.md](../effects/open-borders.md) to extend the display area.
8. Add sprite or extended-display content in the opened border region.

## lookup

| variant | modes active | frame alternation | FLI | open border |
|---|---|:---:|:---:|:---:|
| SHI | SBM hires | yes | no | no |
| SHFLI | SBM hires | no | yes | no |
| SHIFLI | SBM hires | yes | yes | no |
| SHIFXL | SBM hires | yes | yes | yes |

| register | frame A | frame B | effect |
|---|---|---|---|
| `$D016` XSCROLL | `0` | `1` | shifts display 1 px horizontally |
| `$D018` | frame A bitmap/screen | frame B bitmap/screen | selects dataset |

## constraints
- Sub-pixel interlacing produces flicker; acceptable on PAL CRT; problematic on LCD or NTSC.
- SHIFXL open-border extension requires `$D016`/`$D011` trick timing in addition to SHIFLI's per-line writes — extremely few free CPU cycles remain.
- Artwork must be prepared as two interlaced-pixel frames; standard graphics tools do not produce this format natively.
- All SH/SHIFLI/SHIFXL modes are best-effort documented; implementation details vary by release and are not uniformly covered in public sources.

## links
- effects: [fli.md](fli.md)
- effects: [ifli.md](ifli.md)
- effects: [sh.md](sh.md)
- effects: [open-borders.md](../effects/open-borders.md)
- effects: [stable-raster.md](../effects/stable-raster.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- graphics: [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md)

## sources
- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
