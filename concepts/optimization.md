---
type: reference
domain: concepts
granularity: atomic
---

## facts
- Speedcoding (loop unrolling) eliminates loop overhead by expanding a repeated operation into sequential inline instructions, trading code size for execution speed.
- The C64 PAL frame budget is ~19 656 cycles; complex effects routinely consume 30–50% of this budget, making optimization mandatory.
- Zero-page addressing saves 1 cycle per instruction (`LDA $50` = 3 cycles vs. `LDA $0500` = 4 cycles); place all hot variables and pointers in `$00`–`$FF`.
- Table-driven lookups replace runtime calculation; sine, square, multiply, and bit-mask tables cost one `LDA abs,X` (4 cycles) vs. 20–100 cycles for equivalent computation.

## techniques

### Loop unrolling

Replacing a 10-iteration loop of 10 instructions (10×10 + loop overhead = ~130 cycles) with 10 sequential copies of the body costs ~100 cycles — a 23% saving. The payoff grows with iteration count and loop overhead fraction.

**Looped (103 cycles) vs. unrolled (42 cycles) — clearing 10 chars:**
```
; looped
ldx #9         ; 2
loop: sta $0400,x  ; 5
      dex          ; 2
      bpl loop     ; 3 (×10) = 103 cycles total

; unrolled
sta $0400  ; 4
sta $0401  ; 4  ...×10 = 40 cycles + 2 for final
```

Prioritize unrolling innermost loops (highest iteration count). Outer loops with few iterations offer minimal gain.

### Runtime speedcode generation

A small generator routine writes unrolled code into a RAM buffer at runtime. This avoids storing large unrolled blocks on disk and allows dynamic effect variants. Generation costs ~7 cycles per byte written; a 2 KB speedcode block generates in ~14 000 cycles (~0.7 frames).

### Self-modifying code

Modify instruction operands (address bytes or immediate values) directly in code rather than using index registers. Saves 1–2 cycles per iteration by replacing indexed addressing with absolute addressing.

```
ldx #$00      ; start of loop
lda source,x  ; or: modify the low byte of 'lda $xxxx' inline
sta dest,x
inx
cpx #40
bne loop
```

### Table-driven lookups

Pre-compute any value that repeats across frames into a table:
- Sine table (256 bytes, values 0–15 or −128–127)
- Square table (512 bytes: low/high halves for `x² = sqrtbl_hi[x]*256 + sqrtbl_lo[x]`)
- Multiply table (use `(x+y)² - (x-y)²` identity to multiply via square lookups)
- Bit-mask table (8 bytes: `$80`, `$40`, `$20`, `$10`, `$08`, `$04`, `$02`, `$01`)

### Register allocation

- A: data computation and comparisons
- X, Y: index registers; X for column/byte offset, Y for row/page offset
- Prefer X/Y offsets over pointer arithmetic where the range fits in 0–255

### Page alignment

Align tables and large arrays to 256-byte pages (`$xx00`). This ensures indexed accesses (`LDA table,X`) never cross a page boundary — a page-cross adds 1 cycle to indexed read instructions.

### Zero-page pointer tricks

Use zero-page indirect `(ptr),Y` to address arbitrary memory. Store the destination base address in `$FB`/`$FC` (or any ZP pair) and use Y as the offset. This costs 6 cycles per byte but avoids self-modifying code.

## cycle reference

| operation | cycles | notes |
|---|---|---|
| `LDA zp` | 3 | Zero-page absolute |
| `LDA abs` | 4 | Absolute |
| `LDA abs,X` (no page cross) | 4 | Table lookup |
| `LDA abs,X` (page cross) | 5 | Align tables to avoid |
| `LDA (zp),Y` | 6 | ZP indirect indexed |
| `STA abs` | 4 | Absolute store |
| `DEX` / `DEY` | 2 | |
| `BNE rel` (taken) | 3 | Not taken = 2 |
| Bad line cycle theft | 40 cycles/line | Wherever VIC fetches screen RAM |

## constraints
- Unrolled code grows quickly; a 40×25 unrolled loop is 1000 instructions × ~5 bytes = ~5 KB. Budget ROM space accordingly.
- Runtime generators require working RAM at the target address during generation; ensure no ROM or I/O is mapped there; see [memory-banking.md](memory-banking.md).
- Self-modifying code is invisible to the instruction cache — not a concern on the 6510, which has no cache.
- Speedcode generation pauses visible effects for ~0.3–1 frame; schedule it during a part transition or loading screen.

## links
- concepts: [interrupts.md](interrupts.md)
- concepts: [vic-bad-lines.md](vic-bad-lines.md)
- concepts: [memory-banking.md](memory-banking.md)
- concepts: [zero-page.md](zero-page.md)
- effects: [../effects/demo-intro.md](../effects/demo-intro.md)
- effects: [../effects/plasma.md](../effects/plasma.md)
- effects: [../effects/vectors.md](../effects/vectors.md)
- asm: [../asm/INDEX.md](../asm/INDEX.md)

## sources
- codebase64.net: [Speedcode](https://codebase64.net/doku.php?id=base:speedcode) — CC BY-NC-SA 4.0
- codebase64.net: [Speeding Up and Optimising Demo Routines](https://codebase64.net/doku.php?id=base:speeding_up_and_optimising_demo_routines) — CC BY-NC-SA 4.0
- codebase64.net: [Advanced Optimizing](https://codebase64.net/doku.php?id=base:advanced_optimizing) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
