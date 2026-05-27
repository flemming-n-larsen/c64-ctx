---
type: index
domain: cpu/6502
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| Register sizes and status bits | [registers-flags.md](registers-flags.md) | `P` flags MUST be interpreted bitwise. |
| Addressing modes | [addressing-modes.md](addressing-modes.md) | Use to parse operands and effective addresses. |
| Documented instruction effects | [instruction-set.md](instruction-set.md) | Use for mnemonic class, flags, and symbolic operation. |
| Illegal or undocumented behavior | [illegal-opcodes.md](illegal-opcodes.md) | Agents MUST mark behavior as undocumented when using these opcodes. |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [registers-flags.md](registers-flags.md) | planned | Baseline 6502 register and flag facts. |
| [addressing-modes.md](addressing-modes.md) | planned | Operand forms and effective-address behavior. |
| [instruction-set.md](instruction-set.md) | planned | Documented mnemonic, operation, and flag-effect coverage. |
| [illegal-opcodes.md](illegal-opcodes.md) | optional | Undocumented opcode caveats and compatibility notes. |
| [../../sources/INDEX.md](../../sources/INDEX.md) | provenance | Central upstream fallback route. |

## related
| domain | read | why |
|---|---|---|
| Parent CPU index | [../INDEX.md](../INDEX.md) | CPU-domain routing. |
| Memory | [../../memory/INDEX.md](../../memory/INDEX.md) | Address map for effective addresses. |
| Tasks | [../../tasks/INDEX.md](../../tasks/INDEX.md) | Practical sequences using CPU instructions. |
