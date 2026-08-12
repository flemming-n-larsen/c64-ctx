---
type: reference
domain: examples
granularity: example
summary: "Complete BASIC loader that POKEs machine code from DATA and SYSes it."
keywords: [BASIC example, DATA loader, SYS loader, machine code from BASIC]
---

## facts
- Complete BASIC V2 loader that reads machine-code bytes from `DATA`, `POKE`s them into RAM at `$C000` (`49152`), and calls them via `SYS`.
- `$C000-$CFFF` (4 KiB) is RAM that is never paged out and lies outside the BASIC text area, so the routine survives `NEW` and BASIC variable growth.
- The 12 `DATA` bytes assemble to a routine that sets both border and background to the chosen color and returns to BASIC.

## examples

### listing
```
10 FOR I=0 TO 11 : READ B : POKE 49152+I,B : NEXT
20 INPUT "COLOR (0-15)";C
30 POKE 49152+1,C
40 SYS 49152
50 GOTO 20
60 DATA 169,0,141,32,208,141,33,208,96,0,0,0
```

### disassembly of the DATA bytes
| offset | byte (dec) | byte (hex) | mnemonic |
|---:|---:|---:|---|
| `0` | `169` | `$A9` | `LDA #$00` |
| `1` | `0`   | `$00` | (immediate operand, patched by line 30) |
| `2` | `141` | `$8D` | `STA $D020` |
| `3` | `32`  | `$20` | |
| `4` | `208` | `$D0` | |
| `5` | `141` | `$8D` | `STA $D021` |
| `6` | `33`  | `$21` | |
| `7` | `208` | `$D0` | |
| `8` | `96`  | `$60` | `RTS` |
| `9-11` | `0` | `$00` | padding (unused) |

### run
- Type the listing and `RUN`.
- Enter a color number `0-15` at the prompt; the border and background become that color.
- The loop re-prompts; press `STOP` to exit.

## lookup
| element | meaning | route |
|---|---|---|
| `49152` | `$C000`, start of 4 KiB user RAM block | [../memory/map.md](../memory/map.md) |
| `SYS <addr>` | BASIC entry to ML; returns on `RTS` | [../basic/machine-code-bridge.md](../basic/machine-code-bridge.md) |
| `POKE 49152+1,C` | Patches immediate operand of `LDA #` | [../basic/machine-code-bridge.md](../basic/machine-code-bridge.md) |
| `$D020` / `$D021` | Border / background color registers | [../io/vic-ii.md](../io/vic-ii.md) |
| Program entrypoint shapes | BASIC loader + `SYS` shape | [../tasks/program-entrypoints.md](../tasks/program-entrypoints.md) |

## constraints
- The `DATA` bytes MUST be loaded before the first `SYS`; line 10 does this once per `RUN`.
- `POKE 49152+1,C` MUST occur before each `SYS` if `C` has changed — the immediate operand is part of the code stream, not a variable.
- The routine MUST end with `RTS` (`$60`) so `SYS` returns control to BASIC; missing `RTS` causes a crash or freeze.
- `$C000-$CFFF` is NOT auto-cleared on `RUN` or `NEW`; reloading the same `.bas` re-`POKE`s the bytes, but other programs may already have left data there.
- KERNAL ROM MUST remain banked in (`$0001` bit 1 = `HIRAM` = 1, the default) for `SYS` and `RTS` to return correctly.

## links

- BASIC examples reference: [../basic/examples.md](../basic/examples.md)
- CPU instruction set: [../cpu/6502/instruction-set.md](../cpu/6502/instruction-set.md)
- example index: [INDEX.md](INDEX.md)

## sources

- BASIC machine-code bridge: [../basic/machine-code-bridge.md](../basic/machine-code-bridge.md)
- program entrypoints: [../tasks/program-entrypoints.md](../tasks/program-entrypoints.md)
- memory map: [../memory/map.md](../memory/map.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
