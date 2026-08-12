---
type: reference
domain: asm
granularity: assembler
summary: "MADS cross-assembler directives, macros and invocation."
keywords: [MADS, cross-assembler, directives, invocation]
---

## facts
- MADS (Macro Assembler and Development Studio) is a free, open-source cross-assembler for 6502/65C02/65816, written by Tomasz Biela (Tebe/Sav).
- Runs on Windows, Linux, and macOS; invoked as `mads <source.asm> -o <output.prg>`.
- Originally developed for Atari 8-bit but produces standard 6502/6510 object code usable on C64.
- Output is a raw binary or a `.prg` with a 2-byte CBM load-address header when the start address is embedded as `dword`.
- No built-in C64-specific symbol definitions; VIC/SID/CIA register equates MUST be declared manually or via an include file.

## directives
| directive | purpose | example |
|---|---|---|
| `ORG <addr>` | Set program counter | `ORG $C000` |
| `<name> = <expr>` / `EQU` | Define constant | `VIC = $D020` |
| `BYTE` / `DB` | Emit 8-bit values | `BYTE $EA, $EA` |
| `WORD` / `DW` | Emit 16-bit little-endian | `WORD $0801` |
| `DWORD` / `DD` | Emit 32-bit values | — |
| `.PROC <name>` … `.ENDP` | Named procedure scope (local labels inside) | `.PROC main` |
| `.LOCAL` | Mark following label as local to current scope | — |
| `.REPT <n>` … `.ENDR` | Repeat block `n` times; `#` is iteration index | `.REPT 8` |
| `.MACRO <name> [<args>]` … `.ENDM` | Define a macro | `.MACRO SetBorder col` |
| `%<name> [<args>]` | Invoke a macro | `%SetBorder 0` |
| `.IF <expr>` … `.ELSE` … `.ENDIF` | Conditional assembly | `.IF NTSC` |
| `.INCLUDE "<file>"` | Include source file | `.INCLUDE "c64.inc"` |
| `.INCBIN "<file>"` | Embed raw binary | `.INCBIN "sprite.bin"` |

## invocation
| flag | purpose |
|---|---|
| `-o <file>` | Output file path |
| `-s` | Write symbol/label file alongside output |
| `-l` | Write listing file |
| `-d <sym>[=<val>]` | Define symbol on command line |

## constraints
- `.PROC` scoping isolates labels; labels inside a `.PROC` are invisible outside unless explicitly exported — differs from ACME's `!zone` and KickAssembler's `.namespace`.
- Macro invocation uses `%name`; this differs from ACME (`+name`), KickAssembler (`:name`), and 64tass (`#name`) — see [rosetta.md](rosetta.md).
- `ORG` does not emit a load-address header; to produce a `.prg`, prepend `WORD <load_addr>` before the first `ORG` or use a linker script.
- Primarily tested against Atari targets; verify that any MADS-specific pseudo-ops not listed here behave as expected on 6510 output.

## links

- assembler hub: [INDEX.md](INDEX.md)
- cross-assembler equivalence: [rosetta.md](rosetta.md)
- toolchain workflows: [../toolchains/INDEX.md](../toolchains/INDEX.md)

## sources

- attribution: [../ATTRIBUTION.md](../ATTRIBUTION.md)
- upstream: MADS documentation (Tomasz Biela / github.com/tebe6502/Mad-Assembler).
