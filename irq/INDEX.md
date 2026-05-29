---
type: index
domain: irq
source: codebase64
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

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [overview.md](overview.md) | used | Canonical interrupt-generic concept page. |
| [../irq/raster-interrupt.md](../irq/raster-interrupt.md) | used | Canonical raster IRQ setup recipe. |
| [stable-timing.md](stable-timing.md) | used | Stable timing/stable raster technique route derived from Codebase64 interrupt material. |
| [cooperative-threads.md](cooperative-threads.md) | used | Advanced interrupt-driven flow route for cooperative threading/scheduling patterns. |
| [../effects/stable-raster.md](../effects/stable-raster.md) | related | Effect-focused consumer route that now points into `/irq`. |
| [../tasks/cooperative-threads.md](../tasks/cooperative-threads.md) | related | Legacy task backlink route that now points into `/irq`. |
| [../kernal/time-irq.md](../kernal/time-irq.md) | related | KERNAL-owned timer/IRQ behavior remains in `kernal/`. |
| [../music/irq-music-player.md](../music/irq-music-player.md) | related | Music-player IRQ consumer route remains in `music/`. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Local provenance route for `c64ref` and Codebase64-backed interrupt material. |

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II and CIA register facts used by IRQ handlers. |
| memory | [../memory/INDEX.md](../memory/INDEX.md) | RAM/ROM vectors, symbols, and banking context. |
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | ROM-managed IRQ services and API-side coexistence. |
| effects | [../effects/INDEX.md](../effects/INDEX.md) | Raster effects that consume stable interrupt timing. |
| music | [../music/INDEX.md](../music/INDEX.md) | Frame-driven player integration routes. |
