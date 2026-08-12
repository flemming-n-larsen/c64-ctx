---
type: reference
domain: display-modes
granularity: atomic
summary: "Alternating sprite sieve interlace: a sprite grid toggled between frames to mix colors."
keywords: [ASSLACE, sprite sieve, alternating frames, interlace]
---

## facts
- ASSLACE (Alternating Sprite Sieve (Inter)lace) creates a color-mixing illusion by alternating two frames where a sprite grid acts as a "sieve" — in frame A the sprites are visible over the display, in frame B they are not (or vice versa) — so the eye sees a blend of the background and the sprite layer.
- The "sieve" pattern: sprites positioned as a regular grid of dots or stripes create a dithering mask; with frame alternation the masked and unmasked frames blend into a perceived intermediate color.
- Sprites are placed in FRONT of the display (`$D01B` priority bits clear) for the sieve effect, unlike sprite underlay modes.
- Introduced April 2004.

## sequence

1. Set a sprite pattern as a sieve (e.g., alternating columns or a checkerboard of sprite pixels).
2. Frame A: enable sprites (`$D015` = sieve bitmask); sprites show as sieve over the display.
3. Frame B: disable sprites (`$D015` = `$00`) or shift sprite pattern to complement frame A.
4. Frame alternation: toggle frame state at raster line `$00` each PAL frame.
5. The eye blends the sieve-on and sieve-off frames into a perceived mixed color.

## lookup

| register | frame A | frame B | effect |
|---|---|---|---|
| `$D015` | `$FF` (sprites on) | `$00` (sprites off) | sieve alternation |
| `$D01B` | `$00` (sprites in front) | — | sprites occlude display |

## constraints
- The blended color is the average of the sprite color and the underlying display color; the exact perceptual blend depends on the sieve density (percentage of pixels covered by sprites).
- Flicker at 25 fps per sub-frame (PAL); visible on CRT.
- Only 8 hardware sprites; achieving a fine-grained sieve pattern requires careful sprite positioning and pixel design.
- This technique is primarily artistic / used for specific visual effects; not a general-purpose high-color mode.

## links
- effects: [ifli.md](ifli.md)
- effects: [mucsu.md](mucsu.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- tasks: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources
- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
