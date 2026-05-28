---
type: reference
domain: cpu/6502
granularity: atomic
---

## lookup
| mode | bytes | syntax examples | effective target | notes |
|---|---:|---|---|---|
| Implied | 1 | `CLC`, `RTS` | Opcode-defined | No operand byte. |
| Accumulator | 1 | `ASL A` | `A` | Operation targets accumulator. |
| Immediate | 2 | `LDA #$01` | Literal operand byte | Does not read memory address `$0001`. |
| Zero page | 2 | `LDA $02` | `$0000-$00FF` | Short operand; C64 zero page is system-owned. |
| Zero page,X | 2 | `LDA $02,X`, `STY $02,X` | Zero-page wraparound address | Indexing wraps within `$00-$FF`. |
| Zero page,Y | 2 | `LDX $02,Y`, `STX $02,Y` | Zero-page wraparound address | Only `LDX` and `STX` use this mode. |
| Absolute | 3 | `JMP $C000` | 16-bit address | Used for most C64 memory/I/O references. |
| Absolute,X | 3 | `LDA $0400,X` | 16-bit base plus `X` | Page crossings add 1 cycle for reads; writes always pay full cost. |
| Absolute,Y | 3 | `LDA $0400,Y` | 16-bit base plus `Y` | Page crossings add 1 cycle for reads; writes always pay full cost. |
| Relative | 2 | `BEQ label` | Signed branch offset from next instruction | Used by conditional branches. |
| Indirect | 3 | `JMP ($FFFC)` | 16-bit pointer target | Baseline 6502 has the known page-boundary indirect `JMP` behavior. |
| Indexed indirect | 2 | `LDA ($FB,X)` | Zero-page pointer selected by `X` | Common pointer-table form. |
| Indirect indexed | 2 | `LDA ($FB),Y` | Zero-page pointer plus `Y` | Page crossings add 1 cycle for reads. Common stream/table form. |

## constraints
- Agents MUST distinguish immediate `#$nn` from address `$00nn`.
- C64 code SHOULD avoid assuming zero page bytes are free unless ownership is documented.
- Addressing examples SHOULD be cross-checked against opcode availability in [instruction-set.md](instruction-set.md).
- Page-crossing penalty rule: read instructions using `abs,X`, `abs,Y`, or `(ind),Y` take 1 extra cycle when the computed effective address crosses a 256-byte page boundary (high byte changes). Write (store) instructions and read-modify-write instructions (`ASL`, `LSR`, `ROL`, `ROR`, `INC`, `DEC`) in `abs,X` always take the maximum cycle count — no conditional penalty.

## links
- registers and flags: [registers-flags.md](registers-flags.md)
- zero page concept: [../../concepts/zero-page.md](../../concepts/zero-page.md)
- memory map: [../../memory/map.md](../../memory/map.md)

## sources
- local route: [../../sources/INDEX.md](../../sources/INDEX.md)
- CPU index: [INDEX.md](INDEX.md)
