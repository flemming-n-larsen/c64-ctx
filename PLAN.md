# C64 Reference Index — Content Expansion Plan

## Context

The index has solid governance (AGENTS.md, STYLE.md, sources/INDEX.md) and routing structure, but most content pages are stubs ("planned"). Two entire domains are absent that are critical for AI agents doing C64 demo and game programming: BASIC V2 command reference and assembler syntax. This plan fills both gaps and completes the highest-priority existing stubs.

**User decisions recorded here:**
- BASIC V2 source: C64 Programmer's Reference Guide (1982) — AI-first summaries, no verbatim copy
- cbmbasic (mist64) is NOT a source — it is a portable C implementation, not documentation
- Assemblers to cover: ACME, KickAssembler, CA65 (cc65), 64tass
- Plan file location: repo root as `PLAN.md`

---

## Phases

Dependencies: Phase 1 unblocks Phase 6. Phases 2 + 3 are independent (run in parallel). Phase 4 follows Phase 2. Phase 5 follows Phases 2 + 4.

```
Phase 1 (CPU)  ──────────────────────────────────► Phase 6 (ASM)
Phase 2 (I/O)  ──► Phase 4 (Charset/Memory) ──► Phase 5 (Tasks)
Phase 3 (BASIC) — independent
```

---

## Phase 1 — CPU Foundation
*Unblocks assembler pages (Phase 6). All pages already exist as stubs.*

| file | change | key content |
|---|---|---|
| `cpu/6502/registers-flags.md` | status only | Already complete — update INDEX status from `planned` → `used` |
| `cpu/6502/addressing-modes.md` | expand | Add byte-count column; add ZP,Y row; note page-crossing penalty rule |
| `cpu/6502/instruction-set.md` | major expand | Replace class-groups stub with full per-mnemonic table: `mnemonic \| mode(s) \| opcode \| bytes \| cycles \| cycle-notes \| flags` — all 56 documented mnemonics; keep existing class-groups as summary above table |

Source: mist64/c64ref `src/6502`

---

## Phase 2 — I/O Register Completions
*Unblocks task recipes (Phase 5) and custom-charset task.*

| file | change | key content |
|---|---|---|
| `io/vic-ii.md` | major expand | All 47 registers `$D000-$D02E`; columns: `address \| name \| bits/fields \| R/W \| notes`; full bit breakdowns for `$D011`, `$D016`, `$D018`, `$D019`, `$D01A`, `$D020-$D02E`; add VIC bank note (CIA2 `$DD00` bits 0-1, inverted) |
| `io/sid.md` | major expand | All 25 registers `$D400-$D418`; per-voice grouping; CR bit fields (GATE, SYNC, RING, TEST, TRI, SAW, PUL, NOI); ATDCY/SUREL nybble layout; read-only OSC3/ENV3 note |
| `io/cia1.md` | expand | All 16 registers `$DC00-$DC0F`; columns: `address \| register \| role \| bits/fields \| R/W`; keyboard scan pattern note (drive col via PRA, read row from PRB) |
| `io/cia2.md` | expand | All 16 registers `$DD00-$DD0F`; VIC bank select bits 0-1 in `$DD00` (inverted); NMI vs IRQ source distinction |

Source: mist64/c64ref `src/c64io`

---

## Phase 3 — BASIC V2 Domain
*Independent of Phases 2 and 4. Can run in parallel.*

| file | change | key content |
|---|---|---|
| `basic/tokens.md` | fill | Full token table `$80-$CB` (keyword → byte); `$FF` prefix tokens; source: mist64/c64ref `src/c64disasm` |
| `basic/keywords.md` | **new** | All BASIC V2 statements/commands; columns: `keyword \| token \| syntax \| type \| parameters \| notes \| example`; type = statement/command/operator; one-line example per row |
| `basic/functions.md` | **new** | All built-in functions; columns: `function \| syntax \| return type \| argument constraints \| notes`; numeric (ABS, ATN, COS, EXP, FRE, INT, LOG, PEEK, POS, RND, SGN, SIN, SQR, TAN, USR, VAL) and string (ASC, CHR$, LEFT$, LEN, MID$, RIGHT$, STR$) |
| `basic/errors.md` | **new** | All 29 error messages; columns: `code \| message \| conditions` |
| `basic/INDEX.md` | update | Add routes for keywords.md, functions.md, errors.md; update tokens.md status → `used` |

Source: C64 Programmer's Reference Guide (CBM, 1982) — AI-summarized; cite as `C64 Programmer's Reference Guide (Commodore Business Machines, 1982)` in `## sources` of each file. Token bytes from mist64/c64ref.

---

## Phase 4 — Charset and Memory Completions
*Follows Phase 2. Unblocks task recipes.*

| file | change | key content |
|---|---|---|
| `charset/petscii.md` | major expand | Full 256-entry table `$00-$FF`; columns: `code \| name \| printable \| shifted name \| notes`; KERNAL CHROUT range note |
| `charset/screen-codes.md` | major expand | Full 256-entry table; columns: `code \| Unicode name (primary) \| PETSCII equiv \| notes`; not-relationship for `$80-$FF` |
| `charset/control-codes.md` | verify + expand | Verify completeness; expand `$95-$9F` color range to individual rows if missing; add CHROUT-only vs keyboard-only note |
| `charset/keyboard-matrix.md` | major expand | Full 8×8 matrix; columns: `row \| col \| key \| unshifted PETSCII \| shifted \| CBM \| CTRL`; joystick note |
| `memory/map.md` | expand | ~20 sub-regions `$0000-$FFFF`; columns: `range \| default content \| banking-sensitive \| size \| read first`; include CPU vectors `$FFFA-$FFFE` |
| `memory/symbols.md` | expand | Add KERNAL workspace symbols `$90-$FF`; add key vectors `$0314` (IRQ), `$0316` (BRK), `$0318` (NMI); columns: `address \| symbol \| owner \| aliases/notes` |
| `memory/zero-page.md` | expand | Add secondary table for KERNAL workspace `$0090-$00FF` with cross-links to symbols.md |

