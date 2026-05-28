---
type: index
domain: sources
source: c64ref
---

## corpus-map
| local domain | local route | upstream fallback | extraction intent |
|---|---|---|---|
| `cpu/6502` | [../cpu/6502/INDEX.md](../cpu/6502/INDEX.md) | [mist64/c64ref CPU category](https://github.com/mist64/c64ref/tree/master/src/6502) | Extract registers, flags, addressing modes, documented operations, and illegal-opcode caveats. |
| `memory` | [../memory/INDEX.md](../memory/INDEX.md) | [mist64/c64ref memory category](https://github.com/mist64/c64ref/tree/master/src/c64mem) | Extract map ranges, aliases, ROM/RAM regions, zero-page symbols, and cross-links. |
| `io` | [../io/INDEX.md](../io/INDEX.md) | [mist64/c64ref I/O category](https://github.com/mist64/c64ref/tree/master/src/c64io) | Extract processor port, VIC-II, SID, CIA, color RAM, and banking-relevant register facts. |
| `kernal` | [../kernal/INDEX.md](../kernal/INDEX.md) | [mist64/c64ref KERNAL category](https://github.com/mist64/c64ref/tree/master/src/kernal) | Extract KERNAL jump table entries, categories, calling conventions, error returns, and clobbers. |
| `basic` (token bytes, ROM routes, vectors) | [../basic/INDEX.md](../basic/INDEX.md) | [mist64/c64ref ROM category](https://github.com/mist64/c64ref/tree/master/src/c64disasm) | Route BASIC tokens, vectors, interpreter workspace, and ROM routine locations. |
| `basic` (language semantics) | [../basic/INDEX.md](../basic/INDEX.md) | C64 Programmer's Reference Guide (Commodore Business Machines, 1982) | AI-summarized keyword syntax, function semantics, error conditions, variable rules, and BASIC I/O behavior. |
| `rom` | [../rom/INDEX.md](../rom/INDEX.md) | [mist64/c64ref ROM category](https://github.com/mist64/c64ref/tree/master/src/c64disasm) | Create compact routine-location routing, not full disassembly copies. |
| `charset` | [../charset/INDEX.md](../charset/INDEX.md) | [mist64/c64ref character category](https://github.com/mist64/c64ref/tree/master/src/charset) | Extract keyboard matrix, PETSCII/control-code facts, screen-code distinctions, and character-set variants. |
| `colors` | [../colors/INDEX.md](../colors/INDEX.md) | [mist64/c64ref colors category](https://github.com/mist64/c64ref/tree/master/src/colors) | Extract compact color number and palette tables. |
| `tasks` | [../tasks/INDEX.md](../tasks/INDEX.md) | [mist64/c64ref repository](https://github.com/mist64/c64ref) | Link practical recipes to cited memory, I/O, KERNAL, CPU, charset, and color pages. |
| `asm` | [../asm/INDEX.md](../asm/INDEX.md) | Assembler-specific upstream docs — no mist64/c64ref route | Cite ACME, KickAssembler, ca65/cc65, and 64tass documentation directly; see [../ATTRIBUTION.md](../ATTRIBUTION.md). |
| `toolchains` | [../toolchains/INDEX.md](../toolchains/INDEX.md) | Tool-specific upstream docs — no mist64/c64ref route | Cite VICE manual, each assembler's manual, and CBM prg Studio docs directly; see [../ATTRIBUTION.md](../ATTRIBUTION.md). |
| `examples` | [../examples/INDEX.md](../examples/INDEX.md) | Cross-domain derived pages — no direct upstream route | Each example cites local `basic/`, `asm/`, `tasks/`, `io/`, `memory/`, `charset/`, `colors/`, and `toolchains/` pages rather than upstream directly. |
| `effects` | [../effects/INDEX.md](../effects/INDEX.md) | [codebase64.net](https://codebase64.net/) — CC BY-NC-SA 4.0 | Distill technique-level demo/game effect recipes; each page cites the specific codebase64.net article URL and author (where named) in its `## sources` section. |

## source-authority
| source type | authority | rules |
|---|---|---|
| Local Markdown pages | primary for this repository | Agents MUST cite these pages for facts already represented in this repo. |
| Upstream GitHub category links | fallback provenance | Agents SHOULD use these when local pages intentionally summarize, defer, or expose ambiguity. |
| Upstream generation scripts | structural | Agents MAY use these to understand categories, source order, and generated cross-link behavior. |
| Generated HTML output | fallback only | Agents MUST NOT use generated HTML when local Markdown or upstream source material provides the same facts. |

## category-registry
| upstream category | long title | local target | notes |
|---|---|---|---|
| `6502` | `6502 Family CPU Reference` | `cpu/6502` | CPU-family data is not exclusively C64-specific. |
| `kernal` | `C64 KERNAL API` | `kernal` | API calls are organized by jump address and category. |
| `c64disasm` | `C64 BASIC & KERNAL ROM Disassembly` | `rom`, `basic`, `kernal` | Large source files SHOULD be summarized as route tables. |
| `c64mem` | `C64 Memory Map` | `memory`, `concepts` | Multiple source editions MAY differ; keep provenance visible. |
| `c64io` | `C64 I/O Map` | `io` | Marked WIP in upstream generator; facts SHOULD be cross-checked. |
| `charset` | `Character Set · PETSCII · Keyboard` | `charset` | Includes keyboard and character-code data. |
| `colors` | `C64 Colors` | `colors` | Color data overlaps with the character-set palette category. |

## local-rules
- Every derived factual page MUST list local Markdown pages or this provenance page in `## sources`.
- Upstream fallback references MUST use GitHub category or repository links from this page, not local absolute paths.
- Internal navigation MUST use relative Markdown links to local compact files.
- Agents SHOULD report unresolved source differences instead of suppressing them.

## links
- root: [../INDEX.md](../INDEX.md)
- agent contract: [../AGENTS.md](../AGENTS.md)
- style rules: [../STYLE.md](../STYLE.md)