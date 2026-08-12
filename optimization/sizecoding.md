---
type: reference
domain: optimization
source: codebase64.net
granularity: atomic
summary: "Save bytes by reusing KERNAL routines for their side effects."
keywords: [sizecoding, byte saving, small binary, KERNAL side effects]
---

## facts
- Many KERNAL routines have useful side effects (clearing registers, copying pointers) that can replace explicit code.
- Zero-page pointer pairs `$d1/$d2` (screen) and `$f3/$f4` (color RAM) are set by `JSR $E9F0`.
- Multi-page copy via `JSR $A3E8` uses ZP pointers `$5a/$5b` (source) and `$58/$59` (destination).
- Screen line pointer table lives at `$ECF0` (25 entries).
- Sprite data alignment to 64-byte boundaries can be forced with a small `BVC` trick to avoid wasted filler.

## lookup

### Register/memory clear via KERNAL
| Effect | Routine | Notes |
|---|---|---|
| Clear A, zero `$99` | `JSR $F345` | |
| Clear A, zero `$D3` | `JSR $E6FC` | |
| Clear X, zero `$13` | `JSR $ABBA` | |
| Clear X, zero `$0D` + TAY | `JSR $B785` | |
| Clear Y, zero `$02A1` | `JSR $F498` | |
| Clear ZP `$61`, `$66` | `JSR $B8F7` | Saves 1+ byte vs. two explicit STAs |
| Clear ZP `$10`, `$3E` | `JSR $A687` | |
| Clear ZP `$62`–`$65` | `LAX #0 / TAY / JSR $AF87` | 4 locations; saves 2+ bytes |

### 16-bit add via KERNAL
| Operands | Routine |
|---|---|
| A + `$7A/$7B` | `JSR $A8FC` |
| A + `$35/$36` | `JSR $B699` |
| A + `$22/$23`; X ← `$23` | `JSR $B5F8` |
| A + `$33/$34`; X ← `$22`; Y ← `$23` | `JSR $B6CB` |

### Screen / color pointer routines
| Purpose | Routine | Result |
|---|---|---|
| Get pointers for row X | `JSR $E9F0` | `$D1/$D2` = screen ptr, row in X |
| Clear row (ptr in `$D1/$D2`) | `LDY #39 / JSR $EA0A` | |
| Copy screen ptr → color ptr | `JSR $EA24` | `$F3/$F4` = color ptr |
| Copy line | `JSR $E9CF` | Copies with color update |

### Timing delays
| Duration | Routine |
|---|---|
| ~1 ms | `JSR $EEB3` |
| ~2 s | `JSR $FD68` |

## sequence

### Multi-page memory copy
```asm
    ldx #HOW_MANY_PAGES
    lda #<(Source+(HOW_MANY_PAGES-1)*256)
    sta $5a
    lda #>(Source+(HOW_MANY_PAGES-1)*256)
    sta $5b
    lda #<(Destination+(HOW_MANY_PAGES-1)*256)
    sta $58
    lda #>(Destination+(HOW_MANY_PAGES-1)*256)
    sta $59
    jsr $a3e8
```

### Align sprite data (64 bytes) without padding filler
```asm
    * = $ALIGNED_ADDRESS - 2
    bvc +           ; never taken, crosses to aligned address
Sprite
    !fill 63, 0     ; 63 bytes (sprite data)
+                   ; code continues here
```

### Scroll screen up (fastest, 24 lines via unrolled LDA/STA)
```asm
    jsr $e9c8       ; KERNAL scroll-up routine
```

## constraints
- All KERNAL routines require KERNAL ROM to be mapped in (`$01` bit 1 set).
- `$A3E8` copy uses `$58–$5B` ZP; preserve these if used for other purposes.
- `$E9F0` row pointer routine destroys A and Y; preserve if needed.
- Scroll-left / scroll-right routines require copying KERNAL to zero page and disabling ROM.

## sources

- https://codebase64.net/doku.php?id=base:sizecoding — CC BY-NC-SA 4.0
- ROM/RAM banking (disable/enable KERNAL): [../tasks/bank-switch-rom-ram.md](../tasks/bank-switch-rom-ram.md)
- speed optimization: [speed.md](speed.md)
- memory move task: [../tasks/memory-move.md](../tasks/memory-move.md)
