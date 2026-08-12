---
type: index
domain: math
source: codebase64.net
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

## pages
<!-- GENERATED:routes -->
_Every page in this domain is reached from `## routes` above._
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Algorithms | [../algorithms/INDEX.md](../algorithms/INDEX.md) | Sorting, RNG, compression, 3D math |
| Effects | [../effects/INDEX.md](../effects/INDEX.md) | Plasma (sine tables), fractals (fixed-point iteration), RNG |
| Concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Optimization: square-table multiply identity, sine table layout |
| CPU | [../cpu/6502/INDEX.md](../cpu/6502/INDEX.md) | `ADC`/`SBC`/`ROL`/`ROR` — core arithmetic opcodes |
