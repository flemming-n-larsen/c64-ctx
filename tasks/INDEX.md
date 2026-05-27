---
type: index
domain: tasks
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| Load or save a file | [load-save-file.md](load-save-file.md) | Uses KERNAL file I/O and device setup calls. |
| Print text or characters | [print-to-screen.md](print-to-screen.md) | Uses `CHROUT`, screen memory, PETSCII, colors. |
| Read keyboard input | [read-keyboard.md](read-keyboard.md) | Uses KERNAL input and keyboard matrix routes. |
| Create raster interrupt | [raster-interrupt.md](raster-interrupt.md) | Uses VIC-II raster registers, IRQ vectors, CPU flags. |
| Switch ROM/RAM/I/O banks | [bank-switch-rom-ram.md](bank-switch-rom-ram.md) | Uses processor port and memory banking constraints. |

## source-coverage
| source | status | notes |
|---|---|---|
| `C:\Code\c64ref\src\kernal\kernal_prg.txt` | planned | KERNAL call sequences and contracts. |
| `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt` | planned | Memory ranges, vectors, and banking. |
| `C:\Code\c64ref\src\c64io\c64io_prg.txt` | planned | Hardware register bit fields. |
| `C:\Code\c64ref\src\6502\cpu_6502.txt` | planned | CPU registers, flags, and instruction effects. |
| `C:\Code\c64ref\src\charset\keyboard_c64.txt` | planned | Keyboard matrix and character input data. |

## related
| domain | read | why |
|---|---|---|
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | API calls for file, input, output, time. |
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | Address ranges and vectors. |
| I/O | [../io/INDEX.md](../io/INDEX.md) | Hardware registers. |
| Concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Constraints used by recipes. |