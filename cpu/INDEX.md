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
| local coverage | status | notes |
|---|---|---|
| [6502/INDEX.md](6502/INDEX.md) | planned | Registers, flags, mnemonics, operations, opcode tables, and variant caveats. |
| [../io/processor-port.md](../io/processor-port.md) | planned | 6510 processor-port C64-specific behavior. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Central upstream fallback route. |

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | Addressing targets and vectors. |
| I/O | [../io/processor-port.md](../io/processor-port.md) | 6510 on-chip I/O port. |
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | Register contracts for system calls. |
