---
type: reference
domain: memory
granularity: address-range
---

## facts
- `$E000-$FFFF` is the normal KERNAL ROM window when KERNAL ROM is banked in.
- `$0001` bit `1` (`HIRAM`) participates in selecting KERNAL ROM versus RAM at `$E000-$FFFF`.
- KERNAL jump-table entries live near `$FF81-$FFF3`; reset/interrupt vectors occupy the top of address space.

## lookup
| range | default role | route |
|---|---|---|
| `$E000-$FFFF` | KERNAL ROM or underlying RAM | [../rom/kernal-disassembly.md](../rom/kernal-disassembly.md) |
| `$FF81-$FFF3` | KERNAL jump table | [../kernal/jump-table.md](../kernal/jump-table.md) |
| `$FFFA-$FFFF` | CPU vector area | [../concepts/interrupts.md](../concepts/interrupts.md) |

## constraints
- Agents MUST check processor-port state before saying CPU reads at `$E000-$FFFF` see KERNAL ROM.
- Code that switches KERNAL ROM out MUST provide valid interrupt handling or prevent interrupts as appropriate.
- KERNAL API facts SHOULD be taken from [../kernal/INDEX.md](../kernal/INDEX.md) before implementation disassembly pages.

## links
- banking: [../concepts/memory-banking.md](../concepts/memory-banking.md)
- KERNAL API: [../kernal/INDEX.md](../kernal/INDEX.md)
- ROM route: [../rom/kernal-disassembly.md](../rom/kernal-disassembly.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- memory index: [INDEX.md](INDEX.md)
- ROM route: [../rom/kernal-disassembly.md](../rom/kernal-disassembly.md)
