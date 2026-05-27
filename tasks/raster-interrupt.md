---
type: reference
domain: tasks
granularity: recipe
---

## sequence
1. Use `SEI` before changing interrupt vectors or VIC-II interrupt registers.
2. Install or update the intended IRQ vector according to the memory/KERNAL vector strategy being used.
3. Program VIC-II raster compare using `$D012` and `$D011` bit `7` for raster bit `8`.
4. Enable the VIC-II raster interrupt in the relevant VIC-II interrupt-enable register.
5. Use `CLI` only after vector/register state is coherent.
6. In the handler, preserve clobbered registers, acknowledge the VIC-II raster flag via `$D019`, perform work, restore registers, and return with the correct interrupt return sequence.

## lookup
| need | read | notes |
|---|---|---|
| CPU interrupt mask and return behavior | [../cpu/6502/registers-flags.md](../cpu/6502/registers-flags.md) | `I`, `SEI`, `CLI`, `RTI`. |
| Raster registers and acknowledge | [../io/vic-ii.md](../io/vic-ii.md) | `$D011`, `$D012`, `$D019`. |
| IRQ/NMI distinctions | [../concepts/interrupts.md](../concepts/interrupts.md) | CIA1/CIA2/VIC/KERNAL routes. |
| KERNAL time/IRQ coexistence | [../kernal/time-irq.md](../kernal/time-irq.md) | Preserve or deliberately replace KERNAL behavior. |

## constraints
- Raster handlers MUST acknowledge the VIC-II interrupt source.
- Handlers MUST preserve registers unless they fully own the interrupted environment.
- Code that banks out KERNAL ROM MUST NOT rely on KERNAL IRQ code remaining visible.
- Agents SHOULD state whether the recipe chains to the normal KERNAL IRQ handler or replaces it.

## links
- interrupts concept: [../concepts/interrupts.md](../concepts/interrupts.md)
- VIC-II: [../io/vic-ii.md](../io/vic-ii.md)
- CPU instruction set: [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md)
- memory banking: [../concepts/memory-banking.md](../concepts/memory-banking.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- task index: [INDEX.md](INDEX.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- interrupts: [../concepts/interrupts.md](../concepts/interrupts.md)
