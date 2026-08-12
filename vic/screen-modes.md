---
type: reference
domain: vic
granularity: atomic
summary: "Which ECM/BMM/MCM bit combination selects each hardware display mode."
keywords: [screen modes, mode bits, bitmap mode, multicolor, hires]
---

## facts
- VIC-II hardware display mode is selected by the ECM/BMM/MCM bit combination in `$D011` and `$D016`.
- Five official visible modes are routinely used: standard character, multicolor character, standard bitmap, multicolor bitmap, and ECM.
- Unofficial names such as `FLI`, `IFLI`, `UFLI`, `NUFLI`, and `PRS` describe software timing techniques, not extra hardware mode bits.
- Sprite underlay, interlace, and per-line `$D018` changes are the main bridges from official hardware modes into advanced display techniques.

## lookup
| family | route | notes |
|---|---|---|
| Official hardware modes | [../graphics/screen-modes.md](../graphics/screen-modes.md) | ECM/BMM/MCM combinations, memory layout, and color sources. |
| ECM deep dive | [../display-modes/ecm.md](../display-modes/ecm.md) | Dedicated route for the official extended color mode and its charset trade-offs. |
| Unofficial mode families | [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md) | Names, abbreviations, and the core technique behind each family. |
| Per-technique specs | [../display-modes/INDEX.md](../display-modes/INDEX.md) | Detailed pages for FLI, IFLI, NUFLI, UFLI, MUFLI, PRS, and others. |
| Color-expansion ideas | [../concepts/color-mixing.md](../concepts/color-mixing.md) | FLI, interlace, sprite underlay, and dithering as reusable ideas. |

### Hardware mode quick map
| mode family | bits | main route | notes |
|---|---|---|---|
| Standard character | ECM=0, BMM=0, MCM=0 | [../graphics/screen-modes.md](../graphics/screen-modes.md) | Default text/character display. |
| Multicolor character | ECM=0, BMM=0, MCM=1 | [../graphics/screen-modes.md](../graphics/screen-modes.md) | Per-cell mix of hires and multicolor via color RAM bit `3`. |
| Standard / multicolor bitmap | BMM=1 with MCM `0` or `1` | [../graphics/screen-modes.md](../graphics/screen-modes.md) | Bitmap base depends on `$D018` bit `3`. |
| Extended color mode | ECM=1, BMM=0, MCM=0 | [../display-modes/ecm.md](../display-modes/ecm.md) | `64` glyphs, 4 background colors, dedicated ECM route. |
| FLI / interlace / underlay families | raster-timed software technique | [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md) | Built on top of the official modes plus raster precision. |

## constraints
- Mode changes SHOULD preserve non-mode bits in `$D011` and `$D016`, especially scroll bits and display-enable state.
- Bitmap and character/bitmap-base explanations MUST include both `$D018` and CIA2 bank context.
- FLI-family techniques MUST budget for bad lines and per-line `$D018` updates.
- Sprite underlay techniques MUST also consider sprite priority, sprite colors, and shared multicolor sprite registers.

## links

- register summary: [registers.md](registers.md)
- memory and banking: [memory-and-banking.md](memory-and-banking.md)
- timing: [timing.md](timing.md)
- display-modes index: [../display-modes/INDEX.md](../display-modes/INDEX.md)

## sources

- VIC hub: [INDEX.md](INDEX.md)
- official screen modes: [../graphics/screen-modes.md](../graphics/screen-modes.md)
- ECM route: [../display-modes/ecm.md](../display-modes/ecm.md)
- unofficial modes: [../graphics/unofficial-modes.md](../graphics/unofficial-modes.md)
- color mixing: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- VIC-II register reference: [../io/vic-ii.md](../io/vic-ii.md)
