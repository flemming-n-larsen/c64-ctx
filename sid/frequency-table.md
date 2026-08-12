---
type: reference
domain: sid
granularity: reference
summary: "PAL A440 note-to-register values across the octave range."
keywords: [frequency table, PAL notes, note values, A440]
---

## facts
- SID frequency registers are 16-bit (FREQHI:FREQLO); value ≈ Hz × 16777216 ÷ clock.
- PAL clock: 985248 Hz. NTSC (`6567R8`) clock: 1022727 Hz. Same register value produces a slightly higher pitch on NTSC.
- Table below is calibrated to A4 = 440 Hz standard tuning on PAL C64.
- Each octave is exactly 2× the register value of the previous octave.
- Octave 4 is the middle octave: C4 (middle C) ≈ 261 Hz = `$1160`.
- PAL-N "Drean" C64 uses a different clock; this table does not apply there.

## lookup

Write FREQLO (low byte) to voice 1 `$D400`, FREQHI (high byte) to voice 1 `$D401`.
For voices 2/3 add offset +7/+14.

| Note | Oct 0  | Oct 1  | Oct 2  | Oct 3  | Oct 4  | Oct 5  | Oct 6  | Oct 7  |
|------|--------|--------|--------|--------|--------|--------|--------|--------|
| C    | `$0116` | `$022C` | `$0458` | `$08B0` | `$1160` | `$22C0` | `$4580` | `$8B00` |
| C#   | `$0127` | `$024E` | `$049C` | `$0938` | `$1270` | `$24E0` | `$49C0` | `$9380` |
| D    | `$0139` | `$0272` | `$04E4` | `$09C8` | `$1390` | `$2720` | `$4E40` | `$9C80` |
| D#   | `$014B` | `$0296` | `$052C` | `$0A58` | `$14B0` | `$2960` | `$52C0` | `$A580` |
| E    | `$015F` | `$02BE` | `$057C` | `$0AF8` | `$15F0` | `$2BE0` | `$57C0` | `$AF80` |
| F    | `$0174` | `$02E8` | `$05D0` | `$0BA0` | `$1740` | `$2E80` | `$5D00` | `$BA00` |
| F#   | `$018A` | `$0314` | `$0628` | `$0C50` | `$18A0` | `$3140` | `$6280` | `$C500` |
| G    | `$01A1` | `$0342` | `$0684` | `$0D08` | `$1A10` | `$3420` | `$6840` | `$D080` |
| G#   | `$01BA` | `$0374` | `$06E8` | `$0DD0` | `$1BA0` | `$3740` | `$6E80` | `$DD00` |
| A    | `$01D4` | `$03A8` | `$0750` | `$0EA0` | `$1D40` | `$3A80` | `$7500` | `$EA00` |
| A#   | `$01F0` | `$03E0` | `$07C0` | `$0F80` | `$1F00` | `$3E00` | `$7C00` | `$F800` |
| B    | `$020E` | `$041C` | `$0838` | `$1070` | `$20E0` | `$41C0` | `$8380` | —      |

Split each 16-bit value: low byte → `$D400`, high byte → `$D401`. Example for A4 (`$1D40`):

```
LDA #$40 : STA $D400   ; FREQLO
LDA #$1D : STA $D401   ; FREQHI
```

NTSC formula: `freq_reg = Hz × 16777216 ÷ 1022727`. Multiply PAL values by `≈ 1.037` as a fast approximation when retuning from PAL values.

## constraints
- B in octave 7 (`$8380 × 2 = $10700`) overflows 16 bits — do not use.
- Write FREQLO before FREQHI to avoid a transient glitch on some SID revisions.
- Values have < 0.1 semitone pitch error vs ideal A440 across all octaves.

## links

- SID registers: [registers.md](registers.md)
- frequency calculation: [frequency-calculation.md](frequency-calculation.md)
- NTSC frequency table: [ntsc-frequency-table.md](ntsc-frequency-table.md)
- play-SID task: [play-note.md](play-note.md)
- hard restart: [../music/hard-restart.md](../music/hard-restart.md)
- SID index: [INDEX.md](INDEX.md)

## sources

- codebase64.net: [PAL Frequency Table](https://codebase64.net/doku.php?id=base:pal_frequency_table) — CC BY-NC-SA 4.0
