---
type: reference
domain: optimization
source: codebase64.net
granularity: atomic
summary: "Reduce rastertime: opcode cycle costs, KERNAL avoidance, call overhead."
keywords: [speed optimization, rastertime, cycle counting, KERNAL avoidance]
---

## facts
- KERNAL routines are designed for business software, not real-time; avoid in raster loops.
- Screen clear via `JSR $E544` exceeds available cycles per frame at 50/60 Hz.
- Each `JSR`+`RTS` pair costs 12 cycles; minimize in speed-critical loops.
- Absolute addressing (4 cycles load/store) beats indexed when the penalty cycle matters.
- Loop overhead for `INX` + `CPX` + `BNE` = 6 cycles per iteration.

## lookup

### Opcode cycle reference
| Opcode | Cycles | Notes |
|---|---|---|
| `INX` / `INY` / `DEX` / `DEY` | 2 | Register only |
| `CPX` / `CPY` | 2–3 | 2 zero-page, 3 absolute |
| `BNE` / `BEQ` / `BCC` / `BCS` | 2–3 | +1 if taken; +1 again if page crossed |
| `LDA $00` (zero-page) | 3 | |
| `LDA $0000` (absolute) | 4 | |
| `LDA $0000,X` (absolute indexed) | 4–5 | +1 if page crossed |
| `STA $0000,X` | 5 | Always 5 (write doesn't save cycle) |
| `JSR` | 6 | |
| `RTS` | 6 | |

### IRQ setup: KERNAL on vs. off
| Aspect | KERNAL on | KERNAL off |
|---|---|---|
| IRQ vector | `$0314/$0315` | `$FFFE/$FFFF` |
| Register save | KERNAL does it | Must save A/X/Y manually |
| ROM range | `$E000-$FFFF` in use | Free for code |
| Acknowledge VIC IRQ | `INC $D019` | `LDA #$01 / STA $D019` |
| Exit handler | `JMP $EA7E` | `RTI` (restore A/X/Y first) |

## sequence

### Disable KERNAL ROM
```asm
LDA $01
AND #$FD
STA $01        ; $E000-$FFFF now open RAM
```

### IRQ handler (KERNAL disabled) — minimal skeleton
```asm
irq STA $02       ; Save A
    STX $03       ; Save X
    STY $04       ; Save Y
    ; ... your code here ...
    LDA #$01
    STA $D019     ; Acknowledge raster IRQ
    LDY $04
    LDX $03
    LDA $02
    RTI
```

### Loop vs. unrolled — 3×3 scroller example
```asm
; Looped: 1404 cycles
    ldx #$00
loop
    lda $0401,x
    sta $0400,x
    lda $0429,x
    sta $0428,x
    lda $0451,x
    sta $0450,x
    inx
    cpx #$27
    bne loop      ; 6 cycles overhead × 39 = 234 extra cycles

; Unrolled: 1170 cycles (saves 234)
    lda $0401
    sta $0400
    lda $0402
    sta $0401
    ; ... continued 39 times
```

## constraints
- Disabling KERNAL also disables `$FFFA-$FFFF` vectors; IRQ/NMI vectors must be in RAM before switching.
- `$EA7E` is the KERNAL IRQ exit; only valid when KERNAL is enabled.
- Absolute indexed `STA` always takes 5 cycles regardless of page crossing.

## links
- loop-unrolling detail: [loop-unrolling.md](loop-unrolling.md)
- runtime code generation: [speedcode.md](speedcode.md)
- advanced tricks: [advanced.md](advanced.md)
- raster interrupt setup: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- ROM/RAM banking: [../tasks/bank-switch-rom-ram.md](../tasks/bank-switch-rom-ram.md)

## sources
- https://codebase64.net/doku.php?id=base:speeding_up_and_optimising_demo_routines — CC BY-NC-SA 4.0
- [../sources/INDEX.md](../sources/INDEX.md)
