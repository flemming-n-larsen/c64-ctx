---
type: reference
domain: optimization
source: codebase64.net
granularity: atomic
summary: "When unrolling a loop pays for itself, and when it does not."
keywords: [loop unrolling, unrolled loop, loop overhead, size vs speed]
---

## facts
- Unrolling a loop eliminates `INX`/`DEX` + compare + branch overhead (typically 6 cycles/iteration).
- Self-modifying code can make a tight loop faster than full unrolling with fewer bytes.
- Storing values directly into instruction operands (immediate fields) via self-mod costs 4 cycles once, not per iteration.
- Illegal opcode `SBX` transfers A into X then subtracts: `X = (A & X) - imm`; useful in line algorithms.
- Copying optimized loop code to zero page reduces each instruction access by 1 cycle.

## lookup

### Cycle comparison — line algorithm loop variants
| Implementation | Cycles | Notes |
|---|---|---|
| Standard unrolled | 25 | Basic inline repetition |
| Self-modifying loop | 24 | Immediate values patched into loop body |
| Self-modifying + SBX | 22 | Illegal opcode SBX replaces TAX+SBC |

## sequence

### Self-modifying loop pattern
```asm
back
    tax
pix lda #$00          ; operand patched before call
dst1 ora $2000,y
dst2 sta $2000,y
    dey
    bmi out
    txa
dx  sbx #$00          ; SBX: X = (A & X) - imm; operand patched
    bcs back
out rts
```
Patch `pix+1`, `dst1+1`/`dst1+2`, `dst2+1`/`dst2+2`, `dx+1` before use.

### Optimization sequence for tight loops
1. Optimize loop structure — minimize instructions inside the loop body.
2. Use self-modifying code to embed per-call values as immediate operands.
3. Explore illegal opcodes (`SBX`, `LAX`, `SAX`) to combine operations.
4. Copy the loop to zero page for 1-cycle-per-instruction savings.
5. Only fully unroll if the above still falls short of cycle budget.

## constraints
- Self-modified instructions cannot reside in ROM.
- `SBX` ignores carry input; do not rely on carry state entering the instruction.
- Full unrolling trades code size for speed — profile memory impact before unrolling large loops.
- Copying loop to zero page requires the loop fit within the available zero-page window.

## links
- general speed optimization: [speed.md](speed.md)
- advanced tricks including SBX and other illegal opcodes: [advanced.md](advanced.md)
- illegal opcode reference: [../cpu/6502/illegal-opcodes.md](../cpu/6502/illegal-opcodes.md)

## sources
- https://codebase64.net/doku.php?id=base:loops_vs_unrolled — CC BY-NC-SA 4.0
- [../sources/INDEX.md](../sources/INDEX.md)
