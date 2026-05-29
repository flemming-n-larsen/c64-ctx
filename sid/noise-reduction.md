---
type: reference
domain: sid
granularity: atomic
---

## facts
- Codebase64's noise-reduction note focuses on the SID external audio input (`AIN`) as a common path for picked-up system noise.
- Hardware modifications can reduce audible whine substantially, but the source explicitly warns that details may be inaccurate and unsafe if performed carelessly.
- Software can also reduce some noise by minimizing VIC-II display activity and by routing the external input through the SID filter path.

## hardware options
| method | idea | caveat |
|---|---|---|
| Ground `AIN` at the A/V connector | Tie video-port pin `5` (`AIN`) toward pin `2` (`GND`), often via about `100 Ohm` | Source warns that wrong grounding can damage hardware |
| Lift SID `AIN` pin | Remove SID pin `26` from the socket contact so `AIN` no longer picks up board noise | Physical modification risk; source notes some users still hear low-frequency noise |

## software options
- Blank the screen and use dark display colors to reduce display-related noise pickup.

```asm
LDA #$00
STA $D011
STA $D020
```

- Route the external input through the filter with no filter type selected so the unneeded `AIN` signal is effectively muted:

```asm
LDA #$08
STA $D417
```

## constraints
- Hardware mods are machine-level changes, not normal program logic; only recommend them when the user explicitly accepts hardware risk.
- `$D417 = $08` only suppresses the external input path; it does not remove oscillator noise or chip-revision differences.
- Software mitigation helps most in quiet passages and digi-heavy setups, but does not replace proper audio hardware cleanup.

## links
- SID registers: [registers.md](registers.md)
- waveforms: [waveforms.md](waveforms.md)
- digi samples: [digi-samples.md](digi-samples.md)
- SID index: [INDEX.md](INDEX.md)

## sources
- codebase64.net: [Reduce noise](https://codebase64.net/doku.php?id=base:reduce_noise) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
