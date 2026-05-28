---
type: reference
domain: basic
granularity: bridge
---

## facts
- `SYS <addr>` calls machine code at `<addr>` via `JSR`; CPU registers A/X/Y are loaded from `$030C-$030E` on entry and stored back to `$030C-$030E` on return.
- `USR(X)` calls the user-defined ML routine via the vector at `$0311-$0312` (low/high); the argument `X` is passed in the floating-point accumulator (FAC) at `$61-$66`; the ML routine MUST return a float in the FAC.
- `PEEK(A)` reads one byte from address `A` through the current CPU memory configuration (governed by `$0001`).
- `POKE A, V` writes byte `V` (`0-255`) to address `A` (`0-65535`).
- `DATA <list>` stores literal numeric or quoted-string values inside tokenized BASIC text; `READ <var-list>` walks them via `DATPTR` (`$0041`); `RESTORE` resets `DATPTR` to the start of program text.
- The BASIC SYS stub at `$0801-$080C` is a one-line tokenized program of the form `10 SYS <addr>` used to autostart ML when a `.prg` loads at the default BASIC text start.

## lookup
| mechanism | shape | inputs | outputs | typical use |
|---|---|---|---|---|
| `SYS <addr>` | Call ML via `JSR <addr>` | A/X/Y from `$030C-$030E` | A/X/Y back to `$030C-$030E` | Launch routine, KERNAL call wrapper |
| `USR(X)` | Call ML through vector `$0311-$0312` | FAC at `$61-$66` (argument `X`) | FAC return value | Math accelerator, scalar transform |
| `PEEK(A)` | Read byte | `A` in `0-65535` | Byte `0-255` | Read hardware register / RAM |
| `POKE A, V` | Write byte | `A` in `0-65535`, `V` in `0-255` | None | Write hardware register / RAM |
| `DATA …` / `READ var` | Embed and consume constants | `READ` pulls next item via `DATPTR` | Variable populated | Embed ML bytes / tables in BASIC |

## sequence
1. **Allocate code area** — choose a safe address:
   - Cassette buffer `$033C-$03FB` (192 bytes; loses tape I/O support).
   - Unused `$C000-$CFFF` (4 KB RAM, never paged by ROM/I/O; preferred default).
   - Reserve top-of-BASIC RAM by lowering `MEMSIZ` (`$0037`) and following with `CLR`.
2. **Load bytes** — either `DATA` + `READ` + `POKE` loop, or `LOAD "name",8,1` to use the absolute load address embedded in a `.prg`.
3. **Set call registers** if needed — `POKE 780,A` / `POKE 781,X` / `POKE 782,Y` (these mirror `$030C-$030E`).
4. **Call** — `SYS <addr>` as a statement, or `X = USR(arg)` inside an expression.

## constraints
- ML loaded into the BASIC text area (`$0801-`) MUST account for `TXTTAB`/`VARTAB`; using `$033C-$03FB` or `$C000-$CFFF` avoids BASIC-pointer collisions.
- Reserving top-of-BASIC RAM REQUIRES `POKE 56,<page>` and `POKE 55,<lo>` followed by `CLR` so `MEMSIZ` (`$0037`) takes effect.
- `SYS` targets MUST return via `RTS` and MUST preserve the 6502 stack discipline expected by the BASIC interpreter.
- `USR(X)` REQUIRES the vector at `$0311-$0312` to be initialized BEFORE the first call.
- `POKE` and `PEEK` honor `$0001` banking; writes into `$D000-$DFFF` may land in I/O registers or underlying RAM depending on banking state.
- `DATA` items MUST be numeric literals or quoted strings; expressions are NOT evaluated.
- `READ` past the last `DATA` item raises `OUT OF DATA` (error 13).
- BASIC's interpreter overwrites `$61-$66` between `USR` calls; callers MUST read the returned FAC value immediately.

## examples
DATA loader plus `SYS` (loads 12 bytes at `$C000`, then calls; the ML clears the border and background colors to black):

```
10 FOR I=0 TO 11 : READ B : POKE 49152+I, B : NEXT
20 SYS 49152
30 DATA 169,0,141,32,208,141,33,208,96,0,0,0
```

`USR` with argument (sets vector `$0311-$0312` to `$C000` = `49152`, then calls with `3.14` in the FAC):

```
10 POKE 785,0 : POKE 786,192
20 PRINT USR(3.14)
```

Auto-start BASIC stub (the canonical `SYS 2061` one-liner stored in tokenized form at `$0801`; ML body lands at `$080D`):

```
10 SYS 2061
```

## links
- BASIC keywords: [keywords.md](keywords.md)
- BASIC functions: [functions.md](functions.md)
- BASIC variables: [variables.md](variables.md)
- BASIC vectors and workspace: [vectors.md](vectors.md)
- BASIC examples: [examples.md](examples.md)
- Memory map: [../memory/map.md](../memory/map.md)
- Zero page: [../memory/zero-page.md](../memory/zero-page.md)
- Memory symbols: [../memory/symbols.md](../memory/symbols.md)
- 6502 CPU index: [../cpu/6502/INDEX.md](../cpu/6502/INDEX.md)
- Program entrypoints task (planned): `../tasks/program-entrypoints.md`
- Bank switch task: [../tasks/bank-switch-rom-ram.md](../tasks/bank-switch-rom-ram.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md) — C64 Programmer's Reference Guide (Commodore Business Machines, 1982) for `SYS`/`USR`/`PEEK`/`POKE`/`DATA` semantics; mist64/c64ref `src/c64disasm` for BASIC ROM routine routing.
- BASIC vectors: [vectors.md](vectors.md)
- memory map: [../memory/map.md](../memory/map.md)
- BASIC index: [INDEX.md](INDEX.md)
