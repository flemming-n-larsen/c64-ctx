---
type: reference
domain: concepts
granularity: concept
---

## facts
- The 6502 `I` status flag is the interrupt-disable flag in `cpu_6502.txt`.
- VIC-II raster interrupts use VIC-II raster compare/control and interrupt flag registers in the `$D000` I/O block.
- CIA1 and CIA2 interrupt behavior MUST be distinguished: CIA1 is routed as IRQ context here, CIA2 as NMI context here.
- KERNAL time/IRQ services are routed through [../kernal/time-irq.md](../kernal/time-irq.md).

## lookup
| source | common use | local route |
|---|---|---|
| CPU `I` flag | Mask IRQ while installing vectors or handlers | [../cpu/6502/registers-flags.md](../cpu/6502/registers-flags.md) |
| VIC-II `$D011/$D012/$D019` | Raster compare and IRQ acknowledge | [../io/vic-ii.md](../io/vic-ii.md) |
| CIA1 `$DC00-$DCFF` | Keyboard/joystick/timer IRQ context | [../io/cia1.md](../io/cia1.md) |
| CIA2 `$DD00-$DDFF` | Serial/VIC-bank/timer NMI context | [../io/cia2.md](../io/cia2.md) |
| KERNAL IRQ/time calls | ROM-managed timing and stop key | [../kernal/time-irq.md](../kernal/time-irq.md) |

## constraints
- Interrupt setup code SHOULD use `SEI` before changing vectors and `CLI` only after vectors/registers are consistent.
- Raster IRQ handlers MUST acknowledge the VIC-II interrupt source to avoid repeated interrupts.
- Handlers MUST preserve registers they clobber unless the caller/system contract is intentionally replaced.
- Agents MUST distinguish CPU vectors, KERNAL vectors, VIC-II IRQ flags, and CIA interrupt registers.

## links
- raster task: [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md)
- VIC-II: [../io/vic-ii.md](../io/vic-ii.md)
- KERNAL time/IRQ: [../kernal/time-irq.md](../kernal/time-irq.md)

## sources
- `C:\Code\c64ref\src\6502\cpu_6502.txt`
- `C:\Code\c64ref\src\c64io\c64io_prg.txt`
- `C:\Code\c64ref\src\kernal\kernal_prg.txt`
- `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt`
