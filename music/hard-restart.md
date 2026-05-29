---
type: reference
domain: music
granularity: recipe
---

## facts
- The SID envelope uses a 15-bit LFSR prescaler to generate ADSR timing. When an A/D/R register value is *lowered*, the LFSR may have already passed the new comparison threshold. The LFSR must then complete a full 32768-cycle wrap (≈ 1.7 frames at 50 Hz PAL) before the new rate takes effect.
- Symptom: notes re-gated rapidly buzz, glitch, or fail to attack cleanly — especially at high tempo.
- Hard restart: gate off the voice with ATDCY/SUREL both set to `$00`, wait two frames, then gate on with the real ADSR values. The forced `$00` release is instantaneous (6 ms), putting the LFSR in a safe state for any subsequent rate.

## sequence

Two frames before the new note (e.g. two ticks before the music player writes the next note):

1. **Frame N — gate off with zero ADSR**
   ```
   LDA #waveform        ; keep waveform bit, clear GATE (bit 0)
   STA $D404            ; voice 1 CR: gate off
   LDA #$00 : STA $D405 ; ATDCY = 0 (attack 2 ms, decay 6 ms)
   LDA #$00 : STA $D406 ; SUREL = 0 (sustain 0, release 6 ms)
   ```

2. **Frame N+1 — do nothing for this voice**

3. **Frame N+2 — write real ADSR then gate on**
   ```
   LDA #$00 : STA $D405 ; dummy write flushes LFSR state (already $00, harmless)
   LDA atdcy : STA $D405
   LDA surel : STA $D406
   LDA freq_lo : STA $D400
   LDA freq_hi : STA $D401
   LDA #(waveform | $01) ; waveform bit + GATE=1
   STA $D404
   ```

For 1-frame implementations: omit frame N+1 and accept a slightly elevated risk of glitch on very long release values.

## constraints
- ATDCY `$00` = attack 2 ms / decay 6 ms; SUREL `$00` = sustain 0 / release 6 ms. Release is near-instant, so the voice is silent by frame N+2.
- The bug only triggers when *lowering* A/D/R values. Increasing values mid-flight is safe.
- Apply hard-restart logic in the music player, not in a once-per-note interrupt; the 2-frame gap must be scheduled.
- Voice 3: `$D413`/`$D414` for ATDCY/SUREL; apply same pattern with offset +14.

## links
- music index: [INDEX.md](INDEX.md)
- SID index: [../sid/INDEX.md](../sid/INDEX.md)
- SID registers: [../sid/registers.md](../sid/registers.md)
- play-SID task: [../sid/play-note.md](../sid/play-note.md)
- frequency table: [../sid/frequency-table.md](../sid/frequency-table.md)

## sources
- codebase64.net: [Classic Hard-Restart and About ADSR in Generally](https://codebase64.net/doku.php?id=base:classic_hard-restart_and_about_adsr_in_generally) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
