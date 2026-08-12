---
type: index
domain: music
source: codebase64.net
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
| PSID/RSID `.sid` container format | [sid-file-format.md](sid-file-format.md) | Header fields, byte order, payload loading, flags, and strict RSID constraints |
| Raw SID chip registers and waveform/filter setup | [../sid/INDEX.md](../sid/INDEX.md) | Hardware-facing route for direct SID programming |

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| Clean ADSR retrigger for fast notes by scheduling a two-frame hard restart. | [hard-restart.md](hard-restart.md) | hard restart, ADSR retrigger, envelope reset, LFSR prescaler |
| Call a tune's init once and its play once per frame from a stable IRQ. | [irq-music-player.md](irq-music-player.md) | music player, IRQ playback, play routine, frame rate call |
| Place tune code and data safely around the I/O window and ROM banking. | [music-memory-banking.md](music-memory-banking.md) | music banking, ghost registers, load address, I/O window clash |
| Per-frame tune effects: arpeggio, vibrato and portamento over SID frequency writes. | [music-patterns.md](music-patterns.md) | arpeggio, vibrato, portamento, pitch glide, tune effects |
| Keep a tune at the right tempo on both PAL and NTSC machines. | [pal-ntsc-playback.md](pal-ntsc-playback.md) | PAL NTSC, playback speed, timer values, tempo correction |
| How tracker output packs patterns, instruments and sequences, using JCH as the worked case. | [player-file-formats.md](player-file-formats.md) | tracker format, JCH, pattern data, sequence bytes, player layout |
| The PSID and RSID container format: header fields, byte order, payload loading. | [sid-file-format.md](sid-file-format.md) | SID file, PSID, RSID, HVSC, container header |
| Wire a compiled tune into your program: init and play entry points, banking, payload. | [tune-integration.md](tune-integration.md) | tune integration, init routine, embedded tune, player entry points |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| SID | [../sid/INDEX.md](../sid/INDEX.md) | Chip registers, waveforms, filter, and direct note playback |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Raster IRQ setup and other prerequisite runtime patterns |
| Effects | [../effects/INDEX.md](../effects/INDEX.md) | Demo/game contexts that schedule music alongside visuals |
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | `$A000-$FFFF` and `$D000-$DFFF` placement constraints |
| IRQ | [../irq/INDEX.md](../irq/INDEX.md) | Canonical interrupt timing, setup, and frame-driven update routes |
