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

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| Forcing a bad line every second raster line, freeing cycles for twisters and rotators. | [2nd-line-fli.md](2nd-line-fli.md) | 2nd line FLI, twister, X-rotator, waving carpet, Bresenham segments |
| Fade one charset into another pixel by pixel, plus color RAM palette fades. | [blending.md](blending.md) | blending, fade in, fade out, charset blend, palette cycle |
| How a demo is structured: IRQ chain, frame anatomy, and the prerequisite techniques. | [demo-intro.md](demo-intro.md) | demo coding, demo structure, IRQ chain, frame anatomy, intro |
| Warp a logo with independent per-row vertical and horizontal sine displacement. | [distortion.md](distortion.md) | distortion, DYPP, tech-tech, sine warp, logo distortion |
| A field of dots flying toward the viewer from a precomputed perspective table. | [dot-scroll.md](dot-scroll.md) | dot scroll, 3D dots, perspective table, speedcode generation |
| Give each character column its own color by writing color RAM once per raster line. | [dycp.md](dycp.md) | DYCP, dynamic color per char, color scroller, per-column color |
| Reposition sprites mid-frame for extra vertical positions, and stretch them. | [dysp.md](dysp.md) | DYSP, sprite stretching, sprite repositioning, mid-frame update |
| Fire effect using a 4x4 intensity charset and a neighbour-average algorithm. | [fire.md](fire.md) | fire effect, flame, neighbour average, intensity charset |
| Scroll vertically by inserting blank raster lines through bad-line suppression. | [fld.md](fld.md) | FLD, flexible line distance, vertical scroll, bad line suppression |
| Per-line horizontal warp of a graphic by driving the memory pointers from a sine table. | [fpp.md](fpp.md) | FPP, stretcher, flexible pixel position, horizontal warp |
| Render Julia and Mandelbrot sets with fixed-point iteration and lookup tables. | [fractals.md](fractals.md) | fractals, Julia set, Mandelbrot, fixed point iteration |
| Colour flashing via background register cycling, and charset page-flip animation. | [misc.md](misc.md) | colour flashing, notewriter, cracktro, frame animation, page flipping |
| Remove the top, bottom or side borders, and put sprites out there. | [open-borders.md](open-borders.md) | open borders, border removal, side border, sprites in border |
| Flowing color patterns from summed sine waves, in character mode or as rasterbars. | [plasma.md](plasma.md) | plasma, sine sum, color cycling, FLI plasma |
| Colored bars drawn by rewriting the border and background color each raster line. | [rasterbars.md](rasterbars.md) | rasterbars, color bars, raster splits, border color |
| The X-ABC pseudo-random generator: 38 cycles, 28 bytes, 8- or 16-bit output. | [rng.md](rng.md) | RNG, PRNG, X-ABC, random numbers, fast random |
| Horizontal, vertical and sine scrollers built on hardware fine-scroll plus char shifting. | [scrolltext.md](scrolltext.md) | scroller, scrolltext, fine scroll, sine scroller, greetings |
| Show more than 8 sprites by recycling the hardware sprites down the raster. | [sprite-multiplexer.md](sprite-multiplexer.md) | sprite multiplexer, more than 8 sprites, sprite recycling, Y sort |
| Redirect stub with effect-side notes; stable timing lives in the irq domain. | [stable-raster.md](stable-raster.md) | stable raster, redirect, effect timing |
| Depth illusion from dots moving at tiered speeds, character- or sprite-based. | [starfield.md](starfield.md) | starfield, stars, parallax, depth illusion, ROL starfield |
| Move a graphic in a horizontal sine wider than the 8-pixel hardware scroll limit. | [swing.md](swing.md) | swing, tech-tech, techtech, horizontal sine, wide scroll |
| 3D wireframe and filled polygons: projection, depth sort, scanline fill. | [vectors.md](vectors.md) | vectors, 3D polygons, wireframe, painter's algorithm, scanline fill |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Display modes | [../display-modes/INDEX.md](../display-modes/INDEX.md) | FLI/IFLI/NUFLI and all unofficial display mode technique specs |
| sprites | [../sprites/INDEX.md](../sprites/INDEX.md) | Sprite-specific discovery path for the subset of effects built on hardware sprites. |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Prerequisite recipes: raster IRQ setup, sprite display, SID gate |
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II and SID hardware registers used by effects |
| Concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Timing constraints: bad lines, screen geometry, banking |
| ASM | [../asm/INDEX.md](../asm/INDEX.md) | Assembler syntax for effect source code |
