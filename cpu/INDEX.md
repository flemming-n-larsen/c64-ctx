---
type: index
domain: cpu
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| C64 CPU chip identity, 6510 vs 6502 differences, I/O port, clock speed | [6510.md](6510.md) | Read first when the question is C64-specific CPU behavior. |
| 6502-family instruction set, registers, opcodes | [6502/INDEX.md](6502/INDEX.md) | Instruction set is family-scoped; applies to all 6502 derivatives including the 6510. |
| Registers and status flags | [6502/registers-flags.md](6502/registers-flags.md) | Use before reasoning about clobbers or branch conditions. |
| Addressing syntax and modes | [6502/addressing-modes.md](6502/addressing-modes.md) | Use for opcode forms and operand interpretation. |
| Instruction behavior | [6502/instruction-set.md](6502/instruction-set.md) | Compact documented opcode semantics. |
| Undocumented opcodes | [6502/illegal-opcodes.md](6502/illegal-opcodes.md) | Agents SHOULD treat illegal opcodes as compatibility-sensitive. |
| Common coding mistakes (DOKE, self-mod labels, addressing mode confusion) | [pitfalls.md](pitfalls.md) | Silent assembler bugs and self-modifying code offset errors. |
| Detect CPU variant at runtime (NMOS 6502, 65C02, 65816) | [detect-cpu.md](detect-cpu.md) | Use `$1A` / `XBA` / `$3A` opcode behavior differences. |

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| How the C64's 6510 differs from a plain 6502: the on-chip I/O port and clock speed. | [6510.md](6510.md) | 6510, processor port, CPU identity, clock speed |
| Identify NMOS 6502, 65C02, or 65816 at runtime from opcode behavior differences. | [detect-cpu.md](detect-cpu.md) | CPU detection, 65C02, 65816, NMOS, runtime probe |
| Silent 6502 coding mistakes: missing #, DOKE byte order, self-modifying label offsets. | [pitfalls.md](pitfalls.md) | pitfalls, DOKE, self-modifying code, silent bug, immediate mode |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | Addressing targets and vectors. |
| I/O | [../io/processor-port.md](../io/processor-port.md) | 6510 on-chip I/O port. |
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | Register contracts for system calls. |
