---
type: reference
domain: math
granularity: atomic
---

## facts
- The C64 KERNAL includes a 5-byte IEEE-like floating-point library inherited from Microsoft BASIC; entry points are in BASIC ROM.
- BASIC ROM float format: 1 byte exponent (excess-128 biased), 4 bytes mantissa (normalized, sign in bit 7 of exponent byte... actually sign in bit 7 of first mantissa byte); 5 bytes total.
- Rankin's floating-point routines provide a standalone software float library for use outside BASIC ROM.
- Float operations via KERNAL require inputs in the BASIC floating-point accumulator (`FAC`) at `$61`–`$66`.

## lookup
| KERNAL float entry | address | operation | notes |
|---|---|---|---|
| `MOVFM` | `$BBA2` | Memory → FAC | Load 5-byte float from address in Y:A |
| `MOVMF` | `$BBD4` | FAC → Memory | Store FAC to address in Y:X |
| `FADD` | `$B86A` | FAC + ARG → FAC | Add ARG to FAC |
| `FSUB` | `$B853` | FAC − ARG → FAC | Subtract ARG |
| `FMULT` | `$BA28` | FAC × ARG → FAC | Multiply |
| `FDIV` | `$BB12` | FAC ÷ ARG → FAC | Divide |
| `LOG` | `$B9EA` | ln(FAC) → FAC | Natural log |
| `INT` | `$BCCC` | floor(FAC) → FAC | Integer part |
| `SQR` | `$BF71` | sqrt(FAC) → FAC | Square root |
| `SIN` | `$E26B` | sin(FAC) → FAC | In radians |
| `COS` | `$E264` | cos(FAC) → FAC | In radians |
| `ATN` | `$E30E` | atan(FAC) → FAC | |
| `EXP` | `$BFB4` | e^FAC → FAC | |

BASIC float format (5 bytes at `$61`):
| byte | field | description |
|---|---|---|
| `$61` | exponent | excess-128; 0 = zero |
| `$62` | mantissa byte 1 | bit 7 = sign; bits 6..0 = mantissa MSBs |
| `$63`–`$65` | mantissa bytes 2–4 | remaining mantissa bits |
| `$66` | ARG copy / scratch | second accumulator |

## constraints
- KERNAL float routines are in BASIC ROM; MUST have BASIC ROM mapped at `$A000`–`$BFFF` (default with banking bits `%001` or `%011`).
- Float operations clobber `$61`–`$70` (FAC, ARG, temporary workspace); MUST NOT rely on these zero-page/low-RAM locations being preserved.
- Rankin's library is self-contained and does not require BASIC ROM; use it when BASIC ROM is banked out.
- Floating-point is slow (~100–1000 cycles per operation); prefer fixed-point (see [fixed-point.md](fixed-point.md)) or table lookups for real-time code.

## links
- math: [fixed-point.md](fixed-point.md)
- math: [trig.md](trig.md)
- math: [logarithm.md](logarithm.md)
- kernal: [../kernal/INDEX.md](../kernal/INDEX.md)
- memory: [../memory/INDEX.md](../memory/INDEX.md)

## sources
- codebase64.net: [Floating point routines for the 6502](https://codebase64.net/doku.php?id=base:floating_point_routines_for_the_6502) — Rankin — CC BY-NC-SA 4.0
- codebase64.net: [Errata for Rankin's 6502 floating point routines](https://codebase64.net/doku.php?id=base:errata_for_rankin_s_6502_floating_point_routines) — CC BY-NC-SA 4.0
- codebase64.net: [KERNAL floating point mathematics](https://codebase64.net/doku.php?id=base:kernal_floating_point_mathematics) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
