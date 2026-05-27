---
type: index
domain: concepts
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| Banking ROM, RAM, I/O, character ROM | [memory-banking.md](memory-banking.md) | Agents MUST combine this with `$0001` processor-port facts. |
| Zero-page roles and aliases | [zero-page.md](zero-page.md) | Use when memory symbols need behavioral context. |
| IRQ/NMI vectors and interrupt constraints | [interrupts.md](interrupts.md) | Use before writing raster or CIA interrupt code. |
| Screen matrix and color RAM relationship | [screen-memory.md](screen-memory.md) | Use with VIC-II and color RAM pages. |
| PETSCII vs screen code vs keyboard matrix | [character-sets.md](character-sets.md) | Agents MUST NOT conflate code spaces. |

## source-coverage
| source | status | notes |
|---|---|---|
| `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt` | planned | Banking, zero-page, screen memory, vectors. |
| `C:\Code\c64ref\src\c64io\c64io_prg.txt` | planned | Hardware interrupt and I/O register context. |
| `C:\Code\c64ref\src\charset\keyboard_c64.txt` | planned | Keyboard matrix and character input context. |
| `C:\Code\c64ref\src\charset\control_codes_c64.txt` | planned | PETSCII/control code distinctions. |

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | Address ranges and symbols. |
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II, SID, CIA, processor port. |
| Charset | [../charset/INDEX.md](../charset/INDEX.md) | Character encodings and keyboard data. |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Practical recipes that combine concepts. |
