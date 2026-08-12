---
type: reference
domain: vic
granularity: atomic
summary: "NTSC and PAL VIC-II revisions: raster lines, cycles, frame rate, palette differences."
keywords: [chip variants, NTSC vs PAL, 6567, 6569, 8565, revision]
---

## facts
- The VIC-II family spans NTSC and PAL variants across two chip generations (6566/6567/6569/6572/6573 and the later 8562/8565/8566).
- NTSC chips run at ~1.0227 MHz CPU clock (dot clock ~8.18 MHz); PAL chips run at ~0.9852 MHz (dot clock ~7.88 MHz).
- The variant installed determines total raster lines, cycles per line, frames per second, and the safe raster range for effects.
- Palette color values differ slightly between the first-generation 6567/6569 and the revised 8562/8565 due to internal DAC changes.

## lookup
| chip | standard | total lines | cycles/line | fps (approx) | C64 model | notes |
|---|---|---:|---:|---:|---|---|
| 6566 | NTSC-M | 261 | 64 | ~60.0 | VIC-20 only | Not used in C64; listed for completeness. |
| 6567R56A | NTSC-M | 262 | 64 | ~60.0 | Early C64 (pre-1982) | Lines 0–7 have 65 cycles each (one extra cycle per line). |
| 6567R8 | NTSC-M | 263 | 65 | ~59.8 | C64 (main NTSC run) | Most common NTSC chip. |
| 6569 | PAL-B | 312 | 63 | ~50.1 | C64 (European) | Most common PAL chip; used across Europe, Australia. |
| 6572 | PAL-N | 312 | 65 | ~50.1 | C64 (South America) | Argentina/Uruguay; PAL-N encoding, different chroma. |
| 6573 | PAL-M | 263 | 65 | ~59.8 | C64 (Brazil, rare) | PAL-M encoding; NTSC-like line count. |
| 8562 | NTSC-M | 263 | 65 | ~59.8 | C64C (NTSC) | Revised NTSC chip; DAC changes affect palette. |
| 8565 | PAL-B | 312 | 63 | ~50.1 | C64C (European) | Revised PAL chip; same timing as 6569, revised DAC. |
| 8566 | PAL-M | 263 | 65 | ~59.8 | C64C (Brazil) | C64C-era PAL-M replacement. |

## constraints
- Timing-sensitive code MUST handle the NTSC/PAL split: PAL provides ~19,656 cycles/frame vs NTSC's ~17,095 (6567R8).
- Raster effects or music players that target lines ≥ 263 are PAL-only; they will never fire on NTSC.
- Code relying on a fixed cycles-per-line count MUST distinguish 6567R56A (64 cyc/line, lines 0–7 = 65) from 6567R8 (65 cyc/line uniform).
- Palette values stored as fixed constants MAY produce visually different output on 8562/8565 vs 6567/6569 due to DAC revision; treat color output as approximate unless the chip is detected.
- Chip detection at runtime is possible by reading `$D012` at a known stable point and comparing raster-line counts — see [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md) for cycle geometry.

## links
- VIC-II register table: [../io/vic-ii.md](../io/vic-ii.md)
- VIC hub: [INDEX.md](INDEX.md)
- raster geometry and bad lines: [timing.md](timing.md)
- raster interrupt setup: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- music player PAL/NTSC concerns: [../music/INDEX.md](../music/INDEX.md)

## sources
- local VIC hub: [INDEX.md](INDEX.md)
- VIC-II register reference: [../io/vic-ii.md](../io/vic-ii.md)
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
