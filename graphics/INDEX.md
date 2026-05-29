---
type: index
domain: graphics
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| All VIC-II display modes, enable bits, color sources | [screen-modes.md](screen-modes.md) | Modes 0–4 official, 5–7 illegal; memory layout per mode |
| All unofficial/advanced display techniques (names, abbreviations) | [unofficial-modes.md](unofficial-modes.md) | 31 software techniques; FLI, IFLI, NUFLI, UFLI families, etc. |
| How to create more than 16 colors (FLI, interlacing, sprites, dithering) | [../concepts/color-mixing.md](../concepts/color-mixing.md) | The 5 fundamental color-expansion techniques |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [screen-modes.md](screen-modes.md) | used | All 8 ECM/BMM/MCM combinations |
| [unofficial-modes.md](unofficial-modes.md) | used | All 31 unofficial technique names and abbreviations |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Upstream fallback route |

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/vic-ii.md](../io/vic-ii.md) | VIC-II registers `$D011`, `$D016`, `$D018` controlling mode bits |
| concepts | [../concepts/screen-memory.md](../concepts/screen-memory.md) | Screen RAM and VIC bank layout |
| concepts | [../concepts/screen-geometry.md](../concepts/screen-geometry.md) | Display dimensions and raster lines |
| concepts | [../concepts/color-mixing.md](../concepts/color-mixing.md) | Color expansion techniques: FLI, interlacing, sprite underlay, dithering |
| tasks | [../tasks/custom-charset.md](../tasks/custom-charset.md) | Charset relocation and `$D018` pointer setup |
| display-modes | [../display-modes/INDEX.md](../display-modes/INDEX.md) | Per-technique spec pages for all unofficial display modes |
| effects | [../effects/INDEX.md](../effects/INDEX.md) | Runtime demo/game visual effects |
