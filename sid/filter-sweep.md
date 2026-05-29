---
type: reference
domain: sid
granularity: atomic
---

## facts
- The SID filter cutoff is 11-bit, split across `$D415` (bits 2-0) and `$D416` (bits 10-3).
- Incrementing the 11-bit cutoff value each frame sweeps the filter from ~30 Hz to ~12 kHz over ~1 second at 50 Hz PAL.
- The filter affects only voices routed through it via `$D417` bits 0-2; unrouted voices bypass it.
- Filter type (LP/BP/HP) is selected via `$D418` bits 4-6; modes may be combined.

## sequence

1. **Route voices through filter** — write voice selection to `$D417` bits 0-2:
   ```
   LDA #$F1   ; RES=15, FILT1=1 (voice 1 through filter, max resonance)
   STA $D417
   ```
2. **Select filter mode** — e.g. low-pass with resonance:
   ```
   LDA #$1F   ; LP=1, VOL=15
   STA $D418
   ```
3. **Initialize cutoff counter** — store 11-bit value in two zp bytes `cut_lo` (bits 2-0) and `cut_hi` (bits 10-3):
   ```
   LDA #$00 : STA cut_lo
   LDA #$00 : STA cut_hi  ; start at minimum cutoff (bass)
   ```
4. **Each frame in IRQ handler** — increment and write:
   ```
   filter_sweep:
     INC cut_lo            ; advance low 3 bits
     LDA cut_lo : AND #$07 : BNE write
     INC cut_hi            ; carry into high byte
     BNE write
     ; cut_hi wrapped: clamp or reverse direction
     LDA #$00 : STA cut_lo : STA cut_hi  ; reset to min
   write:
     LDA cut_lo : AND #$07 : STA $D415
     LDA cut_hi : STA $D416
     RTS
   ```

## filter modes

| `$D418` bits 6-4 | mode | sound character |
|---|---|---|
| `001` (LP) | low-pass | dark/muffled; classic bass sweep |
| `010` (BP) | band-pass | nasal; sweeps a frequency band |
| `100` (HP) | high-pass | thin; cuts bass; useful for hiss/noise |
| `011` (LP+BP) | notch (combined) | complex character |

## constraints
- Cutoff `$D415` bits 7-3 are unused; writing garbage there has no effect but keep `AND #$07` for clarity.
- Maximum cutoff is `cut_hi=$FF`, `cut_lo=$07` (value 2047); the hardware clips at this point.
- Resonance (`$D417` bits 7-4 = RES): higher values create a sharper resonant peak; RES=15 can self-oscillate at high cutoff on the 6581.
- 6581 and 8580 have different filter response shapes; resonance tuning will differ between chips.
- Bypassed voices (not in `$D417` FILT bits) are unaffected by the filter and pass directly to the output mixer.
- `$D418` bit 7 (3OFF) silences voice 3 from the output while still allowing filter routing — useful for filter-modulated noise without an audible oscillator.

## links
- SID registers: [registers.md](registers.md)
- music patterns: [../music/music-patterns.md](../music/music-patterns.md)
- IRQ music player: [../music/irq-music-player.md](../music/irq-music-player.md)
- SID index: [INDEX.md](INDEX.md)

## sources
- codebase64.net: [SID Programming](https://codebase64.net/doku.php?id=base:sid_programming) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
