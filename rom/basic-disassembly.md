---
type: reference
domain: rom
granularity: route
summary: "Where BASIC ROM routines live, as a route to the upstream disassemblies."
keywords: [BASIC ROM, interpreter routines, disassembly, ROM listing]
---

## lookup
| range / topic | local route | local companion |
|---|---|---|
| `$A000-$BFFF` | [../memory/basic-rom.md](../memory/basic-rom.md) | [../memory/basic-rom.md](../memory/basic-rom.md) |
| BASIC interpreter workspace | [../basic/vectors.md](../basic/vectors.md) | [../basic/vectors.md](../basic/vectors.md) |
| BASIC routines | [../basic/routines.md](../basic/routines.md) | [../basic/routines.md](../basic/routines.md) |
| Tokenized BASIC context | BASIC ROM/source and memory symbols | [../basic/tokens.md](../basic/tokens.md) |

## constraints
- This file MUST route to source disassemblies; it MUST NOT reproduce full ROM listings.
- Agents SHOULD prefer KERNAL jump-table pages for public KERNAL calls even when BASIC calls into KERNAL ROM.
- Agents MUST account for banking before saying `$A000-$BFFF` reads return BASIC ROM.

## sources

- ROM index: [INDEX.md](INDEX.md)
- BASIC routines: [../basic/routines.md](../basic/routines.md)
- BASIC domain: [../basic/INDEX.md](../basic/INDEX.md)
- BASIC ROM memory: [../memory/basic-rom.md](../memory/basic-rom.md)
- banking: [../concepts/memory-banking.md](../concepts/memory-banking.md)
