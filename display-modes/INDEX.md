---
type: index
domain: display-modes
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| FLI — per-line `$D018` color trick | [fli.md](fli.md) | Bad-line force every line; 8 screen RAM blocks; FLI bug |
| IFLI — interlaced FLI | [ifli.md](ifli.md) | 2-frame XSCROLL toggle; ~128 perceived colors; flicker |
| UFLI / UIFLI — sprite underlay FLI | [ufli.md](ufli.md) | Hires sprites behind bitmap; sprite stretch per line |
| NUFLI / NUIFLI — new underlayed FLI | [nufli.md](nufli.md) | 6 double-wide sprites; flicker-free; 3 colors/8×2 px |
| MUFLI / MUIFLI — multicolor sprite underlay FLI | [mufli.md](mufli.md) | MCM sprites (`$D01C`) as underlay beneath FLI bitmap |
| MUCSUFLI / MUCSUH — multicolor sprite underlay | [mucsufli.md](mucsufli.md) | MCM sprites under hires bitmap; MUCSUFLI adds FLI layer |
| ECI — extended colors with interlace | [eci.md](eci.md) | ECM mode + frame alternation; 4 BG registers × 2 frames |
| MUCSU / MCI — multicolor sprite underlay / interlace | [mucsu.md](mucsu.md) | MCM sprite underlay (no FLI); MCI = MCM frame alternation |
| HCB — half char bitmap | [hcb.md](hcb.md) | Custom charset with independent top/bottom 4-row halves |
| PRS — permanent raster split | [prs.md](prs.md) | Stable per-frame register split for dual-region display |
| XFLI / XIFLI — extended FLI | [xfli.md](xfli.md) | FLI + per-line `$D021` writes; XIFLI adds frame alternation |
| SHFLI / SHI / SHIFLI / SHIFXL — super hires FLI | [shfli.md](shfli.md) | Sub-pixel interlacing + FLI; SHIFXL opens borders |
| SH / AH / IH — super/advanced/interlaced hires | [sh.md](sh.md) | Pixel dithering (SH/AH) or 1-px frame offset (IH) |
| AFLI / IAFLI / AIFLI — advanced FLI | [afli.md](afli.md) | Advanced color cell assignment on FLI base |
| MRFLI — multi-resolution FLI | [mrfli.md](mrfli.md) | Per-line MCM toggle for mixed hires/multicolor regions |
| TRIFLI — tri-interlaced FLI | [trifli.md](trifli.md) | 3-frame rotation; ~200–300 perceived colors |
| ASSLACE — alternating sprite sieve interlace | [asslace.md](asslace.md) | Sprite grid sieve toggled between frames |
| Megatext — oversized bitmap text | [megatext.md](megatext.md) | Large glyphs rendered into bitmap; no special VIC trick |
| Software screen modes (16×16 char matrix) | [software-screen-modes.md](software-screen-modes.md) | Custom pixel grid via charset design; no VIC register trick; includes scroll variant |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [fli.md](fli.md) | used | FLI per-line `$D018` technique |
| [ifli.md](ifli.md) | used | Interlaced FLI |
| [ufli.md](ufli.md) | used | Sprite underlay FLI |
| [nufli.md](nufli.md) | used | New underlayed FLI (flicker-free) |
| [mufli.md](mufli.md) | used | Multicolor sprite underlay FLI |
| [mucsufli.md](mucsufli.md) | used | Multicolor sprite underlay + FLI variants |
| [eci.md](eci.md) | used | Extended colors with interlace |
| [mucsu.md](mucsu.md) | used | Multicolor sprite underlay / MCI |
| [hcb.md](hcb.md) | used | Half char bitmap |
| [prs.md](prs.md) | used | Permanent raster split |
| [xfli.md](xfli.md) | used | Extended FLI |
| [shfli.md](shfli.md) | used | Super hires FLI family |
| [sh.md](sh.md) | used | Super/advanced/interlaced hires |
| [afli.md](afli.md) | used | Advanced FLI |
| [mrfli.md](mrfli.md) | used | Multi-resolution FLI |
| [trifli.md](trifli.md) | used | Tri-interlaced FLI |
| [asslace.md](asslace.md) | used | Alternating sprite sieve interlace |
| [megatext.md](megatext.md) | used | Oversized bitmap text |
| [software-screen-modes.md](software-screen-modes.md) | used | 16×16 char matrix software screen mode |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Upstream fallback route |

## related
| domain | read | why |
|---|---|---|
| Graphics | [../graphics/INDEX.md](../graphics/INDEX.md) | Hardware mode register reference (8 official modes) + unofficial modes index |
| Graphics | [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md) | Full name/abbreviation table with links back to these spec pages |
| Concepts | [../concepts/color-mixing.md](../concepts/color-mixing.md) | The 5 underlying color-expansion techniques |
| Effects | [../effects/INDEX.md](../effects/INDEX.md) | Runtime demo/game visual effects (rasterbars, fire, plasma, etc.) |
| Tasks | [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md) | IRQ setup required by most display modes |
| Effects | [../effects/stable-raster.md](../effects/stable-raster.md) | Prerequisite for cycle-exact display mode work |
| Effects | [../effects/open-borders.md](../effects/open-borders.md) | Border opening trick used by SHIFXL and similar |
