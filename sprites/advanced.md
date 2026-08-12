---
type: reference
domain: sprites
granularity: atomic
summary: "Runtime sprite techniques combining raster IRQ timing with per-line register updates."
keywords: [DYSP, multiplexer, sprite stretching, sprite underlay, border sprites]
---

## facts
- Advanced sprite work usually combines raster IRQ timing with dynamic register updates rather than introducing new sprite hardware.
- DYSP changes sprite Y positions mid-frame; multiplexers recycle the 8 hardware sprites to cover more logical objects.
- Sprites remain visible in the border without opening it, which makes them useful for border decoration and underlay techniques.
- Several display modes use sprites as a color-underlay layer behind bitmap content, especially `UFLI`, `NUFLI`, and `MUFLI` families.

## lookup
| technique | read | notes |
|---|---|---|
| Dynamic Y-position sprites | [../effects/dysp.md](../effects/dysp.md) | Mid-frame Y updates and sprite stretching. |
| Sprite multiplexer | [../effects/sprite-multiplexer.md](../effects/sprite-multiplexer.md) | Recycle hardware slots with raster IRQ handoffs. |
| Border usage and border-opening interaction | [../effects/open-borders.md](../effects/open-borders.md) | Sprites already cross the border; opening is mainly for bitmap/text pixels. |
| Sprite-based starfields | [../effects/starfield.md](../effects/starfield.md) | Uses sprites as moving star objects; trades sprite slots for flexibility. |
| Sprite underlay display modes | [../display-modes/ufli.md](../display-modes/ufli.md), [../display-modes/nufli.md](../display-modes/nufli.md), [../display-modes/mufli.md](../display-modes/mufli.md) | Sprite layers used for extra colors behind bitmap/FLI content. |

## constraints
- Most advanced sprite effects SHOULD be paired with stable raster timing and explicit bad-line budgeting.
- Multiplexers MUST treat `$D010` and shared color registers as cross-sprite state, not slot-local state.
- Border techniques that combine sprite motion with open borders MUST keep sprite placement and border-switch timing separate in reasoning.
- Underlay techniques MUST also track sprite priority (`$D01B`) and any per-line sprite-stretch updates.

## links
- sprite hub: [INDEX.md](INDEX.md)
- sprite registers: [registers.md](registers.md)
- sprite display basics: [display.md](display.md)
- VIC timing: [../vic/timing.md](../vic/timing.md)
- DYSP: [../effects/dysp.md](../effects/dysp.md)
- sprite multiplexer: [../effects/sprite-multiplexer.md](../effects/sprite-multiplexer.md)
- open borders: [../effects/open-borders.md](../effects/open-borders.md)
- starfield: [../effects/starfield.md](../effects/starfield.md)
- display-modes index: [../display-modes/INDEX.md](../display-modes/INDEX.md)

## sources
- sprite hub: [INDEX.md](INDEX.md)
- DYSP: [../effects/dysp.md](../effects/dysp.md)
- sprite multiplexer: [../effects/sprite-multiplexer.md](../effects/sprite-multiplexer.md)
- open borders: [../effects/open-borders.md](../effects/open-borders.md)
- starfield: [../effects/starfield.md](../effects/starfield.md)
- sprite underlay modes: [../display-modes/ufli.md](../display-modes/ufli.md), [../display-modes/nufli.md](../display-modes/nufli.md), [../display-modes/mufli.md](../display-modes/mufli.md)
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
