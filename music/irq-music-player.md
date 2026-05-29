---
type: reference
domain: music
granularity: atomic
---

## facts
- A SID music player (e.g., a compiled SID file) requires being called once per frame at a stable rate.
- The raster IRQ at line `$00` provides a consistent 50 Hz (PAL) or 60 Hz (NTSC) call rate.
- The player init routine sets up SID register state; the play routine updates one frame of music.
- The IRQ handler acknowledges the VIC-II raster flag and then jumps to the KERNAL IRQ exit at `$EA31` to preserve system IRQ behavior.

## sequence

1. Disable interrupts: `SEI`.
2. Redirect IRQ vector: write handler address to `$0314`/`$0315`.
3. Disable CIA timer IRQs that would interfere: write `$7F` to `$DC0D` (CIA1 ICR).
4. Enable VIC-II raster IRQ: write `$01` to `$D01A`.
5. Set raster compare to line `$00`: write `$00` to `$D012`; clear `$D011` bit 7.
6. Call the SID player init routine (e.g., `JSR $1000`).
7. Enable interrupts: `CLI`.
8. Enter idle main loop (`JMP *`).

**IRQ handler:**
1. Acknowledge raster IRQ: write `$01` to `$D019`.
2. Call SID player frame routine (e.g., `JSR $1003`).
3. Exit via KERNAL IRQ service: `JMP $EA31`.

## lookup
| register | write | purpose |
|---|---|---|
| `$D011` | `$1B` (bit 7 clear) | Raster compare MSB = 0 (lines 0–255) |
| `$D012` | `$00` | Raster compare = line 0 |
| `$DC0D` | `$7F` | Disable CIA1 timer IRQs |
| `$D01A` | `$01` | Enable VIC-II raster IRQ |
| `$D019` | `$01` | Acknowledge raster IRQ (write to clear) |
| `$0314`/`$0315` | handler lo/hi | KERNAL IRQ vector |

| address | convention | notes |
|---|---|---|
| `$1000` | SID player init | Resets SID and prepares player state |
| `$1003` | SID player frame | Advances one frame of music |
| `$EA31` | KERNAL IRQ exit | Restores registers and RTI |

## constraints
- `$D019` MUST be acknowledged before calling the play routine; otherwise the IRQ re-fires immediately.
- `JMP $EA31` preserves KERNAL timing and the system clock; `RTI` directly would skip KERNAL housekeeping.
- SID file load address (`$1000`) is a convention for PSID/SID files; actual address depends on the player.
- CIA1 timer IRQs MUST be disabled if the player does not rely on them, to prevent interference.
- This pattern calls the player at raster line 0; players that expect 50/60 Hz calls work correctly on PAL/NTSC respectively.

## links
- music index: [INDEX.md](INDEX.md)
- SID index: [../sid/INDEX.md](../sid/INDEX.md)
- tune integration: [tune-integration.md](tune-integration.md)
- PAL/NTSC playback: [pal-ntsc-playback.md](pal-ntsc-playback.md)
- play-SID task: [../sid/play-note.md](../sid/play-note.md)
- music patterns: [music-patterns.md](music-patterns.md)
- filter sweep: [../sid/filter-sweep.md](../sid/filter-sweep.md)
- raster interrupt task: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- stable raster effect: [../effects/stable-raster.md](../effects/stable-raster.md)
- SID registers: [../sid/registers.md](../sid/registers.md)
- VIC-II: [../io/vic-ii.md](../io/vic-ii.md)
- memory symbols: [../memory/symbols.md](../memory/symbols.md)

## sources
- codebase64.net: [Simple IRQ Music Player](https://codebase64.net/doku.php?id=sid:simple_irq_music_player) — Richard Bayliss — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
