---
type: reference
domain: irq
granularity: concept
---

## facts
- The 6502 `I` status flag masks maskable IRQ when set; it does not block NMI. See [../cpu/6502/registers-flags.md](../cpu/6502/registers-flags.md).
- On the C64, VIC-II interrupt work is usually handled through the KERNAL IRQ indirection at `CINV` (`$0314`), while hardware IRQ/BRK and NMI vectors remain at `IRQVEC` (`$FFFE`) and `NMIVEC` (`$FFFA`). See [../memory/symbols.md](../memory/symbols.md).
- VIC-II raster interrupts are configured with raster compare/control registers and must acknowledge the VIC-II interrupt source after entry. See [../io/vic-ii.md](../io/vic-ii.md).
- CIA1 is the common IRQ-side CIA source, while CIA2 is the common NMI-side CIA source on the C64. See [../io/cia1.md](../io/cia1.md) and [../io/cia2.md](../io/cia2.md).
- KERNAL IRQ handling also drives the jiffy clock and stop-key processing, so custom handlers must either chain deliberately or replace that behavior knowingly. See [../kernal/time-irq.md](../kernal/time-irq.md).

## lookup
| need | read | notes |
|---|---|---|
| CPU interrupt mask semantics | [../cpu/6502/registers-flags.md](../cpu/6502/registers-flags.md) | `I`, `SEI`, `CLI`, and interrupt-return context. |
| RAM vectors for KERNAL interception | [../memory/symbols.md](../memory/symbols.md) | `CINV` (`$0314`) and `NMINV` (`$0318`). |
| CPU hardware vectors | [../memory/symbols.md](../memory/symbols.md) | `NMIVEC` (`$FFFA`) and `IRQVEC` (`$FFFE`). |
| VIC-II raster IRQ registers | [../io/vic-ii.md](../io/vic-ii.md) | Raster compare/control and IRQ flag handling. |
| CIA1 IRQ-side behavior | [../io/cia1.md](../io/cia1.md) | Timer/keyboard/joystick CIA route. |
| CIA2 NMI-side behavior | [../io/cia2.md](../io/cia2.md) | NMI route plus VIC-bank/serial context. |
| ROM-managed IRQ side effects | [../kernal/time-irq.md](../kernal/time-irq.md) | Jiffy clock, `TI`/`TI$`, stop key. |

## constraints
- Code SHOULD use `SEI` before updating IRQ/NMI vectors or device interrupt masks, and `CLI` only after vector and register state is coherent.
- Raster and CIA handlers MUST acknowledge the active device source; otherwise the machine can re-enter the handler immediately.
- Custom IRQ code MUST preserve registers it clobbers unless it fully replaces the interrupted contract.
- Agents MUST distinguish CPU hardware vectors from KERNAL RAM indirection vectors; they are related but not interchangeable.
- Code that replaces the standard IRQ path SHOULD state whether KERNAL timekeeping and stop-key handling are preserved.

## links
- raster interrupt recipe: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- KERNAL IRQ timing: [../kernal/time-irq.md](../kernal/time-irq.md)
- memory symbols: [../memory/symbols.md](../memory/symbols.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- CIA1: [../io/cia1.md](../io/cia1.md)
- CIA2: [../io/cia2.md](../io/cia2.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- CPU flags: [../cpu/6502/registers-flags.md](../cpu/6502/registers-flags.md)
- vectors and symbols: [../memory/symbols.md](../memory/symbols.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- CIA1: [../io/cia1.md](../io/cia1.md)
- CIA2: [../io/cia2.md](../io/cia2.md)
- KERNAL IRQ services: [../kernal/time-irq.md](../kernal/time-irq.md)
