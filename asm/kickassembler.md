---
type: reference
domain: asm
granularity: assembler
summary: "KickAssembler directives, macros and its scripting language."
keywords: [KickAssembler, KickAss, scripting, macros, pseudo commands]
---

## facts
- Target version: KickAssembler 5.x (typical: 5.25+).
- Requires a Java runtime (JRE 8 or later); invoked as `java -jar KickAss.jar <source>`.
- Default output is a `.prg` (with 2-byte CBM load-address header) named after the source.
- Source syntax is case-sensitive for symbols; mnemonics are case-insensitive.
- Comments: `//` to end of line, `/* … */` block.
- Powerful scripting layer — supports compile-time evaluation, list/hashtable literals, and Java-style expressions.

## directives
| directive | purpose | example |
|---|---|---|
| `.pc = <expr> ["<seg>"]` | Set program counter (optional segment label) | `.pc = $0801 "basic"` |
| `* = <expr>` | Alias for `.pc =` | `* = $c000` |
| `.byte <list>` / `.by` | Emit 8-bit values | `.byte 1, 2, 3` |
| `.word <list>` / `.wo` | Emit 16-bit little-endian | `.word $0801` |
| `.dword <list>` | Emit 32-bit values | — |
| `.text "<str>"` | Emit PETSCII text | `.text "HELLO"` |
| `.fill <n>, <expr>` | Emit `n` evaluated values; `i` is loop index | `.fill 256, i` |
| `.fillword <n>, <expr>` | 16-bit fill | — |
| `.align <boundary>` | Pad to alignment (`$100` etc.) | `.align $100` |
| `.import source "<file>"` | Include another KickAssembler source | `.import source "lib.asm"` |
| `.import binary "<file>"` | Embed raw binary | `.import binary "sprite.bin"` |
| `.import c64 "<file>"` | Embed `.prg` payload (skips header) | — |
| `.var <name> = <expr>` | Mutable variable | `.var x = 0` |
| `.const <name> = <expr>` | Constant | `.const VIC = $D000` |
| `.label <name> = <expr>` | Address label | `.label sprite_x = $D000` |
| `.enum { A, B, C }` | Enumerated constants | — |
| `.macro <name>(<args>) { … }` | Define macro | — |
| `:<name>(<args>)` | Invoke macro | `:set_border(0)` |
| `.pseudocommand <name> <args> { … }` | Define mnemonic-style macro | — |
| `.function <name>(<args>) { … :return <expr> }` | Compile-time function | — |
| `.eval <expr>` | Evaluate expression for side effect | `.eval x = x + 1` |
| `.if (<expr>) { … } else { … }` | Conditional assembly | — |
| `.for (<init>; <cond>; <step>) { … }` | Compile-time loop | `.for (var i=0; i<8; i++)` |
| `.while (<expr>) { … }` | Compile-time while | — |
| `.namespace <name> { … }` | Scoped name region | — |
| `.segment <name> [<opts>] { … }` | Segment definition | — |
| `.file [name="<f>"; segments="<list>"]` | Output file mapping | — |

## scripting
- Values: numbers, strings, booleans, `List()`, `Hashtable()`, `Vector(x,y)`, `Color()`.
- List literal: `List().add(1).add(2)` or `[1, 2, 3]` in some contexts.
- Hashtable: `Hashtable().put("k", v)`.
- Compile-time math: full Java operator precedence; `pow()`, `sin()`, `cos()`, etc.
- Use `.print "<msg>"` for build-time diagnostics.

## labels
- Global labels: `name:` at start of line.
- Local labels: `!name:`, referenced as `!name+` (next) or `!name-` (previous).
- Multi-label anonymous: `!:` then `!+` / `!-` chains.
- Scoped labels inside `.namespace` or `.macro` are isolated.

## examples
Minimal `.prg` skeleton with BASIC SYS stub:

```
.pc = $0801 "basic"
    .word end_of_basic, 10
    .byte $9e
    .text "2061"
    .byte 0
end_of_basic: .word 0
.pc = $080d "main"
    lda #0
    sta $d020
    rts
```

## sources

- attribution: [../ATTRIBUTION.md](../ATTRIBUTION.md)
- upstream: KickAssembler reference manual (Mads Nielsen), distributed with the KickAssembler release archive.
- common patterns: [common-patterns.md](common-patterns.md)
- rosetta: [rosetta.md](rosetta.md)
- CPU mnemonics: [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md)
- toolchain workflow: [../toolchains/kickassembler-workflow.md](../toolchains/kickassembler-workflow.md)
