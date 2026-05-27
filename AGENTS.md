---
type: agent-contract
domain: root
source: c64ref
---

## consumption-rules
- Agents MUST read [INDEX.md](INDEX.md) first unless the user names a narrower file or domain.
- Agents MUST load the most specific referenced file before loading a broader directory `INDEX.md` or original `c64ref` source.
- Agents SHOULD answer from compact local Markdown files when they contain a cited fact.
- Agents SHOULD inspect `sources` when exact source wording, ambiguity, or conflict resolution matters.
- Agents MUST NOT treat generated HTML output as more authoritative than the source files under `C:\Code\c64ref\src`.
- Agents MUST NOT invent C64 addresses, symbols, register bits, KERNAL entry points, or opcode behavior without a citation.
- Agents MAY combine task recipes with domain pages when a user asks for code sequences or practical workflows.

## source-preference
| question type | preferred local route | preferred source fallback | notes |
|---|---|---|---|
| CPU register, flag, opcode semantics | [cpu/6502/INDEX.md](cpu/6502/INDEX.md) | `C:\Code\c64ref\src\6502\cpu_6502.txt` | CPU facts MUST keep 6502-family scope clear. |
| C64 address or symbol | [memory/INDEX.md](memory/INDEX.md) | `C:\Code\c64ref\src\c64mem\symbols.txt`, `c64mem_mapc64.txt` | Symbols SHOULD preserve aliases where sources show them. |
| Hardware register or bit field | [io/INDEX.md](io/INDEX.md) | `C:\Code\c64ref\src\c64io\c64io_prg.txt`, `c64io_mapc64.txt` | I/O facts MUST consider `$0001` banking when relevant. |
| KERNAL API call | [kernal/INDEX.md](kernal/INDEX.md) | `C:\Code\c64ref\src\kernal\kernal_prg.txt`, `kernal_sta.txt` | Call contracts SHOULD include inputs, outputs, errors, and clobbers when known. |
| ROM routine location | [rom/INDEX.md](rom/INDEX.md) | `C:\Code\c64ref\src\c64disasm\*.txt` | ROM pages MUST route to sources rather than reproduce full listings. |
| PETSCII, screen code, keyboard | [charset/INDEX.md](charset/INDEX.md) | `C:\Code\c64ref\src\charset\*.txt` | Character facts MUST distinguish code spaces. |
| Color value or palette | [colors/INDEX.md](colors/INDEX.md) | `C:\Code\c64ref\src\charset\palette_c64.txt`, `C:\Code\c64ref\src\colors` | Palette facts SHOULD cite source differences if visible. |

## normative-language
| term | agent interpretation |
|---|---|
| `MUST` | Required for correctness, safe routing, or source-faithful behavior. |
| `SHOULD` | Recommended default; exceptions need context or source support. |
| `MUST NOT` | Forbidden, unsupported, or likely incorrect. |
| `MAY` | Optional or context-dependent. |

## answer-rules
- Answers MUST cite local files when using derived facts from this repository.
- Answers SHOULD cite exact `C:\Code\c64ref` source files for low-level facts such as addresses, bit fields, KERNAL entries, or opcode behavior.
- Answers MUST state uncertainty when local files intentionally summarize or defer to sources.
- Answers SHOULD use C64 notation from the index: `$`-prefixed hexadecimal addresses, uppercase hardware symbols, and inline code formatting.
- Answers MUST NOT conflate `PETSCII`, screen codes, keyboard scan positions, and character ROM glyph bytes.

## maintenance-rules
- New factual pages MUST include a `sources` section.
- New pages SHOULD be atomic enough for agent context use.
- New links MUST be relative Markdown links when pointing inside this repo.
- New source citations MUST point to exact files under `C:\Code\c64ref`.
- Long prose copied from sources MUST NOT be added when compact tables or bullets are sufficient.
