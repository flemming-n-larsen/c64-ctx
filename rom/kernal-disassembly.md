---
type: reference
domain: rom
granularity: route
---

## lookup
| range / topic | local route | local companion |
|---|---|---|
| `$E000-$FFFF` | [../memory/kernal-rom.md](../memory/kernal-rom.md) | [../memory/kernal-rom.md](../memory/kernal-rom.md) |
| `$FF81-$FFF3` jump table | [../kernal/jump-table.md](../kernal/jump-table.md) | [../kernal/jump-table.md](../kernal/jump-table.md) |
| IRQ/time routines | [../kernal/time-irq.md](../kernal/time-irq.md) | [../kernal/time-irq.md](../kernal/time-irq.md) |
| Serial and file routines | [../kernal/file-io.md](../kernal/file-io.md) | [../kernal/file-io.md](../kernal/file-io.md) |

## constraints
- Agents MUST prefer documented KERNAL API pages for public calls before implementation disassembly.
- This file SHOULD be used to locate implementation material, not as a complete disassembly.
- Agents MUST account for banking before saying `$E000-$FFFF` reads return KERNAL ROM.

## links
- KERNAL domain: [../kernal/INDEX.md](../kernal/INDEX.md)
- KERNAL ROM memory: [../memory/kernal-rom.md](../memory/kernal-rom.md)
- interrupts: [../irq/overview.md](../irq/overview.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- ROM index: [INDEX.md](INDEX.md)
- KERNAL jump table: [../kernal/jump-table.md](../kernal/jump-table.md)
