---
type: reference
domain: irq
granularity: concept
source: codebase64.net
summary: "Remove IRQ entry jitter for cycle-exact raster effects using double-IRQ sync."
keywords: [stable raster, jitter, double IRQ, cycle exact, raster sync]
---

## facts
- Stable timing starts from the same interrupt machinery as raster IRQ setup, but its goal is cycle-repeatable entry rather than merely line-repeatable entry. See [../irq/raster-interrupt.md](../irq/raster-interrupt.md).
- Raster IRQ entry can shift because the CPU finishes the current instruction before the handler begins; stable-timing techniques compensate for that entry jitter before cycle-critical writes.
- The common C64 stable-raster pattern is a two-stage IRQ: the first IRQ arms the target line, and the second IRQ performs the cycle-alignment check before effect code runs.
- Stable timing is broader than rasterbars: it is also the prerequisite for border tricks, precise sprite timing, and other cycle-tight VIC-II effects. See [../effects/INDEX.md](../effects/INDEX.md).

## lookup
| need | read | notes |
|---|---|---|
| Baseline raster IRQ setup | [../irq/raster-interrupt.md](../irq/raster-interrupt.md) | Install vector first; then add stability work. |
| Stable raster consumer view | [../effects/stable-raster.md](../effects/stable-raster.md) | Double-IRQ sequence, cycle tables, effect-side usage. |
| VIC-II IRQ registers | [../io/vic-ii.md](../io/vic-ii.md) | `$D011`, `$D012`, `$D019`, `$D01A`. |
| Bad-line planning | [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md) | Stable entry does not remove bad-line cycle theft. |
| VIC timing overview | [../vic/timing.md](../vic/timing.md) | PAL/NTSC line and cycle budgets. |

## constraints
- Stability checks MUST happen before the first cycle-sensitive VIC-II write.
- Stable timing SHOULD budget for both entry-jitter compensation and the normal IRQ prologue/epilogue.
- Bad lines still steal CPU cycles even when the IRQ entry point is stabilized.
- PAL and NTSC cycle tables MUST stay separate when documenting stable routines.

## links
- interrupt hub: [INDEX.md](INDEX.md)
- raster interrupt recipe: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- stable raster effect route: [../effects/stable-raster.md](../effects/stable-raster.md)
- VIC timing: [../vic/timing.md](../vic/timing.md)
- bad lines: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- raster setup: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- stable raster consumer route: [../effects/stable-raster.md](../effects/stable-raster.md)
- provenance note: [../sources/INDEX.md](../sources/INDEX.md) — Codebase64 interrupt coverage includes `base:interrupts` and stable-raster material summarized here.