Source: mist64/c64ref `src/charset`, `src/c64mem`

---

## Phase 5 — Task Recipes
*Follows Phases 2 + 4. All task pages use structure: `## sequence` → `## lookup` → `## constraints` → `## links` → `## sources`.*

| file | change | key content |
|---|---|---|
| `tasks/sprite-display.md` | **new** | 6-step sequence: sprite pointer `$07F8+n`, data block, X/Y at `$D000-$D00F`, MSB in `$D010`, enable `$D015`, color `$D027+n` |
| `tasks/play-sid.md` | **new** | 7-step sequence: FREQLO/HI, PWLO/HI, ATDCY, SUREL, CR gate on/off; vol init `$D418=$0F` first |
| `tasks/custom-charset.md` | **new** | 4-step sequence: bank in char ROM (`$0001` CHAREN=0), copy `$D000-$DFFF` to RAM, modify bytes (base + sc×8), point VIC-II `$D018` |
| `tasks/game-loop.md` | **new** | Pattern recipe: init → read input → update state → draw (screen codes + sprites) → sync (raster poll or IRQ) → loop |
| `tasks/raster-interrupt.md` | verify status | Check if content exists; update status → `used` if complete |
| `tasks/read-keyboard.md` | verify status | Check if content exists; update status → `used` if complete |
| `tasks/bank-switch-rom-ram.md` | verify status | Check if content exists; update status → `used` if complete |
| `tasks/load-save-file.md` | verify status | Check if content exists; update status → `used` if complete |
| `tasks/INDEX.md` | update | Add routes for new pages; update statuses |

---

## Phase 6 — Assembler Domain (new)
*Follows Phase 1. Entirely new domain.*

New directory: `asm/`

| file | change | key content |
|---|---|---|
| `asm/INDEX.md` | **new** | Routes to all 4 assembler pages; related: `cpu/6502`, `memory`, `tasks` |
| `asm/acme.md` | **new** | Version 0.97+; `## directives` table (`*=`, `!byte`, `!word`, `!text`, `!scr`, `!fill`, `!align`, `!to`, `!cpu`, `!zone`, `!src`, `!binary`); `## macros` (`!macro`/`+name`); `## expressions` (`<`/`>` byte operators, anonymous `+`/`-` labels); output formats |
| `asm/kickassembler.md` | **new** | Version 5.x, JVM-required; `## directives` (`.pc`, `.byte`, `.word`, `.text`, `.fill`, `.align`, `.import`, `.var`, `.const`, `.enum`); `## macros` (`.macro name(args)`); `## scripting` (`.eval`, `:` prefix, list/hashtable literals) |
| `asm/ca65.md` | **new** | cc65 v2.19+; `## directives` (`.org`/`.segment`, `.byte`, `.word`, `.res`, `.asciiz`, `.include`, `.incbin`, `.macro`/`.endmacro`, `.scope`, `.proc`, `.export`, `.import`); `## segments` (CODE/RODATA/DATA/BSS/ZEROPAGE); `## linker-config` (`ld65 -t c64`, custom `.cfg` MEMORY+SEGMENTS) |
| `asm/64tass.md` | **new** | v1.58+; `## directives` (`*=`, `.byte`, `.word`, `.text`, `.fill`, `.align`, `.include`, `.binclude`, `.cpu`, `.enc`, `.namespace`, `.proc`, `.macro`/`.endm`, `.struct`); `## output-options` (`--cbm-prg`, `--flat`, `--format=`); `## labels` (local `_`, scoped `.`, anonymous `+`/`-`) |

**Root file updates:**
- `INDEX.md`: add `asm` row to domains table and quick-route table
- `sources/INDEX.md`: add `asm` row to corpus-map (no mist64 upstream — cite each assembler's own versioned docs)
- `ATTRIBUTION.md`: note that assembler pages cite assembler-specific upstream docs, not mist64/c64ref

---

## Constraints (apply to all phases)

- All pages MUST follow AGENTS.md + STYLE.md: tables over prose, no empty sections, sources section required
- MUST NOT copy verbatim text from C64 PRG — AI-first summaries only
- MUST NOT add assembler pages to mist64/c64ref upstream in sources/INDEX.md — cite assembler-specific docs
- Task pages MUST NOT duplicate I/O register tables — use `## lookup` rows routing to `io/` pages
- CPU timing data MUST cite mist64/c64ref `src/6502`
- Each assembler page MUST state the targeted assembler version in `## facts`

---

## Verification

After each phase:
1. All new/expanded files have `## sources` sections with correct relative links
2. INDEX.md files in affected domains have updated routes and source-coverage status
3. No dangling references: every internal link resolves to an existing file
4. Root `INDEX.md` routes reach the new `asm` domain
5. `sources/INDEX.md` corpus-map includes `asm` entry

End-to-end check: an AI agent asked "write a C64 sprite display routine in ACME assembly" should be able to resolve: `asm/acme.md` → `tasks/sprite-display.md` → `io/vic-ii.md` → `memory/map.md` without hitting any `planned` stubs.
