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
| Install a VIC-II raster IRQ: vectors, enable bits, acknowledge, KERNAL coexistence. | [raster-interrupt.md](raster-interrupt.md) | raster interrupt, raster IRQ, acknowledge, KERNAL coexistence |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II and CIA register facts used by IRQ handlers. |
| memory | [../memory/INDEX.md](../memory/INDEX.md) | RAM/ROM vectors, symbols, and banking context. |
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | ROM-managed IRQ services and API-side coexistence. |
| effects | [../effects/INDEX.md](../effects/INDEX.md) | Raster effects that consume stable interrupt timing. |
| music | [../music/INDEX.md](../music/INDEX.md) | Frame-driven player integration routes. |
