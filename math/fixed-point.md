---
type: reference
domain: math
granularity: atomic
---

## facts
- The 6502 operates only on integers; fractional arithmetic is done by treating a portion of an integer as the fractional part (fixed-point).
- Fixed-point notation Q(m.n): `m` bits integer part, `n` bits fractional part; stored in `m+n` bits total.
- Multiplying two Q8.8 values produces a Q16.16 result; only the middle 16 bits (Q8.8) are kept.
- Two's complement: negative numbers are represented as `(2^n) − |value|`; addition and subtraction work identically for signed and unsigned.
- The 6502 uses two's complement natively for `ADC`/`SBC`; signed overflow is flagged by V.

## lookup
| concept | definition | example |
|---|---|---|
| Q8.8 | 8-bit integer + 8-bit fraction | $0180 = 1.5 (1 + 128/256) |
| Q4.4 | 4-bit integer + 4-bit fraction | $18 = 1.5 (1 + 8/16) |
| Two's complement negate | `EOR #$FF : ADC #1` (with `CLC` before ADC or use SEC+SBC) | −1 = $FF |
| Arithmetic right shift | `CMP #$80 : ROR` | preserves sign through shift |
| Fixed-point multiply | `(a * b) >> n` where n = fractional bits | Q8.8 × Q8.8 → keep bits 23..8 |

Numerical systems overview:
| system | base | digits | note |
|---|---|---|---|
| Binary | 2 | 0–1 | native to 6502 |
| Hexadecimal | 16 | 0–9, A–F | `$XX` notation |
| Decimal | 10 | 0–9 | BCD mode via `SED` |
| BCD (packed) | 10 | two decimal digits/byte | `SED`/`CLD` to enable/disable |

## sequence
Negate a signed 8-bit value (two's complement):
```
    EOR #$FF
    CLC
    ADC #1       ; result = -A
```

Negate a 16-bit signed value:
```
    LDA lo
    EOR #$FF
    CLC
    ADC #1
    STA lo
    LDA hi
    EOR #$FF
    ADC #0       ; propagate carry
    STA hi
```

Q8.8 × Q8.8 fixed-point multiply (keep middle 16 bits):
```
; a_lo/a_hi = first Q8.8 operand
; b_lo/b_hi = second Q8.8 operand
; Compute full 32-bit product; result = bits 23..8
    ; Use 16×16→32 multiply (see multiply.md)
    ; result_lo = product byte 1 (fractional)
    ; result_hi = product byte 2 (integer)
```

## constraints
- Fixed-point range MUST be checked before operations; overflow wraps silently on 6502.
- BCD mode (`SED`) affects `ADC`/`SBC` results; MUST be cleared (`CLD`) before binary arithmetic.
- Two's complement sign extension when widening from 8-bit to 16-bit MUST propagate sign via `BPL`/`DEX` pattern — see [add-sub.md](add-sub.md).
- Multiplying two Q8.8 values shifts the binary point; discarding the low byte (`result_lo`) introduces a rounding error of up to 1 LSB of the fractional part.

## links
- math: [multiply.md](multiply.md)
- math: [divide.md](divide.md)
- math: [add-sub.md](add-sub.md)
- algorithms: [../algorithms/3d-math.md](../algorithms/3d-math.md)

## sources
- codebase64.net: [Fixed-point arithmetic](https://codebase64.net/doku.php?id=base:fixed_point_arithmethic) — CC BY-NC-SA 4.0
- codebase64.net: [Two's complement system](https://codebase64.net/doku.php?id=base:two_s_complement_system) — CC BY-NC-SA 4.0
- codebase64.net: [Numerical systems](https://codebase64.net/doku.php?id=base:numerical_systems) — CC BY-NC-SA 4.0
- codebase64.net: [Basic math operations](https://codebase64.net/doku.php?id=base:basic_math_operations) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
