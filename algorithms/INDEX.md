---
type: index
domain: algorithms
source: codebase64.net
---

## routes
| need | read | notes |
|---|---|---|
| Sort an array of values | [sort.md](sort.md) | Bubble, shell, quicksort — 8-bit and 16-bit elements |
| Pseudo-random number generator | [rng.md](rng.md) | LFSR, xorshift, tinyrand; X-ABC detail → [../effects/rng.md](../effects/rng.md) |
| Convert between hex and decimal | [number-conversion.md](number-conversion.md) | Hex↔decimal, int→string, sign extension, bit reversal |
| Compress or decompress data | [compression.md](compression.md) | RLE, LZW, LZ77/LZMPI, dictionary; benchmark summary |
| 3D rotation, perspective, backface culling | [3d-math.md](3d-math.md) | Matrix math; cross-reference [../effects/vectors.md](../effects/vectors.md) for rendering |

## pages
<!-- GENERATED:routes -->
_Every page in this domain is reached from `## routes` above._
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Math | [../math/INDEX.md](../math/INDEX.md) | Arithmetic primitives used by algorithms (multiply, fixed-point) |
| Effects | [../effects/INDEX.md](../effects/INDEX.md) | RNG usage (fire, starfield); sprite sort; 3D rendering pipeline |
| CPU | [../cpu/6502/INDEX.md](../cpu/6502/INDEX.md) | `LSR`/`ROL` for LFSR; `ASL`/`LSR` for sort comparisons |
| Concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Timing and zero-page constraints relevant to algorithm loops |
