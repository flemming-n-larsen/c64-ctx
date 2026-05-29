---
type: reference
domain: game
granularity: atomic
---

## facts
- Three practical methods for 6502 score arithmetic: BCD decimal mode, hex mode with conversion, ASCII digit mode. codebase64.net scoring_points.
- BCD decimal mode: `SED` before `ADC`; the 6502 handles carry between digit pairs automatically; each byte holds 2 packed decimal digits. codebase64.net scoring_points.
- ASCII digit mode: each score digit is stored as a screen code (`$30`–`$39`); no conversion needed for display; overflow carried forward via a separate carry table. codebase64.net scoring_points.
- BCD caveat: if an IRQ fires while decimal mode is set, the handler executes with `D` flag active; any `ADC`/`SBC` inside the IRQ produces BCD results. codebase64.net scoring_points.
- A 6-digit decimal score requires 3 bytes in BCD (2 digits per byte). codebase64.net scoring_points.

## sequence
**BCD method (6 digits = 3 bytes):**
```asm
    sed             ; set decimal mode
    clc
    lda points      ; point value to add
    adc score+0     ; units + tens
    sta score+0
    lda score+1     ; hundreds + thousands
    adc #$00
    sta score+1
    lda score+2     ; ten-thousands + hundred-thousands
    adc #$00
    sta score+2
    cld             ; clear decimal mode
```

**Display (BCD → screen codes):**
1. Load score byte; extract high nibble: `lsr; lsr; lsr; lsr; ora #$30`.
2. Store to screen RAM digit position.
3. Extract low nibble: `and #$0f; ora #$30`.
4. Store to next screen RAM position.
5. Repeat for each score byte.

**ASCII digit method (6-digit, 6-byte score buffer):**
1. Zero carry table (6 bytes).
2. Loop digits 0–5: `score[i] + points[i] + carry[i]` → result.
3. Mask bits 0–3: `AND #$0F`.
4. If result ≥ 10: set `carry[i+1] = 1`; subtract 10.
5. `ORA #$30` for direct screen output.

## lookup
| method | bytes per digit | IRQ-safe | display conversion | best for |
|---|---|---|---|---|
| BCD decimal mode | 0.5 (2 per byte) | No — `CLD` required in IRQs | nibble-extract + OR $30 | compact code, 6-digit score |
| Hex mode | variable | Yes | hex→BCD→ASCII routine | score > 6 digits or math needed |
| ASCII digit | 1 byte per digit | Yes | none (already screen code) | simplest display, small score |

## constraints
- IRQ handlers MUST begin with `CLD` when BCD mode may be active, or interrupts MUST be disabled (`SEI`/`CLI`) around the `SED...CLD` block.
- Score buffer MUST be cleared (set to `$30` for ASCII mode, `$00` for BCD) at game start.
- BCD `ADC` MUST be preceded by `CLC` each update; stale carry from a previous operation will corrupt the result.

## links
- game: [hiscore.md](hiscore.md)
- tasks: [../tasks/counter.md](../tasks/counter.md)
- charset: [../charset/petscii.md](../charset/petscii.md)
- charset: [../charset/screen-codes.md](../charset/screen-codes.md)

## sources
- [https://codebase64.net/doku.php?id=base:scoring_points](https://codebase64.net/doku.php?id=base:scoring_points) — codebase64.net — CC BY-NC-SA 4.0
- [../sources/INDEX.md](../sources/INDEX.md)
