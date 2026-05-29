---
type: reference
domain: effects
granularity: atomic
---

## facts
- A software screen mode creates a custom display resolution by redefining how the VIC-II interprets character data, without using any undocumented VIC trick.
- The 16×16 char matrix places 8×8 pixel character blocks on a 16×16-pixel grid by designing character pairs so adjacent chars tile seamlessly.
- Each character still occupies one 8×8 block in the charset; the software grid layout uses character ordering so that the Y coordinate of a pixel maps directly to a byte offset within the character definition.
- Extension: a circular character arrangement (round 16×16 grid) utilizes edge characters more efficiently than a rectangular grid for rotation effects.

## 16×16 pixel matrix — how it works

The VIC-II renders 8×8 pixel characters; a 16×16 matrix is achieved by treating four adjacent screen cells as a single logical 16×16 "super-character":

```
screen cell  | charset char | pixel coverage
(col, row)   | index        |
(0,0)        | '@'  (0x00)  | pixels (0–7,  0–7)
(1,0)        | 'a'  (0x41)  | pixels (8–15, 0–7)
(0,1)        | ...         | pixels (0–7,  8–15)
(1,1)        | ...         | pixels (8–15, 8–15)
```

Character '@' covers Y bytes 0–7; character 'a' covers Y bytes 8–15 — Y coordinate = byte offset in the charset definition.

## pixel-plotting algorithm

```
; Input: X = horizontal coord (0–15), Y = vertical coord (0–15)
; Output: bit set at (X,Y) in charset RAM

; Step 1: find charset byte address
;   char_index = (X / 8) * 64 + (Y / 8) * 128  (approximate)
;   byte_in_char = Y mod 8

; Step 2: find bit position
;   bit_mask = bitmasks[X mod 8]   ; table: $80,$40,$20,$10,$08,$04,$02,$01

; Step 3: OR bit into charset RAM
;   charset_byte |= bit_mask
```

Key register usage: `$FB`/`$FC` = indirect pointer to charset base; X = horizontal coordinate; Y = vertical coordinate.

## memory layout

| item | detail |
|---|---|
| Each character | 8 bytes in charset |
| Charset location | Any 2 KB block in current VIC bank (set via `$D018` bits 3–1) |
| 16×16 matrix charset | 4 chars × 8 bytes = 32 bytes minimum; extend for larger grids |
| Screen RAM | Standard 40×25 grid; each 16×16 cell occupies 2×2 screen positions |

## constraints
- Charset must be in RAM (not ROM) to allow pixel writes.
- Charset must be within the same VIC bank as screen RAM; see [../concepts/memory-banking.md](../concepts/memory-banking.md).
- VIC-II `$D018` bits 3–1 must point to the custom charset location before display begins.
- The 16×16 matrix requires ca65 or equivalent assembler for structured data setup; any assembler supporting byte-data definitions works.
- For scroll extensions: a 16×16 matrix scroll builds on the same charset scheme, advancing the screen pointer each frame.

## links
- tasks: [../tasks/custom-charset.md](../tasks/custom-charset.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- graphics: [../graphics/screen-modes.md](../graphics/screen-modes.md)
- concepts: [../concepts/memory-banking.md](../concepts/memory-banking.md)
- display-modes: [fli.md](fli.md)

## sources
- codebase64.net: [16×16 Char Matrix](https://codebase64.net/doku.php?id=base:16x16_char_matrix) — CC BY-NC-SA 4.0
- codebase64.net: [16×16 Matrix Scroll](https://codebase64.net/doku.php?id=base:16x16_matrix_scroll) — CC BY-NC-SA 4.0
- codebase64.net: [Demo Programming — Software Screen Modes](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
