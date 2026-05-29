---
type: reference
domain: math
granularity: atomic
---

## facts
- Integer exponentiation on 6502 is computed via repeated multiplication: `x^n = x * x * ... * x` (n times).
- Fast exponentiation (exponentiation by squaring) reduces multiplications to O(log n) by squaring and multiplying only on set bits of the exponent.
- Floating-point exponentiation (`x^y` for real y) uses the identity `x^y = e^(y * ln(x))` via BASIC ROM `EXP` and `LOG` entries.
- Powers of 2 are trivially computed with `ASL` shifts; a 256-byte table covers 2^0..2^7 for bit masks.

## lookup
| case | method | cost |
|---|---|---|
| x^2 (square) | multiply routine or square table | see [multiply.md](multiply.md) |
| x^n (integer n, small) | repeated multiply | n−1 multiplies |
| x^n (integer n, large) | exponentiation by squaring | O(log n) multiplies |
| x^y (real y) | `EXP(y * LOG(x))` via BASIC ROM | float cost; BASIC ROM required |
| 2^n (n=0..7) | `ASL`-chain or bit-mask table | 1–7 cycles |

## sequence
Exponentiation by squaring (x^n, both 8-bit unsigned):
```
; base in A, exponent in X
; result in result (16-bit or 8-bit depending on magnitude)
    LDA #1
    STA result      ; result = 1
exp_loop:
    TXA
    BEQ done        ; exponent = 0, return 1
    LSR             ; test LSB of exponent
    TAX
    BCC skip_mul
    ; result *= base
    LDA result
    JSR mul_by_base ; multiply result by base
    STA result
skip_mul:
    ; base *= base (square it)
    LDA base
    JSR square_base
    STA base
    JMP exp_loop
done:
    RTS
```

Real exponentiation via BASIC ROM (x^y):
```
; Compute x^y = EXP(y * LOG(x))
    JSR load_x_to_fac   ; FAC = x
    JSR $B9EA            ; LOG: FAC = ln(x)
    JSR multiply_fac_y   ; FAC = FAC * y
    JSR $BFB4            ; EXP: FAC = e^FAC
```

## constraints
- Integer exponentiation can overflow quickly; 8-bit base with n ≥ 3 likely overflows an 8-bit result.
- BASIC ROM `EXP`/`LOG` require BASIC ROM banked in — see [float.md](float.md) for constraints.
- Exponentiation by squaring MUST handle the case where exponent = 0 (result = 1) and exponent = 1 (result = base).

## links
- math: [multiply.md](multiply.md)
- math: [float.md](float.md)
- math: [logarithm.md](logarithm.md)

## sources
- codebase64.net: [Exponentiation](https://codebase64.net/doku.php?id=base:exponentiation) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
