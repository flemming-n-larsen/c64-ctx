---
type: reference
domain: cpu/6502
granularity: atomic
summary: "The 105 undocumented NMOS opcodes: bytes, stability, demo use, quirks."
keywords: [illegal opcodes, undocumented, LAX, SAX, NOP variants, unstable]
---

## facts
- The NMOS 6510 in the C64 has 105 undocumented opcodes; 19 distinct illegal mnemonics plus overloaded `NOP` variants.
- Illegal opcodes work by activating multiple internal decode lines simultaneously; effects are the union of both operations.
- Stability varies: `stable` = consistent across all NMOS 6510 revisions; `unstable` = chip-revision or even power-supply dependent.
- `JAM` locks the CPU until reset; it cannot be recovered from in software.
- Illegal `NOP` variants consume bytes and cycles without side effects — useful for patching without relocating code.
- Flag column uses mist64/c64ref notation: `*` = affected, `0`/`1` = forced, `-` = unaffected.

## lookup
| mnemonic | stability | opcodes | operation | flags `NV-BDIZC` | alt names |
|---|---|---|---|---|---|
| `ANC` | stable | `$0B #$nn`, `$2B #$nn` | A ∧ M → A, N → C | `*-----**` |  |
| `ARR` | stable | `$6B #$nn` | (A ∧ M) / 2 → A | `**----**` |  |
| `ASR` | stable | `$4B #$nn` | (A ∧ M) / 2 → A | `0-----**` | Ormston, groepaz: ALR |
| `DCP` | stable | `$C3 ($nn,X)`, `$C7 $nn`, `$CF $nnnn`, `$D3 ($nn),Y`, `$D7 $nn,X`, `$DB $nnnn,Y`, `$DF $nnnn,X` | M - 1 → M, A - M | `*-----**` | Ormston: DCM |
| `ISC` | stable | `$E3 ($nn,X)`, `$E7 $nn`, `$EF $nnnn`, `$F3 ($nn),Y`, `$F7 $nn,X`, `$FB $nnnn,Y`, `$FF $nnnn,X` | M + 1 → M, A - M → A | `**----**` | Ormston: INS; VICE: ISB |
| `JAM` | halts | `$02`, `$12`, `$22`, `$32`, `$42`, `$52`, `$62`, `$72`, `$92`, `$B2`, `$D2`, `$F2` | Stop execution | `none` | Ormston: HLT; Graham: KIL |
| `LAS` | stable | `$BB $nnnn,Y` | M ∧ S → A, X, S | `*-----*-` |  |
| `LAX` | stable | `$A3 ($nn,X)`, `$A7 $nn`, `$AB #$nn`, `$AF $nnnn`, `$B3 ($nn),Y`, `$B7 $nn,Y`, `$BF $nnnn,Y` | M → A, X | `*-----*-` |  |
| `NOP` | stable | `$04 $nn`, `$0C $nnnn`, `$14 $nn,X`, `$1A`, `$1C $nnnn,X`, `$34 $nn,X`, `$3A`, `$3C $nnnn,X`, `$44 $nn`, `$54 $nn,X`, `$5A`, `$5C $nnnn,X`, `$64 $nn`, `$74 $nn,X`, `$7A`, `$7C $nnnn,X`, `$80 #$nn`, `$82 #$nn`, `$89 #$nn`, `$C2 #$nn`, `$D4 $nn,X`, `$DA`, `$DC $nnnn,X`, `$E2 #$nn`, `$F4 $nn,X`, `$FA`, `$FC $nnnn,X` |  | `none` |  |
| `RLA` | stable | `$23 ($nn,X)`, `$27 $nn`, `$2F $nnnn`, `$33 ($nn),Y`, `$37 $nn,X`, `$3B $nnnn,Y`, `$3F $nnnn,X` | C ← /M7...M0/ ← C, A ∧ M → A | `*-----**` |  |
| `RRA` | stable | `$63 ($nn,X)`, `$67 $nn`, `$6F $nnnn`, `$73 ($nn),Y`, `$77 $nn,X`, `$7B $nnnn,Y`, `$7F $nnnn,X` | C → /M7...M0/ → C, A + M + C → A | `**----**` |  |
| `SAX` | stable | `$83 ($nn,X)`, `$87 $nn`, `$8F $nnnn`, `$97 $nn,Y` | A ∧ X → M | `none` |  |
| `SBC` | stable | `$EB #$nn` |  | `none` |  |
| `SBX` | stable | `$CB #$nn` | (A ∧ X) - M → X | `*-----**` | Graham: AXS |
| `SHA` | unstable | `$93 ($nn),Y`, `$9F $nnnn,Y` | A ∧ X ∧ V → M | `none` | Graham: AHX |
| `SHS` | unstable | `$9B $nnnn,Y` | A ∧ X → S, S ∧ (H + 1) → M | `none` | Graham, groepaz: TAS |
| `SHX` | unstable | `$9E $nnnn,Y` | X ∧ (H + 1) → M | `none` |  |
| `SHY` | unstable | `$9C $nnnn,X` | Y ∧ (H + 1) → M | `none` |  |
| `SLO` | stable | `$03 ($nn,X)`, `$07 $nn`, `$0F $nnnn`, `$13 ($nn),Y`, `$17 $nn,X`, `$1B $nnnn,Y`, `$1F $nnnn,X` | M * 2 → M, A ∨ M → A | `*-----**` | Ormston: ASO |
| `SRE` | stable | `$43 ($nn,X)`, `$47 $nn`, `$4F $nnnn`, `$53 ($nn),Y`, `$57 $nn,X`, `$5B $nnnn,Y`, `$5F $nnnn,X` | M / 2 → M, A ⊻ M → A | `*-----**` | Ormston: LSE |
| `XAA` | unstable | `$8B #$nn` | (A ∨ V) ∧ X ∧ M → A | `*-----*-` | VICE, groepaz: ANE |

