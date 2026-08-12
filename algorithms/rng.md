---
type: reference
domain: algorithms
granularity: atomic
summary: "Pseudo-random generators for 6502: LFSR, xorshift and tinyrand."
keywords: [RNG, PRNG, LFSR, xorshift, random seed]
---

## facts
- A PRNG (pseudo-random number generator) produces a deterministic sequence that passes statistical randomness tests; the same seed always produces the same sequence.
- LFSRs (Linear Feedback Shift Registers) are fast, small, and have provably long periods; they use XOR of tapped bits.
- Xorshift generators use three XOR-shift operations; a 16-bit xorshift needs no tables and runs in ~20 cycles.
- Tiny generators (tinyrand8, tinyrand16) prioritize minimal code size (< 10 bytes) at some cost to statistical quality.
- For the X-ABC generator (38 cycles, 28 bytes, zero-page state) see [../effects/rng.md](../effects/rng.md).
- Seeding from CIA timer register values provides hardware-sourced entropy for initial state.

## lookup
| generator | period | output | cycles | bytes | notes |
|---|---|---|---|---|---|
| X-ABC (8-bit) | long | 8-bit | 38 | 28 | Detail: [../effects/rng.md](../effects/rng.md) |
| X-ABC (16-bit) | long | 16-bit | ~45 | ~35 | B output as high byte |
| 16-bit xorshift | 65535 | 16-bit | ~20 | ~15 | Simple, no tables |
| 32-bit Galois LFSR | 2³²−1 | 32-bit | ~30 | ~20 | Maximal length |
| Flexible Galois LFSR | varies | 8–32-bit | varies | varies | Configurable tap polynomial |
| 16-bit LFSR (simple) | 65535 | 16-bit | ~15 | ~12 | Classic tapped shift register |
| tinyrand8 | short | 8-bit | ~10 | ~8 | Minimal size |
| tinyrand16 | moderate | 16-bit | ~15 | ~10 | Compact 16-bit |
| AX tinyrand8 | short | 8-bit | ~8 | ~6 | Extremely small |
| Ranged 8-bit (even dist.) | — | 0..N−1 | +10–20 | — | Rejection sampling or scaling |
| BASIC RND() | long | float | slow | — | BASIC ROM; not for assembly |

16-bit xorshift (state in `rng_lo`/`rng_hi`):
```
rng:
    LDA rng_hi
    LSR
    LDA rng_lo
    ROR
    EOR rng_hi
    STA rng_hi
    ROR
    EOR rng_lo
    STA rng_lo
    TAX
    LDA rng_hi
    RTS
```

32-bit Galois LFSR (state in `lfsr0`–`lfsr3`, tap polynomial `$B4BCD35C`):
```
lfsr_step:
    LSR lfsr3
    ROR lfsr2
    ROR lfsr1
    ROR lfsr0
    BCC no_tap
    LDA lfsr3
    EOR #$B4
    STA lfsr3
    LDA lfsr2
    EOR #$BC
    STA lfsr2
    LDA lfsr1
    EOR #$D3
    STA lfsr1
    LDA lfsr0
    EOR #$5C
    STA lfsr0
no_tap:
    RTS
```

## sequence
Seeding from CIA1 timer (hardware entropy):
```
    LDA $DC04        ; CIA1 timer A low byte
    STA rng_lo
    LDA $DC05        ; CIA1 timer A high byte
    STA rng_hi
```

Ranged random number (0..N−1), rejection sampling:
```
; N must be a constant ≤ 128 for efficiency
ranged:
    JSR rng          ; A = 0..255
    CMP #(256 - 256 MOD N)  ; reject values that would bias
    BCS ranged
    ; now use A MOD N
```

## constraints
- MUST seed the PRNG with a non-zero value before first use; an all-zero state causes xorshift and LFSR to produce only zeros.
- X-ABC uses self-modifying code and MUST reside in RAM — see [../effects/rng.md](../effects/rng.md) for details.
- Rejection sampling for ranged values has variable execution time; MUST NOT be used in cycle-critical raster routines.
- LFSR period is exactly `2^n − 1` (never produces the all-zero state); if zero output is required, handle separately.
- CIA timer seeding works only when a timer is running; if the timer is stopped, `$DC04`/`$DC05` hold their last latched value.

## links

- effects: [../effects/rng.md](../effects/rng.md)
- io: [../io/INDEX.md](../io/INDEX.md)
- algorithms: [sort.md](sort.md)

## sources

- codebase64.net: [16-bit xorshift random generator](https://codebase64.net/doku.php?id=base:16bit_xorshift_random_generator) — CC BY-NC-SA 4.0
- codebase64.net: [32-bit Galois LFSR](https://codebase64.net/doku.php?id=base:32bit_galois_lfsr) — CC BY-NC-SA 4.0
- codebase64.net: [Two very fast 16-bit pseudo-random generators as LFSR](https://codebase64.net/doku.php?id=base:two_very_fast_16bit_pseudo_random_generators_as_lfsr) — CC BY-NC-SA 4.0
- codebase64.net: [16-bit pseudo-random generator](https://codebase64.net/doku.php?id=base:16bit_pseudo_random_generator) — CC BY-NC-SA 4.0
- codebase64.net: [Small fast 8-bit PRNG](https://codebase64.net/doku.php?id=base:small_fast_8-bit_prng) — CC BY-NC-SA 4.0
- codebase64.net: [Small fast 16-bit PRNG](https://codebase64.net/doku.php?id=base:small_fast_16-bit_prng) — CC BY-NC-SA 4.0
- codebase64.net: [AX tinyrand8](https://codebase64.net/doku.php?id=base:ax_tinyrand8) — CC BY-NC-SA 4.0
- codebase64.net: [Ranged random numbers with even distribution](https://codebase64.net/doku.php?id=base:ranged_random_numbers_with_even_distribution) — CC BY-NC-SA 4.0
- codebase64.net: [Comparison of 6502 random generators](https://codebase64.net/doku.php?id=base:comparison_of_6502_random_generators) — CC BY-NC-SA 4.0
