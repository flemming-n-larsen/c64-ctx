---
type: index
domain: music
source: codebase64
---

## routes
| need | read | notes |
|---|---|---|
| IRQ-driven music playback loop | [irq-music-player.md](irq-music-player.md) | Call player init once, then play once per video frame |
| Integrate a compiled tune into your program | [tune-integration.md](tune-integration.md) | Init/play entry points, ROM banking, embedded tune payloads |
| Place music safely across ROM/I/O banking boundaries | [music-memory-banking.md](music-memory-banking.md) | `$01` banking rules, `$D000-$DFFF` hazards, ghost registers |
| Keep playback timing sane across PAL and NTSC | [pal-ntsc-playback.md](pal-ntsc-playback.md) | Timer values plus remaining pitch/effect caveats |
| Arpeggio, vibrato, portamento patterns | [music-patterns.md](music-patterns.md) | Per-frame tune effects layered on SID frequency writes |
| Clean ADSR retrigger inside a player | [hard-restart.md](hard-restart.md) | Two-frame hard-restart scheduling for fast notes |
| Tracker/player file-layout notes | [player-file-formats.md](player-file-formats.md) | JCH 20.G4 structure and sequence byte meanings |
| Raw SID chip registers and waveform/filter setup | [../sid/INDEX.md](../sid/INDEX.md) | Hardware-facing route for direct SID programming |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [irq-music-player.md](irq-music-player.md) | used | Stable raster IRQ wrapper for music-player init/play calls |
| [tune-integration.md](tune-integration.md) | used | ROM-banked init/play integration pattern |
| [music-memory-banking.md](music-memory-banking.md) | used | `$D000-$DFFF` placement hazards and ghost-register workaround |
| [pal-ntsc-playback.md](pal-ntsc-playback.md) | used | Cross-video-standard timer values and timing caveats |
| [music-patterns.md](music-patterns.md) | used | Common per-frame music modulation patterns |
| [hard-restart.md](hard-restart.md) | used | Player-scheduled ADSR retrigger technique |
| [player-file-formats.md](player-file-formats.md) | used | Compact tracker/player file-format notes |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | codebase64.net upstream route |

## related
| domain | read | why |
|---|---|---|
| SID | [../sid/INDEX.md](../sid/INDEX.md) | Chip registers, waveforms, filter, and direct note playback |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Raster IRQ setup and other prerequisite runtime patterns |
| Effects | [../effects/INDEX.md](../effects/INDEX.md) | Demo/game contexts that schedule music alongside visuals |
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | `$A000-$FFFF` and `$D000-$DFFF` placement constraints |
| IRQ | [../irq/INDEX.md](../irq/INDEX.md) | Canonical interrupt timing, setup, and frame-driven update routes |
