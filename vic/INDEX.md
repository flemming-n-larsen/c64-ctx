---
type: index
domain: vic
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| VIC-II register overview, raster IRQ bits, sprite registers | [registers.md](registers.md) | Compact VIC-first register route; raw bitfield table remains in [../io/vic-ii.md](../io/vic-ii.md). |
| VIC-visible memory, bank select, screen matrix, `$D018` | [memory-and-banking.md](memory-and-banking.md) | Bridges [../concepts/screen-memory.md](../concepts/screen-memory.md) and [../io/cia2.md](../io/cia2.md). |
| Calculate `$DD00` and `$D018` from screen and graphics addresses | [quick-screen-setup.md](quick-screen-setup.md) | Compact assembler-time formula with alignment, bank, and bit-preservation constraints. |
| Raster timing, bad lines, display-window constraints | [timing.md](timing.md) | Collects raster, bad-line, geometry, and IRQ timing routes. |
| Practical raster interrupt setup | [timing.md](timing.md) | Routes onward to [../irq/raster-interrupt.md](../irq/raster-interrupt.md) once the timing model is clear. |
| Official VIC-II screen modes and enable-bit combinations | [screen-modes.md](screen-modes.md) | VIC-side mode bridge into graphics and display-technique pages. |
| Unofficial mode families and deeper display specs | [screen-modes.md](screen-modes.md) | Routes onward to [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md) and [../display-modes/INDEX.md](../display-modes/INDEX.md). |
| VIC-II chip variants: NTSC vs PAL, raster lines, cycles, C64 model mapping | [variants.md](variants.md) | 6567R56A, 6567R8, 6569, 6572, 8562, 8565, 8566 — timing differences and palette notes. |
| Color values and palette naming | [../colors/palette.md](../colors/palette.md) | Pair with `io/vic-ii.md` when a register stores a color index. |
| Sprite setup and sprite-specific behavior | [../sprites/INDEX.md](../sprites/INDEX.md) | Dedicated sprite hub for setup, visibility, collisions, and advanced techniques. |

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| What the VIC-II can see: 16 KB bank select, screen matrix and charset placement. | [memory-and-banking.md](memory-and-banking.md) | VIC bank, bank select, screen base, charset base, ROM holes |
| Compute the bank and memory-pointer register values from one screen-address constant. | [quick-screen-setup.md](quick-screen-setup.md) | screen setup, bank calculation, bit arithmetic, alignment |
| VIC-first route through the register block: control, raster IRQ, sprites, colors. | [registers.md](registers.md) | VIC registers, register block, mirroring, control registers |
| Which ECM/BMM/MCM bit combination selects each hardware display mode. | [screen-modes.md](screen-modes.md) | screen modes, mode bits, bitmap mode, multicolor, hires |
| The 9-bit raster counter, cycles per line, and the display-window timing model. | [timing.md](timing.md) | raster timing, raster counter, cycles per line, display window |
| NTSC and PAL VIC-II revisions: raster lines, cycles, frame rate, palette differences. | [variants.md](variants.md) | chip variants, NTSC vs PAL, 6567, 6569, 8565, revision |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/INDEX.md](../io/INDEX.md) | Chip-level register references beyond the curated VIC route. |
| graphics | [../graphics/INDEX.md](../graphics/INDEX.md) | Display-mode-first routing when the question is specifically about picture modes. |
| display-modes | [../display-modes/INDEX.md](../display-modes/INDEX.md) | Per-technique format/spec pages such as FLI, NUFLI, and UFLI. |
| concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Cross-domain constraints for memory, geometry, color mixing, and interrupts. |
| tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Practical setup sequences that use VIC-II features. |
| sources | [../sources/INDEX.md](../sources/INDEX.md) | Provenance for `mist64/c64ref` and derived local routes. |
