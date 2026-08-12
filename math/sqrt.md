---
type: reference
domain: math
granularity: atomic
summary: "Integer square root by iteration or table lookup, 16- and 24-bit."
keywords: [square root, sqrt, Newton-Raphson, table lookup]
---

## facts
- Integer square root on 6502 is typically computed iteratively (Newton-Raphson or binary search) or via a pre-computed table lookup.
- The fast sqrt uses the inverse relationship to the square table used by multiply: if a 512-byte square table exists, sqrt can be found by binary search or a 256-byte inverse lookup.
- 16-bit and 24-bit sqrt extend the algorithm to wider input ranges with more iteration steps.
- Result is always the integer floor: `sqrt(n)` returns the largest integer `r` such that `r*r ≤ n`.

## lookup
| variant | input | output | notes |
|---|---|---|---|
| Fast 8-bit (table inverse) | 8-bit | 4-bit | Requires square table; lookup in ~10 cycles |
| Newton-Raphson iterative | 16-bit | 8-bit | ~100–200 cycles; no table needed |
| 16-bit and 24-bit | 16/24-bit | 8/12-bit | Extended shift-subtract method |

## sequence
Binary-search sqrt (16-bit input → 8-bit result):
```
; Input: num_lo/num_hi (16-bit)
; Output: A = floor(sqrt(num))
    LDA #0
    STA root
    LDX #7           ; 8 bits, start from bit 7
bit_loop:
    SEC
    LDA root
    ORA pow2,X      ; set trial bit
    STA trial
    ; compute trial*trial (use multiply routine)
    JSR square      ; result in sq_lo/sq_hi
    LDA sq_hi
    CMP num_hi
    BCC accept
    BNE next        ; sq > num, reject
    LDA sq_lo
    CMP num_lo
    BCS accept      ; sq <= num, accept (BCS = >=, but we want <=...)
    BCC next
accept:
    STX tmp_x
    LDA trial
    STA root
    LDX tmp_x
next:
    DEX
    BPL bit_loop
    LDA root
    RTS

pow2: .byte 1,2,4,8,16,32,64,128
```

## constraints
- The result is always `floor(sqrt(n))`; there is no rounding-to-nearest on 6502 without additional correction.
- If the square table from [multiply.md](multiply.md) is available, an inverse-table lookup gives the result in ~10 cycles for inputs ≤ 255.
- 24-bit sqrt requires intermediate 48-bit partial products; implementation complexity increases significantly.

## links

- math: [multiply.md](multiply.md)
- math: [fixed-point.md](fixed-point.md)

## sources

- codebase64.net: [Fast sqrt](https://codebase64.net/doku.php?id=base:fast_sqrt) — CC BY-NC-SA 4.0
- codebase64.net: [16-bit and 24-bit sqrt](https://codebase64.net/doku.php?id=base:16bit_and_24bit_sqrt) — CC BY-NC-SA 4.0
