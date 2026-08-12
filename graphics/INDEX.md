---
type: index
domain: graphics
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| VIC mode overview with banking/timing context | [../vic/screen-modes.md](../vic/screen-modes.md) | VIC-first route into official and unofficial screen-mode material. |
| All VIC-II display modes, enable bits, color sources | [screen-modes.md](screen-modes.md) | Modes 0–4 official, 5–7 illegal; memory layout per mode |
| Extended color mode deep dive | [../display-modes/ecm.md](../display-modes/ecm.md) | Standalone ECM page with charset limits, background selection, and ECI handoff. |
| All unofficial/advanced display techniques (names, abbreviations) | [unofficial-modes.md](unofficial-modes.md) | 31 software techniques; FLI, IFLI, NUFLI, UFLI families, etc. |
| Sprite-underlay display techniques | [../sprites/advanced.md](../sprites/advanced.md) | Routes to UFLI/NUFLI/MUFLI and other sprite-heavy techniques. |
| How to create more than 16 colors (FLI, interlacing, sprites, dithering) | [../concepts/color-mixing.md](../concepts/color-mixing.md) | Fundamental color-expansion techniques |

## pages
<!-- GENERATED:routes -->
_Every page in this domain is reached from `## routes` above._
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/vic-ii.md](../io/vic-ii.md) | VIC-II registers `$D011`, `$D016`, `$D018` controlling mode bits |
| VIC | [../vic/INDEX.md](../vic/INDEX.md) | Curated VIC-II discovery hub tying graphics back to timing and banking. |
| sprites | [../sprites/INDEX.md](../sprites/INDEX.md) | Sprite underlay and sprite-color expansion routes. |
| concepts | [../concepts/screen-memory.md](../concepts/screen-memory.md) | Screen RAM and VIC bank layout |
| concepts | [../concepts/screen-geometry.md](../concepts/screen-geometry.md) | Display dimensions and raster lines |
| concepts | [../concepts/color-mixing.md](../concepts/color-mixing.md) | Color expansion techniques: FLI, interlacing, sprite underlay, dithering |
| tasks | [../tasks/custom-charset.md](../tasks/custom-charset.md) | Charset relocation and `$D018` pointer setup |
| display-modes | [../display-modes/INDEX.md](../display-modes/INDEX.md) | Per-technique spec pages for all unofficial display modes |
| effects | [../effects/INDEX.md](../effects/INDEX.md) | Runtime demo/game visual effects |
