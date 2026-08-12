---
type: reference
domain: kernal
granularity: api-family
summary: "KERNAL calls that report or move the memory boundaries used by BASIC and the OS."
keywords: [MEMBOT, MEMTOP, memory boundaries, KERNAL memory calls]
---

## lookup
| symbol | address | category | compact contract |
|---|---:|---|---|
| `MEMTOP` | `$FF99` | `MEM` | Read/set top of memory. |
| `MEMBOT` | `$FF9C` | `MEM` | Read/set bottom of memory. |
| `IOBASE` | `$FFF3` | `MEM` | Return base address of I/O devices. |
| `RAMTAS` | `$FF87` | `MEM` | Initialize RAM and system buffers. |
| `VECTOR` | `$FF8D` | `SYS` | Read/set RAM vectors. |
| `RESTOR` | `$FF8A` | `SYS` | Restore default vectors. |

## constraints
- Agents SHOULD use [../memory/map.md](../memory/map.md) for address ranges and this page for KERNAL API calls.
- Code that changes vectors MUST understand whether it is changing CPU vectors, KERNAL RAM vectors, or device interrupt state.
- Exact register contracts MUST be verified in the local KERNAL API pages before use.

## sources

- KERNAL index: [INDEX.md](INDEX.md)
- memory map: [../memory/map.md](../memory/map.md)
- interrupts: [../irq/overview.md](../irq/overview.md)
- jump table: [jump-table.md](jump-table.md)
