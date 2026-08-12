---
type: reference
domain: asm
granularity: assembler
summary: "ACME directives, expressions and output formats."
keywords: [ACME, directives, pseudo opcodes, output formats]
---

## facts
- Target version: ACME 0.97 or later.
- Source syntax is case-insensitive for mnemonics; labels are case-sensitive.
- Output format MUST be selected with `!to "<file>", <format>` where `<format>` is `cbm` (`.prg` header), `plain` (raw), or `apple`.
- The program counter MUST be set with `*= <addr>` before code or data is emitted.
- Comments use `;` to end of line; block comments are not supported.

## directives
| directive | purpose | example |
|---|---|---|
| `*= <expr>` | Set program counter | `*= $0801` |
| `!to "<file>", <fmt>` | Output file + format | `!to "out.prg", cbm` |
| `!cpu <id>` | Select CPU (`6502`, `nmos6502`, `65c02`, `r65c02`, `w65c02`, `65816`) | `!cpu 6510` |
| `!byte <list>` | Emit 8-bit values | `!byte $00, $01, $02` |
| `!word <list>` | Emit 16-bit little-endian | `!word $0801, label` |
| `!24 <list>` / `!32 <list>` | Emit 24/32-bit values | `!24 $123456` |
| `!text "<str>"` | Emit PETSCII (assembler default encoding) | `!text "HELLO"` |
| `!scr "<str>"` | Emit screen-code text | `!scr "HELLO"` |
| `!pet "<str>"` | Force PETSCII text | `!pet "hi"` |
| `!fill <n>[, <val>]` | Emit `n` bytes of value (default `0`) | `!fill 8, $ff` |
| `!align <mask>, <val>[, <fill>]` | Align PC so `PC AND mask == val` | `!align 255, 0` |
| `!zone [<name>]` | Begin local-label zone | `!zone main` |
| `!src "<file>"` / `!source` | Include another source file | `!src "lib.a"` |
| `!binary "<file>"[, <size>[, <skip>]]` | Embed raw binary | `!binary "sprite.bin"` |
| `!if <expr> { … } else { … }` | Conditional assembly | — |
| `!ifdef <sym> { … }` / `!ifndef` | Symbol-defined conditional | — |
| `!for <var>, <start>, <end> { … }` | Compile-time loop | — |
| `!macro <name> [<params>] { … }` | Define macro | — |
| `+<name> [args]` | Invoke macro | `+wait_raster $80` |
| `!set <sym> = <expr>` | Reassignable symbol | `!set count = count + 1` |
| `<sym> = <expr>` | Constant symbol | `VIC = $D000` |

## expressions
- Byte-extract operators: `<expr` low byte, `>expr` high byte, `^expr` bank byte.
- Anonymous labels: `+` and `-`; reference as `+`, `++`, `-`, `--` for forward/backward distance.
- Local labels in a `!zone` prefix with `.` (`.loop`).
- Cheap local labels use `@` prefix; scope ends at next non-local label.
- Arithmetic: `+ - * / % & | ^ << >> ! ~` and logical comparisons.

## output formats
| format | header | use |
|---|---|---|
| `cbm` | 2-byte little-endian load address | C64 `.prg` |
| `plain` | none | raw binary, ROM image |
| `apple` | 4-byte DOS 3.3 header | Apple II |

## examples
Minimal `.prg` skeleton with BASIC SYS stub:

```
!to "hello.prg", cbm
*= $0801
    !word eob, 10
    !byte $9e
    !text "2061"
    !byte 0
eob: !word 0
*= $080d
    lda #0
    sta $d020
    rts
```

## links

- common patterns: [common-patterns.md](common-patterns.md)
- rosetta: [rosetta.md](rosetta.md)
- CPU mnemonics: [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md)
- toolchain workflow: [../toolchains/acme-workflow.md](../toolchains/acme-workflow.md)

## sources

- attribution: [../ATTRIBUTION.md](../ATTRIBUTION.md)
- upstream: ACME user manual (Marco Baye), distributed with the ACME release archive.
