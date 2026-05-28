---
type: index
domain: tasks
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| Display a sprite | [sprite-display.md](sprite-display.md) | Sprite pointer, data block, X/Y position, enable, color. |
| Load or save a file | [load-save-file.md](load-save-file.md) | Uses KERNAL file I/O and device setup calls. |
| Print text or characters | [print-to-screen.md](print-to-screen.md) | Uses `CHROUT`, screen memory, PETSCII, colors. |
| Read keyboard input | [read-keyboard.md](read-keyboard.md) | Uses KERNAL input and keyboard matrix routes. |
| Create raster interrupt | [raster-interrupt.md](raster-interrupt.md) | Uses VIC-II raster registers, IRQ vectors, CPU flags. |
| Switch ROM/RAM/I/O banks | [bank-switch-rom-ram.md](bank-switch-rom-ram.md) | Uses processor port and memory banking constraints. |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [sprite-display.md](sprite-display.md) | used | 6-step sprite setup: pointer, data, position, color, enable. |
| [load-save-file.md](load-save-file.md) | planned | KERNAL file call sequences and contracts. |
| [print-to-screen.md](print-to-screen.md), [read-keyboard.md](read-keyboard.md) | planned | Screen, character, and keyboard workflows. |
| [raster-interrupt.md](raster-interrupt.md) | planned | VIC-II, IRQ vector, and CPU flag workflow. |
| [bank-switch-rom-ram.md](bank-switch-rom-ram.md) | planned | Memory range, banking, and processor-port workflow. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Central upstream fallback route. |

## related
| domain | read | why |
|---|---|---|
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | API calls for file, input, output, time. |
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | Address ranges and vectors. |
| I/O | [../io/INDEX.md](../io/INDEX.md) | Hardware registers. |
| Concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Constraints used by recipes. |