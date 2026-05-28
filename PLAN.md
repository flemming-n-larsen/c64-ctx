# C64 Reference Index — Content Expansion Plan

## Context

The index has solid governance (AGENTS.md, STYLE.md, sources/INDEX.md) and routing structure, but most content pages are stubs ("planned"). Several domains are still missing or too thin for the repo goal: AI agents should be able to write, build, run, and explain practical C64 programs using local reference pages instead of inventing details.

This plan prioritizes the reference layers needed before demo effects and demo-scene-specific material: BASIC V2, common assembler syntax, task recipes, runnable program shapes, and PC toolchain workflows for `VICE`, `KickAssembler`, `ACME`, `CA65`, `64tass`, and `CBM Studio`.

**Working rule:** Each task row MUST have its checkbox updated to `[x]` as soon as that task is completed — do not batch checkbox updates at the end of a phase.

**User decisions recorded here:**
- BASIC V2 source: C64 Programmer's Reference Guide (1982) — AI-first summaries, no verbatim copy
- cbmbasic (mist64) is NOT a source — it is a portable C implementation, not documentation
- Assemblers to cover: ACME, KickAssembler, CA65 (cc65), 64tass
- Workflows should be editor-neutral; mention that any editor can invoke the same tools, but do not make correctness depend on editor-specific config files
- Demo effects and demo-scene topics are intentionally deferred until the programming foundation is usable
- Plan file location: repo root as `PLAN.md`

---

## Phases

Dependencies: Phase 1 unblocks Phase 6. Phases 2 + 3 are independent (run in parallel). Phase 4 follows Phase 2. Phase 5 follows Phases 2 + 4. Phase 7 follows Phase 6 and uses Phase 3. Phase 8 follows Phases 3, 5, 6, and 7.

```
Phase 1 (CPU)  ──────────────────────────────────► Phase 6 (ASM) ──► Phase 7 (Toolchains)
Phase 2 (I/O)  ──► Phase 4 (Charset/Memory) ──► Phase 5 (Tasks) ───┤
Phase 3 (BASIC) ────────────────────────────────────────────────────┘

Phases 3 + 5 + 6 + 7 ─────────────────────────────► Phase 8 (Runnable Examples + Validation)
```

---

## Phase 1 — CPU Foundation
*Unblocks assembler pages (Phase 6). All pages already exist as stubs.*

| done | file | change | key content |
|---|---|---|---|
| [x] | `cpu/6502/registers-flags.md` | status only | Already complete — update INDEX status from `planned` → `used` |
| [x] | `cpu/6502/addressing-modes.md` | expand | Add byte-count column; add ZP,Y row; note page-crossing penalty rule |
| [x] | `cpu/6502/instruction-set.md` | major expand | Replace class-groups stub with full per-mnemonic table: `mnemonic \| mode(s) \| opcode \| bytes \| cycles \| cycle-notes \| flags` — all 56 documented mnemonics; keep existing class-groups as summary above table |
| [x] | `ATTRIBUTION.md` | update | Add entry for mist64/c64ref `src/6502` as source for CPU timing and opcode data |

Source: mist64/c64ref `src/6502`

---

## Phase 2 — I/O Register Completions
*Unblocks task recipes (Phase 5) and custom-charset task.*

| done | file | change | key content |
|---|---|---|---|
| [x] | `io/vic-ii.md` | major expand | All 47 registers `$D000-$D02E`; columns: `address \| name \| bits/fields \| R/W \| notes`; full bit breakdowns for `$D011`, `$D016`, `$D018`, `$D019`, `$D01A`, `$D020-$D02E`; add VIC bank note (CIA2 `$DD00` bits 0-1, inverted) |
| [x] | `io/sid.md` | major expand | All 25 registers `$D400-$D418`; per-voice grouping; CR bit fields (GATE, SYNC, RING, TEST, TRI, SAW, PUL, NOI); ATDCY/SUREL nybble layout; read-only OSC3/ENV3 note |
| [x] | `io/cia1.md` | expand | All 16 registers `$DC00-$DC0F`; columns: `address \| register \| role \| bits/fields \| R/W`; keyboard scan pattern note (drive col via PRA, read row from PRB) |
| [x] | `io/cia2.md` | expand | All 16 registers `$DD00-$DD0F`; VIC bank select bits 0-1 in `$DD00` (inverted); NMI vs IRQ source distinction |
| [x] | `ATTRIBUTION.md` | update | Add entry for mist64/c64ref `src/c64io` as source for VIC-II, SID, CIA1, CIA2 register data |

