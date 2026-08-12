---
type: reference
domain: optimization
source: codebase64.net
granularity: atomic
summary: "Generate unrolled code at runtime, and when a generator beats pre-generated code."
keywords: [speedcode, runtime code generation, code generator, self-modifying]
---

## facts
- Speedcode (loop unrolling) replaces a counted loop with repeated inline operations, eliminating loop overhead entirely.
- A looped `STA screen,x` over 10 iterations = 103 cycles; fully unrolled = 42 cycles.
- Pre-generating speedcode bloats disk files and load time; runtime generators are preferred for productions.
- A runtime generator produces the same speedcode from a compact template (~$140 bytes for a full 40×25 plasma).
- Generator loops should themselves be unrolled — the innermost loop (most iterations) yields the highest gain.
- After initialization, the generator code region can be overlaid with graphics data to reclaim memory.

## lookup

### Generation method comparison
| Method | Code size | Load time | Flexibility |
|---|---|---|---|
| Manual / BASIC-generated | Large (pre-generated) | Slow | Low |
| Macro assembler output | Large (pre-generated) | Slow | Medium |
| Runtime generator | Small (template only) | Fast | High |

### Performance example — 8×8 plasma, 40×25
| Approach | Bytes | Coverage |
|---|---|---|
| Looped | small | 20×20 chars |
| Pre-generated speedcode | ~5297 lines | 40×25 chars |
| Runtime-generated speedcode | ~$140 bytes template | 40×25 chars |

## sequence

### Looped vs. unrolled — basic example
```asm
; Looped (103 cycles for 10 stores)
    lda #0
    ldx #9
loop
    sta screen,x
    dex
    bpl loop

; Unrolled (42 cycles)
    lda #0
    sta screen+0
    sta screen+1
    sta screen+2
    sta screen+3
    sta screen+4
    sta screen+5
    sta screen+6
    sta screen+7
    sta screen+8
    sta screen+9
```

### Runtime generator algorithm (plasma effect)
```
For each Y position (0–24):
  Copy line-init chunk to destination buffer
  Update sine-table address in init chunk
  For each X position (0–39):
    Copy plasma chunk to destination buffer
    Update sine-table addresses in generated code
Patch RTS at end of generated block
```

### KickAssembler pseudo-command for generator readability
```asm
// :gc generates N code bytes at the current destination pointer
// Encapsulates the copy + pointer-advance bookkeeping
.macro gc(bytes) { ... }
```

### Dual-mode generator (generate + update)
- **Generate mode**: writes full instruction bytes to destination.
- **Update mode**: patches only operand bytes in already-generated code.
- Switching variants: use update mode when effect structure is identical but parameters change.

## constraints
- Generated code must reside in RAM (not ROM).
- Self-modified generator instructions cannot be in ROM either.
- Unrolling the generator's own inner loop (X-loop for plasma) gives the highest speedup since it runs 1000 times vs. 25 for the Y-loop.
- Keep a memory map at the top of source to track allocations, especially zero-page variables.

## links

- loop unrolling fundamentals: [loop-unrolling.md](loop-unrolling.md)
- general speed optimization: [speed.md](speed.md)
- advanced cycle tricks: [advanced.md](advanced.md)

## sources

- https://codebase64.net/doku.php?id=base:speedcode — CC BY-NC-SA 4.0
