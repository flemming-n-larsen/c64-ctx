---
type: index
domain: irq
source: codebase64.net
---

## routes
| need | read | notes |
|---|---|---|
| IRQ/NMI overview and vectors | [overview.md](overview.md) | CPU `I` flag, VIC-II IRQ, CIA1 IRQ, CIA2 NMI, KERNAL/page-3 vectors. |
| Install a VIC-II raster interrupt | [../irq/raster-interrupt.md](../irq/raster-interrupt.md) | Setup sequence, acknowledge rules, KERNAL coexistence decisions. |
| Stable timing and stable raster sync | [stable-timing.md](stable-timing.md) | Entry jitter, double-IRQ sync, cycle-budget constraints. |
| Cooperative threads and IRQ-driven flow | [cooperative-threads.md](cooperative-threads.md) | Stack-slice switching, bounded IRQ work, scheduler-style flow. |
| KERNAL timer IRQ behavior | [../kernal/time-irq.md](../kernal/time-irq.md) | Jiffy clock, stop-key handling, ROM coexistence. |
| IRQ-driven music playback | [../music/irq-music-player.md](../music/irq-music-player.md) | Music-player-specific consumer route. |

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| Stack-slice context switching to run several bounded tasks from one interrupt. | [cooperative-threads.md](cooperative-threads.md) | cooperative threads, scheduler, context switch, stack slice |
| IRQ and NMI sources, the I flag, and the KERNAL and page-3 interrupt vectors. | [overview.md](overview.md) | interrupts, NMI, IRQ vectors, I flag, page 3 vectors |
| Install a VIC-II raster IRQ: vectors, enable bits, acknowledge, KERNAL coexistence. | [raster-interrupt.md](raster-interrupt.md) | raster interrupt, raster IRQ, acknowledge, KERNAL coexistence |
| Remove IRQ entry jitter for cycle-exact raster effects using double-IRQ sync. | [stable-timing.md](stable-timing.md) | stable raster, jitter, double IRQ, cycle exact, raster sync |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II and CIA register facts used by IRQ handlers. |
| memory | [../memory/INDEX.md](../memory/INDEX.md) | RAM/ROM vectors, symbols, and banking context. |
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | ROM-managed IRQ services and API-side coexistence. |
| effects | [../effects/INDEX.md](../effects/INDEX.md) | Raster effects that consume stable interrupt timing. |
| music | [../music/INDEX.md](../music/INDEX.md) | Frame-driven player integration routes. |
