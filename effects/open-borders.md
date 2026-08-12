---
type: reference
domain: effects
granularity: atomic
summary: "Remove the top, bottom or side borders, and put sprites out there."
keywords: [open borders, border removal, side border, sprites in border]
---

## facts
- The C64 border is drawn by the VIC-II whenever the display enable bit or column/row mode forces it.
- Top and bottom borders are removed by switching between 25-line and 24-line mode at precise raster positions using `$D011`.
- Side borders are removed by switching between 40-column and 38-column mode at precise horizontal positions using `$D016`.
- Both tricks require raster interrupt precision; see [../irq/raster-interrupt.md](../irq/raster-interrupt.md) for IRQ setup.

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

## sprites in border regions

Sprites always render over the border color regardless of the `$D01B` priority bit — no open-border trick is required to show sprites in border areas. The open-border trick is needed only to show display-area content (bitmap/text pixels) in the border.

| border region | what to do | notes |
|---|---|---|
| Top border | Set sprite Y < `$33` | Sprites visible above display area naturally |
| Bottom border | Set sprite Y > `$FA` | Sprites visible below display area naturally |
| Left border | Set sprite X < `$18` | Low X positions place sprite in left border column |
| Right border | Set sprite X > `$157` (9-bit) | Set MSB in `$D010`; sprite appears in right border |

For side border sprite placement: `$D010` bit n = 1 when sprite n X coordinate ≥ 256; combine low byte in `$D000+n×2`. See [../tasks/sprite-display.md](../tasks/sprite-display.md) for full sprite X setup.

NUFLI and UFLI use sprite underlay across the full display width; the 6 NUFLI underlay sprites naturally extend near the left border (starting at ~X=56) but the FLI bug columns (0–3) remain uncovered. To extend sprites into the very left edge of the side border while simultaneously opening it: apply the side-border trick on the same raster lines as the sprite positions.

## constraints
- Timing MUST be cycle-exact for side border removal; imprecise timing produces artifacts.
- Top/bottom trick requires two chained raster IRQs per frame.
- Side border removal requires switching `$D016` back within the same raster line — any delay opens only part of the border.
- `$D011` bit 7 is raster line 8 (MSB); writes to `$D011` affect raster comparison — account for this when chaining IRQs.
- NTSC timing differs (65 cycles/line vs PAL 63); side border cycle positions must be adjusted.
- These are PAL-measured values; verify on NTSC hardware or emulator with correct chip model.

## links
- sprites: [../sprites/INDEX.md](../sprites/INDEX.md)
- sprite display: [../sprites/display.md](../sprites/display.md)
- sprite techniques: [../sprites/advanced.md](../sprites/advanced.md)
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- effects: [stable-raster.md](stable-raster.md)
- effects: [rasterbars.md](rasterbars.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- concepts: [../concepts/screen-geometry.md](../concepts/screen-geometry.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)

## sources
- codebase64.net: [Opening the Top and Bottom Borders](https://codebase64.net/doku.php?id=vic:opening_the_top_bottom_borders) — CC BY-NC-SA 4.0
- codebase64.net: [Opening Up the Borders — A Further Explanation](https://codebase64.net/doku.php?id=vic:opening_up_the_borders_-_a_further_explanation) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
