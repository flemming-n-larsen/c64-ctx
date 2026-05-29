---
type: index
domain: root
source: c64ref
---

## quick-route
| need | read first | then read | notes |
|---|---|---|---|
| Memory map, zero page, ROM/RAM areas | [memory/INDEX.md](memory/INDEX.md) | [concepts/memory-banking.md](concepts/memory-banking.md) | Agents MUST prefer focused memory pages over broad source files. |
| KERNAL calls, jump table, file I/O | [kernal/INDEX.md](kernal/INDEX.md) | [tasks/load-save-file.md](tasks/load-save-file.md) | Agents SHOULD cite local KERNAL pages and route upstream provenance through [sources/INDEX.md](sources/INDEX.md). |
| CPU registers, flags, opcodes | [cpu/6502/INDEX.md](cpu/6502/INDEX.md) | [cpu/6502/instruction-set.md](cpu/6502/instruction-set.md) | `6502` data SHOULD be treated as CPU-family scoped, not C64-only. |
| VIC-II overview: registers, banks, timing, modes | [vic/INDEX.md](vic/INDEX.md) | [io/vic-ii.md](io/vic-ii.md) | VIC discovery hub that routes to hardware, timing, memory, color, and mode pages. |
| Interrupts, raster timing, stable sync, IRQ-driven flow | [irq/INDEX.md](irq/INDEX.md) | [io/INDEX.md](io/INDEX.md) | Canonical route for interrupt-generic guidance; consumer pages in music/effects/kernal link here. |
| Sprite setup, sprite registers, DYSP, multiplexers | [sprites/INDEX.md](sprites/INDEX.md) | [tasks/sprite-display.md](tasks/sprite-display.md) | Sprite discovery hub that routes to setup, behavior, effects, and examples. |
| VIC-II, CIA, I/O registers | [io/INDEX.md](io/INDEX.md) | [memory/io-area.md](memory/io-area.md) | Agents MUST account for banking at `$D000-$DFFF`. |
| SID chip programming | [sid/INDEX.md](sid/INDEX.md) | [io/INDEX.md](io/INDEX.md) | Registers, waveforms, note recipes, freq tables, filter, chip detection. |
| Music players, tune integration, tracker formats | [music/INDEX.md](music/INDEX.md) | [sid/INDEX.md](sid/INDEX.md) | IRQ players, banking/load-address concerns, PAL/NTSC playback, music-layer formats. |
| BASIC or KERNAL ROM routine locations | [rom/INDEX.md](rom/INDEX.md) | [basic/INDEX.md](basic/INDEX.md) | ROM pages are compact routing aids, not full disassemblies. |
| PETSCII, screen codes, keyboard matrix | [charset/INDEX.md](charset/INDEX.md) | [concepts/character-sets.md](concepts/character-sets.md) | Agents MUST distinguish PETSCII from screen codes. |
| C64 color numbers and palette | [colors/INDEX.md](colors/INDEX.md) | [io/vic-ii.md](io/vic-ii.md) | Color references SHOULD cite both charset palette and colors UI sources when applicable. |
| Practical programming recipe | [tasks/INDEX.md](tasks/INDEX.md) | Matching domain pages | Task pages MUST link to supporting facts rather than duplicate long tables. |
| VIC-II screen/graphics modes, enable bits, color sources | [graphics/INDEX.md](graphics/INDEX.md) | [io/vic-ii.md](io/vic-ii.md) | All 8 ECM/BMM/MCM mode combinations; memory layout and color sources per mode. |
| Display mode technique spec (FLI, IFLI, NUFLI, ECI, PRS, etc.) | [display-modes/INDEX.md](display-modes/INDEX.md) | [graphics/unofficial-modes.md](graphics/unofficial-modes.md) | 18 software picture-format specs; how to encode and play each mode. |
| Demo/game effect technique | [effects/INDEX.md](effects/INDEX.md) | [tasks/INDEX.md](tasks/INDEX.md) | Effect pages combine task recipes and I/O facts into named effect patterns. |
| 6502 math: multiply, divide, trig, fixed-point, float | [math/INDEX.md](math/INDEX.md) | [math/multiply.md](math/multiply.md) | Arithmetic operations — no native multiply/divide on 6502. |
| Algorithms: sort, RNG, number conversion, compression, 3D | [algorithms/INDEX.md](algorithms/INDEX.md) | Matching algorithm page | PRNG, sorting, hex/decimal conversion, LZ/RLE compression, 3D math. |
| Assembler syntax, directives, build patterns | [asm/INDEX.md](asm/INDEX.md) | [asm/rosetta.md](asm/rosetta.md) | Covers ACME, KickAssembler, CA65 (cc65), 64tass. |
| Speed optimization: rastertime, cycle counting, loop unrolling, illegal opcodes | [optimization/INDEX.md](optimization/INDEX.md) | [optimization/speed.md](optimization/speed.md) | KERNAL avoidance, opcode cycle table, advanced tricks, speedcode, sizecoding. |
| Common 6502 coding pitfalls | [cpu/pitfalls.md](cpu/pitfalls.md) | — | DOKE byte order, addressing mode `#` omission, self-mod label offsets. |
| Detect CPU type at runtime (NMOS 6502 / 65C02 / 65816) | [cpu/detect-cpu.md](cpu/detect-cpu.md) | — | Uses `$1A`/`XBA`/`$3A` opcode behavior differences. |
| Hidden RAM beneath `$00`/`$01` | [memory/hidden-ram.md](memory/hidden-ram.md) | — | Read via VIC sprite; write via bus residue timing. |
| Build/run `.prg` on PC (VICE, assembler workflows) | [toolchains/INDEX.md](toolchains/INDEX.md) | [toolchains/vice.md](toolchains/vice.md) | Editor-neutral workflows for ACME, KickAssembler, CA65, 64tass, CBM prg Studio. |
| Complete runnable program examples | [examples/INDEX.md](examples/INDEX.md) | Matching `basic/`, `asm/`, `toolchains/` pages | BASIC listings + per-assembler buildable `.prg` examples; each cites its reference pages. |

