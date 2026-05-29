---
type: index
domain: concepts
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| PAL screen dimensions, raster ranges, border heights, sprite Y offset | [screen-geometry.md](screen-geometry.md) | Use when writing border effects or placing sprites in the border area. |
| Banking ROM, RAM, I/O, character ROM | [memory-banking.md](memory-banking.md) | Agents MUST combine this with `$0001` processor-port facts. |
| Zero-page roles and aliases | [zero-page.md](zero-page.md) | Use when memory symbols need behavioral context. |
| IRQ/NMI vectors and interrupt constraints | [interrupts.md](interrupts.md) | Use before writing raster or CIA interrupt code. |
| Screen matrix and color RAM relationship | [screen-memory.md](screen-memory.md) | Use with VIC-II and color RAM pages. |
| PETSCII vs screen code vs keyboard matrix | [character-sets.md](character-sets.md) | Agents MUST NOT conflate code spaces. |
| VIC-II bad lines and CPU cycle theft | [vic-bad-lines.md](vic-bad-lines.md) | Use before writing cycle-exact or raster-timed code. |
| Color mixing — raster tricks, FLI, interlacing, sprite underlay, dithering | [color-mixing.md](color-mixing.md) | The 5 fundamental techniques for expanding beyond 16 hardware colors. |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [memory-banking.md](memory-banking.md) | planned | Banking, ROM/RAM/I/O visibility, and processor-port context. |
| [zero-page.md](zero-page.md), [screen-memory.md](screen-memory.md) | planned | Workspace, vectors, screen matrix, and color RAM context. |
| [interrupts.md](interrupts.md) | planned | Hardware interrupt, vector, and register context. |
| [character-sets.md](character-sets.md) | planned | PETSCII, screen-code, and keyboard-matrix distinctions. |
| [screen-geometry.md](screen-geometry.md) | used | PAL visible area, raster ranges, border heights, sprite Y offset. |
| [vic-bad-lines.md](vic-bad-lines.md) | used | Bad line condition, cycle cost, YSCROLL trick, frame budget. |
| [color-mixing.md](color-mixing.md) | used | Raster color tricks, FLI, interlacing, sprite underlay, dithering. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Central upstream fallback route. |

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | Address ranges and symbols. |
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II, SID, CIA, processor port. |
| Charset | [../charset/INDEX.md](../charset/INDEX.md) | Character encodings and keyboard data. |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Practical recipes that combine concepts. |
