---
type: reference
domain: basic
granularity: route
---

## facts
- BASIC token facts are routed to BASIC ROM/disassembly sources in this initial index.
- Tokenized BASIC bytes MUST be distinguished from PETSCII text bytes and screen-code bytes.

## lookup
| need | route | notes |
|---|---|---|
| Keyword token implementation | [../rom/basic-disassembly.md](../rom/basic-disassembly.md) | Use `c64disasm_ms.txt` and alternate commentaries. |
| BASIC text pointer context | [vectors.md](vectors.md) | `TXTTAB`, `TXTPTR`, and related symbols. |
| Character input/output context | [../charset/petscii.md](../charset/petscii.md) | Do not conflate tokens with PETSCII/control codes. |

## constraints
- Agents MUST verify exact token values in source material before giving numeric token tables.
- This seed page SHOULD remain a route page until exact token tables are derived from cited sources.

## links
- BASIC ROM route: [../rom/basic-disassembly.md](../rom/basic-disassembly.md)
- BASIC vectors: [vectors.md](vectors.md)
- character sets: [../concepts/character-sets.md](../concepts/character-sets.md)

## sources
- `C:\Code\c64ref\src\c64disasm\c64disasm_ms.txt`
- `C:\Code\c64ref\src\c64mem\c64mem_src.txt`
