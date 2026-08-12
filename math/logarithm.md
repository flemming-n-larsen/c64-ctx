---
type: reference
domain: math
granularity: atomic
summary: "Generate and use an 8-bit logarithm table, or call the ROM LOG entry."
keywords: [logarithm, log table, table generator]
---

## facts
- The 6502 has no log instruction; logarithms are computed via a pre-generated lookup table or via the BASIC ROM `LOG` entry (see [float.md](float.md)).
- An 8-bit log table maps integer inputs 0–255 to 8-bit log values (typically log2 scaled to 0–255).
- A table generator routine computes the table at runtime using BASIC float ROM, then switches to pure assembly for usage.
- Common use: `log2(x)` table for fast multiply-via-log: `x * y = antilog(log(x) + log(y))` (requires matching antilog table).

## lookup
| table | size | input | output | use |
|---|---|---|---|---|
| `log2tab` | 256 bytes | 0–255 | 0–255 (scaled log2) | Fast multiply, audio volume curves |
| `antilog2tab` | 256 bytes | 0–255 | 0–255 | Inverse of log table |

Log-based multiply (approximate, 8-bit):
```
result ≈ antilog[ log[x] + log[y] ]
```
This gives an approximation; error can be ±1 for small values near 0.

## sequence
Runtime log table generation using BASIC ROM float:
```
; Generate log2 table at LOGTAB (256 bytes)
; Uses BASIC ROM float routines — MUST have BASIC ROM mapped

    LDX #0
gen_loop:
    TXA
    BEQ zero_entry      ; log(0) undefined; store 0
    ; convert X to float, call LOG, scale, store
    JSR int_to_float    ; A (= X) → FAC
    JSR $B9EA           ; LOG: ln(FAC) → FAC
    ; scale: multiply by log2(e) = 1/ln(2) ≈ 1.4427
    ; then scale to 0..255 range
    JSR float_scale     ; implementation-specific
    JSR float_to_int    ; FAC → A (0..255)
    STA LOGTAB,X
    INX
    BNE gen_loop
    RTS
zero_entry:
    STA LOGTAB,X        ; store 0 for log(0)
    INX
    BNE gen_loop
    RTS
```

## constraints
- `log(0)` is undefined; table entry for index 0 MUST be assigned a sentinel value (typically 0 or $FF) and callers MUST guard against it.
- Log-via-float table generation requires BASIC ROM mapped; generation MUST complete before banking out.
- Log-multiply approximation is not exact; use only where ±1 LSB error is acceptable (e.g., volume attenuation, audio synthesis, non-critical scaling).

## links
- math: [float.md](float.md)
- math: [multiply.md](multiply.md)
- math: [exponentiation.md](exponentiation.md)

## sources
- codebase64.net: [8-bit logarithm table generator routine](https://codebase64.net/doku.php?id=base:8bit_logarithm_table_generator_routine) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
