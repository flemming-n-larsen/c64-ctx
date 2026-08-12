---
type: reference
domain: math
granularity: atomic
summary: "Sine and cosine tables, 8-bit atan2, CORDIC, and distance approximation."
keywords: [sine table, cosine, atan2, CORDIC, distance approximation]
---

## facts
- The 6502 has no floating-point trigonometric instructions; sin/cos are always pre-computed into lookup tables.
- A 256-byte sine table maps angles 0–255 (full circle) to signed values −128..127 or unsigned 0..255.
- Quarter-wave symmetry reduces the table to 64 bytes with mirroring for the remaining quadrants.
- `atan2(y, x)` returns an 8-bit angle (0–255 = full circle) from the two signed deltas; CORDIC is a common algorithm.
- Distance approximation `≈ max(|dx|, |dy|) + min(|dx|, |dy|)/2` gives ~94% accuracy without a multiply.

## lookup
| function | table size | input | output | accuracy |
|---|---|---|---|---|
| sin (full table) | 256 bytes | 0–255 angle | signed 8-bit (−128..127) | exact for 256 steps |
| sin (quarter table) | 64 bytes | 0–255 angle (mirrored) | signed 8-bit | same, with 3 branches |
| cos | reuse sin table | angle + 64 | signed 8-bit | same (90° phase shift) |
| atan2 (8-bit lookup) | 256+ bytes | signed dx, dy | 0–255 angle | ±1 LSB |
| atan2 (CORDIC) | none | signed dx, dy | 0–255 angle | iterative, no table |
| distance approx | none | |dx|, |dy| | unsigned | ~94% of true distance |

Sine table generation (BASIC, at runtime):
```basic
10 FOR I=0 TO 255
20 POKE SINTAB+I, INT(127*SIN(I*2*π/256)+0.5) AND 255
30 NEXT I
```

## sequence
Sine table lookup with quarter-wave symmetry (angle 0–255 → signed result):
```
; angle in A (0..255, full circle)
; bit 7 = sign of result, bit 6 = mirror flag
    PHA
    AND #$3F         ; low 6 bits = index within quadrant (0..63)
    TAX
    PLA
    AND #$40         ; test bit 6 (mirror flag)
    BEQ no_mirror
    TXA
    EOR #$3F         ; mirror: index = 63 - index
    TAX
no_mirror:
    LDA sintab,X     ; unsigned quarter sine (0..127)
    PLA              ; restore original angle
    BPL positive     ; bit 7 = 0 → positive half
    ; negate: result = -result
    EOR #$FF
    CLC
    ADC #1
positive:
    RTS
```

Distance approximation (|dx| and |dy| in X and Y registers):
```
; Returns approx distance in A (≈ 94% accuracy)
    CPX 0,Y        ; compare |dx| vs |dy|
    BCS dx_larger
    ; |dy| >= |dx|: result = |dy| + |dx|/2
    TYA            ; A = |dy|
    STX tmp
    LSR tmp        ; tmp = |dx|/2
    CLC
    ADC tmp
    RTS
dx_larger:
    ; |dx| > |dy|: result = |dx| + |dy|/2
    TXA
    STY tmp
    LSR tmp
    CLC
    ADC tmp
    RTS
```

## constraints
- Sine table values at exactly 90° (index 64 in a 256-entry table) MUST be clamped to 127, not 128, to avoid signed overflow.
- CORDIC atan2 converges in ~8–12 iterations; cycle cost is proportional to precision requirements.
- Distance approximation overshoot is worst at 45°; exact distance requires sqrt of sum of squares.
- See [../effects/plasma.md](../effects/plasma.md) for a sine-sum color cycling usage example; see [../sid/frequency-table.md](../sid/frequency-table.md) for SID note frequency derivation (also uses sin).

## sources

- codebase64.net: [Generating sines with BASIC](https://codebase64.net/doku.php?id=base:generating_sines_with_basic) — CC BY-NC-SA 4.0
- codebase64.net: [Generating approximate sines in assembly](https://codebase64.net/doku.php?id=base:generating_approximate_sines_in_assembly) — CC BY-NC-SA 4.0
- codebase64.net: [8-bit atan2 8-bit angle](https://codebase64.net/doku.php?id=base:8bit_atan2_8-bit_angle) — CC BY-NC-SA 4.0
- codebase64.net: [8-bit atan2 using CORDIC](https://codebase64.net/doku.php?id=base:8bit_atan2_using_the_cordic_algorithm) — CC BY-NC-SA 4.0
- codebase64.net: [Approximation to distance](https://codebase64.net/doku.php?id=base:approximation_to_distance) — CC BY-NC-SA 4.0
- math: [sqrt.md](sqrt.md)
- math: [fixed-point.md](fixed-point.md)
- effects: [../effects/plasma.md](../effects/plasma.md)
- algorithms: [../algorithms/3d-math.md](../algorithms/3d-math.md)
