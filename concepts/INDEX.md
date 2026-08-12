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
| IRQ/NMI vectors and interrupt constraints | [../irq/overview.md](../irq/overview.md) | Canonical interrupt route now lives in `/irq`. |
| Screen matrix and color RAM relationship | [screen-memory.md](screen-memory.md) | Use with VIC-II and color RAM pages. |
| PETSCII vs screen code vs keyboard matrix | [character-sets.md](character-sets.md) | Agents MUST NOT conflate code spaces. |
| VIC-II bad lines and CPU cycle theft | [vic-bad-lines.md](vic-bad-lines.md) | Use before writing cycle-exact or raster-timed code. |
| Color mixing — raster tricks, FLI, interlacing, sprite underlay, dithering | [color-mixing.md](color-mixing.md) | The 5 fundamental techniques for expanding beyond 16 hardware colors. |
| Optimization — speedcoding, tables, zero-page, self-modifying code | [optimization.md](optimization.md) | Cycle-exact technique reference; loop unrolling, runtime speedcode generation, page alignment. |

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| How the EXROM and GAME expansion-port lines combine with $0001 to pick a memory map. | [cartridge-modes.md](cartridge-modes.md) | cartridge, EXROM, GAME, PLA, expansion port, memory config |
| The four distinct character code spaces and why they must never be conflated. | [character-sets.md](character-sets.md) | code spaces, PETSCII vs screen code, character sets, conflation |
| Five techniques for appearing to exceed the fixed 16-color palette. | [color-mixing.md](color-mixing.md) | color mixing, color expansion, interlacing, dithering, sprite underlay |
| Redirect stub: interrupt material now lives in the irq domain. | [interrupts.md](interrupts.md) | interrupts, redirect, moved page |
| How $0001 processor-port bits decide which ROM, RAM, I/O or character ROM the CPU sees. | [memory-banking.md](memory-banking.md) | banking, LORAM, HIRAM, CHAREN, memory configuration |
| Cycle-exact technique reference: unrolling, tables, zero page, self-modifying code. | [optimization.md](optimization.md) | speedcoding, loop unrolling, self-modifying code, page alignment, tables |
| PAL display dimensions, raster line ranges, border extents and the sprite Y offset. | [screen-geometry.md](screen-geometry.md) | screen geometry, border extents, raster ranges, visible area, display window |
| How the screen matrix and color RAM relate, and where each lives. | [screen-memory.md](screen-memory.md) | screen memory, screen matrix, color RAM, cell layout |
| What makes a raster line bad, the cycles it steals, and how to work around it. | [vic-bad-lines.md](vic-bad-lines.md) | bad lines, badline, cycle theft, DMA steal, YSCROLL |
| Why zero page matters: shorter, faster addressing and who already owns it. | [zero-page.md](zero-page.md) | zero page, fast addressing, byte savings, ownership |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | Address ranges and symbols. |
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II, SID, CIA, processor port. |
| IRQ | [../irq/INDEX.md](../irq/INDEX.md) | Canonical interrupt overview, raster setup, stable timing, advanced flow. |
| Charset | [../charset/INDEX.md](../charset/INDEX.md) | Character encodings and keyboard data. |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Practical recipes that combine concepts. |
