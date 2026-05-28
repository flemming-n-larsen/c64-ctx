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

## instruction-set

Key — `bytes`: instruction length including opcode byte; `cycles`: base machine cycles; `cycle-notes`: `+p` = +1 cycle if page boundary crossed; `+b` = +1 if branch taken (same page), +2 if taken and page crossed.

Mode abbreviations: `imp` implied; `acc` accumulator; `imm` immediate; `zp` zero page; `zpx` zero page,X; `zpy` zero page,Y; `abs` absolute; `abx` absolute,X; `aby` absolute,Y; `ind` indirect; `izx` indexed indirect (addr,X); `izy` indirect indexed (addr),Y; `rel` relative.

Flags notation: `—` = none affected; `all` = all flags restored from stack (RTI, PLP); named flags = those bits updated.

| mnemonic | mode | opcode | bytes | cycles | cycle-notes | flags |
|---|---|---|---:|---:|---|---|
| `ADC` | `imm` | `$69` | 2 | 2 | | N,V,Z,C |
| `ADC` | `zp` | `$65` | 2 | 3 | | N,V,Z,C |
| `ADC` | `zpx` | `$75` | 2 | 4 | | N,V,Z,C |
| `ADC` | `abs` | `$6D` | 3 | 4 | | N,V,Z,C |
| `ADC` | `abx` | `$7D` | 3 | 4 | +p | N,V,Z,C |
| `ADC` | `aby` | `$79` | 3 | 4 | +p | N,V,Z,C |
| `ADC` | `izx` | `$61` | 2 | 6 | | N,V,Z,C |
| `ADC` | `izy` | `$71` | 2 | 5 | +p | N,V,Z,C |
| `AND` | `imm` | `$29` | 2 | 2 | | N,Z |
| `AND` | `zp` | `$25` | 2 | 3 | | N,Z |
| `AND` | `zpx` | `$35` | 2 | 4 | | N,Z |
| `AND` | `abs` | `$2D` | 3 | 4 | | N,Z |
| `AND` | `abx` | `$3D` | 3 | 4 | +p | N,Z |
| `AND` | `aby` | `$39` | 3 | 4 | +p | N,Z |
| `AND` | `izx` | `$21` | 2 | 6 | | N,Z |
| `AND` | `izy` | `$31` | 2 | 5 | +p | N,Z |
| `ASL` | `acc` | `$0A` | 1 | 2 | | N,Z,C |
| `ASL` | `zp` | `$06` | 2 | 5 | | N,Z,C |
| `ASL` | `zpx` | `$16` | 2 | 6 | | N,Z,C |
| `ASL` | `abs` | `$0E` | 3 | 6 | | N,Z,C |
| `ASL` | `abx` | `$1E` | 3 | 7 | | N,Z,C |
| `BCC` | `rel` | `$90` | 2 | 2 | +b | — |
| `BCS` | `rel` | `$B0` | 2 | 2 | +b | — |
| `BEQ` | `rel` | `$F0` | 2 | 2 | +b | — |
| `BIT` | `zp` | `$24` | 2 | 3 | | N,V,Z |
| `BIT` | `abs` | `$2C` | 3 | 4 | | N,V,Z |
| `BMI` | `rel` | `$30` | 2 | 2 | +b | — |
| `BNE` | `rel` | `$D0` | 2 | 2 | +b | — |
| `BPL` | `rel` | `$10` | 2 | 2 | +b | — |
| `BRK` | `imp` | `$00` | 1 | 7 | | I |
| `BVC` | `rel` | `$50` | 2 | 2 | +b | — |
| `BVS` | `rel` | `$70` | 2 | 2 | +b | — |
| `CLC` | `imp` | `$18` | 1 | 2 | | C |
| `CLD` | `imp` | `$D8` | 1 | 2 | | D |
| `CLI` | `imp` | `$58` | 1 | 2 | | I |
| `CLV` | `imp` | `$B8` | 1 | 2 | | V |
| `CMP` | `imm` | `$C9` | 2 | 2 | | N,Z,C |
| `CMP` | `zp` | `$C5` | 2 | 3 | | N,Z,C |
| `CMP` | `zpx` | `$D5` | 2 | 4 | | N,Z,C |
| `CMP` | `abs` | `$CD` | 3 | 4 | | N,Z,C |
| `CMP` | `abx` | `$DD` | 3 | 4 | +p | N,Z,C |
| `CMP` | `aby` | `$D9` | 3 | 4 | +p | N,Z,C |
| `CMP` | `izx` | `$C1` | 2 | 6 | | N,Z,C |
| `CMP` | `izy` | `$D1` | 2 | 5 | +p | N,Z,C |
| `CPX` | `imm` | `$E0` | 2 | 2 | | N,Z,C |
| `CPX` | `zp` | `$E4` | 2 | 3 | | N,Z,C |
| `CPX` | `abs` | `$EC` | 3 | 4 | | N,Z,C |
| `CPY` | `imm` | `$C0` | 2 | 2 | | N,Z,C |
| `CPY` | `zp` | `$C4` | 2 | 3 | | N,Z,C |
| `CPY` | `abs` | `$CC` | 3 | 4 | | N,Z,C |
| `DEC` | `zp` | `$C6` | 2 | 5 | | N,Z |
| `DEC` | `zpx` | `$D6` | 2 | 6 | | N,Z |
| `DEC` | `abs` | `$CE` | 3 | 6 | | N,Z |
| `DEC` | `abx` | `$DE` | 3 | 7 | | N,Z |
| `DEX` | `imp` | `$CA` | 1 | 2 | | N,Z |
| `DEY` | `imp` | `$88` | 1 | 2 | | N,Z |
| `EOR` | `imm` | `$49` | 2 | 2 | | N,Z |
| `EOR` | `zp` | `$45` | 2 | 3 | | N,Z |
| `EOR` | `zpx` | `$55` | 2 | 4 | | N,Z |
| `EOR` | `abs` | `$4D` | 3 | 4 | | N,Z |
| `EOR` | `abx` | `$5D` | 3 | 4 | +p | N,Z |
| `EOR` | `aby` | `$59` | 3 | 4 | +p | N,Z |
| `EOR` | `izx` | `$41` | 2 | 6 | | N,Z |
| `EOR` | `izy` | `$51` | 2 | 5 | +p | N,Z |
| `INC` | `zp` | `$E6` | 2 | 5 | | N,Z |
| `INC` | `zpx` | `$F6` | 2 | 6 | | N,Z |
| `INC` | `abs` | `$EE` | 3 | 6 | | N,Z |
| `INC` | `abx` | `$FE` | 3 | 7 | | N,Z |
| `INX` | `imp` | `$E8` | 1 | 2 | | N,Z |
| `INY` | `imp` | `$C8` | 1 | 2 | | N,Z |
| `JMP` | `abs` | `$4C` | 3 | 3 | | — |
| `JMP` | `ind` | `$6C` | 3 | 5 | | — |
| `JSR` | `abs` | `$20` | 3 | 6 | | — |
| `LDA` | `imm` | `$A9` | 2 | 2 | | N,Z |
| `LDA` | `zp` | `$A5` | 2 | 3 | | N,Z |
| `LDA` | `zpx` | `$B5` | 2 | 4 | | N,Z |
| `LDA` | `abs` | `$AD` | 3 | 4 | | N,Z |
| `LDA` | `abx` | `$BD` | 3 | 4 | +p | N,Z |
| `LDA` | `aby` | `$B9` | 3 | 4 | +p | N,Z |
| `LDA` | `izx` | `$A1` | 2 | 6 | | N,Z |
| `LDA` | `izy` | `$B1` | 2 | 5 | +p | N,Z |
| `LDX` | `imm` | `$A2` | 2 | 2 | | N,Z |
| `LDX` | `zp` | `$A6` | 2 | 3 | | N,Z |
| `LDX` | `zpy` | `$B6` | 2 | 4 | | N,Z |
| `LDX` | `abs` | `$AE` | 3 | 4 | | N,Z |
| `LDX` | `aby` | `$BE` | 3 | 4 | +p | N,Z |
| `LDY` | `imm` | `$A0` | 2 | 2 | | N,Z |
| `LDY` | `zp` | `$A4` | 2 | 3 | | N,Z |
| `LDY` | `zpx` | `$B4` | 2 | 4 | | N,Z |
| `LDY` | `abs` | `$AC` | 3 | 4 | | N,Z |
| `LDY` | `abx` | `$BC` | 3 | 4 | +p | N,Z |
| `LSR` | `acc` | `$4A` | 1 | 2 | | N,Z,C |
| `LSR` | `zp` | `$46` | 2 | 5 | | N,Z,C |
| `LSR` | `zpx` | `$56` | 2 | 6 | | N,Z,C |
| `LSR` | `abs` | `$4E` | 3 | 6 | | N,Z,C |
| `LSR` | `abx` | `$5E` | 3 | 7 | | N,Z,C |
| `NOP` | `imp` | `$EA` | 1 | 2 | | — |
| `ORA` | `imm` | `$09` | 2 | 2 | | N,Z |
| `ORA` | `zp` | `$05` | 2 | 3 | | N,Z |
| `ORA` | `zpx` | `$15` | 2 | 4 | | N,Z |
| `ORA` | `abs` | `$0D` | 3 | 4 | | N,Z |
| `ORA` | `abx` | `$1D` | 3 | 4 | +p | N,Z |
| `ORA` | `aby` | `$19` | 3 | 4 | +p | N,Z |
| `ORA` | `izx` | `$01` | 2 | 6 | | N,Z |
| `ORA` | `izy` | `$11` | 2 | 5 | +p | N,Z |
| `PHA` | `imp` | `$48` | 1 | 3 | | — |
| `PHP` | `imp` | `$08` | 1 | 3 | | — |
| `PLA` | `imp` | `$68` | 1 | 4 | | N,Z |
| `PLP` | `imp` | `$28` | 1 | 4 | | all |
| `ROL` | `acc` | `$2A` | 1 | 2 | | N,Z,C |
| `ROL` | `zp` | `$26` | 2 | 5 | | N,Z,C |
| `ROL` | `zpx` | `$36` | 2 | 6 | | N,Z,C |
| `ROL` | `abs` | `$2E` | 3 | 6 | | N,Z,C |
| `ROL` | `abx` | `$3E` | 3 | 7 | | N,Z,C |
| `ROR` | `acc` | `$6A` | 1 | 2 | | N,Z,C |
| `ROR` | `zp` | `$66` | 2 | 5 | | N,Z,C |
| `ROR` | `zpx` | `$76` | 2 | 6 | | N,Z,C |
| `ROR` | `abs` | `$6E` | 3 | 6 | | N,Z,C |
| `ROR` | `abx` | `$7E` | 3 | 7 | | N,Z,C |
| `RTI` | `imp` | `$40` | 1 | 6 | | all |
| `RTS` | `imp` | `$60` | 1 | 6 | | — |
| `SBC` | `imm` | `$E9` | 2 | 2 | | N,V,Z,C |
| `SBC` | `zp` | `$E5` | 2 | 3 | | N,V,Z,C |
| `SBC` | `zpx` | `$F5` | 2 | 4 | | N,V,Z,C |
| `SBC` | `abs` | `$ED` | 3 | 4 | | N,V,Z,C |
| `SBC` | `abx` | `$FD` | 3 | 4 | +p | N,V,Z,C |
| `SBC` | `aby` | `$F9` | 3 | 4 | +p | N,V,Z,C |
| `SBC` | `izx` | `$E1` | 2 | 6 | | N,V,Z,C |
| `SBC` | `izy` | `$F1` | 2 | 5 | +p | N,V,Z,C |
| `SEC` | `imp` | `$38` | 1 | 2 | | C |
| `SED` | `imp` | `$F8` | 1 | 2 | | D |
| `SEI` | `imp` | `$78` | 1 | 2 | | I |
| `STA` | `zp` | `$85` | 2 | 3 | | — |
| `STA` | `zpx` | `$95` | 2 | 4 | | — |
| `STA` | `abs` | `$8D` | 3 | 4 | | — |
| `STA` | `abx` | `$9D` | 3 | 5 | | — |
| `STA` | `aby` | `$99` | 3 | 5 | | — |
| `STA` | `izx` | `$81` | 2 | 6 | | — |
| `STA` | `izy` | `$91` | 2 | 6 | | — |
| `STX` | `zp` | `$86` | 2 | 3 | | — |
| `STX` | `zpy` | `$96` | 2 | 4 | | — |
| `STX` | `abs` | `$8E` | 3 | 4 | | — |
| `STY` | `zp` | `$84` | 2 | 3 | | — |
| `STY` | `zpx` | `$94` | 2 | 4 | | — |
| `STY` | `abs` | `$8C` | 3 | 4 | | — |
| `TAX` | `imp` | `$AA` | 1 | 2 | | N,Z |
| `TAY` | `imp` | `$A8` | 1 | 2 | | N,Z |
| `TSX` | `imp` | `$BA` | 1 | 2 | | N,Z |
| `TXA` | `imp` | `$8A` | 1 | 2 | | N,Z |
| `TXS` | `imp` | `$9A` | 1 | 2 | | — |
| `TYA` | `imp` | `$98` | 1 | 2 | | N,Z |

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
- `BRK` sets the `I` flag in `P` and pushes `PC+2` and `P` (with the `B` bit forced to 1 in the stack copy) then vectors through `$FFFE/$FFFF`; the byte after the `BRK` opcode is skipped on `RTI` return.
- `BIT` sets `N` from bit 7 of the memory operand, `V` from bit 6, and `Z` from the result of `A AND operand` — without modifying `A`.
- `LSR` always clears `N` (shifts 0 into bit 7); `ROR` sets `N` from the old `C` bit rotated in.

## links
- registers and flags: [registers-flags.md](registers-flags.md)
- addressing modes: [addressing-modes.md](addressing-modes.md)
- illegal opcodes: [illegal-opcodes.md](illegal-opcodes.md)

## sources
- local route: [../../sources/INDEX.md](../../sources/INDEX.md)
- CPU index: [INDEX.md](INDEX.md)
