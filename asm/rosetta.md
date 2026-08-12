---
type: reference
domain: asm
granularity: cross-reference
summary: "Side-by-side equivalence of the same construct across four assemblers."
keywords: [rosetta, syntax translation, assembler comparison, porting source]
---

## facts
- This page maps equivalent constructs across ACME, KickAssembler, CA65, and 64tass.
- Mnemonics, addressing modes, and operand syntax (`lda #$00`, `sta $d020`, `lda ($02),y`) are identical across all four — only directives differ.
- Hex prefix is `$` in all four; binary prefix is `%` in all four.
- All four target the NMOS 6502/6510 by default for C64 work.

## equivalence
| intent | ACME | KickAssembler | CA65 | 64tass |
|---|---|---|---|---|
| Set PC / origin | `*= $0801` | `.pc = $0801` | `.org $0801` (or linker) | `*= $0801` |
| Select output file | `!to "out.prg", cbm` | command-line / `.file` directive | `ld65 -o out.prg` | `-o out.prg --cbm-prg` |
| Emit bytes | `!byte $01, $02` | `.byte 1, 2` | `.byte 1, 2` | `.byte 1, 2` |
| Emit words (LE) | `!word $0801` | `.word $0801` | `.word $0801` | `.word $0801` |
| Emit PETSCII text | `!text "HI"` or `!pet "HI"` | `.text "HI"` | `.byte "HI"` | `.text "HI"` (encoding `petscii`) |
| Emit screen-code text | `!scr "HI"` | `.text @"HI"` (with `.encoding`) | manual conversion | `.text "HI"` after `.enc "screen"` |
| Include source | `!src "lib.a"` | `.import source "lib.asm"` | `.include "lib.inc"` | `.include "lib.asm"` |
| Embed raw binary | `!binary "f.bin"` | `.import binary "f.bin"` | `.incbin "f.bin"` | `.binary "f.bin"` |
| Reserve N bytes | `!fill 8, 0` | `.fill 8, 0` | `.res 8, 0` | `.fill 8, 0` |
| Align PC | `!align 255, 0` | `.align $100` | `.align $100` (in `.cfg`) | `.align $100` |
| Define constant | `VIC = $D000` | `.const VIC = $D000` | `VIC = $D000` | `VIC = $D000` |
| Reassignable variable | `!set x = x + 1` | `.var x = 0` / `.eval x = x+1` | (use macros) | `x := x + 1` |
| Define macro | `!macro name { … }` | `.macro name(args) { … }` | `.macro name … .endmacro` | `.macro name … .endm` |
| Invoke macro | `+name args` | `:name(args)` | `name args` | `#name args` |
| Conditional assembly | `!if expr { … }` | `.if (expr) { … }` | `.if expr` / `.endif` | `.if expr` / `.endif` |
| Compile-time loop | `!for i, 0, 7 { … }` | `.for (var i=0; i<8; i++)` | `.repeat 8, i … .endrepeat` | `.for i = 0, i < 8, i += 1` |
| Local-label scope | `!zone name` | `.namespace name { … }` | `.scope name … .endscope` | `.namespace name … .endn` |
| Procedure (auto-exported) | (use `!zone`) | label + `.macro` | `.proc name … .endproc` | `.proc … .pend` |
| Anonymous forward label | `+` / reference `+` | `!:` / `!+` | `:` / `:+` | `+` / reference `+` |
| Anonymous backward label | `-` / reference `-` | `!:` / `!-` | `:` / `:-` | `-` / reference `-` |
| Low byte of expression | `<label` | `<label` | `<label` | `<label` |
| High byte of expression | `>label` | `>label` | `>label` | `>label` |
| Select CPU variant | `!cpu 6510` | (project-level / target) | `.setcpu "6502"` | `.cpu "6502"` |
| Line comment | `;` | `//` | `;` | `;` |
| Block comment | not supported | `/* … */` | not supported | not supported |

## constraints
- Anonymous forward/backward label syntax differs subtly: KickAssembler requires the leading `!` prefix; ACME and 64tass use bare `+`/`-`; CA65 uses `:`.
- CA65 SHOULD be built with `ld65 -t c64` for the easiest `.prg` output; the other three emit `.prg` directly.
- KickAssembler text encoding defaults to PETSCII; use `.encoding "screencode_mixed"` to switch to screen codes globally, or `@"…"` for one literal.
- 64tass text encoding is selected by `.enc "<name>"` and persists until changed.
- Byte-extract operators (`<expr`, `>expr`) work identically in all four — they MUST follow an operator slot, not lead an expression line.

## links
- ACME: [acme.md](acme.md)
- KickAssembler: [kickassembler.md](kickassembler.md)
- CA65: [ca65.md](ca65.md)
- 64tass: [64tass.md](64tass.md)
- common patterns: [common-patterns.md](common-patterns.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- ACME page: [acme.md](acme.md)
- KickAssembler page: [kickassembler.md](kickassembler.md)
- CA65 page: [ca65.md](ca65.md)
- 64tass page: [64tass.md](64tass.md)
