---
type: index
domain: effects
source: codebase64.net
---

## routes
| need | read | notes |
|---|---|---|
| Sprite-heavy effect route | [../sprites/advanced.md](../sprites/advanced.md) | Curated entry for DYSP, multiplexers, border usage, starfields, and underlay modes. |
| Open top/bottom or side borders | [open-borders.md](open-borders.md) | Double-IRQ `$D011` / `$D016` trick; sprites-in-border notes included |
| Stable raster synchronization | [stable-raster.md](stable-raster.md) | Double-IRQ cycle compensation; prerequisite for precise effects |
| Music playback, tune integration, player timing | [../music/INDEX.md](../music/INDEX.md) | IRQ player, music patterns, hard restart, PAL/NTSC timing, tune placement. |
| SID chip sound primitives and filter sweep | [../sid/INDEX.md](../sid/INDEX.md) | Raw SID registers, waveforms, note tables, filter sweep, chip detection. |
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
| Demo coding introduction and structure | [demo-intro.md](demo-intro.md) | IRQ chain structure; frame anatomy; prerequisites overview |
| Swinging / Tech-Tech (wide horizontal sine) | [swing.md](swing.md) | Per-line `$D018` bank switch + `$D016` XSCROLL; requires FLI-style bad-line forcing |
| 3D Dot Scroll | [dot-scroll.md](dot-scroll.md) | Perspective trajectory table; runtime speedcode generation; raster-synchronized |
| FPP Stretcher (per-line horizontal warp) | [fpp.md](fpp.md) | Sine-driven `chartab`; `$D018` update per line; FLI timing |
| Graphics Distortion (DYPP + tech-tech) | [distortion.md](distortion.md) | Y-axis (DYPP) + X-axis sine warp on FLI logo; per-row bank switching |
| Fractals (Julia / Mandelbrot) | [fractals.md](fractals.md) | Fixed-point iteration; square/log/exp tables; 72×56 framebuffer; multi-frame render |
| Vectors (3D wireframe / filled polygons) | [vectors.md](vectors.md) | Scanline fill; painter's algorithm; speedcode clear; sprite-based variant |
| Blending / Fading | [blending.md](blending.md) | Randomized pixel-by-pixel charset blend; CIA timer PRNG seed; color RAM fade |
| 2nd-line FLI (twisters, rotators, waving carpets) | [2nd-line-fli.md](2nd-line-fli.md) | Forced bad line on alternate lines; Bresenham segment selection; 63 free cycles/even line |
| Misc (colour flashing, frame animation) | [misc.md](misc.md) | EBC mode color register cycling; charset page flipping for animation |

For FLI, IFLI, NUFLI, UFLI, ECI and all other display mode technique specs → see [../display-modes/INDEX.md](../display-modes/INDEX.md).

## related
| domain | read | why |
|---|---|---|
| Display modes | [../display-modes/INDEX.md](../display-modes/INDEX.md) | FLI/IFLI/NUFLI and all unofficial display mode technique specs |
| sprites | [../sprites/INDEX.md](../sprites/INDEX.md) | Sprite-specific discovery path for the subset of effects built on hardware sprites. |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Prerequisite recipes: raster IRQ setup, sprite display, SID gate |
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II and SID hardware registers used by effects |
| Concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Timing constraints: bad lines, screen geometry, banking |
| ASM | [../asm/INDEX.md](../asm/INDEX.md) | Assembler syntax for effect source code |
