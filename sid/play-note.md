---
type: reference
domain: sid
granularity: recipe
summary: "Make a single note sound: volume, frequency, pulse width, envelope, gate."
keywords: [play note, gate, ADSR, envelope, pulse width]
---

## sequence

1. **Initialize master volume** — write `$0F` to `$D418` (VOL=15, no filter mode). Without this, every voice is silent regardless of envelope or waveform.
2. **Set frequency** — write the 16-bit oscillator value low/high to `FREQLO`/`FREQHI` (voice 1: `$D400`/`$D401`; voice 2: `$D407`/`$D408`; voice 3: `$D40E`/`$D40F`). Hz ≈ value × 0.0587 (PAL).
3. **Set pulse width** (only if the pulse waveform is used) — write the 12-bit PW to `PWLO`/`PWHI` nybble (voice 1: `$D402`/`$D403`). Avoid `$000` and `$FFF` — both produce no audible pulse.
4. **Set ATDCY** — write attack nybble (bits 7-4) and decay nybble (bits 3-0) to `ATDCY` (voice 1: `$D405`).
5. **Set SUREL** — write sustain level (bits 7-4) and release nybble (bits 3-0) to `SUREL` (voice 1: `$D406`). Sustain is a level 0-15, not a rate.
6. **Gate ON** — set bit 0 (GATE) of the voice control register `CR` together with the waveform bit (TRI/SAW/PUL/NOI). This starts the attack-decay-sustain phase.
7. **Gate OFF for release** — after the note duration, clear GATE (keep the waveform bit) to start the release phase. Re-gate the same voice only after release completes, or the envelope re-triggers from the current level.

## lookup

| need | read | notes |
|---|---|---|
| All SID registers `$D400-$D418`, R/W, CR bits, ATDCY rate table | [registers.md](registers.md) | Frequency formula, PW range, OSC3/ENV3 read-only |
| Voice 1 vs 2 vs 3 register offsets | [registers.md](registers.md) | Same 7-byte layout repeats; RING/SYNC source rotates 3→1→2 |
| Filter cutoff/resonance/routing `$D415-$D417` | [registers.md](registers.md) | Cutoff is 11-bit, split low/high; route per voice via `$D417` bits 0-2 |
| BASIC `POKE` equivalents for SID | [../basic/graphics-sound.md](../basic/graphics-sound.md) | Same registers as `54272+offset` |
| Frequency tables and note values | [frequency-table.md](frequency-table.md) | PAL A440 16-bit register values; 8 octaves |

## constraints

- `$D418` master VOL MUST be set to a non-zero value before any sound is audible — power-on state is 0.
- All SID registers `$D400-$D418` are write-only; reads return unpredictable values. Only `$D419-$D41C` (paddles, OSC3, ENV3) read back.
- GATE bit MUST be cleared between consecutive notes on the same voice; re-gating without clearing keeps the envelope at sustain.
- TEST bit (CR bit 3) MUST be cleared during normal play; leaving it set holds the oscillator at 0 and silences the voice.
- Pulse waveform REQUIRES both PUL bit set in CR and a non-zero, non-`$FFF` PW value.
- Frequency formula assumes PAL clock (`985248` Hz). NTSC uses `1022727` Hz — same FREQ value produces a slightly different pitch.
- Multiple waveform bits MAY be combined, but the result is chip-revision-dependent (6581 vs 8580 differ); MIDI-style tunings tuned for one chip may not sound identical on the other.
- Voice 3 may be silenced from the mixer via `$D418` bit 7 (3OFF) while still running its envelope/oscillator — useful for using ENV3/OSC3 as modulation sources.
- Code SHOULD NOT touch SID during a raster interrupt that also services player ticks unless the player is re-entrant.

## examples

Minimal one-shot triangle note on voice 1 (assembler-style pseudo-code; addresses written as `$D4xx`):

```
LDA #$0F : STA $D418    ; master volume = 15
LDA #$30 : STA $D405    ; attack=3 (24 ms), decay=0 (6 ms)
LDA #$F8 : STA $D406    ; sustain=15, release=8 (240 ms)
LDA #$10 : STA $D400    ; freq lo
LDA #$22 : STA $D401    ; freq hi (~mid-range note)
LDA #$11 : STA $D404    ; TRI + GATE (start ADS)
; ... wait note duration ...
LDA #$10 : STA $D404    ; TRI, GATE=0 (start release)
```

BASIC `POKE` form of the same first writes:

```
10 POKE 54296,15        : REM $D418 = volume 15
20 POKE 54277,48        : REM $D405 = ATTACK=3, DECAY=0
30 POKE 54278,248       : REM $D406 = SUSTAIN=15, RELEASE=8
40 POKE 54272,16        : POKE 54273,34   : REM freq lo/hi
50 POKE 54276,17        : REM TRI + GATE ON
```

## links

- waveforms: [waveforms.md](waveforms.md)
- frequency table (PAL A440): [frequency-table.md](frequency-table.md)
- frequency calculation: [frequency-calculation.md](frequency-calculation.md)
- hard restart: [../music/hard-restart.md](../music/hard-restart.md)
- I/O area memory: [../memory/io-area.md](../memory/io-area.md)
- raster interrupt: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)

## sources

- SID registers: [registers.md](registers.md)
- BASIC graphics/sound: [../basic/graphics-sound.md](../basic/graphics-sound.md)
- SID index: [INDEX.md](INDEX.md)
