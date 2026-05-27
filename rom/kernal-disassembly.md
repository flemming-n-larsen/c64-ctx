---
type: reference
domain: rom
granularity: route
---

## lookup
| range / topic | source route | local companion |
|---|---|---|
| `$E000-$FFFF` | `c64disasm_cbm.txt`, `c64disasm_en.txt`, `c64disasm_mn.txt`, `c64disasm_mm.txt` | [../memory/kernal-rom.md](../memory/kernal-rom.md) |
| `$FF81-$FFF3` jump table | KERNAL API sources and ROM disassembly | [../kernal/jump-table.md](../kernal/jump-table.md) |
| IRQ/time routines | KERNAL disassembly sources | [../kernal/time-irq.md](../kernal/time-irq.md) |
| Serial and file routines | KERNAL disassembly sources | [../kernal/file-io.md](../kernal/file-io.md) |

## constraints
- Agents MUST prefer documented KERNAL API pages for public calls before implementation disassembly.
- This file SHOULD be used to locate implementation material, not as a complete disassembly.
- Agents MUST account for banking before saying `$E000-$FFFF` reads return KERNAL ROM.

## links
- KERNAL domain: [../kernal/INDEX.md](../kernal/INDEX.md)
- KERNAL ROM memory: [../memory/kernal-rom.md](../memory/kernal-rom.md)
- interrupts: [../concepts/interrupts.md](../concepts/interrupts.md)

## sources
- `C:\Code\c64ref\src\c64disasm\c64disasm_cbm.txt`
- `C:\Code\c64ref\src\c64disasm\c64disasm_en.txt`
- `C:\Code\c64ref\src\c64disasm\c64disasm_mn.txt`
- `C:\Code\c64ref\src\c64disasm\generate.py`
- `C:\Code\c64ref\src\kernal\kernal_prg.txt`
