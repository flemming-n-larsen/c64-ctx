---
type: reference
domain: tasks
source: codebase64.net
granularity: recipe
summary: "Route a byte value to one of N handlers: jump table, stack dispatch, self-mod."
keywords: [dispatch, jump table, stack dispatch, handler table, indirect jump]
---

## facts
- Dispatch on a byte routes execution to one of N handlers based on a byte value (0–255).
- All techniques except stack dispatch use self-modifying code; they require RAM.
- Zero-page resident dispatch routines execute 1 cycle faster and occupy 1 byte less per instruction.
- Stack dispatch is the fastest (8–10 cycles) but limits stack use in handlers.

## lookup

### Dispatch method comparison
| Method | Cycles | Max entries | Constraint |
|---|---|---|---|
| General table (≤128) | 9 (8 ZP) | 128 | Table must be word-aligned |
| General table (>128) | 13–14 (12–13 ZP) | 256 | Split into two half-tables |
| Stack dispatch | 8–10 | 128 | Handlers cannot use stack without repositioning SP |
| Low-address dispatch | 7 (6 ZP) | 256 | All handlers on same page |
| High-address dispatch | 7 (6 ZP) | 256 | Each handler on separate page, same low byte |
| Relative branch dispatch | 7 (6 ZP) | ±127 bytes | Branch range limited |

## sequence

### General table dispatch — up to 128 entries
```asm
    sta dispatch+1       ; patch low byte of pointer
dispatch
    jmp (table)          ; indirect through table[value*2]

table
    .word handler0, handler1, handler2  ; ... up to 128 entries
```

### General table dispatch — more than 128 entries
```asm
    asl                  ; value * 2 → carry set if >= 128
    bcs high_half
    sta dispatch_lo+1
dispatch_lo
    jmp (table)
high_half
    sta dispatch_hi+1
dispatch_hi
    jmp (table + $0100)

table
    .word handler0, ..., handler127
    .word handler128, ..., handler255
```

### Stack dispatch
```asm
    tax
    txs                  ; S = handler index
    rts                  ; pull PC from $0100 + S+1
; Vector table at $0100: word per entry (address − 1)
```

### Low-address dispatch (all handlers on same page)
```asm
    sta dispatch+1       ; patch low byte of JMP
dispatch
    jmp $xx00            ; high byte fixed; low byte = value
; All handlers at $xx00 + value
```

### High-address dispatch (each handler on a separate page)
```asm
    sta dispatch+2       ; patch high byte of JMP
dispatch
    jmp $0000            ; low byte fixed; high byte = value
; handler_N at ($N_page_base + fixed_low_byte)
```

## constraints
- Self-modifying dispatch cannot reside in ROM.
- Stack dispatch: vector table entries must be `address − 1` (RTS increments PC after pull).
- Stack dispatch handlers must not push/pop without adjusting SP back; the stack "base" is the vector table.
- General table: value must be pre-scaled (×2) to index the word table; the self-mod approach handles this when value ≤ 127.

## links
- bitstream decoding (common dispatch consumer): [bitstream.md](bitstream.md)
- advanced optimization: [../optimization/advanced.md](../optimization/advanced.md)
- illegal opcodes (ASR, LAX useful in dispatch prep): [../cpu/6502/illegal-opcodes.md](../cpu/6502/illegal-opcodes.md)

## sources
- https://codebase64.net/doku.php?id=base:dispatch_on_a_byte — CC BY-NC-SA 4.0
- [../sources/INDEX.md](../sources/INDEX.md)
