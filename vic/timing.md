---
type: reference
domain: vic
granularity: atomic
summary: "The 9-bit raster counter, cycles per line, and the display-window timing model."
keywords: [raster timing, raster counter, cycles per line, display window]
---

## facts
- Raster timing is driven by the 9-bit raster counter formed from `$D012` plus `$D011` bit `7`.
- A bad line occurs when DEN=1 and `(Y AND $07) == YSCROLL`; on that line VIC-II steals about 40 cycles for character fetches.
- Sprite DMA steals additional cycles on any raster line occupied by enabled sprites.
- Clearing DEN suppresses bad lines while leaving sprite display available.
- The local repo separates PAL visible-area geometry from bad-line scheduling details; use both routes when exact line placement matters.

## lookup
| timing concern | read | notes |
|---|---|---|
| Raster compare and IRQ acknowledge | [../io/vic-ii.md](../io/vic-ii.md) | `$D011`, `$D012`, `$D019`, `$D01A`. |
| Bad-line condition and cycle budget | [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md) | Includes the `(Y AND $07) == YSCROLL` rule and PAL cycle estimates. |
| Visible-area and border coordinates | [../concepts/screen-geometry.md](../concepts/screen-geometry.md) | PAL-specific visible-area and text-area geometry. |
| Raster IRQ installation sequence | [../irq/raster-interrupt.md](../irq/raster-interrupt.md) | Practical handler setup and acknowledge flow. |
| Cycle-count budgeting inside handlers | [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md) | Use when a routine must fit before the next raster deadline. |

## constraints
- A YSCROLL change intended to suppress or permit a bad line MUST land before the target line begins.
- Stable raster work SHOULD assume sprite DMA costs are additive on top of bad-line steals.
- Raster IRQ handlers MUST acknowledge the active VIC-II source in `$D019` before returning.
- Code that relies on KERNAL IRQ behavior SHOULD state whether it chains to the normal IRQ handler or fully replaces it.
- When line numbers appear to differ between local geometry and timing pages, treat them as separate views of the frame: visible-area placement vs. fetch-scheduling constraints.

## sources

- VIC hub: [INDEX.md](INDEX.md)
- VIC bad lines: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)
- screen geometry: [../concepts/screen-geometry.md](../concepts/screen-geometry.md)
- raster IRQ task: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- VIC-II register reference: [../io/vic-ii.md](../io/vic-ii.md)
- register summary: [registers.md](registers.md)
- memory and banking: [memory-and-banking.md](memory-and-banking.md)
- screen modes: [screen-modes.md](screen-modes.md)
