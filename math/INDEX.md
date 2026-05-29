---
type: index
domain: math
source: codebase64
---

## routes
| need | read | notes |
|---|---|---|
| Compare two 8-bit or 16-bit values | [compare.md](compare.md) | Ranged 8-bit, absolute 16-bit, signed 16-bit |
| 16-bit addition or subtraction | [add-sub.md](add-sub.md) | Multi-byte add/sub; inverse subtract; signed 8→16 |
| Multiply two values | [multiply.md](multiply.md) | 8×8, 16×16, table-based square identity, fastest variants |
| Divide two values | [divide.md](divide.md) | 8-bit, 16-bit, 24-bit; divide-by-constant; ASR |
| Square root | [sqrt.md](sqrt.md) | Fast sqrt; 16-bit and 24-bit variants |
| Sine, cosine, atan2, distance | [trig.md](trig.md) | Sine table gen (BASIC + ASM), 8-bit atan2, CORDIC, distance approx |
| Fixed-point arithmetic, numerical systems | [fixed-point.md](fixed-point.md) | Two's complement, fixed-point, unsigned/signed representations |
| Floating-point on 6502 | [float.md](float.md) | KERNAL float routines; Rankin's software float library |
| Logarithm table | [logarithm.md](logarithm.md) | 8-bit log table generator routine |
| Exponentiation | [exponentiation.md](exponentiation.md) | Power function for 6502 |

## source-coverage
| local file | status | notes |
|---|---|---|
| [compare.md](compare.md) | used | codebase64.net base:8-bit_ranged_comparison, base:16-bit_absolute_comparison, base:16-bit_comparison |
| [add-sub.md](add-sub.md) | used | codebase64.net base:16bit_addition_and_subtraction, base:inverse_subtraction, base:signed_8bit_16bit_addition |
| [multiply.md](multiply.md) | used | codebase64.net 13 multiplication sub-pages |
| [divide.md](divide.md) | used | codebase64.net 5 division sub-pages |
| [sqrt.md](sqrt.md) | used | codebase64.net base:fast_sqrt, base:16bit_and_24bit_sqrt |
| [trig.md](trig.md) | used | codebase64.net 5 trigonometric sub-pages |
| [fixed-point.md](fixed-point.md) | used | codebase64.net base:fixed_point_arithmethic, base:two_s_complement_system, base:numerical_systems |
| [float.md](float.md) | used | codebase64.net base:floating_point_routines_for_the_6502, base:kernal_floating_point_mathematics |
| [logarithm.md](logarithm.md) | used | codebase64.net base:8bit_logarithm_table_generator_routine |
| [exponentiation.md](exponentiation.md) | used | codebase64.net base:exponentiation |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | codebase64.net upstream route |

## related
| domain | read | why |
|---|---|---|
| Algorithms | [../algorithms/INDEX.md](../algorithms/INDEX.md) | Sorting, RNG, compression, 3D math |
| Effects | [../effects/INDEX.md](../effects/INDEX.md) | Plasma (sine tables), fractals (fixed-point iteration), RNG |
| Concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Optimization: square-table multiply identity, sine table layout |
| CPU | [../cpu/6502/INDEX.md](../cpu/6502/INDEX.md) | `ADC`/`SBC`/`ROL`/`ROR` — core arithmetic opcodes |
