---
type: index
domain: tasks
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| Display a sprite | [sprite-display.md](sprite-display.md) | Sprite pointer, data block, X/Y position, enable, color. |
| SID sound (play notes, freq table, filter, music patterns, digis) | [../sid/INDEX.md](../sid/INDEX.md) | Full SID domain: register ref, recipes, effects, chip detection. |
| Install a custom character set | [custom-charset.md](custom-charset.md) | Bank in char ROM, copy, modify, point VIC-II `$D018`. |
| Game-loop skeleton | [game-loop.md](game-loop.md) | init → input → update → draw → sync → loop. |
| Choose program entrypoint shape | [program-entrypoints.md](program-entrypoints.md) | BASIC, SYS loader, standalone `.prg`, cartridge. |
| Load or save a file | [load-save-file.md](load-save-file.md) | Uses KERNAL file I/O and device setup calls. |
| Print text or characters | [print-to-screen.md](print-to-screen.md) | Uses `CHROUT`, screen memory, PETSCII, colors. |
| Read keyboard input | [read-keyboard.md](read-keyboard.md) | Uses KERNAL input and keyboard matrix routes. |
| Create raster interrupt | [raster-interrupt.md](raster-interrupt.md) | Uses VIC-II raster registers, IRQ vectors, CPU flags. |
| Switch ROM/RAM/I/O banks | [bank-switch-rom-ram.md](bank-switch-rom-ram.md) | Uses processor port and memory banking constraints. |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [sprite-display.md](sprite-display.md) | used | 6-step sprite setup: pointer, data, position, color, enable. |
| [../sid/INDEX.md](../sid/INDEX.md) | used | SID domain: registers, play-note, freq table, hard-restart, model-detect, digis. |
| [custom-charset.md](custom-charset.md) | used | 6-step charset relocation: bank, copy, modify, point `$D018`. |
| [game-loop.md](game-loop.md) | used | Init/input/update/draw/sync pattern with raster sync. |
| [program-entrypoints.md](program-entrypoints.md) | used | Five delivery shapes: BASIC, SYS loader, `.prg`, absolute-load ML, cartridge. |
| [load-save-file.md](load-save-file.md) | used | KERNAL file call sequences and contracts. |
| [print-to-screen.md](print-to-screen.md) | used | Screen-RAM, color-RAM, and KERNAL `CHROUT` routes. |
| [read-keyboard.md](read-keyboard.md) | used | KERNAL and direct-matrix keyboard input. |
| [raster-interrupt.md](raster-interrupt.md) | used | VIC-II raster + IRQ vector handler workflow. |
| [bank-switch-rom-ram.md](bank-switch-rom-ram.md) | used | `$0001` banking via processor port. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Central upstream fallback route. |

## related
| domain | read | why |
|---|---|---|
| Effects | [../effects/INDEX.md](../effects/INDEX.md) | Advanced technique recipes built on top of task primitives (border tricks, rasterbars, plasma, etc.). |
| BASIC | [../basic/INDEX.md](../basic/INDEX.md) | Loader/SYS patterns, runnable program shapes. |
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | API calls for file, input, output, time. |
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | Address ranges and vectors. |
| I/O | [../io/INDEX.md](../io/INDEX.md) | Hardware registers. |
| Concepts | [../concepts/INDEX.md](../concepts/INDEX.md) | Constraints used by recipes. |
