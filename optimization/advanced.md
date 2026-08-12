---
type: reference
domain: optimization
source: codebase64.net
granularity: atomic
summary: "Advanced cycle savers: branch cost, illegal opcodes, carry reuse, page alignment."
keywords: [advanced optimization, cycle saving, page crossing, register conservation]
---

## facts
- Branch not-taken = 2 cycles; taken = 3 cycles; taken + page cross = 4 cycles.
- Place frequently-executed code in the not-taken branch path.
- Zero-page addressing saves 1 cycle and 1 byte vs. absolute on load/store.
- Counting down to zero eliminates a `CMP` instruction per iteration.
- The carry flag persists across many operations; track its state to avoid redundant `CLC`/`SEC`.
- `EOR`, `ORA`, `AND` do not affect carry; safe to use between carry-dependent operations.
- Page-crossing penalties apply to indexed reads (+1 cycle when index crosses a page boundary).
- Aligning hot loops and lookup tables to page boundaries avoids crossing penalties.
- The stack pointer can serve as a 4th index register at the cost of stack management overhead.

## lookup

### Addressing mode cycle savings
| Technique | Savings | Notes |
|---|---|---|
| Zero-page store/load | −1 cycle, −1 byte | vs. absolute 16-bit address |
| Count down to zero | −3 cycles/iter | Eliminates `CMP` + separate branch |
| Absolute indirect dispatch | −4 cycles | Avoids save/restore of X/Y |
| Encode index in address | varies | Use self-mod to avoid indexed penalty |
| Stack as 4th register | −2–3 cycles | Free one index register; costs SP management |

### Stable illegal opcodes useful for optimization
| Opcode | Operation | Advantage |
|---|---|---|
| `LAX addr` | `A = X = M[addr]` | Load same value into A and X in one instruction (saves TAX) |
| `SAX addr` | `M[addr] = A & X` | AND-then-store without separate AND + store |
| `SBX #imm` | `X = (A & X) − imm` | Masked subtract, ignores carry in; carry out set |
| `DCP addr` | `M[addr]−−; CMP M[addr]` | Decrement and compare in one instruction |
| `ISC addr` | `M[addr]++; SBC M[addr]` | Increment and subtract in one instruction |
| `ASR #imm` | `A = (A & imm) >> 1` | AND + LSR in one; carry = bit 0 before shift |
| `ARR #imm` | `A = (A & imm) ROR` | AND + ROR; bit 7 = old carry, bit 6 = new carry |

## sequence

### Arithmetic branch optimization
```asm
; Inefficient: branch over expensive block (8 cycles typical)
    bcs skip
    expensive_block   ; runs rarely
    jmp done
skip:
done:

; Better: expensive block in taken path (frequent path avoids jump)
    bcc expensive_block
done:
    jmp end
expensive_block:
end:
```

### Count down to zero
```asm
; Old: CMP each iteration (+3 cycles)
    ldy #$18
loop
    sta $1000,y
    dey
    cpy #$10
    bne loop

; New: pre-calculate delta, count to zero
    ldy #$08        ; $18 - $10 = 8 iterations
loop
    sta $1017,y     ; adjust base address accordingly
    dey
    bne loop
```

### Bit counter (count to 8 via shift)
```asm
    lda #$80
    sta bitcnt
loop
    ; ... process one bit ...
    lsr bitcnt
    bcc loop       ; loops 8 times; after 8th shift, carry set
    ror bitcnt     ; restore $80 for next round
```

### LAX: load A and X simultaneously
```asm
    lax $1000,y    ; A = X = M[$1000+Y]
    eor #$80       ; modify A
    sta output
    txa            ; retrieve original value in X
```

### SAX: AND A with X, store result
```asm
    ldx #$f0       ; high nibble mask
    lda value
    sax result     ; M[result] = A & X; single instruction
```

### Page alignment for lookup tables
```asm
; Force table to page boundary (ACME syntax)
    !align 255, 0
table
    !byte $00, $01, ...   ; no page-cross penalty on indexed reads
```

### Carry reuse across operations
```asm
; Carry clear from prior CMP result — no CLC needed before ADC
    cmp threshold
    bcs high_path
    adc delta      ; carry already clear from CMP
```

## constraints
- `SBX` always ignores carry on input; do not use it where carry state matters.
- `LAX`, `SAX`, `DCP`, `ISC`, `ASR`, `ARR` are NMOS-only; behavior undefined on CMOS 65C02.
- `ARR` carry behavior differs from `ROR`: bit 6 of result sets carry, bit 5 sets overflow.
- Loop must not cross a page boundary or BNE/BCC incurs an extra cycle.
- Stack pointer reuse requires careful bookkeeping; any interrupt must not corrupt the data region.

## links
- illegal opcode stability reference: [../cpu/6502/illegal-opcodes.md](../cpu/6502/illegal-opcodes.md)
- loop unrolling detail: [loop-unrolling.md](loop-unrolling.md)
- general speed overview: [speed.md](speed.md)

## sources
- https://codebase64.net/doku.php?id=base:advanced_optimizing — CC BY-NC-SA 4.0 (author: Bitbreaker/Performers^Nuance)
- [../sources/INDEX.md](../sources/INDEX.md)