Source: mist64/c64ref `src/c64io`

---

## Phase 3 — BASIC V2 Domain
*Independent of Phases 2 and 4. Can run in parallel. Must cover both reference lookup and practical runnable BASIC programs.*

| done | file | change | key content |
|---|---|---|---|
| [x] | `basic/tokens.md` | fill | Full token table `$80-$CB` (keyword → byte); `$FF` prefix tokens; source: mist64/c64ref `src/c64disasm` |
| [x] | `basic/keywords.md` | **new** | All BASIC V2 statements/commands; columns: `keyword \| token \| syntax \| type \| parameters \| notes \| example`; type = statement/command/operator; one-line example per row |
| [x] | `basic/functions.md` | **new** | All built-in functions; columns: `function \| syntax \| return type \| argument constraints \| notes`; numeric (ABS, ATN, COS, EXP, FRE, INT, LOG, PEEK, POS, RND, SGN, SIN, SQR, TAN, USR, VAL) and string (ASC, CHR$, LEFT$, LEN, MID$, RIGHT$, STR$) |
| [x] | `basic/errors.md` | **new** | All 29 error messages; columns: `code \| message \| conditions` |
| [x] | `basic/program-structure.md` | **new** | Line-numbered program shape; immediate mode vs program mode; statement separators; `REM`; `RUN`, `LIST`, `NEW`; compact runnable examples |
| [x] | `basic/variables.md` | **new** | Numeric, string, and integer variables; arrays; naming limits; type suffixes; common interpreter pitfalls |
| [x] | `basic/io.md` | **new** | `PRINT`, `INPUT`, `GET`, `OPEN`, `CLOSE`, `CMD`, `PRINT#`, `INPUT#`, `GET#`; device/file concepts at BASIC level; links to KERNAL file task pages |
| [x] | `basic/graphics-sound.md` | **new** | Practical `POKE`/`PEEK` routes for border/background colors, screen RAM, color RAM, sprite registers, and SID registers; link to `io/`, `colors/`, and `tasks/` instead of duplicating hardware tables |
| [x] | `basic/machine-code-bridge.md` | **new** | `SYS`, `USR`, `PEEK`, `POKE`, `DATA`/`READ` loaders, and BASIC-to-machine-language launch patterns; link to `memory/map.md` and `asm/common-patterns.md` |
| [x] | `basic/examples.md` | **new** | Tiny complete programs: print text, set border/background, read key, play simple tone, load/call machine code; each example links back to cited reference pages |
| [x] | `basic/INDEX.md` | update | Add routes for all new BASIC pages; update tokens.md status → `used`; route "write BASIC program" prompts to program-structure/examples first |
| [x] | `sources/INDEX.md` | update | Split BASIC provenance: token bytes and ROM routes from mist64/c64ref `src/c64disasm`; language semantics from C64 Programmer's Reference Guide |
| [x] | `ATTRIBUTION.md` | verify/update | Verify entries for C64 Programmer's Reference Guide (CBM, 1982) and mist64/c64ref `src/c64disasm` as BASIC sources |

Source: C64 Programmer's Reference Guide (CBM, 1982) — AI-summarized; cite as `C64 Programmer's Reference Guide (Commodore Business Machines, 1982)` in `## sources` of each file. Token bytes from mist64/c64ref.

---

## Phase 4 — Charset and Memory Completions
*Follows Phase 2. Unblocks task recipes.*

