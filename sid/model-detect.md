---
type: reference
domain: sid
granularity: recipe
summary: "Tell a 6581 from an 8580 at runtime using oscillator 3 readback."
keywords: [SID detection, 6581, 8580, chip revision, OSC3 readback]
---

## facts
- Two SID revisions exist: 6581 (original C64, ~1982-1986) and 8580 (C64C, ~1987-1992).
- They differ in filter response, combined-waveform output, and analog audio path behavior.
- Detection exploits a one-cycle oscillator start-up delay present on 8580 but not 6581: reading OSC3 (`$D41B`) immediately after enabling the oscillator yields 3 on 6581 and 2 on 8580.
- Credit: SounDemon and Dag Lem.

## sequence

1. **Disable interrupts** — `SEI`
2. **Avoid bad lines** — poll `$D012` until raster > `$F8` to ensure stable timing
3. **Set voice 3 frequency to maximum**
   ```
   LDA #$FF : STA $D40E   ; voice 3 FREQLO = $FF
   LDA #$FF : STA $D40F   ; voice 3 FREQHI = $FF
   ```
4. **Assert TEST bit** — freezes oscillator
   ```
   LDA #$FF : STA $D412   ; CR: TEST + all waveform bits + GATE
   ```
5. **Release TEST, select sawtooth** — restarts oscillator
   ```
   LDA #$20 : STA $D412   ; CR: SAW=1, all others 0
   ```
6. **Read OSC3**
   ```
   LDA $D41B              ; result: $03 on 6581, $02 on 8580
   ```
7. **Determine chip**
   ```
   LSR A                  ; shift bit 0 into carry
   BCS is_6581            ; carry set  → 6581
   ; fall through         ; carry clear → 8580
   ```

## lookup

| OSC3 value | after LSR | chip |
|:---:|:---:|---|
| `$03` | carry set | 6581 |
| `$02` | carry clear | 8580 |

## constraints
- `SEI` is required; any IRQ between steps 5 and 6 invalidates the timing.
- Voice 3 frequency MUST be set to `$FFFF` before the test; lower values produce different oscillator timing.
- After detection, restore `$D412` to `$00` (TEST cleared, GATE off) before using voice 3.
- Voice 3 should be routed off the output during detection (`$D418` bit 7 set, or `$D417` bit 2 clear) to avoid an audible click.

## sources

- codebase64.net: [Detecting SID Type — Safe Method](https://codebase64.net/doku.php?id=base:detecting_sid_type_-_safe_method) — SounDemon / Dag Lem — CC BY-NC-SA 4.0
- SID registers: [registers.md](registers.md)
- SID index: [INDEX.md](INDEX.md)
