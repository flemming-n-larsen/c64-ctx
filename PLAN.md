# PLAN — read-speed and findability optimization

Completed on branch `agent/reading-speed-optimization`. Not corpus content; exempt from the front-matter and orphan checks in `scripts/audit.ps1`.

## Problem

The routing layer costs more than the answers. Measured on the path `AGENTS.md` mandates (root `INDEX.md` → domain `INDEX.md` → leaf page) for "what does `$D018` do?": 25,778 B, of which **66% is routing, not answer**.

| cause | measured |
|---|---|
| Root `INDEX.md` states routing three times (`quick-route`, `domains`, `source-map`); `README.md` and `AGENTS.md` state it a fourth and fifth | `domains` 4,720 B + `source-map` 1,895 B |
| 28 `## source-coverage` tables restate their sibling `## routes` and `## related` rows, status `used` | 27,120 B = **25% of the whole index layer** |
| Per-page `## links` + `## sources` + front matter | 3,561 of 13,828 leaf lines = **26%** |
| The same `sources/INDEX.md` pointer repeated under four labels | 200 of 210 pages |
| No page is self-describing — no title, summary, or keywords anywhere | **0 of 210** leaf pages |

Findability is the worse half: only **20 of 210** leaf pages are named in the root index. Domain indexes hold good synonym vocabulary that never propagates up, so jargon is invisible to a first-pass search — `tech-tech` (`effects/swing.md`), `twister`/`X-rotator` (`effects/2nd-line-fli.md`), sprite stretching (`effects/dysp.md`), Permanent Raster Split (`display-modes/prs.md`), `hard restart`, `interlace`, `sine table`, `REU`, `jitter`, `load address`, `BCD`, `jiffy`, `ADSR`, `TOD clock` — none appear in the root index.

## Target

One hop instead of three; 6–8 KB instead of 26 KB; jargon resolves without guessing a directory. The index layer becomes generated from leaf front matter so it cannot drift, and `scripts/audit.ps1` proves it current.

| file | authored | role |
|---|---|---|
| `INDEX.md` | hand-written, ~6.7 KB | whole-read entry for agents without text search |
| `ROUTE.md` | generated, ~38 KB | grep entry: page, summary, keywords |
| `SYMBOLS.md` | generated, ~18 KB | grep entry: `$`-address / KERNAL symbol → page |
| `*/INDEX.md` | `## routes` generated between markers, `## related` hand-written | domain fallback, now exhaustive |

`ROUTE.md` is a grep target and MUST NOT be read whole — 210 rows is larger than today's root index. Slimming `INDEX.md` is what keeps the no-search path fast.

## Phases

### ✓ Phase 0 — Branch
`agent/reading-speed-optimization` off `main`. Baseline audit green: 243 files, 194 external URLs.

### ✓ Phase 1 — Delete redundant routing tables
Pure subtraction, no new tooling, ~35 KB off the hot path.

- Delete all 28 `## source-coverage` tables. Verified against the link graph: orphans zero pages.
- Root `INDEX.md`: delete `## domains` and `## source-map`. Safe because `audit.ps1` skips files named `INDEX.md` in the orphan check.
- Rewrite `## quick-route` to target leaf pages wherever one page answers.
- `AGENTS.md`: delete `## source-preference` (all 9 rows share an identical provenance cell) and the stale clause about "generated HTML output" — no such artifact exists in this repo.

### ✓ Phase 2 — Make leaf pages self-describing
Add to all 210 leaf pages:

```yaml
summary: "Six-step sprite setup: data alignment, pointer, X/Y, color, enable bit."
keywords: [sprite setup, sprite pointer, $07f8, $d015, 64-byte alignment]
```

- `keywords` MUST use YAML flow style. `Get-FrontMatter` matches line-by-line; a block list parses as empty and silently drops entries.
- `summary` states what the page **answers**, not what it contains. ≤100 chars, one line, no Markdown links. The first `## facts` bullet is the drafting source on 177 pages; the 17 pages opening straight into `## lookup` need one written.
- `keywords` carries only what a regex cannot recover — jargon and synonyms. Addresses and `## lookup` symbols are auto-extracted. 2–4 typical, 8 max.

Domain batches, smallest first, auditing after each.

### ✓ Phase 3 — Generate the routing layer
`scripts/generate-routes.ps1 [-Check]`, PowerShell 7, no new dependency. Factor `Get-FrontMatter` and `Get-ContentWithoutFences` into `scripts/lib/markdown.ps1` first, dot-sourced from both scripts, so the parser cannot fork.

- `ROUTE.md` — one row per leaf, sorted by path. Keywords = union of extracted and declared.
- `SYMBOLS.md` — in-range addresses (`$0000-$01FF`, `$D000-$DFFF`, `$FF00-$FFFF`) plus uppercase symbols from `## lookup` first columns. Symbol → authoritative page → up to 4 "also in" as bare paths. Rank by declared-in-keywords, then domain in `io`/`memory`/`kernal`/`charset`, then fewest addresses on the page. **Skip pages with >60 distinct addresses** (`charset/chargen-*.md` at 261 each, `cpu/6502/instruction-set.md` 155, `illegal-opcodes.md` 110, the SID frequency tables) — without the cap `$D018` alone lists 46 pages.
- `## routes` blocks in the 28 domain indexes, wrapped in `<!-- GENERATED:routes -->`. HTML comments are invisible on GitHub and pass through `Get-ContentWithoutFences` untouched.

