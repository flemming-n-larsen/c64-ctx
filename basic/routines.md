---
type: reference
domain: basic
granularity: route
summary: "Route to BASIC ROM routine addresses rather than copied listings."
keywords: [BASIC routines, ROM entry points, interpreter routines]
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
- Routine address claims MUST be checked against the local ROM route pages before use.

## sources

- BASIC index: [INDEX.md](INDEX.md)
- ROM route: [../rom/basic-disassembly.md](../rom/basic-disassembly.md)
- BASIC vectors: [vectors.md](vectors.md)
- BASIC tokens: [tokens.md](tokens.md)
