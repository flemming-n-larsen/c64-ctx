---
type: index
domain: sid
source: codebase64
---

## routes
| need | read | notes |
|---|---|---|
| SID register reference (all 29 registers) | [registers.md](registers.md) | Addresses, bit fields, CR breakdown, ATDCY rates |
| Play a SID note (sequence) | [play-note.md](play-note.md) | Volume, freq, PW, ATDCY, SUREL, GATE on/off |
| Note frequency register values (PAL A440) | [frequency-table.md](frequency-table.md) | 96 notes × 8 octaves; 16-bit hex values |
| Clean ADSR envelope retrigger | [hard-restart.md](hard-restart.md) | 2-frame gate-off + zero ADSR before re-gating |
| Detect SID chip revision at runtime | [model-detect.md](model-detect.md) | OSC3 readback distinguishes 6581 from 8580 |
| Play digitized samples (digi) | [digi-samples.md](digi-samples.md) | $D418 volume-register 4-bit PCM; 6581 only |
| IRQ-driven SID music player | [irq-music-player.md](irq-music-player.md) | Raster IRQ wrapper for frame-rate music playback |
| Arpeggio, vibrato, portamento | [music-patterns.md](music-patterns.md) | Per-frame frequency modulation in IRQ handler |
| Filter sweep | [filter-sweep.md](filter-sweep.md) | 11-bit cutoff sweep; LP/BP/HP mode selection |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [registers.md](registers.md) | used | Complete SID register map: addresses, bits, ATDCY rate table |
| [play-note.md](play-note.md) | used | 7-step SID note recipe |
| [frequency-table.md](frequency-table.md) | used | PAL A440 note-to-register table, 8 octaves |
| [hard-restart.md](hard-restart.md) | used | ADSR hard-restart 2-frame technique |
| [model-detect.md](model-detect.md) | used | OSC3-based 6581/8580 runtime detection |
| [digi-samples.md](digi-samples.md) | used | 4-bit CIA-timer digi playback via $D418 |
| [irq-music-player.md](irq-music-player.md) | used | IRQ SID player pattern |
| [music-patterns.md](music-patterns.md) | used | Arpeggio, vibrato, portamento per-frame modulation |
| [filter-sweep.md](filter-sweep.md) | used | 11-bit cutoff sweep; filter mode selection |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | codebase64.net upstream route |

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/INDEX.md](../io/INDEX.md) | SID lives at `$D400-$D7FF`; banking at `$D000` applies |
| Memory | [../memory/io-area.md](../memory/io-area.md) | `$D000-$DFFF` window and banking context |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Prerequisite recipes: raster interrupt setup |
| Effects | [../effects/INDEX.md](../effects/INDEX.md) | Other demo/game effects (border, sprites, plasma, etc.) |
| Concepts | [../concepts/interrupts.md](../concepts/interrupts.md) | IRQ/NMI timing for music players |
| BASIC | [../basic/graphics-sound.md](../basic/graphics-sound.md) | POKE-based SID access from BASIC |
