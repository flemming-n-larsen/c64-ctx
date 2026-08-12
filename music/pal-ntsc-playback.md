---
type: reference
domain: music
granularity: atomic
summary: "Keep a tune at the right tempo on both PAL and NTSC machines."
keywords: [PAL NTSC, playback speed, timer values, tempo correction]
---

## facts
- Most C64 music players are advanced once per video frame, so PAL and NTSC machines naturally play the same tune at different speeds unless the call interval is adjusted.
- Codebase64 gives PAL frame cost as `312 * 63 = 19656` cycles (`$4CC8`) and NTSC frame cost as `263 * 65 = 17095` cycles (`$42C7`).
- To preserve PAL-speed playback on NTSC, Codebase64 recommends a timer value of `$4FB2`.
- To preserve NTSC-speed playback on PAL, Codebase64 recommends a timer value of `$4550`.

## timing lookup
| goal | timer value | notes |
|---|---|---|
| Play PAL-timed tune on NTSC at PAL speed | `$4FB2` | Derived from `19656 / (985248 / 1022727)` |
| Play NTSC-timed tune on PAL at NTSC speed | `$4550` | Derived from `17095 * (1022727 / 985248)` |
| Play PAL tune on PAL-N / Drean at PAL speed | `$4FC1` | Addendum from Codebase64 |

## constraints
- Matching update rate does not fully fix PAL/NTSC differences: Codebase64 explicitly notes pitch, portamento, and vibrato still change because SID pitch uses machine-dependent clocks.
- Raster-IRQ calling once per display frame is fine when you accept native PAL/NTSC speed differences; use CIA timers only when you need cross-standard timing.
- PAL-N / Drean machines need their own timer ratio and should not be treated as either plain PAL or plain NTSC.

## sources

- codebase64.net: [Playing music on PAL and NTSC](https://codebase64.net/doku.php?id=base:playing_music_on_pal_and_ntsc) — CC BY-NC-SA 4.0
- tune integration: [tune-integration.md](tune-integration.md)
- IRQ music player: [irq-music-player.md](irq-music-player.md)
- SID frequency calculation: [../sid/frequency-calculation.md](../sid/frequency-calculation.md)
- PAL frequency table: [../sid/frequency-table.md](../sid/frequency-table.md)
- NTSC frequency table: [../sid/ntsc-frequency-table.md](../sid/ntsc-frequency-table.md)
- raster interrupt task: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- music index: [INDEX.md](INDEX.md)
