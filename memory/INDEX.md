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

## source-coverage
| source | status | notes |
|---|---|---|
| `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt` | planned | Main address descriptions from `Mapping the Commodore 64`. |
| `C:\Code\c64ref\src\c64mem\symbols.txt` | planned | Canonical symbol seed and aliases. |
| `C:\Code\c64ref\src\c64mem\c64mem_src.txt` | planned | Microsoft/Commodore source comments. |
| `C:\Code\c64ref\src\c64mem\generate.py` | observed | Shows cross-reference behavior and source ordering. |

## related
| domain | read | why |
|---|---|---|
| Concepts | [../concepts/memory-banking.md](../concepts/memory-banking.md) | Banking constraints. |
| I/O | [../io/INDEX.md](../io/INDEX.md) | Hardware registers in memory space. |
| ROM | [../rom/INDEX.md](../rom/INDEX.md) | ROM routine locations. |
| BASIC | [../basic/INDEX.md](../basic/INDEX.md) | Interpreter workspace and vectors. |
