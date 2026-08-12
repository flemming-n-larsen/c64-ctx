---
type: reference
domain: irq
granularity: recipe
summary: "Install a VIC-II raster IRQ: vectors, enable bits, acknowledge, KERNAL coexistence."
keywords: [raster interrupt, raster IRQ, acknowledge, KERNAL coexistence]
---

## sequence
1. Use `SEI` before changing vectors or VIC-II interrupt configuration.
2. Decide whether the handler will chain through KERNAL `CINV` (`$0314`) or fully replace the normal IRQ path. See [overview.md](overview.md) and [../kernal/time-irq.md](../kernal/time-irq.md).
3. Install the intended IRQ vector while interrupts are masked.
4. Program the raster compare line using `$D012` plus `$D011` bit `7` for raster bit `8`.
5. Clear any pending VIC-II IRQ source and then enable the raster interrupt in the VIC-II interrupt-enable path.
6. Use `CLI` only after vector and VIC-II state are coherent.
7. In the handler, preserve clobbered registers, acknowledge the VIC-II raster source, do the time-critical work, restore registers, and return with the correct interrupt return sequence.

## lookup
| need | read | notes |
|---|---|---|
| IRQ mask and return semantics | [../cpu/6502/registers-flags.md](../cpu/6502/registers-flags.md) | `I`, `SEI`, `CLI`, `RTI`. |
| IRQ/NMI vectors | [../memory/symbols.md](../memory/symbols.md) | `CINV`, `IRQVEC`, `NMIVEC`. |
| Raster compare and acknowledge registers | [../io/vic-ii.md](../io/vic-ii.md) | `$D011`, `$D012`, VIC-II IRQ flags/enables. |
| IRQ/NMI distinctions | [overview.md](overview.md) | VIC-II/CIA1 IRQ vs CIA2 NMI routing. |
| KERNAL coexistence | [../kernal/time-irq.md](../kernal/time-irq.md) | Preserve or deliberately replace ROM-managed services. |

## constraints
- Raster handlers MUST acknowledge the VIC-II interrupt source before exit.
- Code MUST preserve registers unless it fully owns the interrupted environment.
- Code MUST state whether it chains to the normal KERNAL IRQ path or replaces it.
- If KERNAL ROM is banked out, code MUST NOT assume the usual ROM IRQ handler remains callable.

## sources

- interrupt overview: [overview.md](overview.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- vectors and symbols: [../memory/symbols.md](../memory/symbols.md)
- KERNAL IRQ services: [../kernal/time-irq.md](../kernal/time-irq.md)
- stable raster timing: [../effects/stable-raster.md](../effects/stable-raster.md)
