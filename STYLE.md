---
type: style
domain: root
source: c64ref
---

## writing-rules
- Files MUST start with useful routing data, facts, or lookup tables, not narrative introductions.
- Files MUST NOT include generic `Introduction`, `Conclusion`, or `Summary` sections.
- Files SHOULD use tables for lookup facts and bullets for constraints or caveats.
- Files MUST use inline code for addresses, symbols, registers, filenames, routine names, opcodes, and bit names.
- Files SHOULD keep paragraphs rare and short; dense reference data is preferred.
- Files MUST preserve source uncertainty rather than flatten conflicting references.
- Files MUST use RFC-style terms only when they express a real constraint or recommendation.

## naming
| item | rule | examples |
|---|---|---|
| Directories | MUST use lowercase kebab-case unless an existing machine identifier is clearer as content only | `memory`, `cpu`, `charset` |
| Markdown files | MUST use lowercase kebab-case | `memory-banking.md`, `jump-table.md` |
| C64 symbols in content | MAY preserve source uppercase | `ACPTR`, `CHRIN`, `D6510`, `VIC-II` |
| Addresses | MUST use `$`-prefixed hexadecimal | `$0001`, `$D000-$DFFF` |
| Internal links | MUST use relative Markdown links | `../memory/map.md` |
| Source citations | MUST cite the specific upstream article for directly derived pages | the upstream URL in `## sources` |

## front-matter
| page type | required fields | notes |
|---|---|---|
| Root contract/style | `type`, `domain`, `source` | `domain` is `root`. |
| Directory index | `type: index`, `domain`, `source` | `domain` MUST match its directory (`cpu/6502` for that nested domain). Indexes MUST NOT declare `summary` or `keywords`. |
| Factual reference | `type: reference`, `domain`, `granularity`, `summary`, `keywords` | `granularity` SHOULD be `atomic`, `chip`, `device`, or `recipe`. |

- `source` MAY be omitted from factual references when the `## sources` section is the more accurate mixed-source authority.
- When present, `source` MUST use the canonical identifier already used by the repository: `c64ref`, `codebase64.net`, `commodore-manual`, `hvsc`, `6502.org`, `assembler-docs`, `tool-docs`, `cross-domain`, or `mixed`.
- `summary` MUST state what the page **answers**, not what it contains: `Six-step sprite setup: data alignment, pointer, position, color, enable last.`, not `Covers sprite display.` A summary that restates the heading list is dead weight; a summary that states the answer shape lets an agent reject the page from its first few lines.
- `summary` MUST be one line, at most 100 characters, and MUST NOT contain a Markdown link.
- `keywords` MUST use YAML flow style (`[a, b, c]`). A block list parses as empty, because the front-matter reader in `scripts/lib/markdown.ps1` works line by line.
- `keywords` MUST hold 2-8 entries of at most 30 characters, and SHOULD declare only terms a regex cannot recover from the page: jargon, synonyms, and alternative names (`tech-tech`, `twister`, `screen split`, `hard restart`). Addresses and `## lookup` symbols are extracted automatically and MUST NOT be repeated here.

## index-template
```md
---
type: index
domain: memory
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| Zero page symbols | ./zero-page.md | Fast variable/register lookup |

## pages
<!-- GENERATED:routes -->
Regenerate with scripts/generate-routes.ps1; edits here are overwritten.
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| I/O | ../io/INDEX.md | `$D000-$DFFF` hardware registers |
```

## reference-template
```md
---
type: reference
domain: kernal
granularity: atomic
summary: "Call ACPTR to read one byte from a device already set to talk."
keywords: [serial input, byte read, IEC receive]
---

## facts
- `ACPTR` MUST be called at `$FFA5`.
- Callers SHOULD prepare the serial device with `TALK` and `TKSA` when applicable.

## lookup
| symbol | address | category | inputs | outputs | clobbers |
|---|---:|---|---|---|---|

## constraints
- Code MUST preserve registers unless the routine contract says they are affected.

## sources
- supporting page: [jump-table.md](jump-table.md)
- memory map: [../memory/map.md](../memory/map.md)
```

## allowed-sections
| section | use |
|---|---|
| `routes` | Curated directory `INDEX.md` navigation, including cross-domain routes. |
| `pages` | Generated exhaustive page list in a directory `INDEX.md`. Never hand-edited. |
| `facts` | Short cited truths. |
| `lookup` | Compact tables for addresses, symbols, calls, opcodes, codes, or bits. |
| `constraints` | `MUST`, `SHOULD`, `MUST NOT`, `MAY` rules. |
| `sequence` | Ordered operational steps for calls or tasks. |
| `examples` | Minimal code or data examples only. |
| `sources` | Upstream citations plus the local Markdown pages that support the facts. The single tail section on a reference page. |
| `links` | Navigation footer on a root or directory index only. MUST NOT appear on a reference page. |

- `source-coverage` is retired; it restated the sibling `routes` and `related` rows. `links` is retired on reference pages, where it duplicated `sources`. Both are rejected by `scripts/audit.ps1`.
- `sources` MUST NOT carry a bare pointer to [sources/INDEX.md](sources/INDEX.md). When to consult it is a consumption rule in [AGENTS.md](AGENTS.md), not per-page boilerplate.

## generated-artifacts
| artifact | contents |
|---|---|
| [ROUTE.md](ROUTE.md) | One row per reference page: path, `summary`, and terms. Grep target. |
| [SYMBOLS.md](SYMBOLS.md) | `$`-address and KERNAL/register symbol to its authoritative page. Grep target. |
| `*/INDEX.md` `## pages` | Exhaustive per-domain page list between `<!-- GENERATED:routes -->` markers. |

- These are derived from leaf front matter by `scripts/generate-routes.ps1`. Editing them by hand MUST NOT happen; the change is overwritten on the next run and fails the audit's drift check in the meantime.
- Regenerate after adding, removing, or re-describing any page: `./scripts/generate-routes.ps1`.
- Neither grep target is meant to be read whole. `ROUTE.md` is larger than [INDEX.md](INDEX.md); the curated `## quick-route` table remains the whole-file entry point.

## section-naming
- The table above defines common base sections, not an exclusive vocabulary.
- A page MAY use a more specific domain heading such as `directives`, `flags`, `formulas`, or `registers` when it is clearer than a generic base name.
- Repeated sections SHOULD qualify a base with an em dash, for example `sequence — sprite repositioning` or `lookup — control codes`.
- Section names MUST remain compact, factual, and useful for retrieval.

## compactness
- Atomic files SHOULD fit one concept, address range, chip, API family, or table.
- Atomic files MUST omit empty sections.
- Atomic files SHOULD prefer source pointers over copied prose.
- Large source categories SHOULD be split by task, chip, address range, or API family.

## provenance
- Every non-index factual file MUST include `## sources`.
- A fact derived from multiple local pages SHOULD list all local pages that support or constrain it.
- When two source files disagree, the local page MUST include a compact conflict note and SHOULD not silently choose one source.
- Source sections MUST cite supporting local Markdown pages when the facts are already represented locally.
- Pages derived directly from an upstream article MAY also cite that specific upstream URL and MUST include [sources/INDEX.md](sources/INDEX.md) as the local provenance route.
