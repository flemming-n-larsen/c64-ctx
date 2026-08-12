---
type: reference
domain: math
granularity: atomic
summary: "Compare 8- and 16-bit values, signed and unsigned, and read the flags right."
keywords: [compare, signed comparison, 16-bit compare, flag results]
---

## facts
- The 6502 `CMP`/`CPX`/`CPY` instructions perform unsigned subtraction and set N, Z, C flags; they do not set V (overflow).
- Signed comparison requires inspecting the N and V flags together after a `CMP` + explicit overflow check, or using the subtraction result directly.
- Ranged comparison (is value within `[lo, hi]`?) on 8-bit values requires two `CMP` + branch pairs.
- 16-bit comparison tests the high bytes first; short-circuits on inequality before checking low bytes.

## lookup
| comparison type | technique | flag check |
|---|---|---|
| 8-bit unsigned equality | `CMP value` | `BEQ` / `BNE` |
| 8-bit unsigned less-than | `CMP value` | `BCC` (A < value if carry clear) |
| 8-bit unsigned greater-or-equal | `CMP value` | `BCS` |
| 8-bit ranged (lo ≤ A ≤ hi) | `SEC : SBC #lo : CMP #(hi-lo+1)` | `BCC` = in range |
| 16-bit unsigned | compare high bytes first, then low | `BEQ`+`BCC`/`BCS` |
| 16-bit signed | subtract 16-bit; check N=V for ≥ 0, N≠V for < 0 | N, V flags |

## sequence
8-bit ranged comparison (is A in [LO, HI]?):
```
    SEC
    SBC #LO        ; A = A - LO
    CMP #(HI-LO+1) ; C clear → in range
    BCC in_range
```

16-bit unsigned comparison (ptr0:ptr1 vs val0:val1, big-endian hi:lo):
```
    LDA ptr1       ; high byte
    CMP val1
    BNE not_equal
    LDA ptr0       ; low byte
    CMP val0
not_equal:
    ; C set → ptr >= val; Z set → equal
```

## constraints
- `CMP` does NOT affect V; use the ranged-subtraction technique for signed comparisons rather than relying on overflow.
- For 16-bit signed comparison, subtract the full 16-bit value with `SEC`/`SBC` across both bytes and then test `N XOR V`.
- Ranged comparison with `SBC` assumes carry is set before the first `SBC`; MUST precede with `SEC`.

## links

- math: [add-sub.md](add-sub.md)
- cpu: [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md)

## sources

- codebase64.net: [8-bit ranged comparison](https://codebase64.net/doku.php?id=base:8-bit_ranged_comparison) — CC BY-NC-SA 4.0
- codebase64.net: [16-bit absolute comparison](https://codebase64.net/doku.php?id=base:16-bit_absolute_comparison) — CC BY-NC-SA 4.0
- codebase64.net: [16-bit comparison](https://codebase64.net/doku.php?id=base:16-bit_comparison) — CC BY-NC-SA 4.0
