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
| Source citations | MUST include local provenance; MAY include a direct upstream URL for directly derived pages | `../sources/INDEX.md` plus the specific upstream article |

## front-matter
| page type | required fields | notes |
|---|---|---|
| Root contract/style | `type`, `domain`, `source` | `domain` is `root`. |
| Directory index | `type: index`, `domain`, `source` | `domain` MUST match its directory (`cpu/6502` for that nested domain). |
| Factual reference | `type: reference`, `domain`, `granularity` | `granularity` SHOULD be `atomic`, `chip`, `device`, or `recipe`. |

- `source` MAY be omitted from factual references when the `## sources` section is the more accurate mixed-source authority.
- When present, `source` MUST use the canonical identifier already used by the repository: `c64ref`, `codebase64.net`, `commodore-manual`, `hvsc`, `6502.org`, `assembler-docs`, `tool-docs`, `cross-domain`, or `mixed`.

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

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [symbols.md](symbols.md) | used | Symbol coverage |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Upstream fallback route |

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
---

## facts
- `ACPTR` MUST be called at `$FFA5`.
- Callers SHOULD prepare the serial device with `TALK` and `TKSA` when applicable.

## lookup
| symbol | address | category | inputs | outputs | clobbers |
|---|---:|---|---|---|---|

## constraints
- Code MUST preserve registers unless the routine contract says they are affected.

## links
- memory: [memory/map.md](memory/map.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- supporting page: [jump-table.md](jump-table.md)
```

## allowed-sections
| section | use |
|---|---|
| `routes` | Directory `INDEX.md` navigation. |
| `source-coverage` | Directory-level provenance and source usage status. |
| `facts` | Short cited truths. |
| `lookup` | Compact tables for addresses, symbols, calls, opcodes, codes, or bits. |
| `constraints` | `MUST`, `SHOULD`, `MUST NOT`, `MAY` rules. |
| `sequence` | Ordered operational steps for calls or tasks. |
| `examples` | Minimal code or data examples only. |
| `links` | Internal cross-domain references. |
| `sources` | Local Markdown pages and centralized provenance routes used. |

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
