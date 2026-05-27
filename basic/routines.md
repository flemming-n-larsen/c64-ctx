---
type: reference
domain: basic
granularity: route
---

## lookup
| need | route | notes |
|---|---|---|
| BASIC ROM implementation | [../rom/basic-disassembly.md](../rom/basic-disassembly.md) | `$A000-$BFFF`, banking-sensitive. |
| BASIC workspace symbols | [vectors.md](vectors.md) | Zero-page and pointer symbols. |
| KERNAL service calls used by BASIC | [../kernal/INDEX.md](../kernal/INDEX.md) | Prefer documented KERNAL API for public calls. |
| Memory banking for BASIC ROM | [../memory/basic-rom.md](../memory/basic-rom.md) | Use before reading/copying ROM. |

## constraints
- This initial page MUST route to exact disassembly sources instead of copying long BASIC listings.
- Agents SHOULD use KERNAL API pages when the user asks how to call OS routines from user code.
- Routine address claims MUST be checked against `c64disasm` sources before use.

## links
- BASIC vectors: [vectors.md](vectors.md)
- BASIC tokens: [tokens.md](tokens.md)
- ROM route: [../rom/basic-disassembly.md](../rom/basic-disassembly.md)

## sources
- `C:\Code\c64ref\src\c64disasm\c64disasm_ms.txt`
- `C:\Code\c64ref\src\c64disasm\c64disasm_en.txt`
- `C:\Code\c64ref\src\c64mem\c64mem_src.txt`