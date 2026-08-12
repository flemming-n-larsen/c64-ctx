---
type: reference
domain: display-modes
granularity: atomic
summary: "Extended colors with interlace: ECM plus frame alternation for doubled background colors."
keywords: [ECI, extended color interlace, frame alternation]
---

## facts
- ECI (Extended Colors with Interlace) uses ECM (Extended Color Mode, `$D011` bit 6 = 1) combined with frame interlacing.
- ECM provides 4 selectable background colors (`$D021`–`$D024`) chosen by bits 7-6 of each screen code; only 64 unique character glyphs are available.
- Interlace: frame A and frame B use different values in `$D021`–`$D024`, doubling the effective background color choices per cell (8 perceived backgrounds instead of 4).
- Foreground color (1-pixels) comes from color RAM; can also be changed per raster line for color banding.
- ECI was developed in June 1988, making it one of the earliest unofficial techniques.

## sequence

1. Enable ECM: `$D011` bit 6 = 1 → `$D011` = `$5B` (ECM=1, BMM=0, MCM=0, DEN=1, RSEL=1, YSCROLL=3).
2. Set `$D016` = `$C8` (normal character mode, 40 columns).
3. Configure screen RAM with character codes 0–63 (bits 7-6 select background register; bits 5-0 = glyph index).
4. Set color RAM for foreground per cell.
5. Set frame A background registers: `$D021`–`$D024` = four colors for frame A.
6. Set up frame alternation raster IRQ at line `$00`:
   - Frame A (even): keep `$D021`–`$D024` as set in step 5.
   - Frame B (odd): write new values to `$D021`–`$D024` before the display starts.
7. Optionally add per-raster-line `$D021`–`$D024` writes for color banding on top of the frame alternation.

## lookup

| register | ECM bit | description |
|---|---|---|
| `$D011` bit 6 | `ECM=1` | enable extended color mode |
| `$D021` | BG color 0 | used when char code bits 7-6 = `00` |
| `$D022` | BG color 1 | used when char code bits 7-6 = `01` |
| `$D023` | BG color 2 | used when char code bits 7-6 = `10` |
| `$D024` | BG color 3 | used when char code bits 7-6 = `11` |

### Screen code structure in ECM

| bits 7-6 | bits 5-0 | background | glyph |
|:---:|:---:|---|---|
| `00` | 0–63 | `$D021` | glyph 0–63 |
| `01` | 0–63 | `$D022` | glyph 0–63 |
| `10` | 0–63 | `$D023` | glyph 0–63 |
| `11` | 0–63 | `$D024` | glyph 0–63 |

## constraints
- ECM restricts character set to 64 glyphs; a full custom font MUST fit within 64 characters (512 bytes).
- Interlace flicker applies as with IFLI; see [ifli.md](ifli.md) for flicker notes.
- `$D021`–`$D024` writes for frame B MUST happen before raster line `$33` (first display line); writing mid-frame produces partial-frame color switch.
- ECM cannot be combined with BMM (`$D011` bit 5); ECM+BMM = illegal mode (blank screen).

## sources

- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- effects: [ifli.md](ifli.md)
- graphics: [../graphics/screen-modes.md](../graphics/screen-modes.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
