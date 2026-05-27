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
| source | status | notes |
|---|---|---|
| `C:\Code\c64ref\src\6502\cpu_6502.txt` | planned | Primary source for baseline 6502 data. |
| `C:\Code\c64ref\src\6502\script.js` | optional | MAY clarify generated opcode-table behavior if text data is insufficient. |
| `C:\Code\c64ref\src\6502\index.html` | fallback | MUST NOT override structured text data. |

## related
| domain | read | why |
|---|---|---|
| Parent CPU index | [../INDEX.md](../INDEX.md) | CPU-domain routing. |
| Memory | [../../memory/INDEX.md](../../memory/INDEX.md) | Address map for effective addresses. |
| Tasks | [../../tasks/INDEX.md](../../tasks/INDEX.md) | Practical sequences using CPU instructions. |