## domains
| domain | read | contains | provenance route |
|---|---|---|---|
| `concepts` | [concepts/INDEX.md](concepts/INDEX.md) | Cross-domain constraints: banking, screen memory, zero page, character sets, bad lines, optimization | [sources/INDEX.md](sources/INDEX.md) |
| `irq` | [irq/INDEX.md](irq/INDEX.md) | Canonical interrupt domain: IRQ/NMI overview, raster setup, stable timing, cooperative IRQ-driven flow | [sources/INDEX.md](sources/INDEX.md) |
| `cpu` | [cpu/INDEX.md](cpu/INDEX.md) | CPU-family route plus `6502` subdomain | [sources/INDEX.md](sources/INDEX.md) |
| `memory` | [memory/INDEX.md](memory/INDEX.md) | C64 address map, symbols, zero page, ROM/RAM/I/O regions | [sources/INDEX.md](sources/INDEX.md) |
| `io` | [io/INDEX.md](io/INDEX.md) | Processor port, VIC-II, CIA1, CIA2, color RAM | [sources/INDEX.md](sources/INDEX.md) |
| `vic` | [vic/INDEX.md](vic/INDEX.md) | Curated VIC-II discovery hub: hardware, banking, timing, modes, color context, sprite handoff | [sources/INDEX.md](sources/INDEX.md) |
| `sprites` | [sprites/INDEX.md](sprites/INDEX.md) | Curated sprite hub: registers, display setup, collisions, border usage, advanced effects, examples | [sources/INDEX.md](sources/INDEX.md) |
| `sid` | [sid/INDEX.md](sid/INDEX.md) | SID registers, waveforms, frequency calculation/tables, filter, chip detection, digi samples, hardware issues | codebase64.net — CC BY-NC-SA 4.0 |
| `music` | [music/INDEX.md](music/INDEX.md) | IRQ players, tune integration, banking/load-address constraints, playback timing, music patterns, tracker/player formats | codebase64.net — CC BY-NC-SA 4.0 |
| `kernal` | [kernal/INDEX.md](kernal/INDEX.md) | KERNAL jump table and API families | [sources/INDEX.md](sources/INDEX.md) |
| `basic` | [basic/INDEX.md](basic/INDEX.md) | BASIC tokens, vectors, routine routes | [sources/INDEX.md](sources/INDEX.md) |
| `rom` | [rom/INDEX.md](rom/INDEX.md) | BASIC/KERNAL ROM disassembly routes | [sources/INDEX.md](sources/INDEX.md) |
| `charset` | [charset/INDEX.md](charset/INDEX.md) | PETSCII, screen codes, controls, keyboard matrix | [sources/INDEX.md](sources/INDEX.md) |
| `colors` | [colors/INDEX.md](colors/INDEX.md) | C64 color lookup and palette routes | [sources/INDEX.md](sources/INDEX.md) |
| `tasks` | [tasks/INDEX.md](tasks/INDEX.md) | Agent recipes for common programming goals | Cross-domain derived pages |
| `asm` | [asm/INDEX.md](asm/INDEX.md) | Assembler-specific syntax for ACME, KickAssembler, CA65, 64tass; cross-assembler rosetta; common patterns | Assembler-specific upstream docs |
| `toolchains` | [toolchains/INDEX.md](toolchains/INDEX.md) | VICE emulator workflow and per-assembler source-to-`.prg` build workflows; CBM prg Studio | Tool-specific upstream docs |
| `graphics` | [graphics/INDEX.md](graphics/INDEX.md) | VIC-II screen mode reference: all 8 ECM/BMM/MCM combinations, memory layout, color sources | c64-wiki.com |
| `display-modes` | [display-modes/INDEX.md](display-modes/INDEX.md) | Software display mode technique specs: FLI, IFLI, NUFLI, UFLI, ECI, HCB, PRS, and 12 more | c64-wiki.com (GFDL) + codebase64.net (CC BY-NC-SA 4.0) |
| `effects` | [effects/INDEX.md](effects/INDEX.md) | Demo/game effect technique recipes: border tricks, rasterbars, scrollers, FLD, DYCP, DYSP, sprite multiplexer, fire, starfield, plasma, RNG | codebase64.net — CC BY-NC-SA 4.0 |
| `math` | [math/INDEX.md](math/INDEX.md) | 6502 arithmetic: compare, add/sub, multiply, divide, sqrt, trig, fixed-point, float, logarithm, exponentiation | codebase64.net — CC BY-NC-SA 4.0 |
| `algorithms` | [algorithms/INDEX.md](algorithms/INDEX.md) | General-purpose algorithms: sorting, PRNG, number conversion, compression, 3D math | codebase64.net — CC BY-NC-SA 4.0 |
| `optimization` | [optimization/INDEX.md](optimization/INDEX.md) | Speed and size optimization: cycle reduction, loop unrolling, runtime code generation, KERNAL sizecoding tricks | codebase64.net — CC BY-NC-SA 4.0 |
| `examples` | [examples/INDEX.md](examples/INDEX.md) | Complete runnable BASIC and per-assembler programs with build/run invocations | Cross-domain derived pages |
| `sources` | [sources/INDEX.md](sources/INDEX.md) | Source corpus map and provenance policy | Upstream GitHub fallback links |

