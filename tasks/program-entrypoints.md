---
type: reference
domain: tasks
granularity: recipe
summary: "Pick a delivery shape: BASIC stub, SYS loader, standalone prg, or cartridge."
keywords: [entry point, load address, SYS stub, prg layout, autostart]
---

## sequence

1. **Pick a delivery shape** — choose one of the five options in the lookup table below before writing any code. The choice determines load address, what runs first, and what the program is allowed to assume about ROM/IRQ state.
2. **Write the entry assumptions explicitly** — register state, banking state (`$0001`), IRQ enable, and KERNAL/BASIC ROM visibility expected on entry.
3. **Place code at the matching address** — the chosen shape fixes the start address (e.g. `$0801` for a `.prg` that lands in BASIC text, `$C000` for a SYS-target ML blob).
4. **Provide the matching boot mechanism** — BASIC SYS stub, KERNAL `LOAD ,8,1`, or cartridge cold/warm-start vectors at `$8000-$8003`.
5. **Document the exit contract** — `RTS` to BASIC, infinite loop, or NMI/restart entry; the caller side MUST match.

## lookup

| shape | load address | entry mechanism | ROM/IRQ state on entry | use when |
|---|---|---|---|---|
| BASIC-only program | `$0801` (BASIC text start) | `RUN` after `LOAD "name",8` | BASIC + KERNAL visible, IRQ on | Pure BASIC. See [../basic/program-structure.md](../basic/program-structure.md). |
| BASIC loader + `SYS` | `$0801` (SYS stub) + ML block (e.g. `$C000`) | BASIC `SYS <addr>` calls `JSR <addr>` | BASIC + KERNAL visible, IRQ on, A/X/Y from `$030C-$030E` | Mixed program; ML reachable from BASIC. See [../basic/machine-code-bridge.md](../basic/machine-code-bridge.md). |
| Standalone `.prg` with SYS stub | `$0801` (one-line tokenized `10 SYS 2061`); ML at `$080D` | `LOAD "name",8` then `RUN` autostarts via SYS stub | BASIC + KERNAL visible, IRQ on | Self-contained ML deliverable that still uses the BASIC loader. |
| Absolute-load ML (`LOAD ,8,1`) | Any (e.g. `$C000`, `$0334`) | Manual `SYS <addr>` after load | BASIC + KERNAL visible, IRQ on | ML at a fixed address with no BASIC text; user types `SYS` to start. |
| Cartridge ROM | `$8000-$9FFF` (8 KB) or `$8000-$BFFF` (16 KB) | Cold-start vector at `$8000`/`$8001`, warm-start at `$8002`/`$8003`, magic `CBM80` at `$8004-$8008` | KERNAL reset path; banking and IRQ as left by RESET | Auto-start on power-on. Cartridge presence is detected by the reset routine. |

## constraints

- A `.prg` file's first two bytes ARE the load address (little-endian); they are NOT part of the runnable data. Toolchains that emit `.prg` MUST include this header (`--cbm-prg` for 64tass, `!to "name.prg",cbm` for ACME, default for ca65 `c64` target and KickAssembler).
- Code at `$0801-$08FF` MUST account for the tokenized BASIC SYS line plus `TXTTAB`/`VARTAB`/`ARYTAB` pointers; placing raw ML there without a stub overwrites BASIC's text-start sentinel.
- A SYS stub MUST end with a `$00` byte (BASIC line terminator) and a `$0000` next-line link before ML body begins; the canonical layout is 12 bytes at `$0801-$080C` with ML starting at `$080D` (`SYS 2061`).
- Standalone ML at `$C000-$CFFF` is preferred for SYS-callable code: 4 KB of RAM that is never paged by ROM/I/O, regardless of `$0001`.
- Code that returns to BASIC via `RTS` MUST preserve the stack and MUST NOT alter `MEMSIZ` (`$0037`) / `TXTTAB` (`$002B`) without a matching `CLR`.
- Cartridge code starts with KERNAL ROM, BASIC ROM, and I/O all banked in; it MAY repurpose any of them by writing `$0001`, but it MUST handle its own IRQ vectors if it banks out KERNAL.
- A program that disables interrupts (`SEI`) on entry and replaces the IRQ vector MUST restore them before returning to BASIC, or BASIC will not respond to STOP.
- A program that banks out KERNAL ROM (`$E000-$FFFF`) loses KERNAL IRQ service AND the reset vectors at `$FFFA-$FFFE`; it MUST provide its own IRQ/NMI/BRK handlers in RAM at the matching addresses before the next interrupt.

## examples

Canonical BASIC SYS stub at `$0801` (12 bytes; `SYS 2061` puts entry at `$080D`):

```
$0801: 0C 08 0A 00 9E 20 32 30 36 31 00 00 00
        ^---^ next-line link ($080C)
              ^---^ line number 10
                    ^^ SYS token
                       ^------------^ "2061"
                                   ^^ end-of-line + end-of-program
```

KickAssembler form:

```
.pc = $0801 "basic"
    .word end_of_basic, 10
    .byte $9e        // SYS token
    .text "2061"
    .byte 0
end_of_basic: .word 0
.pc = $080d "main"
    // ML body
    rts
```

## sources

- BASIC machine-code bridge: [../basic/machine-code-bridge.md](../basic/machine-code-bridge.md)
- memory map: [../memory/map.md](../memory/map.md)
- memory symbols: [../memory/symbols.md](../memory/symbols.md)
- task index: [INDEX.md](INDEX.md)
- BASIC program structure: [../basic/program-structure.md](../basic/program-structure.md)
- load/save: [load-save-file.md](load-save-file.md)
- bank switch: [bank-switch-rom-ram.md](bank-switch-rom-ram.md)
