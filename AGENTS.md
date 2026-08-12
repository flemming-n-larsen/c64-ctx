---
type: agent-contract
domain: root
source: c64ref
---

## consumption-rules
- Agents MUST read [INDEX.md](INDEX.md) first unless the user names a narrower file or domain.
- Agents MUST load the most specific referenced local Markdown file before loading a broader directory `INDEX.md` or upstream provenance route.
- Agents SHOULD answer from compact local Markdown files when they contain a cited fact.
- Agents MUST NOT read [sources/INDEX.md](sources/INDEX.md) to answer a question. It is a provenance and maintenance artifact; consult it only when a user asks where a fact came from, when two local pages conflict, or when exact upstream wording is required.
- Agents MUST NOT invent C64 addresses, symbols, register bits, KERNAL entry points, or opcode behavior without a citation.
- Agents MAY combine task recipes with domain pages when a user asks for code sequences or practical workflows.

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
- New factual pages MUST cite supporting local Markdown pages when the facts are already represented locally.
- Pages derived directly from an upstream article MAY also cite that specific upstream URL and MUST include [sources/INDEX.md](sources/INDEX.md) as the local provenance route.
- Long prose copied from sources MUST NOT be added when compact tables or bullets are sufficient.
