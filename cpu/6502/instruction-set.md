---
type: reference
domain: cpu/6502
granularity: atomic
---

## operation-classes
| class | mnemonics | flags commonly affected | notes |
|---|---|---|---|
| Arithmetic | `ADC`, `SBC`, `CMP`, `CPX`, `CPY` | `N`, `V`, `Z`, `C` as applicable | `CMP`/`CPX`/`CPY` subtract for flags without storing result. |
| Logic | `AND`, `EOR`, `ORA`, `BIT` | `N`, `V`, `Z` as applicable | `BIT` transfers memory bits `7`/`6` to `N`/`V`. |
| Shifts/rotates | `ASL`, `LSR`, `ROL`, `ROR` | `N`, `Z`, `C` | Target is accumulator or memory depending on addressing mode. |
| Branches | `BCC`, `BCS`, `BEQ`, `BMI`, `BNE`, `BPL`, `BVC`, `BVS` | none | Use relative offsets and current flags. |
| Loads/stores | `LDA`, `LDX`, `LDY`, `STA`, `STX`, `STY` | loads set `N`, `Z`; stores do not | Store instructions write memory/register target. |
| Inc/dec | `INC`, `INX`, `INY`, `DEC`, `DEX`, `DEY` | `N`, `Z` | Increment/decrement memory or registers. |
| Transfers | `TAX`, `TAY`, `TXA`, `TYA`, `TSX`, `TXS` | usually `N`, `Z` except `TXS` | Move values between registers. |
| Stack | `PHA`, `PHP`, `PLA`, `PLP` | pulls may affect `P` or `N`, `Z` | Use stack page `$0100-$01FF`. |
| Control | `JMP`, `JSR`, `RTS`, `RTI`, `BRK`, `NOP` | opcode-defined | `BRK` vectors through interrupt vector area. |
| Flag ops | `CLC`, `SEC`, `CLD`, `SED`, `CLI`, `SEI`, `CLV` | named flag only | Use `SEI`/`CLI` for IRQ mask control. |

## examples
```asm
; branch on zero result from prior operation
BEQ target

; install-sensitive code usually masks IRQ first
SEI
; update vectors/registers
CLI
```

## constraints
- Agents MUST cite exact mnemonic behavior from the local 6502 CPU pages when explaining flag updates.
- Agents MUST NOT use 65C02-only opcodes as baseline C64 6502-family instructions.
- Code that uses decimal mode SHOULD explicitly `CLD` when returning to code that expects binary arithmetic.

## links
- registers and flags: [registers-flags.md](registers-flags.md)
- addressing modes: [addressing-modes.md](addressing-modes.md)
- illegal opcodes: [illegal-opcodes.md](illegal-opcodes.md)

## sources
- local route: [../../sources/INDEX.md](../../sources/INDEX.md)
- CPU index: [INDEX.md](INDEX.md)
