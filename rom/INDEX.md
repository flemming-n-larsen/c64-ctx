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
| answers | read | terms |
|---|---|---|
| Where BASIC ROM routines live, as a route to the upstream disassemblies. | [basic-disassembly.md](basic-disassembly.md) | BASIC ROM, interpreter routines, disassembly, ROM listing |
| Where KERNAL ROM routines live, as a route to the upstream disassemblies. | [kernal-disassembly.md](kernal-disassembly.md) | KERNAL ROM, disassembly, ROM listing, implementation detail |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | ROM ranges and vectors. |
| BASIC | [../basic/INDEX.md](../basic/INDEX.md) | BASIC interpreter routing. |
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | KERNAL jump table and API contracts. |
