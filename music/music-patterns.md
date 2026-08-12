---
type: reference
domain: music
granularity: atomic
summary: "Per-frame tune effects: arpeggio, vibrato and portamento over SID frequency writes."
keywords: [arpeggio, vibrato, portamento, pitch glide, tune effects]
---

## facts
- SID has three voices; demo music players run once per frame (50 Hz PAL) from a raster IRQ.
- Three standard per-frame modulation techniques — arpeggio, vibrato, portamento — are implemented by updating the frequency registers in the IRQ handler.
- All three can run simultaneously on independent voices.

## arpeggio

Cycling through 2-4 notes fast enough (≥ 10 Hz) creates the illusion of a chord on a single voice.

```
; zp: arp_idx (0-2), arp_tab (3-entry word table of 16-bit freq values)
; call once per frame in IRQ handler

arp_step:
  LDX arp_idx
  LDA arp_tab_lo,X : STA $D400   ; voice 1 FREQLO
  LDA arp_tab_hi,X : STA $D401   ; voice 1 FREQHI
  INX : CPX #3 : BCC +
  LDX #0
+ STX arp_idx
  RTS
```

- 3-entry table at 50 Hz = each note held ~20 ms; perceived as a triad.
- 2-entry table = power chord / octave doubling.
- Common usage: bass voice plays arpeggio while lead voices hold melody notes.

## vibrato

A slow sinusoidal pitch variation (±1-5 Hz depth, ~5-7 Hz rate) adds expression to held notes.

```
; zp: vib_cnt (frame counter 0-31), vib_base_lo/hi (note freq)
; vib_tab: 32-entry signed-byte table, e.g. triangle wave ±16

vib_step:
  LDX vib_cnt
  LDA vib_tab,X          ; signed delta (two's complement)
  BPL +
  ; negative delta
  CLC
  ADC vib_base_lo : STA $D400
  LDA vib_base_hi : ADC #$FF : STA $D401  ; propagate borrow
  BNE done
+ ; positive delta
  CLC
  ADC vib_base_lo : STA $D400
  LDA vib_base_hi : ADC #$00 : STA $D401
done:
  INX : TXA : AND #$1F : STA vib_cnt
  RTS
```

- Depth (`vib_tab` amplitude): ±8 ≈ quarter-semitone, ±32 ≈ one semitone.
- Rate: one full cycle per 32 frames = 1.56 Hz at 50 Hz.

## portamento (pitch glide)

Smoothly slides from one note to another by adding a fixed step to the frequency each frame.

```
; zp: port_cur_lo/hi (current freq), port_tgt_lo/hi (target freq), port_step (unsigned)

port_step:
  ; compare current to target; add or subtract step
  LDA port_tgt_hi : CMP port_cur_hi : BCC down : BNE up
  LDA port_tgt_lo : CMP port_cur_lo : BCC down

up:
  CLC
  LDA port_cur_lo : ADC port_step : STA port_cur_lo
  LDA port_cur_hi : ADC #0        : STA port_cur_hi
  ; clamp: if cur > tgt, snap to tgt
  BCC write
  LDA port_tgt_lo : STA port_cur_lo
  LDA port_tgt_hi : STA port_cur_hi
  BNE write

down:
  SEC
  LDA port_cur_lo : SBC port_step : STA port_cur_lo
  LDA port_cur_hi : SBC #0        : STA port_cur_hi
  ; clamp: if cur < tgt, snap to tgt
  LDA port_tgt_lo : STA port_cur_lo
  LDA port_tgt_hi : STA port_cur_hi

write:
  LDA port_cur_lo : STA $D400
  LDA port_cur_hi : STA $D401
  RTS
```

- `port_step` = 1-4 for slow glide; 16+ for fast slide.
- Start a new note by updating `port_tgt_lo/hi`; `port_cur` follows automatically.

## constraints
- All three routines update voice 1 (`$D400`/`$D401`); adjust offsets for voices 2/3 (+7/+14).
- Arpeggio and vibrato should NOT run on the same voice simultaneously — they fight for the frequency register.
- Portamento step size must be tuned to tempo; too large causes overshoot (snapped by the clamp).
- Vibrato depth table values are in SID frequency units, not Hz; the same depth sounds wider at lower notes.
- Call these routines only from inside the raster IRQ (once per frame) to maintain consistent timing.

## links

- SID registers: [../sid/registers.md](../sid/registers.md)
- frequency table: [../sid/frequency-table.md](../sid/frequency-table.md)
- IRQ music player: [irq-music-player.md](irq-music-player.md)
- filter sweep: [../sid/filter-sweep.md](../sid/filter-sweep.md)
- music index: [INDEX.md](INDEX.md)
- SID index: [../sid/INDEX.md](../sid/INDEX.md)

## sources

- codebase64.net: [SID Programming](https://codebase64.net/doku.php?id=base:sid_programming) — CC BY-NC-SA 4.0
