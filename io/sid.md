---
type: reference
domain: io
granularity: chip
---

## facts
- Chip: MOS 6581 (original C64) / 8580 (C64C); branded SID (Sound Interface Device).
- 25 write registers at `$D400-$D418`; 4 read-only registers at `$D419-$D41C`.
- Block mirrored every `$20` bytes through `$D7FF`.
- Three identical voice circuits (voices 1-3); each voice has frequency, pulse width, control, attack/decay, and sustain/release registers.
- Filter is shared across all voices; routing and type are set per voice via `$D417`-`$D418`.

## lookup

| address | name | bits/fields | R/W | notes |
|---:|---|---|:---:|---|
| `$D400` | voice 1 freq lo | 7-0: frequency low byte | W | combined with `$D401` for 16-bit value |
| `$D401` | voice 1 freq hi | 7-0: frequency high byte | W | freq Hz = reg × Fclk ÷ 16777216 |
| `$D402` | voice 1 PW lo | 7-0: pulse width low byte | W | combined with `$D403` for 12-bit value |
| `$D403` | voice 1 PW hi | 3-0: pulse width high nybble; 7-4: unused | W | full 12-bit PW = `$D403[3:0]:$D402` |
| `$D404` | voice 1 CR | NOI, PUL, SAW, TRI, TEST, RING, SYNC, GATE | W | see CR breakdown below |
| `$D405` | voice 1 ATDCY | 7-4: ATTACK; 3-0: DECAY | W | each nybble selects a rate; see nybble table |
| `$D406` | voice 1 SUREL | 7-4: SUSTAIN level; 3-0: RELEASE | W | SUSTAIN is a level (0-15), not a rate |
| `$D407` | voice 2 freq lo | 7-0: frequency low byte | W | same pattern as voice 1 |
| `$D408` | voice 2 freq hi | 7-0: frequency high byte | W | |
| `$D409` | voice 2 PW lo | 7-0: pulse width low byte | W | |
| `$D40A` | voice 2 PW hi | 3-0: pulse width high nybble; 7-4: unused | W | |
| `$D40B` | voice 2 CR | NOI, PUL, SAW, TRI, TEST, RING, SYNC, GATE | W | RING/SYNC source is voice 1 oscillator |
| `$D40C` | voice 2 ATDCY | 7-4: ATTACK; 3-0: DECAY | W | |
| `$D40D` | voice 2 SUREL | 7-4: SUSTAIN level; 3-0: RELEASE | W | |
| `$D40E` | voice 3 freq lo | 7-0: frequency low byte | W | same pattern as voice 1 |
| `$D40F` | voice 3 freq hi | 7-0: frequency high byte | W | |
| `$D410` | voice 3 PW lo | 7-0: pulse width low byte | W | |
| `$D411` | voice 3 PW hi | 3-0: pulse width high nybble; 7-4: unused | W | |
| `$D412` | voice 3 CR | NOI, PUL, SAW, TRI, TEST, RING, SYNC, GATE | W | RING/SYNC source is voice 2 oscillator |
| `$D413` | voice 3 ATDCY | 7-4: ATTACK; 3-0: DECAY | W | |
| `$D414` | voice 3 SUREL | 7-4: SUSTAIN level; 3-0: RELEASE | W | |
| `$D415` | filter cutoff lo | 2-0: cutoff bits 2-0; 7-3: unused | W | lower 3 bits of 11-bit cutoff value |
| `$D416` | filter cutoff hi | 7-0: cutoff bits 10-3 | W | upper 8 bits of 11-bit cutoff value |
| `$D417` | filter res/route | 7-4: RES; 3: FILT EX; 2: FILT 3; 1: FILT 2; 0: FILT 1 | W | see filter routing breakdown below |
| `$D418` | mode/volume | 7: 3OFF; 6: HP; 5: BP; 4: LP; 3-0: VOL | W | see mode breakdown below |
| `$D419` | paddle X | 7-0: ADC result | R | analog paddle/paddle fire pin |
| `$D41A` | paddle Y | 7-0: ADC result | R | analog paddle/paddle fire pin |
| `$D41B` | OSC3 / random | 7-0: voice 3 oscillator MSB | R | read-only; useful as random source |
| `$D41C` | ENV3 | 7-0: voice 3 envelope level | R | read-only; reflects current envelope |

### CR — control register bits (applies to `$D404`, `$D40B`, `$D412`)

