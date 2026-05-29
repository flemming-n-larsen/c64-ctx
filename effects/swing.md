---
type: reference
domain: effects
granularity: atomic
---

## facts
- The swinging (tech-tech) effect moves a graphic horizontally in a sine wave wider than the 8-pixel hardware scroll limit of `$D016`.
- `$D016` provides only 3-bit pixel-level scroll (0–7); wider movement requires switching to a different video RAM bank where the graphic is stored pre-shifted one character column to the right.
- Multiple pre-shifted copies of the graphic are stored in successive video RAM banks; `$D018` (bits 7–4) selects which copy is displayed each line.
- Because `$D018` normally updates only on bad lines, the tech-tech must force a bad line on every raster line by manipulating `$D011` YSCROLL — the same mechanism as FLI.

## sequence

1. Pre-render `N` copies of the graphic into `N` video RAM banks, each shifted 1 character column (8 px) to the right from the previous.
2. Build a sine table of length 256 (values 0–`N-1`) representing the X-position over one oscillation cycle.
3. On each raster line within the graphic area:
   - Compute `bank_index = sine[frame_counter + line_offset]`.
   - Write `$D018` = base value for selected bank (bits 7–4 = bank pointer).
   - Write `$D016` XSCROLL = pixel offset within the 8-pixel step (bits 0–2).
   - Write `$D011` YSCROLL = `raster_line mod 8` to force a bad line (enables per-line `$D018` updates).
4. Use a stable raster IRQ chain covering each row; see [stable-raster.md](stable-raster.md).

## lookup

| register | role |
|---|---|
| `$D011` bits 0–2 | YSCROLL — set to `raster mod 8` to force bad line per line |
| `$D016` bits 0–2 | XSCROLL — pixel-level 0–7 adjustment |
| `$D018` bits 7–4 | Screen RAM / bitmap bank pointer — selects pre-shifted copy |

| parameter | typical value |
|---|---|
| Number of pre-shifted copies | 8–14 (one per character step of movement) |
| Sine amplitude (chars) | 7–14 (= copies − 1) |
| Sine table length | 256 bytes |

## constraints
- Forcing a bad line every raster line steals 40 cycles per line; total effect timing is the same as FLI; see [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md).
- Each pre-shifted copy requires one full video RAM bank (4 KB for text, 8 KB for bitmap); 14 banks = 56–112 KB — more than available RAM; the effect typically targets a small graphic region, not the full screen.
- `$D018` changes take effect at the following bad line; writing it exactly at the start of each bad line (YSCROLL manipulation) is required.
- The FLI bug (first column artifact at the left side of the screen) applies; mask it with sprites or keep the logo away from column 0.

## links
- effects: [stable-raster.md](stable-raster.md)
- effects: [fld.md](fld.md)
- effects: [dycp.md](dycp.md)
- tasks: [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)

## sources
- codebase64.net: [Demo Programming — Swinging and Tech-Tech](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- codebase64.net: [TechTech (using FLI routine)](https://codebase64.net/doku.php?id=base:techtech_fli) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
