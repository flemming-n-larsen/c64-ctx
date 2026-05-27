---
type: reference
domain: io
granularity: chip
---

## facts
- `$DD00-$DDFF` is a `MOS 6526 Complex Interface Adapter` block in the local I/O pages.
- `$DD00` is data port `A` for serial bus, RS-232, and VIC bank-related signals in the local I/O pages.
- CIA2 is the default route for serial bus hardware and VIC bank selection context in this index.

## lookup
| range / register | role | route |
|---|---|---|
| `$DD00-$DDFF` | CIA2 block | Serial bus, RS-232, VIC bank select, timers, NMI. |
| `$DD00` | Port `A` | Serial bus / RS-232 / VIC bank-related port. |
| CIA timers | Timer `A`, timer `B` | Use source rows for exact register addresses. |
| CIA NMI control | Interrupt flags/mask | Use with [../concepts/interrupts.md](../concepts/interrupts.md). |

## constraints
- Agents MUST distinguish CIA2 NMI behavior from CIA1 IRQ behavior.
- VIC bank selection facts SHOULD be cross-linked with [vic-ii.md](vic-ii.md) and [../concepts/screen-memory.md](../concepts/screen-memory.md).
- Serial-bus recipes SHOULD prefer KERNAL API calls unless direct hardware programming is explicitly requested.

## links
- serial KERNAL: [../kernal/serial-bus.md](../kernal/serial-bus.md)
- screen memory: [../concepts/screen-memory.md](../concepts/screen-memory.md)
- VIC-II: [vic-ii.md](vic-ii.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- I/O index: [INDEX.md](INDEX.md)
- memory I/O area: [../memory/io-area.md](../memory/io-area.md)