| done | file | change | key content |
|---|---|---|---|
| [ ] | `charset/petscii.md` | major expand | Full 256-entry table `$00-$FF`; columns: `code \| name \| printable \| shifted name \| notes`; KERNAL CHROUT range note |
| [ ] | `charset/screen-codes.md` | major expand | Full 256-entry table; columns: `code \| Unicode name (primary) \| PETSCII equiv \| notes`; not-relationship for `$80-$FF` |
| [ ] | `charset/control-codes.md` | verify + expand | Verify completeness; expand `$95-$9F` color range to individual rows if missing; add CHROUT-only vs keyboard-only note |
| [ ] | `charset/keyboard-matrix.md` | major expand | Full 8×8 matrix; columns: `row \| col \| key \| unshifted PETSCII \| shifted \| CBM \| CTRL`; joystick note |
| [ ] | `memory/map.md` | expand | ~20 sub-regions `$0000-$FFFF`; columns: `range \| default content \| banking-sensitive \| size \| read first`; include CPU vectors `$FFFA-$FFFE` |
| [ ] | `memory/symbols.md` | expand | Add KERNAL workspace symbols `$90-$FF`; add key vectors `$0314` (IRQ), `$0316` (BRK), `$0318` (NMI); columns: `address \| symbol \| owner \| aliases/notes` |
| [ ] | `memory/zero-page.md` | expand | Add secondary table for KERNAL workspace `$0090-$00FF` with cross-links to symbols.md |
| [ ] | `ATTRIBUTION.md` | update | Add entries for mist64/c64ref `src/charset` and `src/c64mem` as sources for charset and memory pages |

Source: mist64/c64ref `src/charset`, `src/c64mem`

---

## Phase 5 — Task Recipes
*Follows Phases 2 + 4. Task pages use structure: `## sequence` → `## lookup` → `## constraints` → optional `## examples` → `## links` → `## sources`.*

Task pages route practical workflows to cited reference pages. They MUST NOT become duplicate hardware/register dumps.

| done | file | change | key content |
|---|---|---|---|
| [x] | `tasks/sprite-display.md` | **new** | 6-step sequence: sprite pointer `$07F8+n`, data block, X/Y at `$D000-$D00F`, MSB in `$D010`, enable `$D015`, color `$D027+n` |
| [ ] | `tasks/play-sid.md` | **new** | 7-step sequence: FREQLO/HI, PWLO/HI, ATDCY, SUREL, CR gate on/off; vol init `$D418=$0F` first |
| [ ] | `tasks/custom-charset.md` | **new** | 4-step sequence: bank in char ROM (`$0001` CHAREN=0), copy `$D000-$DFFF` to RAM, modify bytes (base + sc×8), point VIC-II `$D018` |
| [ ] | `tasks/game-loop.md` | **new** | Pattern recipe: init → read input → update state → draw (screen codes + sprites) → sync (raster poll or IRQ) → loop |
| [ ] | `tasks/program-entrypoints.md` | **new** | Choosing BASIC-only, BASIC loader + `SYS`, standalone `.prg`, KERNAL-using ML, and cartridge/ROM-style entry assumptions; route to BASIC, ASM, memory, and toolchains pages |
| [ ] | `tasks/raster-interrupt.md` | verify status | Check if content exists; update status → `used` if complete |
| [ ] | `tasks/read-keyboard.md` | verify status | Check if content exists; update status → `used` if complete |
| [ ] | `tasks/bank-switch-rom-ram.md` | verify status | Check if content exists; update status → `used` if complete |
| [ ] | `tasks/load-save-file.md` | verify status | Check if content exists; update status → `used` if complete |
| [ ] | `tasks/INDEX.md` | update | Add routes for new pages; update statuses |

---

## Phase 6 — Assembler Domain (new)
*Follows Phase 1. Entirely new domain. Must support agents writing and translating buildable source, not just recognizing directives.*

New directory: `asm/`