## source-map
| coverage route | local domains | status | notes |
|---|---|---|---|
| [cpu/6502/INDEX.md](cpu/6502/INDEX.md) | `cpu/6502` | planned seed | Local CPU pages cover registers, flags, mnemonics, operations, and undocumented caveats. |
| [memory/INDEX.md](memory/INDEX.md) | `memory`, `concepts`, `basic`, `rom`, `io` | planned seed | Local memory pages cover address ranges, symbols, aliases, and ROM/RAM constraints. |
| [io/INDEX.md](io/INDEX.md) | `io`, `tasks`, `irq` | planned seed | Local I/O pages cover register ranges and bit-level hardware fields. |
| [irq/INDEX.md](irq/INDEX.md) | `irq`, `effects`, `music`, `kernal`, `tasks` | planned seed | Local interrupt pages centralize generic IRQ/NMI concepts, timing, and flow before consumer-specific routes. |
| [vic/INDEX.md](vic/INDEX.md) | `vic`, `io`, `graphics`, `concepts`, `tasks`, `colors`, `display-modes` | planned seed | Local VIC routing gathers the main hardware, timing, banking, and screen-mode entry points. |
| [sprites/INDEX.md](sprites/INDEX.md) | `sprites`, `io`, `tasks`, `effects`, `display-modes`, `examples` | planned seed | Local sprite routing gathers hardware setup, placement, advanced runtime techniques, and runnable examples. |
| [kernal/INDEX.md](kernal/INDEX.md) | `kernal`, `tasks` | planned seed | Local KERNAL pages cover jump addresses, call preparation, returns, and affected registers. |
| [rom/INDEX.md](rom/INDEX.md) | `rom`, `basic`, `kernal` | planned seed | Local ROM pages provide route/provenance material, not full copied listings. |
| [charset/INDEX.md](charset/INDEX.md) | `charset`, `colors`, `tasks` | planned seed | Local charset pages cover keyboard, PETSCII/control, chargen, and palette facts. |
| [colors/INDEX.md](colors/INDEX.md) | `colors` | planned seed | Local color pages cover color names, indices, and palette intent. |
| [sources/INDEX.md](sources/INDEX.md) | all domains | provenance | Central upstream fallback route for `mist64/c64ref`. |

## rules
- Agents MUST start here when no narrower entry point is supplied.
- Agents MUST prefer the smallest topical file that answers the question before reading broad indexes or original source files.
- Agents SHOULD follow `sources` links when facts conflict, are surprising, or require exact wording.
- Agents MUST NOT assume undocumented behavior without a cited source.
- Agents MUST distinguish `facts`, `constraints`, `aliases`, and unresolved source differences.
- Generated or derived pages MUST preserve local Markdown provenance and route upstream fallback through [sources/INDEX.md](sources/INDEX.md).

## links
- agent rules: [AGENTS.md](AGENTS.md)
- style rules: [STYLE.md](STYLE.md)
- source coverage: [sources/INDEX.md](sources/INDEX.md)
