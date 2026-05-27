---
type: index
domain: root
source: c64ref
---

## quick-route
| need | read first | then read | notes |
|---|---|---|---|
| Memory map, zero page, ROM/RAM areas | [memory/INDEX.md](memory/INDEX.md) | [concepts/memory-banking.md](concepts/memory-banking.md) | Agents MUST prefer focused memory pages over broad source files. |
| KERNAL calls, jump table, file I/O | [kernal/INDEX.md](kernal/INDEX.md) | [tasks/load-save-file.md](tasks/load-save-file.md) | Agents SHOULD verify call contracts against cited `kernal_prg.txt` entries. |
| CPU registers, flags, opcodes | [cpu/6502/INDEX.md](cpu/6502/INDEX.md) | [cpu/6502/instruction-set.md](cpu/6502/instruction-set.md) | `6502` data SHOULD be treated as CPU-family scoped, not C64-only. |
| VIC-II, SID, CIA, I/O registers | [io/INDEX.md](io/INDEX.md) | [memory/io-area.md](memory/io-area.md) | Agents MUST account for banking at `$D000-$DFFF`. |
| BASIC or KERNAL ROM routine locations | [rom/INDEX.md](rom/INDEX.md) | [basic/INDEX.md](basic/INDEX.md) | ROM pages are compact routing aids, not full disassemblies. |
| PETSCII, screen codes, keyboard matrix | [charset/INDEX.md](charset/INDEX.md) | [concepts/character-sets.md](concepts/character-sets.md) | Agents MUST distinguish PETSCII from screen codes. |
| C64 color numbers and palette | [colors/INDEX.md](colors/INDEX.md) | [io/vic-ii.md](io/vic-ii.md) | Color references SHOULD cite both charset palette and colors UI sources when applicable. |
| Practical programming recipe | [tasks/INDEX.md](tasks/INDEX.md) | Matching domain pages | Task pages MUST link to supporting facts rather than duplicate long tables. |

## domains
| domain | read | contains | primary source area |
|---|---|---|---|
| `concepts` | [concepts/INDEX.md](concepts/INDEX.md) | Cross-domain constraints: banking, interrupts, screen memory, zero page, character sets | Derived from multiple `c64ref` categories |
| `cpu` | [cpu/INDEX.md](cpu/INDEX.md) | CPU-family route plus `6502` subdomain | `C:\Code\c64ref\src\6502` |
| `memory` | [memory/INDEX.md](memory/INDEX.md) | C64 address map, symbols, zero page, ROM/RAM/I/O regions | `C:\Code\c64ref\src\c64mem` |
| `io` | [io/INDEX.md](io/INDEX.md) | Processor port, VIC-II, SID, CIA1, CIA2, color RAM | `C:\Code\c64ref\src\c64io` |
| `kernal` | [kernal/INDEX.md](kernal/INDEX.md) | KERNAL jump table and API families | `C:\Code\c64ref\src\kernal` |
| `basic` | [basic/INDEX.md](basic/INDEX.md) | BASIC tokens, vectors, routine routes | `C:\Code\c64ref\src\c64disasm`, `C:\Code\c64ref\src\c64mem` |
| `rom` | [rom/INDEX.md](rom/INDEX.md) | BASIC/KERNAL ROM disassembly routes | `C:\Code\c64ref\src\c64disasm` |
| `charset` | [charset/INDEX.md](charset/INDEX.md) | PETSCII, screen codes, controls, keyboard matrix | `C:\Code\c64ref\src\charset` |
| `colors` | [colors/INDEX.md](colors/INDEX.md) | C64 color lookup and palette routes | `C:\Code\c64ref\src\colors`, `C:\Code\c64ref\src\charset` |
| `tasks` | [tasks/INDEX.md](tasks/INDEX.md) | Agent recipes for common programming goals | Cross-domain derived pages |
| `sources` | [sources/INDEX.md](sources/INDEX.md) | Source corpus map and provenance policy | `C:\Code\c64ref` |

## source-map
| `c64ref` source | local domains | status | notes |
|---|---|---|---|
| `C:\Code\c64ref\src\6502` | `cpu/6502` | planned seed | Structured CPU description files use sections such as `[registers]`, `[flags]`, `[mnemos]`, `[operations]`. |
| `C:\Code\c64ref\src\c64mem` | `memory`, `concepts`, `basic`, `rom`, `io` | planned seed | Memory text files and `symbols.txt` supply address ranges, symbols, and ROM/RAM constraints. |
| `C:\Code\c64ref\src\c64io` | `io`, `tasks` | planned seed | I/O maps supply register ranges and bit-level hardware fields. |
| `C:\Code\c64ref\src\kernal` | `kernal`, `tasks` | planned seed | KERNAL API files supply jump addresses, call preparation, returns, and affected registers. |
| `C:\Code\c64ref\src\c64disasm` | `rom`, `basic`, `kernal` | planned seed | Disassembly sources SHOULD be used as route/provenance material, not copied wholesale. |
| `C:\Code\c64ref\src\charset` | `charset`, `colors`, `tasks` | planned seed | Keyboard, PETSCII/control, chargen, and palette files back character facts. |
| `C:\Code\c64ref\src\colors` | `colors` | planned seed | Color UI assets MAY clarify palette names and display intent. |

## rules
- Agents MUST start here when no narrower entry point is supplied.
- Agents MUST prefer the smallest topical file that answers the question before reading broad indexes or original source files.
- Agents SHOULD follow `sources` links when facts conflict, are surprising, or require exact wording.
- Agents MUST NOT assume undocumented behavior without a cited source.
- Agents MUST distinguish `facts`, `constraints`, `aliases`, and unresolved source differences.
- Generated or derived pages MUST preserve provenance to exact `C:\Code\c64ref` files.

## links
- agent rules: [AGENTS.md](AGENTS.md)
- style rules: [STYLE.md](STYLE.md)
- source coverage: [sources/INDEX.md](sources/INDEX.md)
