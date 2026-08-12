---
type: reference
domain: tasks
source: codebase64.net
granularity: recipe
summary: "A decimal digit counter with carry propagation and on-screen display."
keywords: [score counter, digit table, carry propagation, decimal display]
---

## facts
- Decimal digits stored as 0–9 values in a table; convert to PETSCII by adding `$30` for screen display.
- Carry propagates right-to-left: digit at highest index is least significant.
- Configurable digit count via `numdigits` constant; table must be 256-byte aligned.
- Screen output writes directly to screen RAM at `$0400`; adjust for other screen locations.

## sequence

### 6-digit decimal counter
```asm
numdigits = 6

    * = $C000

    ldx #0
    txa
-   sta tellertabel,x   ; zero out digit table
    inx
    cpx #numdigits
    bne -

loop
    ldx #0
-   lda tellertabel+1,x
    clc
    adc #$30             ; convert 0–9 → PETSCII '0'–'9'
    sta $0400,x          ; write to screen top-left
    inx
    cpx #numdigits
    bne -

    jsr teller           ; increment counter
    jmp loop

teller
    ldx #numdigits
-   lda tellertabel,x
    cmp #9
    beq +                ; digit is 9: reset and carry
    inc tellertabel,x    ; not 9: increment and return
    rts
+   lda #0
    sta tellertabel,x    ; reset digit to 0
    dex
    bne -
    rts

    .align 256
tellertabel              ; 256 bytes reserved
```

## constraints
- `tellertabel` must be 256-byte aligned to avoid page-crossing penalties on indexed access.
- Digit count limited to 255 (X register wraps at 256).
- `teller` does not handle overflow past `numdigits` digits — the most-significant digit silently resets.
- PETSCII offset `$30` maps 0→`0`, 1→`1`, …, 9→`9`; applies only to character display, not score math.

## links

- print to screen: [print-to-screen.md](print-to-screen.md)
- PETSCII reference: [../charset/INDEX.md](../charset/INDEX.md)
- game loop integration: [game-loop.md](game-loop.md)

## sources

- https://codebase64.net/doku.php?id=base:making_a_counter — CC BY-NC-SA 4.0 (author: Scout/Silicon Ltd.)
