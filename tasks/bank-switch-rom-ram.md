---
type: reference
domain: tasks
granularity: recipe
summary: "Switch ROM, RAM and I/O in and out safely, including the IRQ hazard."
keywords: [bank switching, ROM to RAM, banking recipe, IRQ hazard]
---

## sequence
1. Read [../io/processor-port.md](../io/processor-port.md) before changing `$0001`.
2. Preserve unrelated `$0001` bits with read-modify-write unless intentionally controlling cassette lines.
3. Set `LORAM`/`HIRAM`/`CHAREN` bits for the needed visibility at `$A000-$BFFF`, `$D000-$DFFF`, and `$E000-$FFFF`.
4. Avoid KERNAL calls/interrupt behavior that requires hidden ROM while it is banked out.
5. Restore a safe banking state before returning to BASIC/KERNAL-managed code.

## lookup
| goal | required topic | read |
|---|---|---|
| Access RAM under BASIC ROM | `LORAM`/`HIRAM` behavior | [../concepts/memory-banking.md](../concepts/memory-banking.md) |
| Access RAM under KERNAL ROM | `HIRAM` behavior and interrupt safety | [../memory/kernal-rom.md](../memory/kernal-rom.md) |
| Access I/O registers | `CHAREN` plus ROM configuration | [../memory/io-area.md](../memory/io-area.md) |
| Access character ROM | `$D000-$DFFF` banking | [../concepts/character-sets.md](../concepts/character-sets.md) |
| Keep cassette lines intact | `$0001` non-banking bits | [../io/processor-port.md](../io/processor-port.md) |

## constraints
- Code MUST treat `$0000` as data direction and `$0001` as port data; they are not interchangeable.
- Code SHOULD use read-modify-write on `$0001` to avoid unintended cassette side effects.
- Agents MUST explain banking state when naming `$A000`, `$D000`, or `$E000` targets.
- Interrupt-sensitive code SHOULD use `SEI`/`CLI` and vector safety rules from [../irq/raster-interrupt.md](../irq/raster-interrupt.md) and [../irq/overview.md](../irq/overview.md).

## links
- processor port: [../io/processor-port.md](../io/processor-port.md)
- memory banking: [../concepts/memory-banking.md](../concepts/memory-banking.md)
- memory map: [../memory/map.md](../memory/map.md)
- KERNAL ROM: [../memory/kernal-rom.md](../memory/kernal-rom.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- task index: [INDEX.md](INDEX.md)
- banking: [../concepts/memory-banking.md](../concepts/memory-banking.md)
- processor port: [../io/processor-port.md](../io/processor-port.md)
