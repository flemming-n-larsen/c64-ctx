---
type: reference
domain: kernal
granularity: api-family
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

## links
- memory map: [../memory/map.md](../memory/map.md)
- interrupts: [../concepts/interrupts.md](../concepts/interrupts.md)
- jump table: [jump-table.md](jump-table.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- KERNAL index: [INDEX.md](INDEX.md)
- memory map: [../memory/map.md](../memory/map.md)