| bit | name | description |
|:---:|---|---|
| 7 | NOI | 1 = noise waveform enabled |
| 6 | PUL | 1 = pulse waveform enabled |
| 5 | SAW | 1 = sawtooth waveform enabled |
| 4 | TRI | 1 = triangle waveform enabled |
| 3 | TEST | 1 = reset oscillator and lock it at 0; disables oscillator output while set |
| 2 | RING | 1 = ring modulation; TRI waveform modulated by previous voice oscillator |
| 1 | SYNC | 1 = hard sync; this voice's oscillator reset by previous voice oscillator |
| 0 | GATE | 1 = start attack/decay/sustain; 0 = start release phase |

- Multiple waveform bits may be set simultaneously; behavior is chip-revision-dependent (6581 vs 8580 differ).
- RING and SYNC source voice: voice 1 uses voice 3, voice 2 uses voice 1, voice 3 uses voice 2.

### ATDCY — attack/decay nybble rates

| nybble value | attack time | decay/release time |
|:---:|---|---|
| 0 | 2 ms | 6 ms |
| 1 | 8 ms | 24 ms |
| 2 | 16 ms | 48 ms |
| 3 | 24 ms | 72 ms |
| 4 | 38 ms | 114 ms |
| 5 | 56 ms | 168 ms |
| 6 | 68 ms | 204 ms |
| 7 | 80 ms | 240 ms |
| 8 | 100 ms | 300 ms |
| 9 | 250 ms | 750 ms |
| A | 500 ms | 1.5 s |
| B | 800 ms | 2.4 s |
| C | 1 s | 3 s |
| D | 3 s | 9 s |
| E | 5 s | 15 s |
| F | 8 s | 24 s |

- Attack nybble (bits 7-4 of ATDCY): rise time from 0 to peak.
- Decay nybble (bits 3-0 of ATDCY): fall time from peak to sustain level.
- Release nybble (bits 3-0 of SUREL): fall time from sustain to 0 after GATE cleared.
- Sustain (bits 7-4 of SUREL): level held after decay, 0=silent, 15=full peak.

### $D417 — filter resonance/routing bits

| bits | name | description |
|:---:|---|---|
| 7-4 | RES | resonance 0-15 (0=none, 15=maximum Q) |
| 3 | FILT EX | 1 = route external audio input through filter |
| 2 | FILT 3 | 1 = route voice 3 output through filter |
| 1 | FILT 2 | 1 = route voice 2 output through filter |
| 0 | FILT 1 | 1 = route voice 1 output through filter |

- Voices not routed through filter bypass it and go directly to the output mixer.
- Filter cutoff is 11-bit: `($D416 << 3) | ($D415 & $07)`, range 0-2047, approximately 30 Hz–12 kHz.

### $D418 — mode/volume bits

| bits | name | description |
|:---:|---|---|
| 7 | 3OFF | 1 = disconnect voice 3 from audio output (voice 3 envelope/oscillator still runs) |
| 6 | HP | 1 = high-pass filter output to mixer |
| 5 | BP | 1 = band-pass filter output to mixer |
| 4 | LP | 1 = low-pass filter output to mixer |
| 3-0 | VOL | master volume 0-15 |

- Multiple filter type bits (HP, BP, LP) may be set simultaneously to combine responses.
- 3OFF is typically set when using voice 3 as a random/envelope source without audible output.
- VOL MUST be set to a non-zero value (e.g., `$0F`) before any sound is audible; default power-on state is 0.

## constraints
- All SID registers are write-only except `$D419-$D41C`; reads from `$D400-$D418` return unpredictable values.
- OSC3 (`$D41B`) and ENV3 (`$D41C`) are read-only snapshots of voice 3 state; agents MUST NOT write to them.
- GATE bit MUST be cleared (released) between notes; gating without release causes envelope to stay at sustain indefinitely.
- Pulse waveform requires both PUL bit set in CR and a non-zero PW value; `$000` and `$FFF` produce no output.
- TEST bit MUST be cleared before re-enabling the oscillator; leaving it set permanently silences the voice.
- 6581 and 8580 chip revisions differ in filter characteristics and combined-waveform output; music tuned for one may not sound identical on the other.
- Frequency formula (PAL): Hz = FREQ_reg × 985248 ÷ 16777216 ≈ FREQ_reg × 0.0587.

## links
- play-SID task: [../tasks/play-sid.md](../tasks/play-sid.md)
- I/O area: [../memory/io-area.md](../memory/io-area.md)
- processor port: [processor-port.md](processor-port.md)
- I/O index: [INDEX.md](INDEX.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- upstream: [mist64/c64ref src/c64io](https://github.com/mist64/c64ref/tree/master/src/c64io)
- I/O index: [INDEX.md](INDEX.md)
- memory I/O area: [../memory/io-area.md](../memory/io-area.md)
