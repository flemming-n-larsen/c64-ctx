---
type: index
domain: memory
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| Whole-machine address overview | [map.md](map.md) | Agents SHOULD start here for unknown addresses. |
| Symbol lookup and aliases | [symbols.md](symbols.md) | Use for zero-page, vectors, and OS workspace names. |
| Zero-page workspace | [zero-page.md](zero-page.md) | Use before relying on BASIC/KERNAL zero-page storage. |
| BASIC ROM range | [basic-rom.md](basic-rom.md) | `$A000-$BFFF`; banking-dependent. |
| KERNAL ROM range | [kernal-rom.md](kernal-rom.md) | `$E000-$FFFF`; includes vectors near top of memory. |
| I/O and character ROM window | [io-area.md](io-area.md) | `$D000-$DFFF`; depends on `CHAREN` and ROM/RAM banking. |
| Hidden RAM beneath `$00`/`$01` processor port registers | [hidden-ram.md](hidden-ram.md) | Read via VIC sprite collision; write via bus residue timing technique. |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [map.md](map.md) | used | Whole-machine sub-region map including I/O sub-ranges and CPU vectors `$FFFA-$FFFF`. |
| [symbols.md](symbols.md) | used | Processor port, BASIC workspace, KERNAL workspace `$0090-$00FF`, page-3 vectors, CPU vectors. |
| [zero-page.md](zero-page.md) | used | Zero-page broad allocation plus KERNAL workspace `$0090-$00FF` detail. |
| [basic-rom.md](basic-rom.md), [kernal-rom.md](kernal-rom.md), [io-area.md](io-area.md) | planned | ROM, RAM, I/O, and character-ROM visibility constraints. |
| [hidden-ram.md](hidden-ram.md) | used | Hidden RAM at `$00`/`$01`; read/write techniques and constraints. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Central upstream fallback route. |

## related
| domain | read | why |
|---|---|---|
| Concepts | [../concepts/memory-banking.md](../concepts/memory-banking.md) | Banking constraints. |
| I/O | [../io/INDEX.md](../io/INDEX.md) | Hardware registers in memory space. |
| ROM | [../rom/INDEX.md](../rom/INDEX.md) | ROM routine locations. |
| BASIC | [../basic/INDEX.md](../basic/INDEX.md) | Interpreter workspace and vectors. |
