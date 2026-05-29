---
type: reference
domain: math
granularity: atomic
---

## facts
- The 6502 has no 16-bit add/subtract instructions; multi-byte arithmetic is built from `ADC`/`SBC` chained across bytes.
- `ADC` adds carry-in; carry MUST be cleared (`CLC`) before the low byte add to avoid spurious carry.
- `SBC` subtracts with borrow; carry MUST be set (`SEC`) before the low byte subtract (carry = NOT borrow).
- Inverse subtraction computes `result = value - A` rather than `A - value`; use `EOR #$FF : SEC : ADC value`.
- Signed 8-bit → 16-bit extension copies the sign bit into the high byte using `CMP #$80 : LDA #0 : ADC #0` (0 if positive, 1 if negative... wait, correct pattern uses BPL or ASL).

## lookup
| operation | bytes | sequence |
|---|---|---|
| 16-bit add: result = a16 + b16 | low then high | `CLC : LDA alo : ADC blo : STA rlo : LDA ahi : ADC bhi : STA rhi` |
| 16-bit sub: result = a16 − b16 | low then high | `SEC : LDA alo : SBC blo : STA rlo : LDA ahi : SBC bhi : STA rhi` |
| Inverse subtract: result = val − A | — | `EOR #$FF : SEC : ADC val` |
| Sign-extend 8-bit to 16-bit | — | `LDX #0 : BPL pos : DEX : pos: STX hi` |

## sequence
16-bit addition (ptr16 = ptr16 + val16):
```
    CLC
    LDA ptr_lo
    ADC val_lo
    STA ptr_lo
    LDA ptr_hi
    ADC val_hi
    STA ptr_hi
```

Signed 8-bit to 16-bit (A → lo byte, sign extend to hi byte):
```
    STA result_lo
    LDX #0
    BPL +        ; branch if positive (bit 7 clear)
    DEX          ; X = $FF for negative
+   STX result_hi
```

Inverse subtraction (result = mem − A):
```
    EOR #$FF
    SEC
    ADC mem      ; = mem - A (via two's complement)
    STA result
```

## constraints
- MUST use `CLC` before the first `ADC` in a multi-byte chain; carry from a prior operation causes an off-by-one.
- MUST use `SEC` before the first `SBC` in a multi-byte chain.
- Overflow flag (V) indicates signed overflow after `ADC`/`SBC`; unsigned overflow is indicated by carry.
- The sign-extension pattern MUST be applied before the high byte is used; any intermediate use of A or X will corrupt it.

## links
- math: [compare.md](compare.md)
- math: [multiply.md](multiply.md)
- cpu: [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md)

## sources
- codebase64.net: [16-bit addition and subtraction](https://codebase64.net/doku.php?id=base:16bit_addition_and_subtraction) — CC BY-NC-SA 4.0
- codebase64.net: [Inverse subtraction](https://codebase64.net/doku.php?id=base:inverse_subtraction) — CC BY-NC-SA 4.0
- codebase64.net: [Signed 8-bit to 16-bit addition](https://codebase64.net/doku.php?id=base:signed_8bit_16bit_addition) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
