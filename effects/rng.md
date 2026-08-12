---
type: reference
domain: effects
granularity: atomic
summary: "The X-ABC pseudo-random generator: 38 cycles, 28 bytes, 8- or 16-bit output."
keywords: [RNG, PRNG, X-ABC, random numbers, fast random]
---

## facts
- The X-ABC algorithm is a fast 8/16-bit pseudo-random number generator for 6502/6510 assembly; it costs 38 cycles (excluding `RTS`) and occupies 28 bytes.
- Four zero-page state variables (x, a, b, c) are updated via XOR and addition each call.
- The `C` (accumulator) output is used for 8-bit random numbers; the `B` output is used as the high byte for 16-bit random numbers.
- The routine uses self-modifying code and MUST NOT run from ROM.

## sequence

```
; Zero-page state: x1, a1, b1, c1 (4 bytes)
; Call: JSR rng
; Returns: A = 8-bit random value (c state)
;          Y preserved, X incremented

rng:
    INX              ; x += 1
    STX x1+1        ; self-modify: operand of next LDA
x1: LDA #0          ; A = x state
    EOR b1+1        ; A ^= b
    STA a1+1        ; store as a
    LDA b1+1        ; A = b
    ADC c1+1        ; A += c + carry
    STA b1+1        ; store as b (16-bit high byte)
c1: LDA #0          ; A = c state
    ADC a1+1        ; A += a
    STA c1+1        ; store as c (8-bit result)
a1: LDA #0          ; (used as scratch above)
b1: LDA #0          ; (used as scratch above)
    RTS
```

## lookup
| output | use | description |
|---|---|---|
| `A` register on return | 8-bit random | Value of `c` state after update |
| `b1+1` memory | 16-bit high byte | Combine with `A` for 16-bit result |
| X register | State counter | Incremented each call; contributes to sequence |

| property | value |
|---|---|
| Cycle cost | 38 (excl. `RTS`) |
| Code size | 28 bytes |
| State size | 4 zero-page bytes |
| Period | Long pseudo-random sequence |
| Self-modifying | Yes — MUST be in RAM |

## constraints
- MUST place routine in RAM; self-modification fails in ROM or ROM-mapped regions.
- X register is used as state; callers MUST NOT rely on X being preserved across calls.
- Seed the state variables (x1, a1, b1, c1) with non-zero values before first call for best sequence quality; all-zero seed produces a degenerate sequence.
- For fire ([fire.md](fire.md)) or starfield ([starfield.md](starfield.md)) seeding, call once per cell where randomness is needed.

## sources

- codebase64.net: [X ABC Random Number Generator (8/16-bit)](https://codebase64.net/doku.php?id=6502_6510_maths:x_abc_random_number_generator_8_16_bit) — EternityForest (algorithm), Wil (C64 implementation) — CC BY-NC-SA 4.0
- effects: [fire.md](fire.md)
- effects: [starfield.md](starfield.md)
- effects: [plasma.md](plasma.md)
- memory: [../memory/zero-page.md](../memory/zero-page.md)
