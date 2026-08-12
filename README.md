# c64-ctx

A structured Markdown knowledge base for Commodore 64 development, organized for AI agent consumption. Every file is compact and citation-backed. Agents resolve a question in one hop — search `ROUTE.md` for a topic or `SYMBOLS.md` for a `$`-address, then read the single page that answers it. `ROUTE.md`, `SYMBOLS.md`, and each directory index's `## pages` block are generated from page front matter by `scripts/generate-routes.ps1`, so the routing layer cannot drift from the content.

## Entry points

| goal | start here |
|---|---|
| Find a page by topic or jargon (search, do not read whole) | [ROUTE.md](ROUTE.md) |
| Find the page owning a `$`-address or KERNAL symbol | [SYMBOLS.md](SYMBOLS.md) |
| Any C64 question (no narrower entry known) | [INDEX.md](INDEX.md) |
| Agent consumption rules | [AGENTS.md](AGENTS.md) |
| File style and naming rules | [STYLE.md](STYLE.md) |
| Source corpus and provenance policy | [sources/INDEX.md](sources/INDEX.md) |
| License and attribution | [ATTRIBUTION.md](ATTRIBUTION.md) |

## Domains

| domain | index | covers |
|---|---|---|
| `cpu` | [cpu/INDEX.md](cpu/INDEX.md) | 6510/6502 registers, flags, instruction set, addressing modes, illegal opcodes |
| `memory` | [memory/INDEX.md](memory/INDEX.md) | Address map, zero page, banking, ROM/RAM regions |
| `io` | [io/INDEX.md](io/INDEX.md) | VIC-II, SID, CIA1, CIA2, color RAM, processor port, disk formats |
| `vic` | [vic/INDEX.md](vic/INDEX.md) | VIC-II hardware, timing, banking, screen modes, chip variants |
| `sprites` | [sprites/INDEX.md](sprites/INDEX.md) | Sprite registers, display, collisions, multiplexers, border effects |
| `irq` | [irq/INDEX.md](irq/INDEX.md) | IRQ/NMI setup, raster timing, stable sync, cooperative flow |
| `sid` | [sid/INDEX.md](sid/INDEX.md) | SID registers, waveforms, frequency tables, filter, digi, chip detection |
| `music` | [music/INDEX.md](music/INDEX.md) | IRQ players, tune integration, banking, PAL/NTSC playback, tracker formats |
| `kernal` | [kernal/INDEX.md](kernal/INDEX.md) | Jump table, API families, calling conventions, error returns |
| `basic` | [basic/INDEX.md](basic/INDEX.md) | Tokens, keywords, functions, errors, variables, I/O, machine-code bridge |
| `rom` | [rom/INDEX.md](rom/INDEX.md) | BASIC/KERNAL ROM routine routing (not full disassemblies) |
| `charset` | [charset/INDEX.md](charset/INDEX.md) | PETSCII, screen codes, control codes, keyboard matrix, chargen bitmaps |
| `colors` | [colors/INDEX.md](colors/INDEX.md) | Color numbers, palette, luma clusters |
| `graphics` | [graphics/INDEX.md](graphics/INDEX.md) | All 8 ECM/BMM/MCM VIC-II mode combinations; memory layout; color sources |
| `display-modes` | [display-modes/INDEX.md](display-modes/INDEX.md) | FLI, IFLI, NUFLI, UFLI, ECI, HCB, and other unofficial picture formats |
| `concepts` | [concepts/INDEX.md](concepts/INDEX.md) | Banking, screen memory, bad lines, character sets, optimization overview |
| `effects` | [effects/INDEX.md](effects/INDEX.md) | Rasterbars, scrollers, FLD, DYCP, fire, plasma, starfield, vectors |
| `game` | [game/INDEX.md](game/INDEX.md) | Tile maps, scrolling, frameskip, high scores, scoring |
| `math` | [math/INDEX.md](math/INDEX.md) | 6502 arithmetic: multiply, divide, trig, fixed-point, float, log, exp |
| `algorithms` | [algorithms/INDEX.md](algorithms/INDEX.md) | Sort, PRNG, number conversion, compression, 3D math |
| `optimization` | [optimization/INDEX.md](optimization/INDEX.md) | Cycle reduction, loop unrolling, speedcode, sizecoding, KERNAL avoidance |
| `asm` | [asm/INDEX.md](asm/INDEX.md) | ACME, KickAssembler, CA65, 64tass, Buddy, MADS syntax and directives |
| `toolchains` | [toolchains/INDEX.md](toolchains/INDEX.md) | VICE and per-assembler source-to-`.prg` build workflows |
| `tasks` | [tasks/INDEX.md](tasks/INDEX.md) | Practical recipes: print, keyboard, load/save, sprites, custom charset |
| `examples` | [examples/INDEX.md](examples/INDEX.md) | Runnable BASIC listings and per-assembler `.prg` programs |
| `tools` | [tools/INDEX.md](tools/INDEX.md) | Crunchers, graphics editors, music editors, emulators, transfer tools |
| `sources` | [sources/INDEX.md](sources/INDEX.md) | Corpus map and upstream fallback provenance policy |

## Sources

Content is derived from:

- **[mist64/c64ref](https://github.com/mist64/c64ref)** (Michael Steil, BSD 2-Clause) — CPU, memory, I/O, KERNAL, ROM, charset, colors
- **[codebase64.net](https://codebase64.net/)** (CC BY-NC-SA 4.0) — effects, game programming, math, algorithms, optimization, SID, music, tools
- **[c64-wiki.com](https://www.c64-wiki.com/)** (GFDL) — graphics modes, display-mode technique specs
- **C64 Programmer's Reference Guide** (Commodore, 1982) — BASIC V2 language semantics
- **Original Commodore/peripheral manuals** — VIC-II geometry, 1351 mouse, Passport MIDI, and 1541 architecture
- **HVSC SID File Format Description** — PSID/RSID container structure and constraints
- Assembler manuals (ACME, KickAssembler, CA65/cc65, 64tass) — `asm/` and `toolchains/` pages

See [ATTRIBUTION.md](ATTRIBUTION.md) for full attribution details.

## License

CC BY-NC-SA 4.0 — see [ATTRIBUTION.md](ATTRIBUTION.md).
