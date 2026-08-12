---
type: index
domain: sid
source: codebase64.net
---

## routes
| need | read | notes |
|---|---|---|
| SID register reference (all 29 registers) | [registers.md](registers.md) | Addresses, bit fields, CR breakdown, ATDCY rates |
| Waveform behavior and caveats | [waveforms.md](waveforms.md) | Triangle/noise behavior, pulse-width limits, combined-waveform cautions |
| Play a SID note (sequence) | [play-note.md](play-note.md) | Volume, freq, PW, ATDCY, SUREL, GATE on/off |
| Calculate your own SID frequency values | [frequency-calculation.md](frequency-calculation.md) | Equal-temperament formula plus machine clock constants |
| Note frequency register values (PAL A440) | [frequency-table.md](frequency-table.md) | 96 notes × 8 octaves; 16-bit hex values |
| Note frequency register values (NTSC A440) | [ntsc-frequency-table.md](ntsc-frequency-table.md) | Common 6567R8 NTSC table with R56A caveat |
| Detect SID chip revision at runtime | [model-detect.md](model-detect.md) | OSC3 readback distinguishes 6581 from 8580 |
| Play digitized samples (digi) | [digi-samples.md](digi-samples.md) | $D418 volume-register 4-bit PCM; 6581 only |
| Filter sweep | [filter-sweep.md](filter-sweep.md) | 11-bit cutoff sweep; LP/BP/HP mode selection |
| Reduce external-input noise | [noise-reduction.md](noise-reduction.md) | Hardware and software mitigation routes for `AIN` noise |
| Player-level music workflows | [../music/INDEX.md](../music/INDEX.md) | IRQ playback, music patterns, hard restart, and tune integration |

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| Play 4-bit PCM by hammering the master volume register; a 6581 side effect. | [digi-samples.md](digi-samples.md) | digi samples, PCM playback, sample player, volume trick, 8-bit PWM |
| Sweep the 11-bit filter cutoff and choose low, band or high pass. | [filter-sweep.md](filter-sweep.md) | filter sweep, cutoff, resonance, low pass, band pass |
| Convert a note to a SID frequency register value using equal temperament. | [frequency-calculation.md](frequency-calculation.md) | frequency calculation, equal temperament, pitch formula, clock constants |
| PAL A440 note-to-register values for 96 notes across eight octaves. | [frequency-table.md](frequency-table.md) | frequency table, PAL notes, note values, A440 |
| Tell a 6581 from an 8580 at runtime using oscillator 3 readback. | [model-detect.md](model-detect.md) | SID detection, 6581, 8580, chip revision, OSC3 readback |
| Hardware and software mitigations for noise picked up on the SID audio input. | [noise-reduction.md](noise-reduction.md) | noise reduction, audio input, AIN, hum, interference |
| NTSC A440 note-to-register values, calibrated for the common 6567R8. | [ntsc-frequency-table.md](ntsc-frequency-table.md) | NTSC frequency table, NTSC notes, 6567R8, A440 |
| Make a single note sound: volume, frequency, pulse width, envelope, gate. | [play-note.md](play-note.md) | play note, gate, ADSR, envelope, pulse width |
| All 29 SID registers with bit fields, control-register breakdown and envelope rates. | [registers.md](registers.md) | SID registers, 6581, 8580, control register, ADSR rates |
| The four SID waveforms, their quirks, and the combined-waveform cautions. | [waveforms.md](waveforms.md) | waveforms, triangle, sawtooth, pulse, noise, ring modulation |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/INDEX.md](../io/INDEX.md) | SID lives at `$D400-$D7FF`; banking at `$D000` applies |
| Memory | [../memory/io-area.md](../memory/io-area.md) | `$D000-$DFFF` window and banking context |
| Music | [../music/INDEX.md](../music/INDEX.md) | Player/update-loop topics built on top of SID |
| Colors | [../colors/INDEX.md](../colors/INDEX.md) | Screen blanking/dark display choices affect noise-mitigation recipes |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Prerequisite recipes: raster interrupt setup |
| Effects | [../effects/INDEX.md](../effects/INDEX.md) | Other demo/game effects (border, sprites, plasma, etc.) |
| IRQ | [../irq/INDEX.md](../irq/INDEX.md) | IRQ/NMI timing and raster/timer setup for music players |
| BASIC | [../basic/graphics-sound.md](../basic/graphics-sound.md) | POKE-based SID access from BASIC |
