---
type: index
domain: cpu
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| C64 CPU baseline | [6502/INDEX.md](6502/INDEX.md) | The C64 uses a 6510 CPU with a 6502-family core plus on-chip I/O port. |
| Registers and status flags | [6502/registers-flags.md](6502/registers-flags.md) | Use before reasoning about clobbers or branch conditions. |
| Addressing syntax and modes | [6502/addressing-modes.md](6502/addressing-modes.md) | Use for opcode forms and operand interpretation. |
| Instruction behavior | [6502/instruction-set.md](6502/instruction-set.md) | Compact documented opcode semantics. |
| Undocumented opcodes | [6502/illegal-opcodes.md](6502/illegal-opcodes.md) | Agents SHOULD treat illegal opcodes as compatibility-sensitive. |

## source-coverage
| source | status | notes |
|---|---|---|
| `C:\Code\c64ref\src\6502\cpu_6502.txt` | planned | Registers, flags, mnemonics, operations, opcode table. |
| `C:\Code\c64ref\src\6502\cpu_65c02.txt` | referenced | Variant contrast only; MUST NOT be treated as C64 baseline. |
| `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt` | planned | 6510 processor-port C64-specific behavior. |

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | Addressing targets and vectors. |
| I/O | [../io/processor-port.md](../io/processor-port.md) | 6510 on-chip I/O port. |
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | Register contracts for system calls. |
