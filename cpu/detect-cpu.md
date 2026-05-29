---
type: reference
domain: cpu
source: codebase64.net
---

## facts
- Opcode `$1A` is `INA` (increment accumulator) on 65C02 and 65816; treated as `NOP` on NMOS 6502/6510.
- Opcode `$3A` is `DEC A` on 65C02/65816; also NOP on NMOS.
- Instruction `XBA` (`$EB`) swaps the 65816 A register halves; acts as NOP on 65C02.
- C64 and C128 ship with NMOS 6510/8502 (result 0).
- Detection is useful for code that must run across multiple 6502-family platforms.

## lookup

### Detection routine return values
| CPU | Carry | A | Notes |
|---|---|---|---|
| NMOS 6502 / 6510 / 8502 | Clear | 0 | Standard C64/C128 CPU |
| CMOS 65C02 | Set | 1 | Enhanced instruction set |
| WDC 65816 | Set | 2 | 16-bit capable; used in SNES, Apple IIGS |

## sequence

### Detection routine
```asm
detect_cpu
    lda #0
    !byte $1A            ; INA on 65C02/816; NOP on NMOS
    cmp #1
    bcc nmos             ; A still 0 → NMOS

    ; Distinguish 65C02 from 65816 via XBA
    !byte $EB            ; XBA on 65816 (preserves A in B); NOP on 65C02
    !byte $3A            ; DEC A on both C02 and 816
    !byte $EB            ; XBA on 65816 restores saved A (=1)
    !byte $1A            ; INA: 65C02 → A was 0 → A=1; 65816 → A was 1 → A=2
    sec
    rts

nmos
    clc
    rts
```
Use `!byte` (ACME) or `.byte` (other assemblers) to emit opcodes the assembler doesn't know by mnemonic.

## constraints
- The C64 always contains an NMOS 6510 (or 8500 in later revisions); this routine returns carry clear, A=0 on real hardware.
- 65C02 extended opcodes (`INA`, `DEC A`, branch-always) are not available on the 6510; do not use in C64-only code.
- `XBA` is a 65816-only instruction; on 65C02 it executes as a two-cycle NOP (`$EB`).

## links
- CPU identity and 6510 specifics: [6510.md](6510.md)
- illegal opcodes (NMOS-only): [6502/illegal-opcodes.md](6502/illegal-opcodes.md)

## sources
- https://codebase64.net/doku.php?id=base:detect_cpu_type — CC BY-NC-SA 4.0 (author: Ullrich von Bassewitz)
- [../sources/INDEX.md](../sources/INDEX.md)
