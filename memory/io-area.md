---
type: reference
domain: memory
granularity: address-range
---

## lookup
| range | visible when I/O selected | primary page | notes |
|---|---|---|---|
| `$D000-$D02E` | `VIC-II` registers | [../io/vic-ii.md](../io/vic-ii.md) | the local I/O pages labels this as MOS `6566` video interface controller. |
| `$D400-$D7FF` | `SID` registers | [../io/sid.md](../io/sid.md) | Sound interface device. |
| `$D800-$DBFF` | Color RAM nybbles | [../io/color-ram.md](../io/color-ram.md) | Stores 4-bit color values. |
| `$DC00-$DCFF` | `CIA1` registers | [../io/cia1.md](../io/cia1.md) | Keyboard, joystick, timers, IRQ. |
| `$DD00-$DDFF` | `CIA2` registers | [../io/cia2.md](../io/cia2.md) | Serial bus, RS-232, VIC bank select, NMI. |
| `$D000-$DFFF` | Character ROM or RAM instead | [../concepts/memory-banking.md](../concepts/memory-banking.md) | Depends on processor-port banking state. |

## constraints
- CPU access to `$D000-$DFFF` MUST be interpreted through the current `$0001` `CHAREN`, `HIRAM`, and `LORAM` state.
- Agents MUST NOT assume `$D000-$DFFF` always means I/O registers.
- Color RAM at `$D800-$DBFF` SHOULD be treated as nybble-wide storage, not normal 8-bit RAM.

## links
- processor port: [../io/processor-port.md](../io/processor-port.md)
- banking concept: [../concepts/memory-banking.md](../concepts/memory-banking.md)
- I/O index: [../io/INDEX.md](../io/INDEX.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- memory index: [INDEX.md](INDEX.md)
- I/O index: [../io/INDEX.md](../io/INDEX.md)
