---
type: reference
domain: memory
granularity: overview
---

## lookup
| range | default visible content | banking-sensitive | read first |
|---|---|---:|---|
| `$0000-$0001` | `D6510`, `R6510` 6510 on-chip I/O registers | no | [../io/processor-port.md](../io/processor-port.md) |
| `$0002-$03FF` | Zero page, stack, BASIC/KERNAL workspace, vectors | no | [zero-page.md](zero-page.md) |
| `$0400-$07E7` | Default text screen matrix | yes, by VIC memory setup | [../concepts/screen-memory.md](../concepts/screen-memory.md) |
| `$0801-$9FFF` | Default BASIC program/RAM area | no | [symbols.md](symbols.md) |
| `$A000-$BFFF` | BASIC ROM or underlying RAM | yes | [basic-rom.md](basic-rom.md) |
| `$C000-$CFFF` | RAM commonly used for machine-language programs | no | [symbols.md](symbols.md) |
| `$D000-$DFFF` | I/O devices, color RAM, character ROM, or RAM | yes | [io-area.md](io-area.md) |
| `$E000-$FFFF` | KERNAL ROM or underlying RAM | yes | [kernal-rom.md](kernal-rom.md) |

## constraints
- Agents MUST check `$0001` before deciding whether `$A000-$BFFF`, `$D000-$DFFF`, or `$E000-$FFFF` names ROM, I/O, character ROM, or RAM.
- Code MAY write to RAM underneath ROM; the visible read target still depends on banking.
- Agents SHOULD use [symbols.md](symbols.md) for canonical labels before inventing local names.
- Agents MUST NOT assume VIC-II sees the same banked memory view as the CPU.

## links
- banking: [../concepts/memory-banking.md](../concepts/memory-banking.md)
- processor port: [../io/processor-port.md](../io/processor-port.md)
- ROM routes: [../rom/INDEX.md](../rom/INDEX.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- memory index: [INDEX.md](INDEX.md)
- I/O context: [../io/INDEX.md](../io/INDEX.md)
