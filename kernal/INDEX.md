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

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| Load, save, open, close and channel I/O through the KERNAL, in call order. | [file-io.md](file-io.md) | file I/O, SETLFS, SETNAM, LOAD, SAVE, channels |
| Every KERNAL jump table entry with address and category; a route table, not contracts. | [jump-table.md](jump-table.md) | jump table, KERNAL API, entry points, call addresses |
| KERNAL character I/O calls for keyboard and screen, versus direct screen writes. | [keyboard-screen.md](keyboard-screen.md) | GETIN, CHRIN, CHROUT, screen editor, character I/O |
| KERNAL calls that report or move the memory boundaries used by BASIC and the OS. | [memory.md](memory.md) | MEMBOT, MEMTOP, memory boundaries, KERNAL memory calls |
| Low-level IEC serial bus calls for talking to drives and printers directly. | [serial-bus.md](serial-bus.md) | serial bus, IEC, LISTEN, TALK, ACPTR, CIOUT |
| KERNAL jiffy clock, timer, IRQ restoration and stop-key services. | [time-irq.md](time-irq.md) | jiffy clock, RDTIM, SETTIM, stop key, IRQ restore |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/kernal-rom.md](../memory/kernal-rom.md) | KERNAL ROM and vectors. |
| ROM | [../rom/kernal-disassembly.md](../rom/kernal-disassembly.md) | Implementation routing. |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Practical KERNAL call sequences. |
| CPU | [../cpu/6502/registers-flags.md](../cpu/6502/registers-flags.md) | Register and flag effects. |
