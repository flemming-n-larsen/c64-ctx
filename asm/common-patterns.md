---
type: reference
domain: asm
granularity: patterns
summary: "Assembler-agnostic patterns: prg load address, BASIC SYS stub, KERNAL calls."
keywords: [common patterns, SYS stub, prg header, boilerplate]
---

## facts
- A C64 `.prg` file begins with a 2-byte little-endian load address; everything after is the data loaded starting at that address.
- The canonical BASIC autostart load address is `$0801`. A tokenized one-line `10 SYS 2061` (`$0801-$080C`) makes ML at `$080D` autostart on `RUN`.
- `$C000-$CFFF` (4 KB) is RAM that is never paged out by ROM/I/O regardless of `$0001`; it MUST be loaded with `LOAD ",8,1"` because it lies outside BASIC text.
- Zero-page `$02-$7F` is the user-safe scratch range when KERNAL/BASIC are active; touching `$80-$FF` may corrupt KERNAL workspace.

## sequence
### BASIC SYS stub at $0801

| step | bytes (hex) | meaning |
|---|---|---|
| 1. next-line link | `0C 08` | pointer to `$080C` (end-of-program marker) |
| 2. line number | `0A 00` | line 10 |
| 3. SYS token | `9E` | BASIC `SYS` keyword |
| 4. SYS argument | `20 32 30 36 31` | `" 2061"` in PETSCII |
| 5. end of line | `00` | line terminator |
| 6. end of program | `00 00` | empty next-line link |
| 7. ML start | (begins at `$080D`) | first ML instruction |

### Standalone .prg layout
1. First 2 file bytes: load address (e.g. `01 08` for `$0801`, `00 C0` for `$C000`).
2. Body bytes follow contiguously; assembler emits these after the header.
3. If load address is `$0801`, include the SYS stub above so `RUN` works. Otherwise the user MUST type `SYS <addr>` after `LOAD ",8,1"`.

### Calling a KERNAL routine
1. Set up registers per the routine contract (see [../kernal/INDEX.md](../kernal/INDEX.md)).
2. Ensure KERNAL ROM is banked in (`$0001` bit 1 = `HIRAM` = 1; default after reset).
3. `JSR <kernal_addr>` (e.g. `JSR $FFD2` for `CHROUT`).
4. Check return: most KERNAL calls return errors via `C` flag set and accumulator = error code.
5. Preserve registers around the call only if the caller still needs them — KERNAL routines clobber per their contract.

## lookup
| pattern | route |
|---|---|
| BASIC SYS stub bytes / 12-byte canonical layout | [../tasks/program-entrypoints.md](../tasks/program-entrypoints.md) |
| Bank `$0001` for ROM/RAM/I/O choices | [../tasks/bank-switch-rom-ram.md](../tasks/bank-switch-rom-ram.md) |
| KERNAL jump-table call addresses | [../kernal/INDEX.md](../kernal/INDEX.md) |
| Memory map and safe code/data zones | [../memory/map.md](../memory/map.md) |
| Zero-page user-safe range | [../memory/zero-page.md](../memory/zero-page.md) |
| Raster IRQ pattern (`SEI`/vector/`$D012`/`CLI`/`RTI`) | [../irq/raster-interrupt.md](../irq/raster-interrupt.md) |
| Choosing program shape (BASIC, SYS, `.prg`, cartridge) | [../tasks/program-entrypoints.md](../tasks/program-entrypoints.md) |

## constraints
- ML placed at `$0801` without a BASIC stub overwrites `TXTTAB` / next-line-link bytes and will not run via `RUN`; it MUST be entered via `SYS 2049` or higher.
- Code returning to BASIC via `RTS` MUST leave KERNAL ROM banked in and IRQ enabled (`CLI` if previously `SEI`).
- Programs that disable interrupts (`SEI`) MUST either re-enable (`CLI`) before returning or replace the IRQ vector at `$0314/$0315`.
- A KERNAL call with KERNAL ROM banked out (`HIRAM=0`) MUST NOT be made — jump-table addresses `$FF81-$FFF5` only resolve correctly when ROM is visible.
- Self-modifying code in ROM-shadow RAM (`$A000-$BFFF`, `$E000-$FFFF`) requires explicit banking via `$0001` before writes can be read back.
- Zero-page writes to `$00`/`$01` change the CPU data direction and processor port — they MUST be done with read-modify-write care and the IRQ-safe pattern from [../tasks/bank-switch-rom-ram.md](../tasks/bank-switch-rom-ram.md).

## examples
Minimal "set border colour and return to BASIC" — same shape in each assembler:

ACME:
```
!to "border.prg", cbm
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

KickAssembler:
```
.pc = $0801 "basic"
    .word eob, 10
    .byte $9e
    .text "2061"
    .byte 0
eob: .word 0
.pc = $080d "main"
    lda #0
    sta $d020
    rts
```

CA65 (with `ld65 -t c64`, no hand-rolled stub needed — the c64 runtime emits the SYS line):
```
.segment "CODE"
.export _main
_main:
    lda #0
    sta $d020
    rts
```

64tass:
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

KERNAL `CHROUT` call (assembler-neutral mnemonics):
```
    lda #'A'        ; PETSCII 'A'
    jsr $ffd2       ; CHROUT
    rts
```

## sources

- program entrypoints: [../tasks/program-entrypoints.md](../tasks/program-entrypoints.md)
- memory map: [../memory/map.md](../memory/map.md)
- zero-page: [../memory/zero-page.md](../memory/zero-page.md)
- KERNAL index: [../kernal/INDEX.md](../kernal/INDEX.md)
- ACME: [acme.md](acme.md)
- KickAssembler: [kickassembler.md](kickassembler.md)
- CA65: [ca65.md](ca65.md)
- 64tass: [64tass.md](64tass.md)
- rosetta: [rosetta.md](rosetta.md)
- BASIC machine-code bridge: [../basic/machine-code-bridge.md](../basic/machine-code-bridge.md)
