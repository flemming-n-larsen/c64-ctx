---
type: reference
domain: math
granularity: atomic
summary: "Software division on 6502: shift-and-subtract, and divide by a constant."
keywords: [divide, division routine, shift and subtract, divide by constant]
---

## facts
- The 6502 has no divide instruction; all division is implemented via repeated subtraction or shift-and-subtract (restoring or non-restoring).
- Dividing by a power of two is a single `LSR` (÷2) or chain of shifts.
- Dividing by a constant can be replaced by a multiply by the reciprocal: `floor(256/N)` gives a fixed-point multiplier for 8-bit quotients.
- Signed ÷ 2 is an arithmetic shift right: `CMP #$80 : ROR` preserves the sign bit correctly.
- 24-bit division extends the 16-bit pattern with an extra byte of dividend and quotient.

## lookup
| variant | dividend | divisor | quotient | remainder | approx cycles |
|---|---|---|---|---|---|
| 8÷8 restoring | 8-bit | 8-bit | 8-bit | 8-bit | ~70–90 |
| 8÷8 by constant | 8-bit | constant | 8-bit | — | ~10–20 (multiply reciprocal) |
| 16÷16 | 16-bit | 16-bit | 16-bit | 16-bit | ~150–200 |
| 24÷24 | 24-bit | 24-bit | 24-bit | 24-bit | ~250+ |
| Signed 8÷2 (ASR) | signed 8-bit | 2 | signed 8-bit | — | 2 cycles |

## sequence
Divide by power of two (A ÷ 2, unsigned):
```
    LSR A
```

Signed divide by 2 (arithmetic shift right, preserves sign):
```
    CMP #$80   ; set carry if A >= $80 (negative)
    ROR A      ; shift right, C rotates into bit 7
```

Divide by constant N (8-bit, using reciprocal multiply):
```
; Precompute K = round(256/N) at assembly time
; result ≈ (A * K) >> 8  (high byte of product)
    LDA dividend
    JSR mul_by_K   ; multiply A by constant K
    LDA result_hi  ; high byte = quotient
```

Generic 8÷8 shift-and-subtract:
```
; dividend in A, divisor in tmp, quotient → A, remainder → remainder
    LDX #8         ; 8 bits
    ASL A          ; shift dividend left
divide_loop:
    ROL remainder  ; rotate partial remainder
    LDA remainder
    SEC
    SBC divisor    ; trial subtract
    BCC no_sub     ; if < 0, skip
    STA remainder  ; accept subtraction
no_sub:
    ROL quotient   ; rotate result bit
    DEX
    BNE divide_loop
```

## constraints
- Integer division truncates toward zero for unsigned values; signed division behavior depends on implementation.
- Reciprocal-multiply for divide-by-constant only produces exact results for values where `A * K` does not overflow the quotient approximation.
- `LSR` for unsigned ÷ 2 sets carry to the shifted-out bit (usable as the remainder bit).
- `ROR` for signed ASR MUST be preceded by `CMP #$80` to set carry correctly from the sign bit.

## links
- math: [multiply.md](multiply.md)
- math: [fixed-point.md](fixed-point.md)
- cpu: [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md)

## sources
- codebase64.net: [8-bit divide 8-bit product](https://codebase64.net/doku.php?id=base:8bit_divide_8bit_product) — CC BY-NC-SA 4.0
- codebase64.net: [8-bit divide by constant 8-bit result](https://codebase64.net/doku.php?id=base:8bit_divide_by_constant_8bit_result) — CC BY-NC-SA 4.0
- codebase64.net: [16-bit division 16-bit result](https://codebase64.net/doku.php?id=base:16bit_division_16-bit_result) — CC BY-NC-SA 4.0
- codebase64.net: [24-bit division 24-bit result](https://codebase64.net/doku.php?id=base:24bit_division_24-bit_result) — CC BY-NC-SA 4.0
- codebase64.net: [Signed 8-bit divide by 2 (ASR)](https://codebase64.net/doku.php?id=base:signed_8bit_divide_by_2_arithmetic_shift_right) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
