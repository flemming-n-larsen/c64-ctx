---
type: reference
domain: memory
granularity: address-range
---

## facts
- `$A000-$BFFF` is the normal BASIC ROM window when BASIC ROM is banked in.
- `$0001` bit `0` (`LORAM`) participates in selecting BASIC ROM versus RAM at `$A000-$BFFF`.
- Writes to the `$A000-$BFFF` address range MAY store into underlying RAM even when ROM is visible for reads.

## lookup
| range | default role | route |
|---|---|---|
| `$A000-$BFFF` | BASIC interpreter ROM or underlying RAM | [../rom/basic-disassembly.md](../rom/basic-disassembly.md) |
| `$A000-$BFFF` | BASIC code/data routines | [../basic/routines.md](../basic/routines.md) |

## constraints
- Agents MUST check processor-port state before saying CPU reads at `$A000-$BFFF` see BASIC ROM.
- Code that switches BASIC ROM out MUST ensure it does not return to BASIC expecting ROM routines to remain visible.
- Agents SHOULD use ROM disassembly pages for routine routing instead of copying source listings.

## links
- banking: [../concepts/memory-banking.md](../concepts/memory-banking.md)
- processor port: [../io/processor-port.md](../io/processor-port.md)
- BASIC domain: [../basic/INDEX.md](../basic/INDEX.md)

## sources
- `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt`
- `C:\Code\c64ref\src\c64disasm\c64disasm_ms.txt`
