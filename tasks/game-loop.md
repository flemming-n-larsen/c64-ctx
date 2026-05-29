---
type: reference
domain: tasks
granularity: recipe
---

## sequence

1. **Init** — set up VIC-II mode (`$D011`, `$D016`, `$D018`), background/border colors (`$D020`/`$D021`), screen RAM contents, sprite pointers and data, color RAM, CIA1 timers (if used for input timing), and SID master volume (`$D418`). One-shot work that MUST NOT live inside the frame loop.
2. **Read input** — keyboard via KERNAL `GETIN` (`$FFE4`) or direct CIA1 matrix scan at `$DC00`/`$DC01`; joystick port 2 via `$DC00`, port 1 via `$DC01` (low bits = direction, bit 4 = fire, active low).
3. **Update game state** — move actors, advance timers, run collision logic. State SHOULD live in a fixed RAM block (e.g. `$C000-$CFFF`) so banking choices do not break it.
4. **Draw** — write screen codes to screen RAM, color indices to color RAM `$D800-$DBFF`, sprite X/Y to `$D000-$D00F` (+ MSB in `$D010`), and SID writes for sound effects. Drawing SHOULD complete within one frame's budget.
5. **Sync to frame** — either poll the raster line at `$D012` until a chosen line (e.g. wait for `$D012 = $FF` then for next non-`$FF`), or install a raster interrupt at a stable line and let the IRQ handler set a frame-tick flag the main loop waits on.
6. **Loop** — `JMP` back to step 2. State and screen are now consistent; the next frame begins.

## lookup

| need | read | notes |
|---|---|---|
| Raster line `$D012`, raster IRQ `$D019`/`$D01A` | [../io/vic-ii.md](../io/vic-ii.md) | Polling is simplest; raster IRQ gives jitter-free sync |
| Keyboard via KERNAL | [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md) | `GETIN` returns 0 if no key |
| Joystick / direct keyboard matrix | [../io/cia1.md](../io/cia1.md) | Active-low; port 2 = `$DC00`, port 1 = `$DC01` |
| Sprite setup | [sprite-display.md](sprite-display.md) | Pointer, X/Y, MSB, color, enable |
| Screen codes for tiles/text | [../charset/screen-codes.md](../charset/screen-codes.md) | Screen RAM stores screen codes, not PETSCII |
| Raster interrupt setup | [../irq/raster-interrupt.md](../irq/raster-interrupt.md) | Required for jitter-sensitive timing or multi-split frames |
| BASIC equivalent for prototyping | [../basic/examples.md](../basic/examples.md) | BASIC `WAIT 53266,128` waits for raster ≥ 256; useful sync primitive |

## constraints

- The loop body MUST fit within one PAL/NTSC frame (≈ 20 ms PAL, ≈ 17 ms NTSC) to stay at 50/60 Hz; longer frames produce visible stutter and break input cadence.
- Raster-poll sync MUST account for the raster wrapping past 256; check `$D011` bit 7 (RST8) when waiting for lines ≥ 256.
- Direct screen RAM writes during the visible portion of the frame MAY cause flicker; bulk drawing SHOULD happen during the upper border (raster ≈ `$0`-`$30` PAL) or via raster IRQ.
- Sprite enable (`$D015`) SHOULD be the last sprite-related write each frame; flipping it mid-fetch may show garbage for one line.
- Input polling MUST happen at most once per frame for stable timing; polling inside both an IRQ and the main loop causes double-reads and lost edges.
- KERNAL `GETIN` and direct matrix scan MUST NOT be mixed without disabling the KERNAL keyboard IRQ — both touch `$DC00`/`$DC01`.
- Banking choices made for screen/character data (CIA2 `$DD00`) MUST be re-asserted if any code in the loop touches CIA2 for serial bus or NMI work.

## examples

Skeleton in 6502 pseudo-code using simple raster polling (no IRQ):

```
init:
  JSR setup_vic
  JSR setup_sprites
  JSR setup_sid

frame:
  JSR read_input        ; result in zero-page state bytes
  JSR update_state
  JSR draw

  ; sync: wait for raster to leave the visible area, then for it to come back
wait_vbl_in:
  LDA $D012 : CMP #$F8 : BCC wait_vbl_in   ; wait for raster ≥ $F8
wait_vbl_out:
  LDA $D012 : CMP #$F8 : BCS wait_vbl_out  ; wait for it to wrap below $F8
  JMP frame
```

## links

- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- CIA1 ports / joystick: [../io/cia1.md](../io/cia1.md)
- KERNAL keyboard/screen: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)
- sprite display: [sprite-display.md](sprite-display.md)
- raster interrupt: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- read keyboard: [read-keyboard.md](read-keyboard.md)
- play SID: [../sid/play-note.md](../sid/play-note.md)
- task index: [INDEX.md](INDEX.md)

## sources

- local route: [../sources/INDEX.md](../sources/INDEX.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- CIA1: [../io/cia1.md](../io/cia1.md)
- raster interrupt task: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- task index: [INDEX.md](INDEX.md)
