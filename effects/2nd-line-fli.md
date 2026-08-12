---
type: reference
domain: effects
granularity: atomic
summary: "Forcing a bad line every second raster line, freeing cycles for twisters and rotators."
keywords: [2nd line FLI, twister, X-rotator, waving carpet, Bresenham segments]
---

## facts
- 2nd-line FLI forces `$D018` updates on every 2nd raster line (rather than every 8 lines in standard FLI); this preserves ~63 cycles per line on PAL for additional effect calculations.
- The freed cycles enable: twister effects (characters appear to rotate around a vertical axis), X-rotators (horizontal spinning), and waving carpets (undulating floor patterns).
- The data organization uses 8 half-filled charsets plus 4 screen RAM pages per bank; combined, these yield 32 unique display chunks per bank.
- Visual shape assembly uses a Bresenham line-drawing algorithm where Y = screen raster line and X = the charset segment index; varying the slope controls how curved or twisted the shape appears.

## mechanism

Standard FLI forces bad lines every raster line by setting `$D011` YSCROLL = `line mod 8`, exhausting nearly all CPU cycles. 2nd-line FLI only forces bad lines on alternate lines:

- Odd lines: `$D011` YSCROLL = `line mod 8` (forced bad line; `$D018` updated).
- Even lines: normal display; ~63 cycles free for Bresenham step and sprite writes.

The freed even-line cycles allow real-time calculation of which charset segment to display next, enabling smooth curve tracing.

## sequence

1. Pre-fill 8 half-filled charsets per bank with the source graphic split into horizontal segments.
2. Organize screen RAM into 4 pages (`$0400`, `$0C00`, `$1400`, `$1C00`) pointing into the charsets.
3. Build a Bresenham line table for the desired shape (slope = twist amount).
4. Each frame:
   - On each odd raster line: write `$D018` to select the next segment from the Bresenham table.
   - On each even raster line: advance the Bresenham X counter; optionally update sprite positions for outline/shadow.
5. Advance the Bresenham starting offset each frame to animate rotation.

## lookup

| register | role |
|---|---|
| `$D018` | Charset/screen bank pointer — updated per line |
| `$D011` bits 0–2 | YSCROLL — set to `raster mod 8` on odd lines to force bad line |
| `$D015`/`$D001`/`$D003` etc. | Sprite enables and Y positions for outline effects |

| parameter | value |
|---|---|
| Charsets per bank | 8 (half-filled) |
| Screen pages per bank | 4 |
| Unique chunks per bank | 32 |
| Free cycles per even line | ~63 PAL |

## constraints
- The 40-cycle bad-line bus takeover still applies on forced odd lines, with possible BA lead-in stall; the net gain is that every 2nd line is free, rather than no lines free as in full FLI.
- Steeper Bresenham slopes (more X advance per Y step) produce straighter shapes; flatter slopes create more twisted/bent appearance.
- Sprite register updates (outline, shadow, multicolor) must fit within the ~63 free cycles on even lines.
- Bank size is 16 KB (`$0000`–`$3FFF`); charsets and screen pages must fit within one bank.

## links

- effects: [stable-raster.md](stable-raster.md)
- effects: [swing.md](swing.md)
- effects: [fpp.md](fpp.md)
- display-modes: [../display-modes/fli.md](../display-modes/fli.md)
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)

## sources

- codebase64.net: [Twisters, X-Rotators and Waving Carpets](https://codebase64.net/doku.php?id=base:twisters_x-rotators_and_waving_carpets) — CC BY-NC-SA 4.0
- codebase64.net: [Demo Programming — 2nd Line FLI](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
