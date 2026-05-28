---
type: index
domain: root
source: c64ref
---

## quick-route
| need | read first | then read | notes |
|---|---|---|---|
| Memory map, zero page, ROM/RAM areas | [memory/INDEX.md](memory/INDEX.md) | [concepts/memory-banking.md](concepts/memory-banking.md) | Agents MUST prefer focused memory pages over broad source files. |
| KERNAL calls, jump table, file I/O | [kernal/INDEX.md](kernal/INDEX.md) | [tasks/load-save-file.md](tasks/load-save-file.md) | Agents SHOULD cite local KERNAL pages and route upstream provenance through [sources/INDEX.md](sources/INDEX.md). |
| CPU registers, flags, opcodes | [cpu/6502/INDEX.md](cpu/6502/INDEX.md) | [cpu/6502/instruction-set.md](cpu/6502/instruction-set.md) | `6502` data SHOULD be treated as CPU-family scoped, not C64-only. |
| VIC-II, SID, CIA, I/O registers | [io/INDEX.md](io/INDEX.md) | [memory/io-area.md](memory/io-area.md) | Agents MUST account for banking at `$D000-$DFFF`. |
| BASIC or KERNAL ROM routine locations | [rom/INDEX.md](rom/INDEX.md) | [basic/INDEX.md](basic/INDEX.md) | ROM pages are compact routing aids, not full disassemblies. |
| PETSCII, screen codes, keyboard matrix | [charset/INDEX.md](charset/INDEX.md) | [concepts/character-sets.md](concepts/character-sets.md) | Agents MUST distinguish PETSCII from screen codes. |
| C64 color numbers and palette | [colors/INDEX.md](colors/INDEX.md) | [io/vic-ii.md](io/vic-ii.md) | Color references SHOULD cite both charset palette and colors UI sources when applicable. |
| Practical programming recipe | [tasks/INDEX.md](tasks/INDEX.md) | Matching domain pages | Task pages MUST link to supporting facts rather than duplicate long tables. |
| Assembler syntax, directives, build patterns | [asm/INDEX.md](asm/INDEX.md) | [asm/rosetta.md](asm/rosetta.md) | Covers ACME, KickAssembler, CA65 (cc65), 64tass. |
| Build/run `.prg` on PC (VICE, assembler workflows) | [toolchains/INDEX.md](toolchains/INDEX.md) | [toolchains/vice.md](toolchains/vice.md) | Editor-neutral workflows for ACME, KickAssembler, CA65, 64tass, CBM prg Studio. |
| Complete runnable program examples | [examples/INDEX.md](examples/INDEX.md) | Matching `basic/`, `asm/`, `toolchains/` pages | BASIC listings + per-assembler buildable `.prg` examples; each cites its reference pages. |

## domains
| domain | read | contains | provenance route |
|---|---|---|---|
| `concepts` | [concepts/INDEX.md](concepts/INDEX.md) | Cross-domain constraints: banking, interrupts, screen memory, zero page, character sets | [sources/INDEX.md](sources/INDEX.md) |
| `cpu` | [cpu/INDEX.md](cpu/INDEX.md) | CPU-family route plus `6502` subdomain | [sources/INDEX.md](sources/INDEX.md) |
| `memory` | [memory/INDEX.md](memory/INDEX.md) | C64 address map, symbols, zero page, ROM/RAM/I/O regions | [sources/INDEX.md](sources/INDEX.md) |
| `io` | [io/INDEX.md](io/INDEX.md) | Processor port, VIC-II, SID, CIA1, CIA2, color RAM | [sources/INDEX.md](sources/INDEX.md) |
| `kernal` | [kernal/INDEX.md](kernal/INDEX.md) | KERNAL jump table and API families | [sources/INDEX.md](sources/INDEX.md) |
| `basic` | [basic/INDEX.md](basic/INDEX.md) | BASIC tokens, vectors, routine routes | [sources/INDEX.md](sources/INDEX.md) |
| `rom` | [rom/INDEX.md](rom/INDEX.md) | BASIC/KERNAL ROM disassembly routes | [sources/INDEX.md](sources/INDEX.md) |
| `charset` | [charset/INDEX.md](charset/INDEX.md) | PETSCII, screen codes, controls, keyboard matrix | [sources/INDEX.md](sources/INDEX.md) |
| `colors` | [colors/INDEX.md](colors/INDEX.md) | C64 color lookup and palette routes | [sources/INDEX.md](sources/INDEX.md) |
| `tasks` | [tasks/INDEX.md](tasks/INDEX.md) | Agent recipes for common programming goals | Cross-domain derived pages |
| `asm` | [asm/INDEX.md](asm/INDEX.md) | Assembler-specific syntax for ACME, KickAssembler, CA65, 64tass; cross-assembler rosetta; common patterns | Assembler-specific upstream docs |
| `toolchains` | [toolchains/INDEX.md](toolchains/INDEX.md) | VICE emulator workflow and per-assembler source-to-`.prg` build workflows; CBM prg Studio | Tool-specific upstream docs |
| `examples` | [examples/INDEX.md](examples/INDEX.md) | Complete runnable BASIC and per-assembler programs with build/run invocations | Cross-domain derived pages |
| `sources` | [sources/INDEX.md](sources/INDEX.md) | Source corpus map and provenance policy | Upstream GitHub fallback links |

## source-map
| coverage route | local domains | status | notes |
|---|---|---|---|
| [cpu/6502/INDEX.md](cpu/6502/INDEX.md) | `cpu/6502` | planned seed | Local CPU pages cover registers, flags, mnemonics, operations, and undocumented caveats. |
| [memory/INDEX.md](memory/INDEX.md) | `memory`, `concepts`, `basic`, `rom`, `io` | planned seed | Local memory pages cover address ranges, symbols, aliases, and ROM/RAM constraints. |
| [io/INDEX.md](io/INDEX.md) | `io`, `tasks` | planned seed | Local I/O pages cover register ranges and bit-level hardware fields. |
| [kernal/INDEX.md](kernal/INDEX.md) | `kernal`, `tasks` | planned seed | Local KERNAL pages cover jump addresses, call preparation, returns, and affected registers. |
| [rom/INDEX.md](rom/INDEX.md) | `rom`, `basic`, `kernal` | planned seed | Local ROM pages provide route/provenance material, not full copied listings. |
| [charset/INDEX.md](charset/INDEX.md) | `charset`, `colors`, `tasks` | planned seed | Local charset pages cover keyboard, PETSCII/control, chargen, and palette facts. |
| [colors/INDEX.md](colors/INDEX.md) | `colors` | planned seed | Local color pages cover color names, indices, and palette intent. |
| [sources/INDEX.md](sources/INDEX.md) | all domains | provenance | Central upstream fallback route for `mist64/c64ref`. |

## rules
- Agents MUST start here when no narrower entry point is supplied.
- Agents MUST prefer the smallest topical file that answers the question before reading broad indexes or original source files.
- Agents SHOULD follow `sources` links when facts conflict, are surprising, or require exact wording.
- Agents MUST NOT assume undocumented behavior without a cited source.
- Agents MUST distinguish `facts`, `constraints`, `aliases`, and unresolved source differences.
- Generated or derived pages MUST preserve local Markdown provenance and route upstream fallback through [sources/INDEX.md](sources/INDEX.md).

## links
- agent rules: [AGENTS.md](AGENTS.md)
- style rules: [STYLE.md](STYLE.md)
- source coverage: [sources/INDEX.md](sources/INDEX.md)
