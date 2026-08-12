---
type: index
domain: root
source: c64ref
---

## entry-points
- Agents with text search SHOULD search [ROUTE.md](ROUTE.md) for a topic or term, or [SYMBOLS.md](SYMBOLS.md) for a `$`-address or KERNAL symbol, then read the matched page. Both are grep targets and MUST NOT be read whole.
- Without text search, use `## quick-route` below, then read the matched page.

## quick-route
| need | read first | then read | notes |
|---|---|---|---|
| C64 address map, ROM/RAM areas | [memory/map.md](memory/map.md) | [concepts/memory-banking.md](concepts/memory-banking.md) | Prefer focused memory pages over broad source files. |
| Zero page usage and free bytes | [memory/zero-page.md](memory/zero-page.md) | [concepts/zero-page.md](concepts/zero-page.md) | KERNAL/BASIC ownership decides what is safe to use. |
| Hidden RAM beneath `$00`/`$01` | [memory/hidden-ram.md](memory/hidden-ram.md) | [io/processor-port.md](io/processor-port.md) | Read via VIC sprite; write via bus residue timing. |
| KERNAL calls, jump table, file I/O | [kernal/jump-table.md](kernal/jump-table.md) | [kernal/file-io.md](kernal/file-io.md) | Call contracts include inputs, outputs, errors, clobbers. |
| Load or save a file from machine code | [tasks/load-save-file.md](tasks/load-save-file.md) | [kernal/file-io.md](kernal/file-io.md) | `SETLFS`/`SETNAM`/`LOAD`/`SAVE` sequence. |
| CPU registers, flags, opcodes | [cpu/6502/instruction-set.md](cpu/6502/instruction-set.md) | [cpu/6502/registers-flags.md](cpu/6502/registers-flags.md) | `6502` data is CPU-family scoped, not C64-only. |
| Undocumented / illegal opcodes | [cpu/6502/illegal-opcodes.md](cpu/6502/illegal-opcodes.md) | [optimization/advanced.md](optimization/advanced.md) | NMOS-only; unstable on 65C02/65816. |
| Common 6502 coding pitfalls | [cpu/pitfalls.md](cpu/pitfalls.md) | — | DOKE byte order, `#` omission, self-mod label offsets. |
| Detect CPU type at runtime | [cpu/detect-cpu.md](cpu/detect-cpu.md) | — | Uses `$1A`/`XBA`/`$3A` opcode behavior differences. |
| VIC-II registers and bit fields | [io/vic-ii.md](io/vic-ii.md) | [vic/INDEX.md](vic/INDEX.md) | Account for banking at `$D000-$DFFF`. |
| VIC-II bank select, screen/charset placement | [vic/memory-and-banking.md](vic/memory-and-banking.md) | [io/cia2.md](io/cia2.md) | Bank via `$DD00`; layout via `$D018`. |
| Raster timing, cycles per line, bad lines | [vic/timing.md](vic/timing.md) | [concepts/vic-bad-lines.md](concepts/vic-bad-lines.md) | VIC takes the bus for 40 cycles; CPU delay can be 40–43 cycles. |
| VIC-II chip variant (NTSC vs PAL, 6567/6569/8562/8565) | [vic/variants.md](vic/variants.md) | [vic/timing.md](vic/timing.md) | Raster counts, cycles/line, fps, palette by revision. |
| Interrupts, IRQ/NMI vectors | [irq/overview.md](irq/overview.md) | [irq/raster-interrupt.md](irq/raster-interrupt.md) | Canonical route for interrupt-generic guidance. |
| Install a raster interrupt | [irq/raster-interrupt.md](irq/raster-interrupt.md) | [irq/stable-timing.md](irq/stable-timing.md) | Setup, acknowledge rules, KERNAL coexistence. |
| Stable raster / remove jitter | [irq/stable-timing.md](irq/stable-timing.md) | [effects/stable-raster.md](effects/stable-raster.md) | Double-IRQ sync and cycle-budget constraints. |
| Sprite setup, positioning, color | [tasks/sprite-display.md](tasks/sprite-display.md) | [sprites/registers.md](sprites/registers.md) | 9-bit X; data MUST be 64-byte aligned. |
| More than 8 sprites (multiplexer) | [effects/sprite-multiplexer.md](effects/sprite-multiplexer.md) | [sprites/advanced.md](sprites/advanced.md) | Reuse sprite slots down the raster. |
| CIA timers, keyboard scan, joystick | [io/cia1.md](io/cia1.md) | [io/joystick.md](io/joystick.md) | CIA1 IRQ; CIA2 NMI and VIC bank. |
| Read the keyboard | [tasks/read-keyboard.md](tasks/read-keyboard.md) | [charset/keyboard-matrix.md](charset/keyboard-matrix.md) | KERNAL `GETIN` vs direct matrix scan. |
| Mouse, paddles, light pen | [io/pointing-devices.md](io/pointing-devices.md) | [io/mouse-1351.md](io/mouse-1351.md) | 1351 proportional mode vs joystick mode. |
| D64/D71/D81 disk image format | [io/disk-formats.md](io/disk-formats.md) | [kernal/file-io.md](kernal/file-io.md) | Track/sector layout, BAM, directory. |
| Serial bus, fast loaders, tape | [io/disk-tape-io.md](io/disk-tape-io.md) | [io/fast-loaders.md](io/fast-loaders.md) | IEC protocol and custom transfer routines. |
| SID registers, waveforms, envelope | [sid/registers.md](sid/registers.md) | [sid/waveforms.md](sid/waveforms.md) | ADSR, gate, ring modulation, sync. |
| Play a note / build a frequency table | [sid/play-note.md](sid/play-note.md) | [sid/frequency-table.md](sid/frequency-table.md) | PAL and NTSC tables differ. |
| Music player integration, hard restart | [music/irq-music-player.md](music/irq-music-player.md) | [music/hard-restart.md](music/hard-restart.md) | IRQ players, banking and load-address concerns. |
| BASIC or KERNAL ROM routine locations | [rom/basic-disassembly.md](rom/basic-disassembly.md) | [rom/kernal-disassembly.md](rom/kernal-disassembly.md) | Compact routing aids, not full disassemblies. |
| BASIC V2 keywords, functions, tokens | [basic/keywords.md](basic/keywords.md) | [basic/tokens.md](basic/tokens.md) | Distinguish token bytes from PETSCII. |
| Call machine code from BASIC (`SYS`) | [basic/machine-code-bridge.md](basic/machine-code-bridge.md) | [tasks/program-entrypoints.md](tasks/program-entrypoints.md) | Load address, `SYS` stub, parameter passing. |
| PETSCII, screen codes, control codes | [charset/petscii.md](charset/petscii.md) | [charset/screen-codes.md](charset/screen-codes.md) | PETSCII and screen codes are different code spaces. |
| Custom character set | [tasks/custom-charset.md](tasks/custom-charset.md) | [concepts/character-sets.md](concepts/character-sets.md) | Charset base via `$D018`; avoid the ROM holes. |
| C64 color numbers and palette | [colors/palette.md](colors/palette.md) | [colors/luma-clusters.md](colors/luma-clusters.md) | Luma clusters govern which pairs mix cleanly. |
| VIC-II screen modes, enable bits, color sources | [graphics/screen-modes.md](graphics/screen-modes.md) | [vic/screen-modes.md](vic/screen-modes.md) | All 8 ECM/BMM/MCM combinations. |
| Unofficial picture mode spec (FLI, IFLI, NUFLI, ECI, PRS…) | [display-modes/INDEX.md](display-modes/INDEX.md) | [graphics/unofficial-modes.md](graphics/unofficial-modes.md) | Per-mode specs for unofficial picture formats. |
| Demo/game effect technique | [effects/INDEX.md](effects/INDEX.md) | [tasks/INDEX.md](tasks/INDEX.md) | Named effect patterns built on task and I/O facts. |
| Open the borders | [effects/open-borders.md](effects/open-borders.md) | [irq/stable-timing.md](irq/stable-timing.md) | Top/bottom and side border removal. |
| Scrolling text and character scrollers | [effects/scrolltext.md](effects/scrolltext.md) | [effects/dycp.md](effects/dycp.md) | Smooth scroll via `$D016`/`$D011`. |
| Game loop, tile maps, scrolling, score | [game/INDEX.md](game/INDEX.md) | [tasks/game-loop.md](tasks/game-loop.md) | Routes to game/, effects/, sprites/, tasks/. |
| 6502 math: multiply, divide, trig, fixed-point | [math/multiply.md](math/multiply.md) | [math/INDEX.md](math/INDEX.md) | No native multiply/divide on 6502. |
| Algorithms: sort, RNG, conversion, compression, 3D | [algorithms/INDEX.md](algorithms/INDEX.md) | Matching algorithm page | PRNG, sorting, hex/decimal, LZ/RLE, 3D math. |
| Speed optimization, cycle counting, unrolling | [optimization/speed.md](optimization/speed.md) | [optimization/advanced.md](optimization/advanced.md) | KERNAL avoidance, cycle table, speedcode. |
| Size optimization / sizecoding | [optimization/sizecoding.md](optimization/sizecoding.md) | [optimization/speedcode.md](optimization/speedcode.md) | ROM routine reuse and byte-saving tricks. |
| Assembler syntax and directives | [asm/rosetta.md](asm/rosetta.md) | [asm/common-patterns.md](asm/common-patterns.md) | ACME, KickAssembler, CA65, 64tass, Buddy, MADS. |
| Build/run a `.prg` on PC | [toolchains/vice.md](toolchains/vice.md) | [toolchains/INDEX.md](toolchains/INDEX.md) | Editor-neutral per-assembler build workflows. |
| Tools: crunchers, editors, emulators, transfer | [tools/INDEX.md](tools/INDEX.md) | Matching tool page | Cross-platform and native C64 development tools. |
| Complete runnable program examples | [examples/INDEX.md](examples/INDEX.md) | Matching `basic/`, `asm/`, `toolchains/` pages | BASIC listings plus per-assembler buildable `.prg`. |
| Cartridge modes and `$8000`/`$A000` mapping | [concepts/cartridge-modes.md](concepts/cartridge-modes.md) | [tasks/bank-switch-rom-ram.md](tasks/bank-switch-rom-ram.md) | `EXROM`/`GAME` lines select the memory config. |

## rules
- Agents MUST start here when no narrower entry point is supplied.
- Agents MUST prefer the smallest topical file that answers the question before reading broad indexes or original source files.
- Agents MUST NOT assume undocumented behavior without a cited source.
- Agents MUST distinguish `facts`, `constraints`, `aliases`, and unresolved source differences.
- Agents SHOULD consult [sources/INDEX.md](sources/INDEX.md) only when provenance, exact upstream wording, or a conflict between local pages is at stake.
- A directory `INDEX.md` is the fallback when no row above matches, or when a question spans a whole domain.

## links
- agent rules: [AGENTS.md](AGENTS.md)
- style rules: [STYLE.md](STYLE.md)
- domain list: [README.md](README.md)
- source coverage: [sources/INDEX.md](sources/INDEX.md)
