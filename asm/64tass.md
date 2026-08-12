---
type: reference
domain: asm
granularity: assembler
summary: "64tass directives, output options and label scoping."
keywords: [64tass, directives, output options, label scoping]
---

## facts
- Target version: 64tass 1.58 or later.
- Single-pass-style invocation; no separate linker. Output is selected on the command line, not in source.
- Default output is flat binary; `.prg` output MUST be requested with `--cbm-prg` (or `--output-format prg`).
- Mnemonics are case-insensitive; labels are case-sensitive (by default).
- Comments use `;` to end of line.
- Largely TASM-compatible; many ACME and Turbo Assembler conventions also work.

## directives
| directive | purpose | example |
|---|---|---|
| `*= <expr>` | Set program counter | `*= $0801` |
| `.byte <list>` / `.byt` | Emit 8-bit values | `.byte $00, $01` |
| `.word <list>` | Emit 16-bit little-endian | `.word $0801, label` |
| `.dword <list>` / `.long` | Emit 32-bit / 24-bit values | — |
| `.text "<str>"` | Emit text in current encoding | `.text "HELLO"` |
| `.shift "<str>"` | Text with high bit set on last byte | — |
| `.null "<str>"` | Text + zero terminator | `.null "HI"` |
| `.fill <n>[, <val>]` | Emit `n` bytes of value | `.fill 8, 0` |
| `.align <boundary>` | Align PC to boundary | `.align $100` |
| `.include "<file>"` | Include another source | `.include "lib.asm"` |
| `.binclude "<file>"` | Include source inside an implicit scope | `.binclude "lib.asm"` |
| `.binary "<file>"[, <off>[, <size>]]` | Embed raw binary | `.binary "data.bin"` |
| `.cpu "<id>"` | Select CPU (`"6502"`, `"6502i"`, `"65c02"`, `"65816"`, `"default"`) | `.cpu "6502"` |
| `.enc "<name>"` | Select text encoding (`"none"`, `"screen"`, `"petscii"`) | `.enc "screen"` |
| `.namespace <name> … .endn` | Named scope | — |
| `.proc … .pend` | Anonymous procedure scope | — |
| `.block … .bend` | Anonymous local scope | — |
| `.macro <name> [<args>] … .endm` | Define macro | — |
| `.segment <name> [<args>] … .endm` | Segment-style macro (called with `#name`) | — |
| `<name> .function (<args>) … .endf` | Compile-time function | — |
| `.struct <name> … .ends` | Record layout | — |
| `.if <expr>` / `.else` / `.endif` | Conditional assembly | — |
| `.for <var> = <init>, <cond>, <step> … .next` | Compile-time loop | — |
| `.rept <count> … .next` | Repeat block | — |
| `<sym> = <expr>` | Constant symbol | `VIC = $D000` |
| `<sym> := <expr>` | Reassignable variable | — |
| `.logical <expr> … .here` | Logical-PC override (code assembled for one address, lives at another) | — |

## output-options
| flag | effect | use |
|---|---|---|
| `--cbm-prg` / `-b` | Emit `.prg` with 2-byte load-address header | Standard C64 program |
| `--flat` / `-f` | Raw flat binary, no header | ROM image, cartridge body |
| `--nostart` | Suppress load-address header even with `--cbm-prg` | — |
| `--output-format <fmt>` | Explicit format (`prg`, `xex`, `flat`, `intel-hex`, `srec`) | Multi-platform output |
| `-o <file>` | Output filename | `-o out.prg` |
| `-I <dir>` | Add include search path | — |
| `-L <file>` | Emit label list / listing | — |
| `--ascii` | Treat source string literals as ASCII not PETSCII | — |

## labels
- Global labels: `name` at start of line (colon optional).
- Local labels prefixed with `_` are scoped to the surrounding non-local label.
- Scoped labels use `.` inside `.namespace` / `.proc` / `.block` (`outer.inner`).
- Anonymous labels: `+` and `-`; reference with `+`, `++`, `-`, `--` for distance.
- Cheap labels: `_loop` inside a parent block.

## examples
Minimal `.prg` skeleton with BASIC SYS stub:

```
*= $0801
    .word eob, 10
    .byte $9e
    .text "2061"
    .byte 0
eob: .word 0
*= $080d
    lda #0
    sta $d020
    rts
```

Build with: `64tass --cbm-prg -o hello.prg hello.asm`.

## links
- common patterns: [common-patterns.md](common-patterns.md)
- rosetta: [rosetta.md](rosetta.md)
- CPU mnemonics: [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md)
- toolchain workflow: [../toolchains/64tass-workflow.md](../toolchains/64tass-workflow.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- attribution: [../ATTRIBUTION.md](../ATTRIBUTION.md)
- upstream: 64tass manual (Soci/Singular), distributed with the 64tass release archive.
