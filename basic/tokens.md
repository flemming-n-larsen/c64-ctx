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
| Keyword token implementation | [../rom/basic-disassembly.md](../rom/basic-disassembly.md) | Use the local BASIC ROM route and alternate commentaries. |
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
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- BASIC index: [INDEX.md](INDEX.md)
- BASIC routines: [routines.md](routines.md)
