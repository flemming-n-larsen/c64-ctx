---
type: reference
domain: sid
granularity: recipe
summary: "Play 4-bit PCM by hammering the master volume register; a 6581 side effect."
keywords: [digi samples, PCM playback, sample player, volume trick, 8-bit PWM]
---

## facts
- The 6581 SID has a hardware side-effect: rapidly writing to the master volume register (`$D418` bits 3-0) causes audible amplitude modulation on the audio output, enabling 4-bit PCM sample playback.
- This is an analog DAC bleed artifact — the volume register feeds into the audio path outside the voice mixers.
- Effective sample rate: up to ~8 kHz using a CIA timer interrupt; higher rates reduce audio quality.
- Resolution: 4 bits (16 amplitude levels), giving ~24 dB dynamic range.
- 8580 revision: the analog path was redesigned; the volume-register bleed is significantly attenuated. Digi playback works poorly or not at all on most 8580 chips without hardware modification.

## sequence — CIA timer digi player (6581)

1. **Silence all voices** — set GATE=0 on all three voices; set all waveform bits to 0
2. **Keep master volume register writable** — write `$00` to `$D418` to start (volume=0, no filter)
3. **Configure CIA1 timer A** for the sample rate — e.g. `$91` cycles for ~8 kHz at PAL:
   ```
   LDA #$91 : STA $DC04   ; CIA1 timer A lo
   LDA #$00 : STA $DC05   ; CIA1 timer A hi
   ```
4. **Enable CIA1 timer A interrupt**:
   ```
   LDA #$81 : STA $DC0D   ; CIA1 ICR: set bit 0 (timer A) + bit 7 (set)
   ```
5. **Start timer A in continuous mode**:
   ```
   LDA #$11 : STA $DC0E   ; start, continuous, load
   ```
6. **In the IRQ handler** — fetch next sample byte, extract amplitude, write to `$D418`:
   ```
   LDA (sample_ptr),Y     ; fetch byte (two 4-bit samples packed)
   LSR A : LSR A : LSR A : LSR A  ; shift high nybble to bits 3-0
   AND #$0F               ; mask to 4 bits
   STA $D418              ; write amplitude
   ; advance sample_ptr / Y for next call
   ```
7. **Restore on completion** — write `$0F` to `$D418` to re-enable normal audio

## 8-bit PWM method (experimental, any SID)

Alternative using voice 3 pulse width for higher resolution:
- Set voice 3 to TEST mode (`$D412` bit 3 = 1); oscillator is frozen
- Write 8-bit sample value to voice 3 PW lo (`$D410`) each timer tick
- Route voice 3 through filter; adjust filter for optimal DC response
- Less reliable across SID revisions; requires tuning per chip

## constraints
- All three SID voices MUST be silent during digi playback; any running oscillator adds interference to the volume DAC bleed.
- `$D418` bits 7-4 (filter mode and 3OFF) should remain `$00` during digi playback to keep only the volume bits active.
- CIA1 timer interrupt conflicts with KERNAL and CIA-driven music players — disable interfering IRQs before starting.
- 8580 chips: do not rely on volume-register digi technique; detect chip type first via [model-detect.md](model-detect.md).
- Sample rate accuracy depends on PAL/NTSC clock; CIA timer values must be recalculated for NTSC.
- Packing: two 4-bit samples per byte (hi nybble first) is standard; loop pointer advancement must match.

## links
- SID registers: [registers.md](registers.md)
- noise reduction: [noise-reduction.md](noise-reduction.md)
- SID model detection: [model-detect.md](model-detect.md)
- SID index: [INDEX.md](INDEX.md)

## sources
- c64-wiki.com: [SID — Sample Playback](https://www.c64-wiki.com/wiki/SID) — CC BY-SA 3.0
- codebase64.net: [SID Programming — Samples aka Digis](https://codebase64.net/doku.php?id=base:sid_programming#samples_aka_digis) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
