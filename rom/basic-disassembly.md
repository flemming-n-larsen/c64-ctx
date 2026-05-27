---
type: reference
domain: rom
granularity: route
---

## lookup
| range / topic | source route | local companion |
|---|---|---|
| `$A000-$BFFF` | `c64disasm_ms.txt`, `c64disasm_en.txt`, `c64disasm_de.txt`, `c64disasm_mm.txt` | [../memory/basic-rom.md](../memory/basic-rom.md) |
| BASIC interpreter workspace | `c64mem_src.txt`, `symbols.txt` | [../basic/vectors.md](../basic/vectors.md) |
| BASIC routines | `c64disasm_ms.txt` plus alternate commentaries | [../basic/routines.md](../basic/routines.md) |
| Tokenized BASIC context | BASIC ROM/source and memory symbols | [../basic/tokens.md](../basic/tokens.md) |

## constraints
- This file MUST route to source disassemblies; it MUST NOT reproduce full ROM listings.
- Agents SHOULD prefer KERNAL jump-table pages for public KERNAL calls even when BASIC calls into KERNAL ROM.
- Agents MUST account for banking before saying `$A000-$BFFF` reads return BASIC ROM.

## links
- BASIC domain: [../basic/INDEX.md](../basic/INDEX.md)
- BASIC ROM memory: [../memory/basic-rom.md](../memory/basic-rom.md)
- banking: [../concepts/memory-banking.md](../concepts/memory-banking.md)

## sources
- `C:\Code\c64ref\src\c64disasm\c64disasm_ms.txt`
- `C:\Code\c64ref\src\c64disasm\c64disasm_en.txt`
- `C:\Code\c64ref\src\c64disasm\generate.py`
- `C:\Code\c64ref\src\c64mem\c64mem_src.txt`
