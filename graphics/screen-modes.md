---
type: reference
domain: graphics
granularity: atomic
summary: "All eight ECM/BMM/MCM bit combinations: enable bits, memory layout, color source per mode."
keywords: [screen modes, bitmap mode, multicolor, hires, extended color mode]
---

## lookup

### Mode summary

| # | name | ECM | BMM | MCM | resolution | colors/cell | notes |
|:---:|---|:---:|:---:|:---:|---|:---:|---|
| 0 | Standard Character | 0 | 0 | 0 | 320×200 (40×25 chars) | 2 | default power-on mode |
| 1 | Multicolor Character | 0 | 0 | 1 | 160×200 (40×25 chars) | 2 or 4 | per-char flag in color RAM bit 3 |
| 2 | Standard Bitmap | 0 | 1 | 0 | 320×200 bitmap | 2 | 2 colors per 8×8 cell |
| 3 | Multicolor Bitmap | 0 | 1 | 1 | 160×200 bitmap | 4 | 4 colors per 8×8 cell |
| 4 | Extended BG Color | 1 | 0 | 0 | 320×200 (40×25 chars) | 2 fg + 4 bg | only 64 unique glyphs |
| 5 | (illegal) | 1 | 0 | 1 | — | — | blank output |
| 6 | (illegal) | 1 | 1 | 0 | — | — | blank/garbled output |
| 7 | (illegal) | 1 | 1 | 1 | — | — | blank/garbled output |

ECM = `$D011` bit 6; BMM = `$D011` bit 5; MCM = `$D016` bit 4.

### Enable register writes

| mode | `$D011` write | `$D016` write | effect |
|:---:|---|---|---|
| 0 SCM | clear bit 6 (ECM=0), clear bit 5 (BMM=0) | clear bit 4 (MCM=0) | standard character display |
| 1 MCCM | clear bits 6,5 | set bit 4 (MCM=1) | multicolor character display |
| 2 SBM | clear bit 6, set bit 5 (BMM=1) | clear bit 4 | hires bitmap |
| 3 MCBM | clear bit 6, set bit 5 | set bit 4 | multicolor bitmap |
| 4 ECM | set bit 6 (ECM=1), clear bit 5 | clear bit 4 | extended background color |
| 5–7 | ECM=1 with BMM or MCM set | — | avoid — no visible output |

Modify only the mode bits; preserve `YSCROLL` (bits 2-0) and `DEN`/`RSEL`/`RST8` in `$D011`, and `XSCROLL`/`CSEL` in `$D016`.

### Memory layout per mode

| mode | screen RAM role | color RAM `$D800` role | char/bitmap base | data size |
|:---:|---|---|---|---|
| 0 SCM | character codes (1 byte/cell) | foreground color (nibble, bits 3-0) | `$D018` bits 3-1 × `$0800` | 1000 screen + 1000 color bytes |
| 1 MCCM | character codes (1 byte/cell) | bit 3 = multicolor flag; bits 2-0 = color 11 | `$D018` bits 3-1 × `$0800` | 1000 screen + 1000 color bytes |
| 2 SBM | color pair per cell: bits 7-4 = fg, bits 3-0 = bg | unused in standard SBM | `$D018` bit 3 (0=`$0000`, 1=`$2000` in bank) | 8000 bitmap + 1000 screen bytes |
| 3 MCBM | color 01 (high nibble) and color 10 (low nibble) per cell | color 11 (nibble, bits 3-0) per cell | `$D018` bit 3 (0=`$0000`, 1=`$2000` in bank) | 8000 bitmap + 1000 screen + 1000 color bytes |
| 4 ECM | char code bits 7-6 select BG register; bits 5-0 = glyph index (0–63) | foreground color (nibble, bits 3-0) | `$D018` bits 3-1 × `$0800` | 1000 screen + 1000 color bytes |

Screen RAM base = `$D018` bits 7-4 × `$0400` within VIC bank. All addresses are relative to the active VIC bank set via CIA2 `$DD00` bits 1-0 (inverted).

### Color sources per mode

#### Mode 0 — Standard Character (SCM)
| pixel value | color source |
|---|---|
| 0 (background) | `$D021` background color 0 |
| 1 (foreground) | color RAM `$D800+cell` bits 3-0 |

#### Mode 1 — Multicolor Character (MCCM)
- Character cells where color RAM bit 3 = 0: behave exactly as mode 0 (2 colors, full 8-px resolution).
- Character cells where color RAM bit 3 = 1: 4 colors, 2-px-wide pixel pairs.

| pixel bits | color source |
|---|---|
| `00` | `$D021` background color 0 |
| `01` | `$D022` background color 1 |
| `10` | `$D023` background color 2 |
| `11` | color RAM `$D800+cell` bits 2-0 |

#### Mode 2 — Standard Bitmap (SBM)
| pixel value | color source |
|---|---|
| 0 | screen RAM byte bits 3-0 (per 8×8 cell) |
| 1 | screen RAM byte bits 7-4 (per 8×8 cell) |

#### Mode 3 — Multicolor Bitmap (MCBM)
| pixel bits | color source |
|---|---|
| `00` | `$D021` background color 0 |
| `01` | screen RAM byte bits 7-4 (per 8×8 cell) |
| `10` | screen RAM byte bits 3-0 (per 8×8 cell) |
| `11` | color RAM `$D800+cell` bits 3-0 |

#### Mode 4 — Extended Background Color (ECM)
| pixel value | color source |
|---|---|
| 0 (background) | `$D021`–`$D024` selected by screen code bits 7-6 |
| 1 (foreground) | color RAM `$D800+cell` bits 3-0 |

Screen code bits 7-6 → BG register: `00`=`$D021`, `01`=`$D022`, `10`=`$D023`, `11`=`$D024`. Glyph ROM/RAM index = bits 5-0 (64 unique glyphs only).

#### Modes 5–7 — Illegal
- VIC-II produces no valid video signal; screen appears black or garbled.
- Occasionally used by demos to blank the display during raster effects.

## constraints
- `$D016` bit 5 MUST be written as 0 when modifying `$D016`; see `io/vic-ii.md`.
- In bitmap modes (2, 3), `$D018` bits 2-1 are ignored; only bit 3 selects the bitmap base address.
- Mode 1 per-character switching (color RAM bit 3) allows mixing high-res and multicolor chars on the same screen.
- ECM (mode 4) reduces the character set to 64 glyphs; bit patterns 64–255 in screen RAM select the same glyphs with different background colors.
- VIC bank base from CIA2 `$DD00` MUST be applied to all `$D018`-derived addresses.
- Screen RAM and bitmap data MUST NOT overlap; plan VIC bank layout to avoid collisions.

## sources

- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes)
- local VIC-II register reference: [../io/vic-ii.md](../io/vic-ii.md)
- VIC hub: [../vic/INDEX.md](../vic/INDEX.md)
- VIC screen modes: [../vic/screen-modes.md](../vic/screen-modes.md)
- standalone ECM route: [../display-modes/ecm.md](../display-modes/ecm.md)
- unofficial modes: [unofficial-modes.md](unofficial-modes.md)
- color mixing concept: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- Screen RAM layout: [../concepts/screen-memory.md](../concepts/screen-memory.md)
- Screen geometry: [../concepts/screen-geometry.md](../concepts/screen-geometry.md)
- VIC bank select: [../io/cia2.md](../io/cia2.md)
- Color palette: [../colors/palette.md](../colors/palette.md)
- Custom charset task: [../tasks/custom-charset.md](../tasks/custom-charset.md)
- Sprite display: [../tasks/sprite-display.md](../tasks/sprite-display.md)
