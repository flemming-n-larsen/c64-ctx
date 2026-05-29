---
type: index
domain: algorithms
source: codebase64
---

## routes
| need | read | notes |
|---|---|---|
| Sort an array of values | [sort.md](sort.md) | Bubble, shell, quicksort — 8-bit and 16-bit elements |
| Pseudo-random number generator | [rng.md](rng.md) | LFSR, xorshift, tinyrand; X-ABC detail → [../effects/rng.md](../effects/rng.md) |
| Convert between hex and decimal | [number-conversion.md](number-conversion.md) | Hex↔decimal, int→string, sign extension, bit reversal |
| Compress or decompress data | [compression.md](compression.md) | RLE, LZW, LZ77/LZMPI, dictionary; benchmark summary |
| 3D rotation, perspective, backface culling | [3d-math.md](3d-math.md) | Matrix math; cross-reference [../effects/vectors.md](../effects/vectors.md) for rendering |

## source-coverage
| local file | status | notes |
|---|---|---|
| [sort.md](sort.md) | used | codebase64.net sorting sub-pages |
| [rng.md](rng.md) | used | codebase64.net RNG sub-pages; X-ABC detail in [../effects/rng.md](../effects/rng.md) |
| [number-conversion.md](number-conversion.md) | used | codebase64.net number conversion sub-pages |
| [compression.md](compression.md) | used | codebase64.net packing/crunching sub-pages |
| [3d-math.md](3d-math.md) | used | codebase64.net 3D art sub-pages |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | codebase64.net upstream route |

## related
| domain | read | why |
|---|---|---|
| Math | [../math/INDEX.md](../math/INDEX.md) | Arithmetic primitives used by algorithms (multiply, fixed-point) |
| Effects | [../effects/INDEX.md](../effects/INDEX.md) | RNG usage (fire, starfield); sprite sort; 3D rendering pipeline |
| CPU | [../cpu/6502/INDEX.md](../cpu/6502/INDEX.md) | `LSR`/`ROL` for LFSR; `ASL`/`LSR` for sort comparisons |
| Concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Timing and zero-page constraints relevant to algorithm loops |
