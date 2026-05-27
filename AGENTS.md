---
type: agent-contract
domain: root
source: c64ref
---

## consumption-rules
- Agents MUST read [INDEX.md](INDEX.md) first unless the user names a narrower file or domain.
- Agents MUST load the most specific referenced local Markdown file before loading a broader directory `INDEX.md` or upstream provenance route.
- Agents SHOULD answer from compact local Markdown files when they contain a cited fact.
- Agents SHOULD inspect [sources/INDEX.md](sources/INDEX.md) when upstream provenance, ambiguity, or conflict resolution matters.
- Agents MUST NOT treat generated HTML output as more authoritative than local Markdown pages or the upstream source corpus linked from [sources/INDEX.md](sources/INDEX.md).
- Agents MUST NOT invent C64 addresses, symbols, register bits, KERNAL entry points, or opcode behavior without a citation.
- Agents MAY combine task recipes with domain pages when a user asks for code sequences or practical workflows.

## source-preference
| question type | preferred local route | provenance route | notes |
|---|---|---|---|
| CPU register, flag, opcode semantics | [cpu/6502/INDEX.md](cpu/6502/INDEX.md) | [sources/INDEX.md](sources/INDEX.md) | CPU facts MUST keep 6502-family scope clear. |
| C64 address or symbol | [memory/INDEX.md](memory/INDEX.md) | [sources/INDEX.md](sources/INDEX.md) | Symbols SHOULD preserve aliases where local pages show them. |
| Hardware register or bit field | [io/INDEX.md](io/INDEX.md) | [sources/INDEX.md](sources/INDEX.md) | I/O facts MUST consider `$0001` banking when relevant. |
| KERNAL API call | [kernal/INDEX.md](kernal/INDEX.md) | [sources/INDEX.md](sources/INDEX.md) | Call contracts SHOULD include inputs, outputs, errors, and clobbers when known. |
| ROM routine location | [rom/INDEX.md](rom/INDEX.md) | [sources/INDEX.md](sources/INDEX.md) | ROM pages MUST route to local Markdown summaries rather than reproduce full listings. |
| PETSCII, screen code, keyboard | [charset/INDEX.md](charset/INDEX.md) | [sources/INDEX.md](sources/INDEX.md) | Character facts MUST distinguish code spaces. |
| Color value or palette | [colors/INDEX.md](colors/INDEX.md) | [sources/INDEX.md](sources/INDEX.md) | Palette facts SHOULD cite local source-difference notes if visible. |

## normative-language
| term | agent interpretation |
|---|---|
| `MUST` | Required for correctness, safe routing, or source-faithful behavior. |
| `SHOULD` | Recommended default; exceptions need context or source support. |
| `MUST NOT` | Forbidden, unsupported, or likely incorrect. |
| `MAY` | Optional or context-dependent. |

## answer-rules
- Answers MUST cite local files when using derived facts from this repository.
- Answers SHOULD cite [sources/INDEX.md](sources/INDEX.md) for upstream provenance when local pages intentionally summarize, defer, or expose ambiguity.
- Answers MUST state uncertainty when local files intentionally summarize or defer to sources.
- Answers SHOULD use C64 notation from the index: `$`-prefixed hexadecimal addresses, uppercase hardware symbols, and inline code formatting.
- Answers MUST NOT conflate `PETSCII`, screen codes, keyboard scan positions, and character ROM glyph bytes.

## maintenance-rules
- New factual pages MUST include a `sources` section.
- New pages SHOULD be atomic enough for agent context use.
- New links MUST be relative Markdown links when pointing inside this repo.
- New source citations MUST point to local Markdown pages; upstream fallback provenance MUST be routed through [sources/INDEX.md](sources/INDEX.md).
- Long prose copied from sources MUST NOT be added when compact tables or bullets are sufficient.
