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
| SID registers | [../sid/registers.md](../sid/registers.md) | Sound chip register route — full SID domain at [../sid/INDEX.md](../sid/INDEX.md). |
| CIA1 registers | [cia1.md](cia1.md) | Keyboard, joystick, timers, IRQ. |
| CIA2 registers | [cia2.md](cia2.md) | Serial bus, VIC bank select, NMI. |
| Color RAM | [color-ram.md](color-ram.md) | `$D800-$DBFF`; 4-bit color storage. |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [processor-port.md](processor-port.md) | planned | 6510 port and memory-configuration bits. |
| [vic-ii.md](vic-ii.md) | planned | Video register coverage. |
| [../sid/registers.md](../sid/registers.md) | used | Sound register coverage — SID domain. |
| [cia1.md](cia1.md), [cia2.md](cia2.md) | planned | CIA timers, keyboard/joystick, serial bus, IRQ/NMI coverage. |
| [color-ram.md](color-ram.md), [../memory/io-area.md](../memory/io-area.md) | planned | Color RAM plus `$D000-$DFFF` banking context. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Central upstream fallback route. |

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/io-area.md](../memory/io-area.md) | `$D000-$DFFF` memory window. |
| Concepts | [../concepts/interrupts.md](../concepts/interrupts.md) | IRQ/NMI constraints. |
| Colors | [../colors/INDEX.md](../colors/INDEX.md) | VIC-II color values. |
| Tasks | [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md) | Practical VIC-II IRQ recipe. |