## nop-variants
- Illegal `NOP` opcodes consume the instruction bytes without visible side effects.
- Useful for in-place patching: replace an instruction with a matching-size NOP to disable it.

| opcode | mode | bytes | cycles |
|---:|---|---:|---:|
| `$1A` | implied | 1 | 2 |
| `$3A` | implied | 1 | 2 |
| `$5A` | implied | 1 | 2 |
| `$7A` | implied | 1 | 2 |
| `$DA` | implied | 1 | 2 |
| `$FA` | implied | 1 | 2 |
| `$80` | immediate | 2 | 2 |
| `$82` | immediate | 2 | 2 |
| `$89` | immediate | 2 | 2 |
| `$C2` | immediate | 2 | 2 |
| `$E2` | immediate | 2 | 2 |
| `$04` | zero page | 2 | 3 |
| `$44` | zero page | 2 | 3 |
| `$64` | zero page | 2 | 3 |
| `$14` | zero page,X | 2 | 4 |
| `$34` | zero page,X | 2 | 4 |
| `$54` | zero page,X | 2 | 4 |
| `$74` | zero page,X | 2 | 4 |
| `$D4` | zero page,X | 2 | 4 |
| `$F4` | zero page,X | 2 | 4 |
| `$0C` | absolute | 3 | 4 |
| `$1C` | absolute,X | 3 | 4+ |
| `$3C` | absolute,X | 3 | 4+ |
| `$5C` | absolute,X | 3 | 4+ |
| `$7C` | absolute,X | 3 | 4+ |
| `$DC` | absolute,X | 3 | 4+ |
| `$FC` | absolute,X | 3 | 4+ |

## demo-use
Common uses of illegal opcodes in C64 demo and game programming.

