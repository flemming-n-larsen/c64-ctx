---
type: reference
domain: tasks
source: codebase64.net
granularity: recipe
summary: "Decode variable-length bitfields from a byte stream with a sentinel shifter."
keywords: [bitstream, getbit, sentinel shifter, Huffman, bit reader]
---

## facts
- A shifter ZP byte holds pending bits with a sentinel `1` bit marking how many remain: `[data bits][1][0…]`.
- Initialization: set shifter = `$80` (no data bits pending; sentinel at MSB).
- `getbit` extracts one bit into carry; `getfield` extracts an N-bit field into A.
- Field width is encoded in the initial accumulator value: bit position of the `1` determines how many bits to collect.
- When the sentinel exits the shifter (BEQ fires), a new byte is fetched from the input buffer.
- Input buffer pointer is self-modified in place (mod_source+1 / mod_source+2).

## lookup

### Field width encoding (initial A value)
| Bits wanted | Initial A | Result location |
|---|---|---|
| 1 | `%10000000` | carry flag |
| 2 | `%01000000` | bits 1–0 of A |
| 3 | `%00100000` | bits 2–0 of A |
| 4 | `%00010000` | bits 3–0 of A |
| 5 | `%00001000` | bits 4–0 of A |
| 8 | `%00000001` | A (full byte) |

## sequence

### Core bit/field extractor
```asm
shifter = $FB            ; ZP: current pending bits + sentinel

getbit
    lda #%10000000       ; request 1 bit
getfield
    clc
    jmp field_loop

getbyte
mod_source
    ldx buffer           ; self-modifying: low byte at mod_source+1, high at mod_source+2
    inc mod_source+1
    bne no_new_page
    inc mod_source+2
no_new_page
    stx shifter          ; load new byte; sentinel must be set separately

field_loop
    rol shifter          ; shift one data bit into carry
    beq getbyte          ; sentinel exited → fetch next byte
    rol                  ; shift carry into A
    bcc field_loop       ; sentinel not yet in carry → keep collecting
    rts                  ; sentinel in carry → A holds the field
```

### Decision-tree decoder (variable-length codes)
```asm
decode
    lda #%10000000
    clc
    jmp decode_loop

decode_loop
    rol shifter
    beq getbyte_d        ; (inline getbyte for this variant)
    rol
    bcc decode_loop
    bmi done             ; MSB set → return node
    tay
    adc fields,y         ; branch node: get next field spec
    bne decode_loop
done
    adc offsets,y
    rts

; fields table: one byte per node encoding next field width + continuation
; offsets table: base offset added to extracted bits for return nodes
```

## constraints
- Buffer pointer self-modification requires the routine to be in RAM.
- `shifter` must be in zero page for the `ROL shifter` addressing.
- Caller is responsible for initializing `shifter = $80` and `mod_source+1`/`+2` before first call.
- `getfield` result in A is right-justified (bits at low end); unused high bits are 0.
- The sentinel scheme limits field width to 7 bits per call (initial A must have at least one `0` below the `1`).

## links

- dispatch techniques (common consumer of decoded values): [dispatch.md](dispatch.md)
- algorithms/compression: [../algorithms/INDEX.md](../algorithms/INDEX.md)
- advanced optimization (self-modifying code patterns): [../optimization/advanced.md](../optimization/advanced.md)

## sources

- https://codebase64.net/doku.php?id=base:decoding_bitstreams — CC BY-NC-SA 4.0
