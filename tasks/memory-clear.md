---
type: reference
domain: tasks
source: codebase64.net
granularity: recipe
summary: "Clear or fill a memory region, from three stores up to optimized index loops."
keywords: [memory clear, fill memory, zero fill, clear screen]
---

## facts
- Clearing 1–3 locations: use explicit `LDA #0 / STA addr` — no loop overhead needed.
- Clearing up to 256 bytes: use a ZP indirect indexed loop with X or Y as counter.
- `TOPNT` (2-byte ZP pointer) holds the start address; set before calling.
- Optimized variant (Pointier) uses only Y register, eliminating the X counter.

## sequence

### Single address
```asm
    LDA #$00
    STA target
```

### Index register loop — up to 256 bytes
```asm
TOPNT = $FB             ; ZP word: base address

CLRMEM
    LDA #$00
    TAY                 ; Y = index = 0
CLRM1
    STA (TOPNT),Y
    INY
    DEX                 ; X was pre-loaded with count
    BNE CLRM1
    RTS
```
Setup: store target address in `TOPNT`/`TOPNT+1`; load X with byte count (1–256, where 0 = 256).

### Optimized variant (Y only, no X counter)
```asm
CLRMEM
    LDA #$00
CLRM1
    DEY                 ; pre-decrement; Y was pre-loaded with count
    STA (TOPNT),Y
    BNE CLRM1
    RTS
```
Setup: load Y with count before `JSR CLRMEM`. Starts from `TOPNT + count − 1` down to `TOPNT + 0`.

## constraints
- Both loop variants clear at most 256 bytes per call; chain calls for larger areas.
- The optimized variant clears in reverse order (high index to 0); safe for initialization, not for order-dependent data.
- Routine clobbers A and the counter register (X or Y).

## links

- memory move: [memory-move.md](memory-move.md)
- sizecoding fill via KERNAL: [../optimization/sizecoding.md](../optimization/sizecoding.md)

## sources

- https://codebase64.net/doku.php?id=base:clearing_a_section_of_memory — CC BY-NC-SA 4.0
- *6502 Software Gourmet Guide & Cookbook* (cited by source)
