---
type: index
domain: effects
source: codebase64
---

## routes
| need | read | notes |
|---|---|---|
| Open top/bottom or side borders | [open-borders.md](open-borders.md) | Double-IRQ `$D011` / `$D016` trick; sprites-in-border notes included |
| Stable raster synchronization | [stable-raster.md](stable-raster.md) | Double-IRQ cycle compensation; prerequisite for precise effects |
| IRQ-driven SID music player | [irq-music-player.md](irq-music-player.md) | Raster IRQ wrapper for SID playback routines |
| Rasterbars (color bars in border/display) | [rasterbars.md](rasterbars.md) | `$D020`/`$D021` writes in raster IRQ |
| Scrolling text | [scrolltext.md](scrolltext.md) | `$D016` fine-scroll + char shift; sprite scroller variant |
| Flexible Line Distance (vertical smooth scroll) | [fld.md](fld.md) | Bad-line suppression via `$D011` YSCROLL trick |
| Dynamic Color Per Character (DYCP) | [dycp.md](dycp.md) | Per-char-row color via raster split + color RAM writes |
| Dynamic Y-position sprites (DYSP) | [dysp.md](dysp.md) | Per-sprite IRQ Y update; sprite stretching |
| Sprite multiplexer (>8 sprites) | [sprite-multiplexer.md](sprite-multiplexer.md) | Sort by Y; IRQ-driven hardware sprite recycling |
| Fire effect | [fire.md](fire.md) | 4×4 charset cells; neighbor-average algorithm; color gradient |
| Starfield | [starfield.md](starfield.md) | ROL-based or sprite-based; speed tiers |
| Plasma | [plasma.md](plasma.md) | Sine-sum color cycling; FLI plasma variant |
| Pseudo-random number generator | [rng.md](rng.md) | X-ABC PRNG; 38 cycles; 8/16-bit output |

For FLI, IFLI, NUFLI, UFLI, ECI and all other display mode technique specs → see [../display-modes/INDEX.md](../display-modes/INDEX.md).

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [open-borders.md](open-borders.md) | used | Double-IRQ border removal + sprites in border |
| [stable-raster.md](stable-raster.md) | used | Cycle-level raster sync |
| [irq-music-player.md](irq-music-player.md) | used | IRQ SID player pattern |
| [rasterbars.md](rasterbars.md) | used | Color bar raster effect |
| [scrolltext.md](scrolltext.md) | used | Fine-scroll and char-copy patterns |
| [fld.md](fld.md) | used | FLD vertical scroll trick |
| [dycp.md](dycp.md) | used | Per-char dynamic color |
| [dysp.md](dysp.md) | used | Dynamic sprite Y positioning |
| [sprite-multiplexer.md](sprite-multiplexer.md) | used | IRQ sprite multiplexing |
| [fire.md](fire.md) | used | Charset fire algorithm |
| [starfield.md](starfield.md) | used | Starfield rendering |
| [plasma.md](plasma.md) | used | Sine-based plasma |
| [rng.md](rng.md) | used | X-ABC pseudo-random number generator |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | codebase64.net upstream route |

## related
| domain | read | why |
|---|---|---|
| Display modes | [../display-modes/INDEX.md](../display-modes/INDEX.md) | FLI/IFLI/NUFLI and all unofficial display mode technique specs |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Prerequisite recipes: raster IRQ setup, sprite display, SID gate |
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II and SID hardware registers used by effects |
| Concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Timing constraints: bad lines, screen geometry, banking |
| ASM | [../asm/INDEX.md](../asm/INDEX.md) | Assembler syntax for effect source code |
