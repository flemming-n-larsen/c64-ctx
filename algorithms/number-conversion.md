---
type: reference
domain: algorithms
granularity: atomic
summary: "Convert between hex, decimal and strings, plus sign extension and bit reversal."
keywords: [number conversion, hex to decimal, int to string, bit reversal]
---

## facts
- Hex→decimal conversion is non-trivial on 6502 because the CPU has no native decimal-to-ASCII path; BCD mode (`SED`) helps for binary→BCD.
- The most common need is converting a value in A/X to a printable decimal or hex string.
- Hexadecimal characters 0–9 map to PETSCII $30–$39; A–F map to $41–$46 (uppercase) or $61–$66 (lowercase).
- Bit reversal (LSB↔MSB) is done with a 256-byte reverse table or via 8 `ROL`/`ROR` shift pairs.
- Sign extension widening (8-bit signed → 16-bit) uses `BPL`/`DEX` — see [../math/add-sub.md](../math/add-sub.md).

## lookup
| conversion | direction | method | notes |
|---|---|---|---|
| 8-bit → 2-char hex string | binary → ASCII | mask + table or `AND`+`ORA`+adjust | 2 characters |
| 16-bit → 4-char hex string | binary → ASCII | 4 × nibble conversions | high byte first |
| 8-bit → 3-char decimal | binary → BCD | `SED` + double-dabble or subtract-tens | BCD mode |
| 16-bit → 5-char decimal | binary → BCD | extended subtract-tens | 0–65535 |
| 32-bit → 10-char decimal | binary → BCD | extended algorithm | 0–4294967295 |
| Hex string → 8-bit | ASCII → binary | subtract $30, adjust for A–F | |
| int16/uint16 → decimal string | binary → PETSCII | repeated subtraction + ASCII offset | |
| Bit reversal 8-bit | bitwise | 8 `ROL`/`ROR` pairs or 256-byte table | |
| Sign extension 8→16 | binary | see [../math/add-sub.md](../math/add-sub.md) | |

PETSCII digit offsets:
| char | PETSCII | screen code |
|---|---|---|
| `'0'` | $30 | $00 |
| `'9'` | $39 | $09 |
| `'A'` | $41 | $01 |
| `'F'` | $46 | $06 |

## sequence
8-bit value in A → 2 hex PETSCII characters (hi nibble then lo nibble):
```
    PHA
    LSR
    LSR
    LSR
    LSR           ; hi nibble in bits 3..0
    JSR nibble_to_hex
    STA hex_hi
    PLA
    AND #$0F      ; lo nibble
    JSR nibble_to_hex
    STA hex_lo
    RTS

nibble_to_hex:
    CMP #10
    BCC digit     ; 0–9: add $30
    ADC #6        ; A–F: skip $3A–$40 ($39+7=$40, but need $41, so add 6 more)
digit:
    ADC #$30
    RTS
```

8-bit binary → 3-digit decimal string (BCD mode):
```
    SED           ; decimal mode
    LDX #0        ; result BCD low
    LDY #0        ; result BCD high
    CLC
    ADC #0        ; re-add in BCD (trick: convert via double-dabble)
    CLD           ; exit decimal mode
    ; unpack BCD nibbles to ASCII
```

Bit reversal 8-bit (A → bit-reversed A), no table:
```
    LDX #8
    LDY #0
rev_loop:
    LSR          ; shift A right into carry
    ROL Y        ; rotate carry into Y from left
    DEX
    BNE rev_loop
    TYA          ; Y = reversed byte
```

## constraints
- `SED` (BCD mode) affects only `ADC`/`SBC`; `INC`/`DEC`/`ROL`/`ROR` are not BCD-aware. MUST `CLD` before returning to binary arithmetic.
- The nibble-to-hex routine relies on the `ADC` carrying correctly; do NOT use the version above in BCD mode.
- Hex-string-to-binary MUST handle both uppercase (A–F = $41–$46) and lowercase (a–f = $61–$66) input if parsing user strings.
- 32-bit decimal conversion requires 10 result bytes and may take 200–500 cycles; not suitable for per-frame conversion.

## sources

- codebase64.net: [Hexadecimal to decimal conversion](https://codebase64.net/doku.php?id=base:hexadecimal_to_decimal_conversion) — CC BY-NC-SA 4.0
- codebase64.net: [Decimal to hexadecimal conversion](https://codebase64.net/doku.php?id=base:decimal_to_hexadecimal_conversion) — CC BY-NC-SA 4.0
- codebase64.net: [8-bit to hexadecimal conversion](https://codebase64.net/doku.php?id=base:8_bit_to_hexadecimal_conversion) — CC BY-NC-SA 4.0
- codebase64.net: [32-bit hexadecimal to decimal conversion](https://codebase64.net/doku.php?id=base:32_bit_hexadecimal_to_decimal_conversion) — CC BY-NC-SA 4.0
- codebase64.net: [int16 and uint16 conversion to string](https://codebase64.net/doku.php?id=base:int16_and_uint16_conversion_to_string) — CC BY-NC-SA 4.0
- codebase64.net: [Sign extension](https://codebase64.net/doku.php?id=base:sign_extension) — CC BY-NC-SA 4.0
- codebase64.net: [Reversing bits in a byte](https://codebase64.net/doku.php?id=base:reversing_bits_in_a_byte) — CC BY-NC-SA 4.0
- math: [../math/fixed-point.md](../math/fixed-point.md)
- math: [../math/add-sub.md](../math/add-sub.md)
- charset: [../charset/INDEX.md](../charset/INDEX.md)
