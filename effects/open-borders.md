---
type: reference
domain: effects
granularity: atomic
summary: "Remove the top, bottom, or side borders, with timing and sprite-placement constraints."
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

The active screen border has priority over sprites, and `$D01B` does not change that. Sprite pixels in a border region are masked while that border is closed. Opening the relevant border reveals those pixels only where the VIC-II is still producing visible video rather than horizontal or vertical blanking.

The following ranges assume the standard 40-column, 25-row display window: X=`$18-$157` and raster lines `$33-$FA`. For a normal-height sprite at X≤`$164`, the first sprite row is displayed on the raster line after the value in its Y register. A sprite positioned to the right of `$164` can start on the matching raster because its X position has not yet passed when sprite display is enabled; such far-right placement needs separate cycle-level treatment.

| border region | normal-height sprite placement | relation to the standard display window |
|---|---|---|
| Top border | Y=`$1E-$31` | The sprite overlaps the top border and the display window; Y=`$00-$1D` is fully above the display window. |
| Bottom border | Y=`$E6-$F9` | The sprite overlaps the display window and bottom border; Y=`$FA` is the first position fully below the display window. |
| Left border | X=`$01-$17` | The sprite overlaps the left border and display window; X=`$00` is fully left of the display window. |
| Right border | X=`$141-$157` | The sprite overlaps the display window and right border; X=`$158` is the first position fully right of the display window. Set the corresponding `$D010` bit. |

For side border sprite placement: `$D010` bit n = 1 when sprite n X coordinate ≥ 256; combine low byte in `$D000+n×2`. See [../tasks/sprite-display.md](../tasks/sprite-display.md) for full sprite X setup.

### PAL and NTSC differences

- The standard display-window coordinates above are common VIC-II coordinates; they do not by themselves describe how much opened border is visible in the output signal.
- Codebase64's PAL monitor measurements call raster `$08` the earliest line known to be displayed by any monitor, which maps to sprite Y=`$07`. This is a best-case PAL extent, not a line guaranteed visible on every monitor or capture device.
- PAL 6569/8565 has 312 raster lines. Because sprite Y is only 8 bits, Y=`$00-$37` can match once at the top of the frame and again on raster lines 256–311. A low-Y top-border sprite can therefore reappear near the bottom unless it is disabled or repositioned before the second match.
- Common NTSC variants have only 262 or 263 raster lines, so only Y=`$00-$05` or `$00-$06` can match a second time. Conversely, a sprite beginning near Y=`$FA` reaches the end of an NTSC frame before all 21 rows can be generated; PAL has enough raster lines for the full normal-height sprite.
- Horizontal and vertical blanking, and therefore the amount of an opened border that a monitor or capture device can show, differs by VIC-II variant. Border-opening code and claimed visible extents MUST be verified for the target chip; PAL timing is the normal baseline for scene demos in this repository.

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
- VIC-II variants: [../vic/variants.md](../vic/variants.md)

## sources

- codebase64.net: [Opening the Top and Bottom Borders](https://codebase64.net/doku.php?id=vic:opening_the_top_bottom_borders) — CC BY-NC-SA 4.0
- codebase64.net: [Opening Up the Borders — A Further Explanation](https://codebase64.net/doku.php?id=vic:opening_up_the_borders_-_a_further_explanation) — CC BY-NC-SA 4.0
- codebase64.net: [Visible Area](https://codebase64.net/doku.php?id=vic:visible_area) — PAL monitor-visible extent and sprite Y=`$07`
- Codebase64: [Sprite Introduction](https://codebase.c64.org/doku.php?id=base:spriteintro) — priority and border layering
- Christian Bauer: [The MOS 6567/6569 video controller (VIC-II) and its application in the Commodore 64](https://pc.sux.org/files/vic-article_html_engl_vic_article_1.pdf) — display-window coordinates, border priority, sprite Y timing, and VIC-II variant geometry
