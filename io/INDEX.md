---
type: index
domain: io
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| 6510 port and banking bits | [processor-port.md](processor-port.md) | `$0000-$0001`; MUST be considered before `$A000`, `$D000`, `$E000` facts. |
| VIC-II registers | [vic-ii.md](vic-ii.md) | Raster, screen, sprites, interrupts, video control. |
| SID registers | [sid.md](sid.md) | Sound chip register route. |
| CIA1 registers | [cia1.md](cia1.md) | Keyboard, joystick, timers, IRQ. |
| CIA2 registers | [cia2.md](cia2.md) | Serial bus, VIC bank select, NMI. |
| Color RAM | [color-ram.md](color-ram.md) | `$D800-$DBFF`; 4-bit color storage. |

## source-coverage
| source | status | notes |
|---|---|---|
| `C:\Code\c64ref\src\c64io\c64io_prg.txt` | planned | Programmer's Reference Guide I/O map. |
| `C:\Code\c64ref\src\c64io\c64io_mapc64.txt` | planned | Mapping-style I/O detail. |
| `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt` | planned | Banking and memory window context. |

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/io-area.md](../memory/io-area.md) | `$D000-$DFFF` memory window. |
| Concepts | [../concepts/interrupts.md](../concepts/interrupts.md) | IRQ/NMI constraints. |
| Colors | [../colors/INDEX.md](../colors/INDEX.md) | VIC-II color values. |
| Tasks | [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md) | Practical VIC-II IRQ recipe. |