`ROUTE.md` and `SYMBOLS.md` need `type: index` / `domain: root` front matter and an inbound link from `README.md`.

### ✓ Phase 4 — Enforce it
Add to `audit.ps1`, warning-level during Phase 2 and error-level here: `summary` present and ≤100 chars with no `](`; `keywords` present, flow style, 2–8 entries; no `summary`/`keywords` on `INDEX.md`; no `## source-coverage` heading; every reference page appears exactly once in `ROUTE.md`; and a **drift check** running `generate-routes.ps1 -Check`.

**Revised orphan check:** exclude links originating from `ROUTE.md` and `SYMBOLS.md` when building `$linkedFiles`. Otherwise `ROUTE.md` links all 210 pages and the check becomes vacuous — it must keep measuring hand-authored and domain-route reachability.

`.github/workflows/documentation-audit.yml` needs no change.

### ✓ Phase 5 — Consolidate leaf tails
Merge `## links` into a single deduped `## sources`; **do not delete the cross-references**. Across the 210 pages holding both, `## links` has 1,106 distinct targets against `## sources`' 658, overlapping on only 205 and a strict subset on 7 — those ~900 unique targets are the real cross-reference graph.

What is safe and large: strip the repeated `sources/INDEX.md` pointer from the 200 pages carrying it, and merge the two headings. ~825 lines, ~26 KB, no information loss. The 10 pages currently reachable only via a tail link are covered by the Phase 3 generated routes, so `$orphanAllowList` stays at one entry.

### ✓ Phase 6 — Rewrite the contracts
`AGENTS.md` `## consumption-rules` becomes two-path and one-hop: search `ROUTE.md`/`SYMBOLS.md` then read the page; without search, `INDEX.md` `## quick-route` then the page; domain index only as fallback; read a page's `summary` before its body when several candidates match; and **MUST NOT read `sources/INDEX.md` to answer a question** — 11,822 B that today's vague "when ambiguity matters" trigger invites onto the hot path.

`STYLE.md`: document `summary`/`keywords`; drop `source-coverage` and `links` from `## allowed-sections`; update both templates; add a `## generated-artifacts` section.

### ✓ Phase 7 — Verify
`audit.ps1` green after every batch; `generate-routes.ps1 -Check` exits 0; one `audit.ps1 -CheckExternal` pass at the end (CI runs it weekly only, so it will not have run on the branch).

Then the behavioral benchmark, which is the actual deliverable: 8 queries — `$D018`, sprite multiplexer, tech-tech, twister, hard restart, screen split, read the keyboard, color mixing banding — resolved on this branch versus on `main`, recording bytes opened per query.

## Result (measured, all phases complete)

Eight queries resolved on this branch and on `main`, counting the bytes actually opened. All eight resolve in **one grep** of a routing artifact; on `main` three of them (`tech-tech`, `twister`, `screen split`) had no root-index route at all and required guessing a directory first.

| query | `main` (three hops) | with search | without search |
|---|---:|---:|---:|
| `$D018` | 25,716 | 8,912 | 18,314 |
| sprite multiplexer | 22,761 | 3,686 | 12,788 |
| tech-tech | 22,848 | 3,729 | 17,306 |
| twister effect | 23,176 | 3,884 | 17,622 |
| hard restart | 18,937 | 2,855 | 12,195 |
| split the screen | 21,534 | 3,476 | 16,596 |
| read the keyboard | 20,862 | 1,940 | 11,286 |
| color mixing banding | 17,615 | 3,038 | 12,367 |
| **total** | **173,449** | **31,520 (−82%)** | **118,474 (−32%)** |

| layer | main | now |
|---|---:|---:|
| root `INDEX.md` | 13,327 | 9,532 |
| `AGENTS.md` | 4,195 | 3,146 |
| index layer (29 files) | 106,585 | 80,963 |
| leaf layer (210 pages) | 703,104 | 708,307 |
| generated layer | — | 87,004 |

The search path beat the −70% estimate; the no-search path missed its −36% estimate at −32%, because `## quick-route` grew to 48 rows (9,532 B against a 6,700 B target) to name 60 leaf pages instead of 20. That is a deliberate trade: the extra rows remove a domain-index hop for those topics, which is worth more than the bytes it costs.

Leaf pages grew slightly overall (−25,574 B of merged tails against +30,777 B of front matter). The win is on the read path, not repo size.

## Out of scope

- `granularity` has 30 distinct values where `STYLE.md` names 4 (`emulator` *and* `emulators`; `reference` alongside `type: reference`). Required but unvalidated — it neither routes nor filters. Close the vocabulary or drop the field, in a separate pass.
- `tasks/raster-interrupt.md` is a 23-line redirect stub repeating one target three times, and is the sole `$orphanAllowList` entry. Deletion candidate.
- No coverage at all for VSP, linecrunch, AGSP, sprite crunching, DMA delay, Kefrens bars, copper lists, double buffering, NOP slide. A content gap, not a routing one.
