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

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [registers.md](registers.md) | used | Complete SID register map: addresses, bits, ATDCY rate table |
| [waveforms.md](waveforms.md) | used | Triangle/noise behavior and waveform-selection caveats |
| [play-note.md](play-note.md) | used | 7-step SID note recipe |
| [frequency-calculation.md](frequency-calculation.md) | used | Formulas and machine constants for generating SID tables |
| [frequency-table.md](frequency-table.md) | used | PAL A440 note-to-register table, 8 octaves |
| [ntsc-frequency-table.md](ntsc-frequency-table.md) | used | NTSC A440 note-to-register table and VIC caveat |
| [model-detect.md](model-detect.md) | used | OSC3-based 6581/8580 runtime detection |
| [digi-samples.md](digi-samples.md) | used | 4-bit CIA-timer digi playback via $D418 |
| [filter-sweep.md](filter-sweep.md) | used | 11-bit cutoff sweep; filter mode selection |
| [noise-reduction.md](noise-reduction.md) | used | External-input noise mitigation options |
| [../music/INDEX.md](../music/INDEX.md) | routed | Music-player, scheduling, and tracker-facing topics moved to `/music` |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | codebase64.net upstream route |

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
