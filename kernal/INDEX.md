---
type: index
domain: kernal
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| All KERNAL jump table entries | [jump-table.md](jump-table.md) | Agents SHOULD use this for address/category routing. |
| Load, save, open, close, channel I/O | [file-io.md](file-io.md) | Use for device/file workflows. |
| Serial/IEEE bus calls | [serial-bus.md](serial-bus.md) | Use for `LISTEN`, `TALK`, `ACPTR`, `CIOUT`, `UNLSN`, `UNTLK`. |
| Keyboard and screen calls | [keyboard-screen.md](keyboard-screen.md) | Use for `GETIN`, `CHRIN`, `CHROUT`, editor calls. |
| Memory calls | [memory.md](memory.md) | Use for `MEMBOT`, `MEMTOP`, `SETNAM`, `SETLFS` context. |
| Time, IRQ, stop-key calls | [time-irq.md](time-irq.md) | Use for timers, IRQ restoration, and `STOP`. |

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/kernal-rom.md](../memory/kernal-rom.md) | KERNAL ROM and vectors. |
| ROM | [../rom/kernal-disassembly.md](../rom/kernal-disassembly.md) | Implementation routing. |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Practical KERNAL call sequences. |
| CPU | [../cpu/6502/registers-flags.md](../cpu/6502/registers-flags.md) | Register and flag effects. |
