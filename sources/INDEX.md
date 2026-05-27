---
type: index
domain: sources
source: c64ref
---

## corpus-map
| local domain | primary source files | status | extraction intent |
|---|---|---|---|
| `cpu/6502` | `C:\Code\c64ref\src\6502\cpu_6502.txt`; related variant files such as `cpu_65c02.txt` | observed | Extract registers, flags, addressing modes, documented operations, and illegal-opcode caveats. |
| `memory` | `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt`; `c64mem_src.txt`; `symbols.txt` | observed | Extract map ranges, aliases, ROM/RAM regions, zero-page symbols, and cross-links. |
| `io` | `C:\Code\c64ref\src\c64io\c64io_prg.txt`; `c64io_mapc64.txt`; `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt` | observed | Extract processor port, VIC-II, SID, CIA, color RAM, and banking-relevant register facts. |
| `kernal` | `C:\Code\c64ref\src\kernal\kernal_prg.txt`; `kernal_sta.txt`; `kernal_dh.txt`; `generate.py` | observed | Extract KERNAL jump table entries, categories, calling conventions, error returns, and clobbers. |
| `basic` | `C:\Code\c64ref\src\c64disasm\c64disasm_ms.txt`; `C:\Code\c64ref\src\c64mem\c64mem_src.txt` | observed | Route BASIC tokens, vectors, interpreter workspace, and ROM routine locations. |
| `rom` | `C:\Code\c64ref\src\c64disasm\c64disasm_ms.txt`; `c64disasm_cbm.txt`; `c64disasm_en.txt`; `generate.py` | observed | Create compact routine-location routing, not full disassembly copies. |
| `charset` | `C:\Code\c64ref\src\charset\keyboard_c64.txt`; `control_codes_c64.txt`; `palette_c64.txt`; `C64IPRI.TXT`; `C64IALT.TXT` | observed | Extract keyboard matrix, PETSCII/control-code facts, screen-code distinctions, and character-set variants. |
| `colors` | `C:\Code\c64ref\src\colors\index.html`; `script.js`; `C:\Code\c64ref\src\charset\palette_c64.txt` | observed | Extract compact color number and palette tables. |
| `tasks` | Cross-domain sources above | derived | Link practical recipes to cited memory, I/O, KERNAL, CPU, charset, and color pages. |

## source-authority
| source type | authority | rules |
|---|---|---|
| Structured source text under `C:\Code\c64ref\src` | primary | Agents MUST prefer these files over generated HTML. |
| Category `generate.py` scripts | structural | Agents SHOULD use these to understand categories, source order, and generated cross-link behavior. |
| `C:\Code\c64ref\README.md` | corpus overview | Agents MAY use this to identify named source editions and provenance. |
| Generated HTML output | fallback only | Agents MUST NOT use generated HTML when source text files provide the same facts. |

## category-registry
| `generate.py` path | long title | local target | notes |
|---|---|---|---|
| `6502` | `6502 Family CPU Reference` | `cpu/6502` | CPU-family data is not exclusively C64-specific. |
| `kernal` | `C64 KERNAL API` | `kernal` | API calls are organized by jump address and category. |
| `c64disasm` | `C64 BASIC & KERNAL ROM Disassembly` | `rom`, `basic`, `kernal` | Large source files SHOULD be summarized as route tables. |
| `c64mem` | `C64 Memory Map` | `memory`, `concepts` | Multiple source editions MAY differ; keep provenance visible. |
| `c64io` | `C64 I/O Map` | `io` | Marked WIP in upstream generator; facts SHOULD be cross-checked. |
| `charset` | `Character Set · PETSCII · Keyboard` | `charset` | Includes keyboard and character-code data. |
| `colors` | `C64 Colors` | `colors` | Color data overlaps with `charset/palette_c64.txt`. |

## local-rules
- Every derived factual page MUST list exact source files in `## sources`.
- Source paths MUST remain absolute Windows paths for auditability.
- Internal navigation MUST use relative Markdown links to local compact files.
- Agents SHOULD report unresolved source differences instead of suppressing them.

## links
- root: [../INDEX.md](../INDEX.md)
- agent contract: [../AGENTS.md](../AGENTS.md)
- style rules: [../STYLE.md](../STYLE.md)