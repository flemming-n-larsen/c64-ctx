---
type: agent-contract
domain: root
source: c64ref
---

## consumption-rules
Resolve a question in one hop, then read the page. There are two entry paths.

- Agents with text search MUST search [ROUTE.md](ROUTE.md) for a topic or jargon term, or [SYMBOLS.md](SYMBOLS.md) for a `$`-address or KERNAL symbol, then read the matched page. Both files are grep targets and MUST NOT be read whole.
- Agents without text search MUST read [INDEX.md](INDEX.md) `## quick-route`, then read the matched page.
- Agents MUST use a directory `INDEX.md` only when neither entry path resolves, or when the question spans a whole domain.
- Agents MUST read a page's front-matter `summary` before loading its body when more than one candidate matched.
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
- Answers SHOULD cite the upstream URL in a page's `## sources` when local pages intentionally summarize, defer, or expose ambiguity, and MAY cite [sources/INDEX.md](sources/INDEX.md) when the question is about provenance itself.
- Answers MUST state uncertainty when local files intentionally summarize or defer to sources.
- Answers SHOULD use C64 notation from the index: `$`-prefixed hexadecimal addresses, uppercase hardware symbols, and inline code formatting.
- Answers MUST NOT conflate `PETSCII`, screen codes, keyboard scan positions, and character ROM glyph bytes.

## maintenance-rules
- New factual pages MUST include front-matter `summary` and `keywords`, and a `## sources` section.
- New pages SHOULD be atomic enough for agent context use.
- New links MUST be relative Markdown links when pointing inside this repo.
- New factual pages MUST cite supporting local Markdown pages when the facts are already represented locally.
- Pages derived directly from an upstream article MUST cite that specific upstream URL in `## sources`.
- Long prose copied from sources MUST NOT be added when compact tables or bullets are sufficient.
- After adding, removing, or re-describing a page, run `scripts/generate-routes.ps1`. [ROUTE.md](ROUTE.md), [SYMBOLS.md](SYMBOLS.md), and the `## pages` block in each directory index are generated; editing them by hand is overwritten and fails the audit.
