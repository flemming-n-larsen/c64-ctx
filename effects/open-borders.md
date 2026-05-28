---
type: reference
domain: effects
granularity: atomic
---

## facts
- The C64 border is drawn by the VIC-II whenever the display enable bit or column/row mode forces it.
- Top and bottom borders are removed by switching between 25-line and 24-line mode at precise raster positions using `$D011`.
- Side borders are removed by switching between 40-column and 38-column mode at precise horizontal positions using `$D016`.
- Both tricks require raster interrupt precision; see [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md) for IRQ setup.

## sequence — top/bottom border removal

1. Set up raster IRQ at line `$00` (before top border ends); see `raster-interrupt.md`.
2. In the first IRQ handler: write `$D011 = $00` (24-line mode, display off for one line). This causes VIC-II to skip setting the bottom border flag.
3. Immediately chain a second IRQ at raster `$FA` (last text line).
4. In the second IRQ handler: write `$D011 = $1B` (25-line mode, display on). This restores normal display and closes the bottom border.
5. Chain back to the first handler for the next frame.

## sequence — side border removal

1. Inside a cycle-exact raster IRQ (use stable raster; see [stable-raster.md](stable-raster.md)):
2. Switch `$D016` from `$C8` (40-col) to `$C0` (38-col) at the right horizontal cycle to suppress the side border trigger.
3. Switch `$D016` back to `$C8` within the same line before the display area begins.
4. Repeat every raster line where side borders should be open.

## lookup
| register | value | effect |
|---|---|---|
| `$D011` | `$1B` | 25-line mode, display on (normal) |
| `$D011` | `$00` | 24-line mode, display off (opens top/bottom border) |
| `$D016` | `$C8` | 40-column mode (normal) |
| `$D016` | `$C0` | 38-column mode (opens side borders when switched at right cycle) |
| `$D012` | `$00` | Raster line trigger for first IRQ |
| `$D012` | `$FA` | Raster line trigger for second IRQ (restore display) |

## constraints
- Timing MUST be cycle-exact for side border removal; imprecise timing produces artifacts.
- Top/bottom trick requires two chained raster IRQs per frame.
- Side border removal requires switching `$D016` back within the same raster line — any delay opens only part of the border.
- `$D011` bit 7 is raster line 8 (MSB); writes to `$D011` affect raster comparison — account for this when chaining IRQs.
- NTSC timing differs (65 cycles/line vs PAL 63); side border cycle positions must be adjusted.
- These are PAL-measured values; verify on NTSC hardware or emulator with correct chip model.

## links
- tasks: [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md)
- effects: [stable-raster.md](stable-raster.md)
- effects: [rasterbars.md](rasterbars.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- concepts: [../concepts/screen-geometry.md](../concepts/screen-geometry.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)

## sources
- codebase64.net: [Opening the Top and Bottom Borders](https://codebase64.net/doku.php?id=vic:opening_the_top_bottom_borders) — CC BY-NC-SA 4.0
- codebase64.net: [Opening Up the Borders — A Further Explanation](https://codebase64.net/doku.php?id=vic:opening_up_the_borders_-_a_further_explanation) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
