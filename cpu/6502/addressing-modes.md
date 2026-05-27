---
type: reference
domain: cpu/6502
granularity: atomic
---

## lookup
| mode | syntax examples | effective target | notes |
|---|---|---|---|
| Implied | `CLC`, `RTS` | Opcode-defined | No operand byte. |
| Accumulator | `ASL A` | `A` | Operation targets accumulator. |
| Immediate | `LDA #$01` | Literal operand byte | Does not read memory address `$0001`. |
| Zero page | `LDA $02` | `$0000-$00FF` | Short operand; C64 zero page is system-owned. |
| Zero page indexed | `LDA $02,X`, `STY $02,X` | Zero-page wraparound address | Indexing wraps within `$00-$FF`. |
| Absolute | `JMP $C000` | 16-bit address | Used for most C64 memory/I/O references. |
| Absolute indexed | `LDA $0400,X`, `LDA $0400,Y` | 16-bit base plus index | Page crossings may affect timing. |
| Relative | `BEQ label` | Signed branch offset from next instruction | Used by conditional branches. |
| Indirect | `JMP ($FFFC)` | 16-bit pointer target | Baseline 6502 has the known page-boundary indirect `JMP` behavior. |
| Indexed indirect | `LDA ($FB,X)` | Zero-page pointer selected by `X` | Common pointer-table form. |
| Indirect indexed | `LDA ($FB),Y` | Zero-page pointer plus `Y` | Common stream/table form. |

## constraints
- Agents MUST distinguish immediate `#$nn` from address `$00nn`.
- C64 code SHOULD avoid assuming zero page bytes are free unless ownership is documented.
- Addressing examples SHOULD be cross-checked against opcode availability in [instruction-set.md](instruction-set.md).

## links
- registers and flags: [registers-flags.md](registers-flags.md)
- zero page concept: [../../concepts/zero-page.md](../../concepts/zero-page.md)
- memory map: [../../memory/map.md](../../memory/map.md)

## sources
- local route: [../../sources/INDEX.md](../../sources/INDEX.md)
- CPU index: [INDEX.md](INDEX.md)
