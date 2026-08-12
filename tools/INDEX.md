---
type: index
domain: tools
source: codebase64.net
---

## routes
| need | read | notes |
|---|---|---|
| Compress/crunch a `.prg` for distribution | [crunchers.md](crunchers.md) | Exomizer, Pucrunch, ByteBoozer (cross + native). |
| Pixel/sprite/charset graphics editor | [graphics-editors.md](graphics-editors.md) | CharPad, SpritePad Pro, Pixcen, and others. |
| SID music composition and export | [music-editors.md](music-editors.md) | GoatTracker, CheeseCutter, JCH, DMC, NinjaTracker. |
| Disassemble or analyze a C64 binary | [disassemblers.md](disassemblers.md) | IDA Pro, Regenerator. |
| Transfer files to/from real C64 hardware | [transfer.md](transfer.md) | Final Replay, Codenet, TMPView. |
| Emulate a C64 on PC | [emulators.md](emulators.md) | VICE, HOXS64, CCS64; VICE workflow in toolchains. |
| Native assemblers (run on the C64 itself) | [native-tools.md](native-tools.md) | Turbo Assembler, Ass Blaster, TMPx; native packers/linkers. |
| Cross-assembler syntax and features | [../asm/INDEX.md](../asm/INDEX.md) | ACME, KickAssembler, CA65, 64tass. |
| Cross-assembler build workflows | [../toolchains/INDEX.md](../toolchains/INDEX.md) | Source → `.prg` → VICE per assembler. |
| Run/debug on VICE emulator | [../toolchains/vice.md](../toolchains/vice.md) | Autostart, monitor, command-line flags. |

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| Compressors that pack a prg and decrunch it at load time, cross and native. | [crunchers.md](crunchers.md) | crunchers, Exomizer, Pucrunch, ByteBoozer, packer |
| Tools for disassembling and analysing a C64 binary. | [disassemblers.md](disassemblers.md) | disassemblers, IDA Pro, Regenerator, binary analysis |
| C64 emulators for PC and which build is cycle-exact. | [emulators.md](emulators.md) | emulators, VICE, x64sc, HOXS64, CCS64 |
| Editors for charsets, tiles, sprites and bitmap graphics. | [graphics-editors.md](graphics-editors.md) | graphics editors, CharPad, SpritePad, Pixcen, pixel editor |
| SID trackers and composition tools, cross-platform and native. | [music-editors.md](music-editors.md) | music editors, GoatTracker, CheeseCutter, trackers, SID composer |
| Assemblers, packers and linkers that run on the C64 itself. | [native-tools.md](native-tools.md) | native tools, Turbo Assembler, TMPx, on-machine development |
| Moving files between a PC and real C64 hardware. | [transfer.md](transfer.md) | file transfer, Final Replay, Codenet, RR-net, real hardware |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Assemblers (syntax) | [../asm/INDEX.md](../asm/INDEX.md) | Language reference for cross-assemblers. |
| Toolchains (build/run) | [../toolchains/INDEX.md](../toolchains/INDEX.md) | Editor-neutral build and emulator workflows. |
| Music integration | [../music/INDEX.md](../music/INDEX.md) | IRQ players, banking, tune loading. |
| Graphics display modes | [../display-modes/INDEX.md](../display-modes/INDEX.md) | Target format specs that graphics editors produce. |
| Sprites | [../sprites/INDEX.md](../sprites/INDEX.md) | Hardware context for SpritePad Pro output. |
| Optimization | [../optimization/INDEX.md](../optimization/INDEX.md) | Context for why crunching improves load times. |
