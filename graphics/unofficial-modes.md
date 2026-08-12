---
type: reference
domain: graphics
granularity: atomic
summary: "Names and abbreviations for 31 software display techniques that exploit VIC-II timing."
keywords: [unofficial modes, FLI family, technique names, mode abbreviations]
---

## facts
- Unofficial modes are software techniques that exploit VIC-II timing behavior, not hardware register states.
- All techniques require raster IRQ precision; most require cycle-exact timing.
- "FLI" in a name means the `$D018` per-line trick is used (color RAM re-read every raster line instead of every 8).
- "I" / "Interlaced" in a name means two frames alternate per PAL field (25 fps each) to blend perceived colors.
- "U" / "Underlay" in a name means sprites are placed behind the bitmap layer to add independent color planes.
- "MU" / "Multicolor Underlay" means multicolor-mode sprites (3 colors each) are used as the underlay.
- "MUCS" means multicolor sprite underlay specifically (shares `$D025`/`$D026` shared colors).
- Techniques may be combined: MUIFLI = Multicolor Underlay + Interlaced + FLI.

## lookup

### High-resolution techniques

| abbreviation | full name | first seen | core techniques | spec | notes |
|---|---|---|---|---|---|
| `AFLI` | Advanced Flexible Line Interpretation | Apr 1990 | FLI + advanced color layout | [afli.md](../display-modes/afli.md) | per-line color RAM via `$D018`; improved cell color assignment |
| `AH` | Advanced HiRes | Dec 1996 | hires bitmap tricks | [sh.md](../display-modes/sh.md) | pixel-level color tricks beyond standard SBM |
| `AIFLI` | Advanced Interlaced Flexible Line Interpretation | — | FLI + interlace | [afli.md](../display-modes/afli.md) | AFLI with frame alternation |
| `ASSLACE` | Alternating Sprite Sieve (Inter)lace | Apr 2004 | sprites + interlace | [asslace.md](../display-modes/asslace.md) | sprite grid interleaved with interlaced frame data |
| `ECI` | Extended Colors with Interlace | Jun 1988 | ECM + interlace | [eci.md](../display-modes/eci.md) | uses `$D011` ECM bit and frame alternation for expanded BG colors |
| `IAFLI` | Interlaced Advanced Flexible Line Interpretation | Apr 1990 | FLI + interlace | [afli.md](../display-modes/afli.md) | interlaced variant of AFLI |
| `IH` | Interlaced HiRes | — | hires + interlace | [sh.md](../display-modes/sh.md) | alternating hires frames; flicker-based color blend |
| `MRFLI` | Multi Resolution Flexible Line Interpretation | Feb 2010 | FLI + multiple resolutions | [mrfli.md](../display-modes/mrfli.md) | mixes hires and multicolor regions via per-line mode switching |
| `MUCSUFLI` | Multicolor Sprite Underlay Flexible Line Interpretation | May 2011 | FLI + multicolor sprite underlay | [mucsufli.md](../display-modes/mucsufli.md) | multicolor sprites (`$D025`/`$D026`) beneath FLI bitmap |
| `MUCSUH` | Multicolor Sprite Underlay HiRes | Feb 2009 | hires + multicolor sprite underlay | [mucsufli.md](../display-modes/mucsufli.md) | no FLI; multicolor sprites under standard hires bitmap |
| `MUFLI` | Multicolor Underlayed Flexible Line Interpretation | Jul 2006 | FLI + multicolor sprite underlay | [mufli.md](../display-modes/mufli.md) | MCM sprites behind FLI bitmap; more unique colors per cell area |
| `MUIFLI` | Multicolor Underlayed Interlaced Flexible Line Interpretation | Jul 2009 | FLI + multicolor underlay + interlace | [mufli.md](../display-modes/mufli.md) | MUFLI with frame alternation |
| `NUFLI` | New Underlayed Flexible Line Interpretation | Jul 2009 | FLI + sprite underlay (improved) | [nufli.md](../display-modes/nufli.md) | 6 double-wide hires sprites beneath FLI; sprite-stretching per raster line; flicker-free; 3 colors per 8×2 px |
| `NUIFLI` | New Underlayed Interlaced Flexible Line Interpretation | Jul 2009 | FLI + sprite underlay + interlace | [nufli.md](../display-modes/nufli.md) | NUFLI with frame alternation for even more perceived colors |
| `SH` | Super HiRes | Jan 1991 | hires + pixel tricks | [sh.md](../display-modes/sh.md) | sub-pixel or multi-layer trick to exceed standard 320 px effective resolution |
| `SHFLI` | Super HiRes Flexible Line Interpretation | Apr 1996 | FLI + super hires | [shfli.md](../display-modes/shfli.md) | combines SH pixel tricks with per-line color changes |
| `SHI` | Super HiRes Interlace | — | hires + interlace | [shfli.md](../display-modes/shfli.md) | SH with frame alternation |
| `SHIFLI` | Super HiRes Interlaced Flexible Line Interpretation | Apr 1996 | FLI + super hires + interlace | [shfli.md](../display-modes/shfli.md) | SHFLI with frame alternation |
| `SHIFXL` | Super HiRes Interlaced Flexible Line Interpretation eXtra Large | Apr 1997 | SHIFLI extended | [shfli.md](../display-modes/shfli.md) | extends SHIFLI to wider display area (open borders) |
| `TRIFLI` | Tri Interlaced Flexible Line Interpretation | Jan 2010 | FLI + triple interlace | [trifli.md](../display-modes/trifli.md) | three alternating frames instead of two; higher perceived color count at cost of more flicker |
| `UFLI` | Underlayed Flexible Line Interpretation | Apr 1996 | FLI + sprite underlay | [ufli.md](../display-modes/ufli.md) | hires sprites beneath FLI bitmap; adds 2–3 independent colors per area |
| `UIFLI` | Underlayed Interlaced Flexible Line Interpretation | Dec 1997 | FLI + sprite underlay + interlace | [ufli.md](../display-modes/ufli.md) | UFLI with frame alternation |
| `XFLI` | eXtended Flexible Line Interpretation | Aug 2002 | FLI + extended color tricks | [xfli.md](../display-modes/xfli.md) | per-line `$D021` writes to extend per-line background color |
| `XIFLI` | eXtended Interlaced Flexible Line Interpretation | Aug 2002 | FLI + extended color + interlace | [xfli.md](../display-modes/xfli.md) | XFLI with frame alternation |

