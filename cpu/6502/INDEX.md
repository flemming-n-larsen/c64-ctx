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
| Illegal / undocumented opcodes for demo/game use | [illegal-opcodes.md](illegal-opcodes.md) | Opcode bytes, stability, demo-use notes, quirks, examples. |

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| Every 6502 addressing mode with its operand syntax and effective-address rule. | [addressing-modes.md](addressing-modes.md) | addressing modes, indirect indexed, zero page, operand syntax |
| The 105 undocumented NMOS opcodes: bytes, stability, demo use, quirks. | [illegal-opcodes.md](illegal-opcodes.md) | illegal opcodes, undocumented, LAX, SAX, NOP variants, unstable |
| Documented 6502 opcode semantics: operation class, flag effects, cycle counts. | [instruction-set.md](instruction-set.md) | instruction set, mnemonics, opcodes, flag effects, cycle counts |
| The A, X, Y, S, P, PC registers and every status flag bit in P. | [registers-flags.md](registers-flags.md) | registers, status flags, carry, overflow, decimal mode |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Parent CPU index | [../INDEX.md](../INDEX.md) | CPU-domain routing. |
| Memory | [../../memory/INDEX.md](../../memory/INDEX.md) | Address map for effective addresses. |
| Tasks | [../../tasks/INDEX.md](../../tasks/INDEX.md) | Practical sequences using CPU instructions. |
