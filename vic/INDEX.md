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

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [registers.md](registers.md), [../io/vic-ii.md](../io/vic-ii.md) | used | Compact register route plus authoritative raw register table. |
| [memory-and-banking.md](memory-and-banking.md), [../io/cia2.md](../io/cia2.md), [../concepts/screen-memory.md](../concepts/screen-memory.md) | used | Bank selection, screen matrix placement, and `$D018` routing. |
| [quick-screen-setup.md](quick-screen-setup.md) | used | Address-derived `$DD00` and `$D018` setup formula and constraints. |
| [timing.md](timing.md), [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md), [../irq/raster-interrupt.md](../irq/raster-interrupt.md) | used | Timing constraints, geometry, and raster IRQ practice. |
| [screen-modes.md](screen-modes.md), [../graphics/screen-modes.md](../graphics/screen-modes.md), [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md), [../display-modes/INDEX.md](../display-modes/INDEX.md) | used | Mode and technique routing. |
| [variants.md](variants.md) | used | VIC-II chip variant hardware reference: NTSC/PAL timing, raster geometry, palette differences. |
| [../colors/palette.md](../colors/palette.md), [../sprites/INDEX.md](../sprites/INDEX.md), [../tasks/sprite-display.md](../tasks/sprite-display.md) | used | Color and sprite-adjacent context. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Central upstream fallback route. |

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/INDEX.md](../io/INDEX.md) | Chip-level register references beyond the curated VIC route. |
| graphics | [../graphics/INDEX.md](../graphics/INDEX.md) | Display-mode-first routing when the question is specifically about picture modes. |
| display-modes | [../display-modes/INDEX.md](../display-modes/INDEX.md) | Per-technique format/spec pages such as FLI, NUFLI, and UFLI. |
| concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Cross-domain constraints for memory, geometry, color mixing, and interrupts. |
| tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Practical setup sequences that use VIC-II features. |
| sources | [../sources/INDEX.md](../sources/INDEX.md) | Provenance for `mist64/c64ref` and derived local routes. |
