---
type: index
domain: tasks
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| Sprite discovery hub | [../sprites/INDEX.md](../sprites/INDEX.md) | VIC-II sprite routes for registers, display setup, and advanced techniques. |
| Display a sprite | [sprite-display.md](sprite-display.md) | Sprite pointer, data block, X/Y position, enable, color. |
| SID chip sound (play notes, freq table, filter, digis) | [../sid/INDEX.md](../sid/INDEX.md) | Hardware-facing SID domain: registers, waveforms, tables, effects, chip detection. |
| Music playback / tune integration | [../music/INDEX.md](../music/INDEX.md) | IRQ players, banking/load-address constraints, music patterns, hard restart. |
| Install a custom character set | [custom-charset.md](custom-charset.md) | Bank in char ROM, copy, modify, point VIC-II `$D018`. |
| Game-loop skeleton | [game-loop.md](game-loop.md) | init → input → update → draw → sync → loop. |
| Choose program entrypoint shape | [program-entrypoints.md](program-entrypoints.md) | BASIC, SYS loader, standalone `.prg`, cartridge. |
| Load or save a file | [load-save-file.md](load-save-file.md) | Uses KERNAL file I/O and device setup calls. |
| Print text or characters | [print-to-screen.md](print-to-screen.md) | Uses `CHROUT`, screen memory, PETSCII, colors. |
| Read keyboard input | [read-keyboard.md](read-keyboard.md) | Uses KERNAL input and keyboard matrix routes. |
| Create raster interrupt | [../irq/raster-interrupt.md](../irq/raster-interrupt.md) | Canonical IRQ recipe with VIC-II raster registers, vectors, and coexistence rules. |
| Switch ROM/RAM/I/O banks | [bank-switch-rom-ram.md](bank-switch-rom-ram.md) | Uses processor port and memory banking constraints. |
| Move a block of memory | [memory-move.md](memory-move.md) | MOVEDOWN (to higher) and MOVEUP (to lower) with overlap handling. |
| Clear / zero a memory region | [memory-clear.md](memory-clear.md) | Index-loop and optimized Y-only variants; up to 256 bytes per call. |
| Decimal digit counter with screen display | [counter.md](counter.md) | Digit table, carry propagation, PETSCII conversion. |
| Cooperative multitasking / multiple threads | [../irq/cooperative-threads.md](../irq/cooperative-threads.md) | Canonical IRQ-driven threading/scheduler route. |
| Dispatch to handler based on a byte value | [dispatch.md](dispatch.md) | Jump table, stack dispatch, self-mod variants; cycle comparison table. |
| Decode variable-length bitfields from a byte stream | [bitstream.md](bitstream.md) | Sentinel shifter pattern; decision-tree decoder for Huffman/LZ. |

## related
| domain | read | why |
|---|---|---|
| Effects | [../effects/INDEX.md](../effects/INDEX.md) | Advanced technique recipes built on top of task primitives (border tricks, rasterbars, plasma, etc.). |
| sprites | [../sprites/INDEX.md](../sprites/INDEX.md) | Sprite-specific route that connects the basic task to advanced effects and examples. |
| Music | [../music/INDEX.md](../music/INDEX.md) | Player-level audio workflows built on top of IRQ and banking tasks. |
| BASIC | [../basic/INDEX.md](../basic/INDEX.md) | Loader/SYS patterns, runnable program shapes. |
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | API calls for file, input, output, time. |
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | Address ranges and vectors. |
| I/O | [../io/INDEX.md](../io/INDEX.md) | Hardware registers. |
| Concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Constraints used by recipes. |
| IRQ | [../irq/INDEX.md](../irq/INDEX.md) | Canonical interrupt-generic setup, timing, and flow routes. |