| mnemonic | when to use |
|---|---|
| `LAX` | Load A and X simultaneously. Saves one instruction vs LDA+TAX. Use in inner loops reading a table value into both A and X. |
| `SAX` | Store A AND X to memory without affecting flags. Useful for storing a masked value in zero page cheaply. |
| `SLO` | ASL memory then ORA result into A. Two-in-one: shift a flags byte and set bits in A in one instruction. |
| `SRE` | LSR memory then EOR result into A. Useful in depack routines or LFSR-style bit manipulation. |
| `RLA` | ROL memory then AND result into A. Compact bit-test+rotate without extra registers. |
| `RRA` | ROR memory then ADC result into A. Useful in multiply/divide routines. |
| `DCP` | DEC memory then CMP A against result. Compare against a counter that also decrements — tight loop use. |
| `ISC` | INC memory then SBC from A. Increment and subtract in one opcode; useful in counters. |
| `ANC` | AND immediate then copy bit 7 into Carry. Fast signed-to-carry extraction; often used before branch logic. |
| `ASR` | AND immediate then LSR A. Arithmetic right shift with mask. Compact divide-by-2 with masking. |
| `ARR` | AND immediate then ROR A. C64 demos use this in fast crypto / hash-like routines. V and C behavior is complex. |
| `SBX` | A AND X minus immediate into X, sets flags. Fast masked subtraction into X for index arithmetic. |
| `LAS` | M AND S to A, X, S. Loads all three from a memory-AND-stack-pointer result. Rare; useful for restoring a known stack pointer. |
| `NOP` | Illegal NOP variants consume bytes and cycles without side effects. Use for in-place patching without relocating code. |
| `SBC` | Duplicate of documented SBC ($E9). Identical behavior; only exists at $EB. |
| `XAA` | Unstable: (A OR magic) AND X AND immediate to A. Behavior is chip-revision dependent; avoid in production code. |
| `SHA` | Store A AND X AND (addr_high+1). Address-dependent result; used in some C64 copy-protection schemes. |
| `SHX` | Store X AND (addr_high+1). Same quirk as SHA. Used in certain demo effects that exploit address-dependent writes. |
| `SHY` | Store Y AND (addr_high+1). Same quirk. Used similarly to SHX. |
| `SHS` | A AND X to S, then store S AND (addr_high+1). Clobbers stack pointer — dangerous outside deliberate SP tricks. |
| `JAM` | Halts the CPU. In demos: sometimes used as a hard crash sentinel at end of a one-shot effect to catch runaway code. |

## examples
```asm
; LAX: load table byte into both A and X (saves TAX)
; instead of:  LDA table,Y  /  TAX
  LAX table,Y       ; A = X = table[Y], 2 bytes instead of 4

; SAX: store A AND X to zero page without touching flags
  LDA #$F0
  LDX ptr           ; X = address of some pointer
  SAX $FB           ; $FB = A & X = masked pointer, flags intact

; DCP: decrement counter and compare in one instruction
  DCP counter       ; counter-- then CMP A against counter
  BNE loop          ; branch if A != counter (after decrement)

; ANC: AND immediate, copy N into C (fast signed bit extract)
  ANC #$80          ; A &= $80; C = bit7 of original A
  BCS negative      ; branch if original A had bit 7 set

; SLO: shift memory left then OR into A
  SLO flags         ; flags <<= 1; A |= flags (new value)

; Illegal NOP to skip 2 bytes (patch without relocation)
  !byte $89         ; NOP imm -- consumes next byte as dummy operand
  !byte $EA         ; this byte is skipped (treated as NOP operand)
; execution continues here
```

## quirks
- `ARR`: V flag = bit6 XOR bit5 of result; C = bit6. This differs from a plain ROR.
- `XAA`: the "magic constant" ORed into A before the AND varies by chip revision ($00, $EE, $FF are common). Do not rely on it.
- `SHA`/`SHX`/`SHY`/`SHS`: when a page boundary is crossed, the high byte of the effective address is AND-ed with the stored value. The write may go to an unexpected address on page-crossing.
- `SHS` clobbers S (stack pointer). Safe only if the stack is not used between this instruction and the next restore of S.
- `JAM` freezes the CPU permanently until hardware RESET. IRQ/NMI lines are ignored after a JAM.
- Cycle counts for `absolute,X` illegal opcodes include the +1 page-crossing penalty.

## constraints
- Agents MUST label these as illegal/undocumented when generating code for a general audience.
- Agents SHOULD note the assembler directive needed: ACME requires `!byte $xx` for opcodes the assembler does not recognise by mnemonic.
- `unstable` opcodes MUST NOT be used in code targeting multiple revisions or emulators without a compatibility note.
- `JAM` MUST only be used as a deliberate crash sentinel, never in a code path that should return.

## links
- instruction set: [instruction-set.md](instruction-set.md)
- addressing modes: [addressing-modes.md](addressing-modes.md)
- CPU index: [INDEX.md](INDEX.md)

## sources
- local route: [../../sources/INDEX.md](../../sources/INDEX.md)
- opcode bytes and operations: mist64/c64ref src/6502/cpu_6502.txt (VICE mnemonic convention)
- stability and behavior: "NMOS 6510 Unintended Opcodes" (No More Secrets, 2010); "64doc" by John West and Marko Makela