| done | file | change | key content |
|---|---|---|---|
| [ ] | `asm/INDEX.md` | **new** | Routes to all 4 assembler pages; related: `cpu/6502`, `memory`, `tasks` |
| [ ] | `asm/acme.md` | **new** | Version 0.97+; `## directives` table (`*=`, `!byte`, `!word`, `!text`, `!scr`, `!fill`, `!align`, `!to`, `!cpu`, `!zone`, `!src`, `!binary`); `## macros` (`!macro`/`+name`); `## expressions` (`<`/`>` byte operators, anonymous `+`/`-` labels); output formats |
| [ ] | `asm/kickassembler.md` | **new** | Version 5.x, JVM-required; `## directives` (`.pc`, `.byte`, `.word`, `.text`, `.fill`, `.align`, `.import`, `.var`, `.const`, `.enum`); `## macros` (`.macro name(args)`); `## scripting` (`.eval`, `:` prefix, list/hashtable literals) |
| [ ] | `asm/ca65.md` | **new** | cc65 v2.19+; `## directives` (`.org`/`.segment`, `.byte`, `.word`, `.res`, `.asciiz`, `.include`, `.incbin`, `.macro`/`.endmacro`, `.scope`, `.proc`, `.export`, `.import`); `## segments` (CODE/RODATA/DATA/BSS/ZEROPAGE); `## linker-config` (`ld65 -t c64`, custom `.cfg` MEMORY+SEGMENTS) |
| [ ] | `asm/64tass.md` | **new** | v1.58+; `## directives` (`*=`, `.byte`, `.word`, `.text`, `.fill`, `.align`, `.include`, `.binclude`, `.cpu`, `.enc`, `.namespace`, `.proc`, `.macro`/`.endm`, `.struct`); `## output-options` (`--cbm-prg`, `--flat`, `--format=`); `## labels` (local `_`, scoped `.`, anonymous `+`/`-`) |
| [ ] | `asm/rosetta.md` | **new** | Cross-assembler equivalence table: set PC, emit byte/word/text, include source/binary, reserve/fill/align data, macros, local labels, anonymous labels, low/high byte expressions, PETSCII/screen text, output `.prg` |
| [ ] | `asm/common-patterns.md` | **new** | BASIC `SYS` stub pattern, standalone `.prg` layout, safe code placement choices, KERNAL-call setup pattern, zero-page scratch cautions, minimal "hello" shape per assembler |
| [ ] | `INDEX.md` | update | Add `asm` row to domains table and quick-route table |
| [ ] | `sources/INDEX.md` | update | Add `asm` row to corpus-map (no mist64 upstream — cite each assembler's own versioned docs) |
| [ ] | `ATTRIBUTION.md` | verify/update | Verify note that assembler pages cite assembler-specific upstream docs, not mist64/c64ref; list ACME, KickAssembler, ca65, 64tass doc sources |

---

## Phase 7 — Toolchains and Runnable Workflows (new)
*Follows Phase 6 and uses BASIC/task pages. This phase is the bridge from reference facts to working `.prg` files on a PC.*

New directory: `toolchains/`

| done | file | change | key content |
|---|---|---|---|
| [ ] | `toolchains/INDEX.md` | **new** | Routes for emulator, assembler, and project workflows; quick route for "build/run this in VICE" prompts |
| [ ] | `toolchains/vice.md` | **new** | Editor-neutral `.prg` run/autostart/debug loop; command-line launch examples; monitor route; note when emulator behavior is outside source corpus and must cite VICE docs |
| [ ] | `toolchains/kickassembler-workflow.md` | **new** | Minimal source → `.prg` → `VICE` loop; JVM/tool invocation assumptions; links to `asm/kickassembler.md` and `asm/common-patterns.md` |
| [ ] | `toolchains/acme-workflow.md` | **new** | Minimal source → `.prg` → `VICE` loop; output directive expectations; links to `asm/acme.md` |
| [ ] | `toolchains/ca65-workflow.md` | **new** | `ca65`/`ld65` C64 build patterns; when `ld65 -t c64` is enough vs custom linker config; links to `asm/ca65.md` |
| [ ] | `toolchains/64tass-workflow.md` | **new** | `.prg` output workflow; `--cbm-prg`, flat output distinction, and `VICE` run loop; links to `asm/64tass.md` |
| [ ] | `toolchains/cbm-studio.md` | **new** | CBM Studio project/workflow assumptions and source-reference routes; do not duplicate assembler reference tables |
| [ ] | `INDEX.md` | update | Add `toolchains` row to domains table; add quick-route row for PC build/run workflows |
| [ ] | `sources/INDEX.md` | update | Add local provenance routes for `VICE`, assembler tool docs, and `CBM Studio` documentation |
| [ ] | `ATTRIBUTION.md` | verify/update | Add or verify attribution/source notes for `VICE`, `CBM Studio`, and assembler workflow documentation |

---

## Phase 8 — Runnable Examples and Validation Prompts (new)
*Follows Phases 3, 5, 6, and 7. Examples prove that the reference pages are actionable for agents.*

New directory: `examples/`

| done | file | change | key content |
|---|---|---|---|
| [ ] | `examples/INDEX.md` | **new** | Route complete runnable examples by language/toolchain/task; each route links to BASIC, ASM, task, memory, I/O, charset/color, and toolchain pages |
| [ ] | `examples/basic-border-background.md` | **new** | Complete BASIC V2 program changing border/background colors; cite `basic/graphics-sound.md`, `colors/INDEX.md`, and `io/vic-ii.md` |
| [ ] | `examples/basic-read-key.md` | **new** | Complete BASIC V2 keyboard example; cite `basic/io.md`, `tasks/read-keyboard.md`, and charset/keyboard pages |
| [ ] | `examples/basic-sys-loader.md` | **new** | BASIC loader using `DATA`, `POKE`, and `SYS` to call machine code; cite `basic/machine-code-bridge.md`, `tasks/program-entrypoints.md`, and `memory/map.md` |
| [ ] | `examples/acme-hello.md` | **new** | Minimal buildable ACME program with BASIC start or documented entrypoint; cite `asm/acme.md`, `asm/common-patterns.md`, and `toolchains/acme-workflow.md` |
| [ ] | `examples/kickassembler-sprite.md` | **new** | Minimal buildable KickAssembler sprite example; cite `asm/kickassembler.md`, `tasks/sprite-display.md`, and `toolchains/kickassembler-workflow.md` |
| [ ] | `examples/ca65-minimal-prg.md` | **new** | Minimal `ca65`/`ld65` C64 `.prg`; cite `asm/ca65.md`, `asm/common-patterns.md`, and `toolchains/ca65-workflow.md` |
| [ ] | `examples/64tass-hello.md` | **new** | Minimal `64tass` `.prg`; cite `asm/64tass.md`, `asm/common-patterns.md`, and `toolchains/64tass-workflow.md` |
| [ ] | `INDEX.md` | update | Add optional `examples` row to domains table and quick-route table for complete runnable programs |
| [ ] | `sources/INDEX.md` | update | Add `examples` row as cross-domain derived pages; examples cite local reference pages rather than upstream sources directly unless needed |

---

## Constraints (apply to all phases)

- All pages MUST follow AGENTS.md + STYLE.md: tables over prose, no empty sections, sources section required
- MUST NOT copy verbatim text from C64 PRG — AI-first summaries only
- MUST NOT add assembler pages to mist64/c64ref upstream in sources/INDEX.md — cite assembler-specific docs
- Task pages MUST NOT duplicate I/O register tables — use `## lookup` rows routing to `io/` pages
- Examples MUST link back to cited `basic/`, `asm/`, `tasks/`, `io/`, `memory/`, `charset/`, `colors/`, and `toolchains/` pages instead of becoming uncited fact dumps
- Toolchain pages MUST be editor-neutral and MUST NOT require editor-specific project/config files for correctness
- CPU timing data MUST cite mist64/c64ref `src/6502`
- Each assembler page MUST state the targeted assembler version in `## facts`
- Workflow pages SHOULD state command/version assumptions and route exact tool behavior to `sources/INDEX.md` or tool-specific docs

---

## Verification

After each phase:
1. All new/expanded files have `## sources` sections with correct relative links
2. INDEX.md files in affected domains have updated routes and source-coverage status
3. No dangling references: every internal link resolves to an existing file
4. Root `INDEX.md` routes reach the new `asm` domain
5. Root `INDEX.md` routes reach the new `toolchains` domain and optional `examples` domain
6. `sources/INDEX.md` corpus-map includes `asm`, `toolchains`, and optional `examples` entries

End-to-end validation matrix:

| prompt | expected local route |
|---|---|
| "Write a BASIC V2 program that changes border/background colors." | `basic/program-structure.md` → `basic/graphics-sound.md` → `colors/INDEX.md` → `io/vic-ii.md` |
| "Write a KickAssembler sprite display program runnable in VICE." | `toolchains/kickassembler-workflow.md` → `asm/kickassembler.md` → `tasks/sprite-display.md` → `io/vic-ii.md` → `memory/map.md` |
| "Write a CA65 program using ld65 -t c64." | `toolchains/ca65-workflow.md` → `asm/ca65.md` → `asm/common-patterns.md` → `memory/map.md` |
| "Convert this ACME snippet to 64tass." | `asm/rosetta.md` → `asm/acme.md` → `asm/64tass.md` |
| "Write a BASIC loader that calls machine code." | `basic/machine-code-bridge.md` → `tasks/program-entrypoints.md` → `memory/map.md` → selected `asm/` page |
| "Build and run this `.prg` on a PC." | `toolchains/INDEX.md` → `toolchains/vice.md` → selected assembler workflow |

The plan is complete for the repo goal when these prompts can be answered without hitting `planned` stubs in the selected route.
