---
type: reference
domain: sid
granularity: atomic
summary: "The four SID waveforms, their quirks, and the combined-waveform cautions."
keywords: [waveforms, triangle, sawtooth, pulse, noise, ring modulation]
---

## facts
- SID waveform selection lives in each voice control register `CR` (`$D404`, `$D40B`, `$D412`): `TRI`, `SAW`, `PUL`, and `NOI` are the four primary waveform bits.
- Codebase64's triangle-waveform measurements show a linear ramp from `$00` up to `$FF`, then a linear ramp back down to `$00`.
- Codebase64's noise-waveform examination models the SID noise source as a long repeating pseudo-random sequence generated from a 23-bit internal shift register and exposed through the OSC3 readout.
- Pulse output depends on both the `PUL` bit and a non-zero pulse-width setting; combined waveforms remain chip-revision-dependent and should be treated as 6581/8580-specific sound design.

## lookup
| waveform | control bit | practical notes |
|---|---|---|
| Triangle | `TRI` (bit 4) | Smooth up/down ramp; ring modulation only affects triangle |
| Sawtooth | `SAW` (bit 5) | Rising ramp; common bright lead/bass source |
| Pulse | `PUL` (bit 6) | Requires `PWLO`/`PWHI`; extreme widths near `$000`/`$FFF` go silent |
| Noise | `NOI` (bit 7) | Pseudo-random source used for drums, hiss, and effects |

## triangle waveform
- Measured from OSC3 (`$D41B`) after resetting the oscillator with `TEST`, the triangle starts at `$00`, rises linearly to `$FF`, then falls linearly back to `$00`.
- The Codebase64 article models the internal triangle counter as 9 bits wide (`0..511`), with the 8-bit OSC3 value derived from that up/down ramp.

## noise waveform
- Voice 3 OSC3 (`$D41B`) lets you sample the current 8-bit noise output without routing voice 3 to the audible mix.
- Codebase64's loop-checking experiment found the noise stream repeats only after a long sequence (about `8 MB` of sampled bytes at the tested setup), consistent with a 23-bit internal register.
- The article maps the 8 visible output bits to selected positions of that internal register, which explains why the waveform is pseudo-random but still deterministic.

## constraints
- OSC3 readback uses voice 3 (`$D41B`), so do not rely on that register for both gameplay logic and audible voice-3 playback at the same time.
- `TEST` resets the oscillator state, but Codebase64 notes the reset is not instantaneous for noise; sample/restart experiments must allow settling time.
- Combined waveform bits can sound useful, but they are explicitly revision-dependent; validate on both 6581 and 8580 if you depend on a specific timbre.

## links
- SID registers: [registers.md](registers.md)
- play-SID task: [play-note.md](play-note.md)
- SID model detection: [model-detect.md](model-detect.md)
- noise reduction: [noise-reduction.md](noise-reduction.md)
- SID index: [INDEX.md](INDEX.md)

## sources
- local companion: [registers.md](registers.md)
- codebase64.net: [Triangle Waveform](https://codebase64.net/doku.php?id=base:triangle_waveform) — CC BY-NC-SA 4.0
- codebase64.net: [Noise Waveform](https://codebase64.net/doku.php?id=base:noise_waveform) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
