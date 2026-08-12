---
type: reference
domain: math
granularity: atomic
summary: "Software multiplication: shift-add, and the fast square-table identity."
keywords: [multiply, multiplication routine, square table, shift and add]
---

## facts
- The 6502 has no multiply instruction; all multiplication is implemented in software.
- The fastest general 8×8→16 technique uses a pre-computed 512-byte square table exploiting the identity `x*y = ((x+y)²/4) − ((x−y)²/4)`.
- Table-based multiplication trades ~512 bytes of memory for 10–20 cycle multiply times vs. 50–150 cycles for shift-and-add.
- Multiplying by a power of two is a single `ASL` (×2) or chain of shifts; multiplying by a constant can be decomposed into shifts and adds.
- 16×16→32 multiply requires four 8×8 partial products and 16-bit additions.

## lookup
| variant | input | output | approx cycles | table RAM |
|---|---|---|---|---|
| 8×8 shift-and-add | 2 × 8-bit | 8-bit (lo only) | ~50–70 | none |
| 8×8 → 16-bit shift-and-add | 2 × 8-bit | 16-bit | ~70–100 | none |
| 8×8 → 16-bit square table | 2 × 8-bit | 16-bit | ~10–20 | 512 bytes (sqrlo+sqrhi) |
| 8×8 → 16-bit fastest (2023) | 2 × 8-bit | 16-bit | ~7–10 | larger table |
| 16×16 → 32-bit | 2 × 16-bit | 32-bit | ~60–100 | varies |
| Multiply by constant N | 8-bit | varies | minimal | none |

Square table identity:
```
x * y = (sqr(x+y) - sqr(x-y)) / 4
```
Store `sqrlo[n] = (n*n/4) & $FF` and `sqrhi[n] = (n*n/4) >> 8` for n = 0..511 (using signed offset: tables indexed by `x+y+128` and `|x−y|`).

## sequence
8×8 → 16-bit using square tables (A = factor1, X = factor2 → result_lo/hi):
```
; Tables: sqrlo[512], sqrhi[512], placed at page boundary
; Inputs: A = x (0..255), X = y (0..255)

    STX tmp
    CLC
    ADC tmp            ; A = x + y
    TAX
    LDA sqrhi,X        ; hi part of (x+y)²/4
    STA tmp_hi
    LDA sqrlo,X        ; lo part
    STA tmp_lo
    ; compute |x - y|
    LDA factor1
    SEC
    SBC factor2
    BPL +
    EOR #$FF
    ADC #1             ; absolute value
+   TAX
    SEC
    LDA tmp_lo
    SBC sqrlo,X        ; result_lo = sqr(x+y) - sqr(x-y)
    STA result_lo
    LDA tmp_hi
    SBC sqrhi,X
    STA result_hi
```

Multiply by constant (example: A × 5 = A×4 + A):
```
    STA tmp
    ASL              ; A×2
    ASL              ; A×4
    CLC
    ADC tmp          ; A×5
```

## constraints
- Square table method requires both operands to be in range 0–255; the table indices `x+y` and `|x−y|` must stay within 0–511.
- Table MUST be aligned to a page boundary for the indexed addressing to work correctly.
- 16×16→32 result accumulates carry across four partial products; intermediate overflows MUST be handled with `ADC #0` carry propagation.
- Multiplying signed values requires sign handling before or after the unsigned multiply (negate result if signs differ).
- See [../concepts/optimization.md](../concepts/optimization.md) for the square-table layout used in this project's optimization reference.

## sources

- codebase64.net: [8-bit multiplication 16-bit product](https://codebase64.net/doku.php?id=base:8bit_multiplication_16bit_product) — CC BY-NC-SA 4.0
- codebase64.net: [Seriously fast multiplication](https://codebase64.net/doku.php?id=base:seriously_fast_multiplication) — CC BY-NC-SA 4.0
- codebase64.net: [Fastest multiplication (2023)](https://codebase64.net/doku.php?id=base:fastest_multiplication_2023) — CC BY-NC-SA 4.0
- codebase64.net: [16-bit multiplication 32-bit product](https://codebase64.net/doku.php?id=base:16bit_multiplication_32-bit_product) — CC BY-NC-SA 4.0
- codebase64.net: [Multiplication with a constant](https://codebase64.net/doku.php?id=base:multiplication_with_a_constant) — CC BY-NC-SA 4.0
- codebase64.net: [Table generator for fast 8-bit mul table](https://codebase64.net/doku.php?id=base:table_generator_routine_for_fast_8_bit_mul_table) — CC BY-NC-SA 4.0
- math: [add-sub.md](add-sub.md)
- math: [divide.md](divide.md)
- math: [fixed-point.md](fixed-point.md)
- concepts: [../concepts/optimization.md](../concepts/optimization.md)
