---
type: reference
domain: examples
granularity: example
summary: "Minimal buildable ACME program that prints HELLO and returns to BASIC."
keywords: [ACME example, hello world, minimal prg, buildable]
---

## facts
- Minimal buildable ACME 0.97+ program that prints `HELLO` to the default screen via the KERNAL `CHROUT` routine and returns to BASIC.
- Loads at `$0801` with a tokenized BASIC `SYS 2061` stub so `RUN` autostarts the ML body at `$080D`.
- ACME emits the `.prg` directly via `!to "<file>", cbm` — no separate linker step.

## examples

### source — `hello.a`
```
!to "hello.prg", cbm
!cpu 6510

; -------- BASIC SYS stub at $0801 --------
*= $0801
        !word eob, 10           ; next-line link, line number 10
        !byte $9e               ; SYS token
        !text "2061"            ; PETSCII " 2061"
        !byte 0                 ; end of line
eob:    !word 0                 ; end of program

; -------- main routine at $080D --------
*= $080d
        ldx #0
loop:   lda message,x
        beq done
        jsr $ffd2               ; CHROUT — print PETSCII in .A
        inx
        bne loop
done:   rts

message:
        !text "HELLO"
        !byte $0d, 0            ; CR + NUL terminator
```

### build and run
```
acme hello.a
x64sc hello.prg
```
Type `RUN` after the C64 boots; `HELLO` prints on the next line and control returns to BASIC's `READY.` prompt.

## lookup
| element | meaning | route |
|---|---|---|
| `!to "<f>", cbm` | Emit `.prg` with 2-byte CBM load-address header | [../asm/acme.md](../asm/acme.md) |
| `*= $0801` | Set program counter | [../asm/acme.md](../asm/acme.md) |
| BASIC SYS stub at `$0801` | 12-byte autostart shape | [../asm/common-patterns.md](../asm/common-patterns.md) |
| `JSR $FFD2` | KERNAL `CHROUT` — print PETSCII char in `.A` | [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md) |
| ACME → `.prg` → VICE loop | Build/run pipeline | [../toolchains/acme-workflow.md](../toolchains/acme-workflow.md) |

## constraints
- `!to "hello.prg", cbm` MUST appear before any code emission; ACME refuses to assemble if the output format is ambiguous.
- The `$080D` body MUST follow the 12-byte SYS stub — `RUN` jumps to address `2061` (`$080D`) regardless of the actual code location.
- KERNAL ROM MUST be banked in (`$0001` bit 1 = `HIRAM` = 1, default after reset) for `JSR $FFD2` to call `CHROUT`.
- The message MUST be NUL-terminated (`!byte 0`) because the loop branches on `BEQ`.
- `x64sc` is the VICE PAL-C64 emulator binary; substitute `x64` if `x64sc` is not present.

## sources

- ACME reference: [../asm/acme.md](../asm/acme.md)
- common ASM patterns: [../asm/common-patterns.md](../asm/common-patterns.md)
- ACME workflow: [../toolchains/acme-workflow.md](../toolchains/acme-workflow.md)
- KERNAL CHROUT: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)
- VICE: [../toolchains/vice.md](../toolchains/vice.md)
- memory map: [../memory/map.md](../memory/map.md)
- CPU instruction set: [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md)
- example index: [INDEX.md](INDEX.md)
