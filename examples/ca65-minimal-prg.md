---
type: reference
domain: examples
granularity: example
summary: "Minimal buildable cc65 program assembled with ca65 and linked with ld65."
keywords: [ca65 example, cc65 example, minimal prg, buildable]
---

## facts
- Minimal buildable cc65 2.19+ program assembled with `ca65` and linked with `ld65 -t c64`.
- Uses the bundled `c64.cfg` + `c64.lib` so the SYS stub at `$0801` is emitted by the cc65 runtime automatically — the source contains only the body.
- Body sets border + background to black and returns to the C runtime, which returns control to BASIC.

## examples

### source — `hello.s`
```
.setcpu "6502"
.export _main

.segment "CODE"
_main:
        lda #0
        sta $d020       ; border = black
        sta $d021       ; background = black
        rts
```

### build and run
```
ca65 -t c64 hello.s -o hello.o
ld65 -t c64 -o hello.prg hello.o c64.lib
x64sc hello.prg
```
Type `RUN`; the screen frame and background go black, and control returns to BASIC.

### alternative — hand-rolled SYS stub, no cc65 runtime
For a minimal `.prg` without the cc65 C runtime, use a custom linker config (`custom.cfg`, see [../asm/ca65.md](../asm/ca65.md#linker-config)) and emit the SYS stub directly:

```
.segment "STARTUP"
        .word $080b              ; next-line link
        .word 10                 ; line number
        .byte $9e, "2061", 0     ; SYS 2061
        .word 0                  ; end-of-program

.segment "CODE"
        lda #0
        sta $d020
        sta $d021
        rts
```
Build with `ca65 hello.s -o hello.o` and `ld65 -C custom.cfg -o hello.prg hello.o`.

## lookup
| element | meaning | route |
|---|---|---|
| `.setcpu` / `.segment` / `.export` | ca65 directives | [../asm/ca65.md](../asm/ca65.md) |
| `_main` entry | cc65 C-runtime entry symbol | [../asm/ca65.md](../asm/ca65.md) |
| `ld65 -t c64` | C64 target — pulls `c64.cfg` + `c64.lib` | [../toolchains/ca65-workflow.md](../toolchains/ca65-workflow.md) |
| `$D020` / `$D021` | VIC-II border / background color | [../io/vic-ii.md](../io/vic-ii.md) |
| BASIC SYS stub layout | 12-byte autostart shape | [../asm/common-patterns.md](../asm/common-patterns.md) |

## constraints
- `-t c64` MUST be passed to BOTH `ca65` and `ld65` for the runtime to link cleanly; mismatched targets produce link errors.
- `c64.lib` MUST be on the `ld65` library search path; standard cc65 installs configure this automatically.
- With the `-t c64` runtime, the body MUST be reachable from `_main` and MUST end with `RTS` so the runtime returns to BASIC.
- A custom-config build MUST emit its own BASIC SYS stub at `$0801`, otherwise `RUN` jumps into garbage.
- The cc65 runtime saves/restores the stack pointer; aggressive zero-page use (`$02-$1A`) MAY clobber the runtime's scratch — see the `ZEROPAGE` segment in `c64.cfg`.

## links

- VICE: [../toolchains/vice.md](../toolchains/vice.md)
- memory map: [../memory/map.md](../memory/map.md)
- CPU instruction set: [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md)
- example index: [INDEX.md](INDEX.md)

## sources

- CA65 reference: [../asm/ca65.md](../asm/ca65.md)
- common ASM patterns: [../asm/common-patterns.md](../asm/common-patterns.md)
- CA65 workflow: [../toolchains/ca65-workflow.md](../toolchains/ca65-workflow.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
