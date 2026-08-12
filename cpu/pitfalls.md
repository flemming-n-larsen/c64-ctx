---
type: reference
domain: cpu
source: codebase64.net
granularity: atomic
summary: "Silent 6502 coding mistakes: missing #, DOKE byte order, self-modifying label offsets."
keywords: [pitfalls, DOKE, self-modifying code, silent bug, immediate mode]
---

## facts
- Assemblers accept both `CMP 4` (address `$04`) and `CMP #4` (literal 4) without warning; omitting `#` is a silent logic error.
- The 6502 has no instruction cache; self-modifying code is valid and common.
- A label placed on the same line as a program counter assignment (`* = $1100`) resolves to the byte *before* the new PC, not at it.
- 16-bit stores ("DOKE") should use the accumulator for both bytes to avoid X/Y transposition bugs.

## lookup

### Addressing mode confusion
| Written | Assembler interprets as | Actual effect |
|---|---|---|
| `CMP 4` | Compare A with memory at `$04` | Tests zero-page byte, not literal 4 |
| `CMP #4` | Compare A with immediate `$04` | Correct |
| `LDA 5` | Load from address `$05` | Loads zero-page byte |
| `LDA #5` | Load immediate `$05` | Correct |

No assembler warning is generated for either form.

## sequence

### 16-bit store (DOKE) — safe pattern
```asm
    lda #<value
    sta address
    lda #>value
    sta address+1
```
Avoid using X and Y for the two bytes — easy to transpose. Use a macro:
```asm
; ACME macro
!macro doke .addr, .val {
    lda #<.val
    sta .addr
    lda #>.val
    sta .addr+1
}
```

### Self-modifying code — label offset pattern
```asm
loop
smod = * + 1             ; smod points to the operand byte, not the opcode
    sta $0400            ; opcode at smod-1; operand (low) at smod
    inc smod             ; advance destination address
    bne loop
    rts
```
The `= * + 1` offset skips the opcode byte to reach the address operand. Getting the offset wrong corrupts the opcode.

### Program counter vs. label — correct ordering
```asm
; WRONG: label resolves to byte before $1100
    * = $1000
    ; ... code ...
    rts
irq * = $1100            ; label 'irq' = address of RTS + 1, not $1100
    inc $D020

; CORRECT: set PC first, then define label
    * = $1100
irq                      ; label 'irq' = $1100
    inc $D020
```

## constraints
- Self-modified code must be in RAM; ROM writes are silently ignored on the C64.
- The `smod = * + 1` pattern is instruction-specific: a 2-byte instruction has a 1-byte operand at `+1`; a 3-byte instruction has a 2-byte operand at `+1` (low) and `+2` (high).
- Modifying the opcode byte itself (offset 0) changes the instruction type — intentional in some techniques, a bug otherwise.

## links
- self-modifying code in optimization: [../optimization/advanced.md](../optimization/advanced.md)
- illegal opcodes (another source of subtle behavior): [6502/illegal-opcodes.md](6502/illegal-opcodes.md)
- addressing modes reference: [6502/addressing-modes.md](6502/addressing-modes.md)

## sources
- https://codebase64.net/doku.php?id=base:common_pitfalls — CC BY-NC-SA 4.0
- [../sources/INDEX.md](../sources/INDEX.md)
