---
type: index
domain: rom
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| BASIC ROM routine routing | [basic-disassembly.md](basic-disassembly.md) | `$A000-$BFFF`; compact route to source disassemblies. |
| KERNAL ROM routine routing | [kernal-disassembly.md](kernal-disassembly.md) | `$E000-$FFFF`; compact route to source disassemblies. |
| KERNAL API addresses | [../kernal/jump-table.md](../kernal/jump-table.md) | Use before implementation details. |
| ROM/RAM banking | [../concepts/memory-banking.md](../concepts/memory-banking.md) | ROM visibility depends on processor-port bits. |

## pages
<!-- GENERATED:routes -->
_Every page in this domain is reached from `## routes` above._
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | ROM ranges and vectors. |
| BASIC | [../basic/INDEX.md](../basic/INDEX.md) | BASIC interpreter routing. |
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | KERNAL jump table and API contracts. |
