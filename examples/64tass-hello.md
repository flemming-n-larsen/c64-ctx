---
type: reference
domain: examples
granularity: example
summary: "Minimal buildable 64tass program that prints HELLO and returns to BASIC."
keywords: [64tass example, hello world, minimal prg, buildable]
---

## facts
- Minimal buildable 64tass 1.58+ program that prints `HELLO` via KERNAL `CHROUT` and returns to BASIC.
- Loads at `$0801` with a BASIC SYS stub so `RUN` autostarts the body at `$080D`.
- 64tass output format is set on the CLI — `--cbm-prg` (or `-b`) MUST be used to emit a `.prg` with the 2-byte load-address header.

## examples

### source — `hello.asm`
```
*= $0801
        .word eob, 10           ; next-line link, line number 10
        .byte $9e               ; SYS token
        .text "2061"            ; PETSCII " 2061"
        .byte 0                 ; end of line
eob:    .word 0                 ; end of program

*= $080d
        ldx #0
loop:   lda message,x
        beq done
        jsr $ffd2               ; CHROUT
        inx
        bne loop
done:   rts

message:
        .text "HELLO"
        .byte $0d, 0
```

### build and run
```
64tass --cbm-prg -o hello.prg hello.asm
x64sc hello.prg
```
Type `RUN`; `HELLO` prints on the next line and control returns to BASIC's `READY.` prompt.

## lookup
| element | meaning | route |
|---|---|---|
| `*= <addr>` | Set program counter / load address | [../asm/64tass.md](../asm/64tass.md) |
| `.text "<s>"` | Emit PETSCII bytes (default `.enc`) | [../asm/64tass.md](../asm/64tass.md) |
| `--cbm-prg` / `-b` | Emit `.prg` with CBM load-address header | [../toolchains/64tass-workflow.md](../toolchains/64tass-workflow.md) |
| BASIC SYS stub at `$0801` | 12-byte autostart shape | [../asm/common-patterns.md](../asm/common-patterns.md) |
| `JSR $FFD2` | KERNAL `CHROUT` — print PETSCII char in `.A` | [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md) |

## constraints
- `--cbm-prg` MUST be passed to `64tass`; the default flat-binary output omits the 2-byte load-address header and will not autostart as a `.prg`.
- The first `*= <addr>` defines the load address that becomes the `.prg` header; later `*=` directives do NOT change the header.
- The SYS stub MUST precede the `$080D` body; `RUN` jumps to address `2061` (`$080D`) regardless of body location.
- `.text` encoding defaults to PETSCII; if `.enc` has been switched, restore it before emitting CBM-targeted strings.
- KERNAL ROM MUST be banked in (`$0001` bit 1 = `HIRAM` = 1, default after reset) for `JSR $FFD2` to call `CHROUT`.

## sources

- 64tass reference: [../asm/64tass.md](../asm/64tass.md)
- common ASM patterns: [../asm/common-patterns.md](../asm/common-patterns.md)
- 64tass workflow: [../toolchains/64tass-workflow.md](../toolchains/64tass-workflow.md)
- KERNAL CHROUT: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)
- VICE: [../toolchains/vice.md](../toolchains/vice.md)
- memory map: [../memory/map.md](../memory/map.md)
- CPU instruction set: [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md)
- example index: [INDEX.md](INDEX.md)
