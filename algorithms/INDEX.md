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
| answers | read | terms |
|---|---|---|
| 3D rotation, perspective projection and backface culling in fixed point. | [3d-math.md](3d-math.md) | 3D math, rotation matrix, perspective, backface culling, Q8.8 |
| RLE, LZ and dictionary compression for prg files and in-memory data. | [compression.md](compression.md) | compression, RLE, LZ77, LZW, decompression, packing |
| Convert between hex, decimal and strings, plus sign extension and bit reversal. | [number-conversion.md](number-conversion.md) | number conversion, hex to decimal, int to string, bit reversal |
| Pseudo-random generators for 6502: LFSR, xorshift and tinyrand. | [rng.md](rng.md) | RNG, PRNG, LFSR, xorshift, random seed |
| Bubble, shell and quicksort for 8- and 16-bit arrays in RAM. | [sort.md](sort.md) | sorting, bubble sort, shell sort, quicksort, sprite Y sort |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Math | [../math/INDEX.md](../math/INDEX.md) | Arithmetic primitives used by algorithms (multiply, fixed-point) |
| Effects | [../effects/INDEX.md](../effects/INDEX.md) | RNG usage (fire, starfield); sprite sort; 3D rendering pipeline |
| CPU | [../cpu/6502/INDEX.md](../cpu/6502/INDEX.md) | `LSR`/`ROL` for LFSR; `ASL`/`LSR` for sort comparisons |
| Concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Timing and zero-page constraints relevant to algorithm loops |