### Medium-resolution techniques

| abbreviation | full name | first seen | core techniques | spec | notes |
|---|---|---|---|---|---|
| `FLI` | Flexible Line Interpretation | Jul 1989 | per-line `$D018` | [fli.md](../display-modes/fli.md) | writes `$D018` each raster line to force color RAM re-read; implies multicolor mode; 160×200; FLI bug: leftmost 12 px show bright gray (`$FF` color) |
| `HCB` | Half Char Bitmap | Oct 2008 | character cell halving | [hcb.md](../display-modes/hcb.md) | splits 8×8 char cells into 8×4 blocks for finer vertical color resolution |
| `IFLI` | Interlaced Flexible Line Interpretation | 1991 | FLI + interlace | [ifli.md](../display-modes/ifli.md) | two FLI frames alternate per PAL field; `$D016` XSCROLL toggles 0/1 each frame to shift pixel phase; ~128 perceived blended colors; flickery |
| `MCI` | Multicolor Interlace | — | MCM + interlace | [mucsu.md](../display-modes/mucsu.md) | alternating multicolor frames for blended color illusion |
| `MUCSU` | Multicolor Sprite Underlay | — | multicolor sprite underlay | [mucsu.md](../display-modes/mucsu.md) | multicolor sprites beneath non-FLI display; adds up to 3 sprite colors |

### Low-resolution techniques

| abbreviation | full name | first seen | core techniques | spec | notes |
|---|---|---|---|---|---|
| (none) | Megatext | Jul 2004 | bitmap font rendering | [megatext.md](../display-modes/megatext.md) | oversized text rendered into bitmap; no special VIC trick |
| `PRS` | Permanent Raster Split | Feb 2011 | stable raster split | [prs.md](../display-modes/prs.md) | maintains a stable `$D011`/`$D016` split every frame, effectively combining two independent display configurations on one screen |

## constraints
- All FLI variants MUST write `$D018` (and trigger a bad line) every raster line within the display window; missing a line produces a visible color error.
- Interlaced modes MUST synchronize frame alternation to the PAL 50 Hz field rate; use `$D011` RST8/`$D012` raster compare for frame-phase detection.
- Sprite underlay modes MUST set `$D01B` priority bits for underlay sprites so they render behind the bitmap plane.
- NUFLI sprite-stretching MUST update `$D017` (Y expand) and sprite pointers each raster line; see `concepts/color-mixing.md` for the sprite-stretch mechanism.
- Sprite X positions beyond 255 MUST set the corresponding bit in `$D010`; see `tasks/sprite-display.md`.
- FLI bug region (leftmost ~3 character columns) SHOULD be treated as a design constraint, not an error to suppress.

## links
- VIC hub: [../vic/INDEX.md](../vic/INDEX.md)
- VIC screen modes: [../vic/screen-modes.md](../vic/screen-modes.md)
- display-modes index: [../display-modes/INDEX.md](../display-modes/INDEX.md)
- color-mixing concept: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- official screen modes: [screen-modes.md](screen-modes.md)
- open borders: [../effects/open-borders.md](../effects/open-borders.md)
- sprite display: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- raster IRQ: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- stable raster: [../effects/stable-raster.md](../effects/stable-raster.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- VIC bad lines: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)

## sources
- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- c64-wiki.com: [NUFLI](https://www.c64-wiki.com/wiki/NUFLI) — GFDL
- codebase64.net: [FLI](https://codebase64.net/doku.php?id=base:fli) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
