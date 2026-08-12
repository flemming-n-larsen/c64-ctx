---
type: reference
domain: sprites
granularity: atomic
summary: "Sprite register families: position, enable, color, expand, priority, collision."
keywords: [sprite registers, collision, priority, expansion, X MSB]
---

## facts
- Each sprite uses paired position registers in `$D000-$D00F`: even addresses hold X low bytes and odd addresses hold Y positions.
- Shared sprite control uses bitmap registers where bit `n` controls sprite `n`: `$D010`, `$D015`, `$D017`, `$D01B`, `$D01C`, and `$D01D`.
- Sprite collisions are latched in `$D01E` and `$D01F`; both registers clear on read.
- Sprite colors use one per-sprite register (`$D027-$D02E`) plus two shared multicolor registers (`$D025`, `$D026`).

## lookup
| sprite concern | registers | use |
|---|---|---|
| X / Y coordinates | `$D000-$D00F` | X low bytes and Y bytes for sprites `0-7`. |
| X high bits | `$D010` | Bit `n` extends sprite `n` X from 8 to 9 bits. |
| Enable / disable | `$D015` | Bit `n` shows or hides sprite `n`. |
| Stretching | `$D017`, `$D01D` | Double height and double width bitmaps. |
| Priority and multicolor | `$D01B`, `$D01C` | Foreground/background priority and multicolor enable per sprite. |
| Collision latches | `$D01E`, `$D01F` | Sprite-sprite and sprite-background collision status. |
| Shared multicolor values | `$D025`, `$D026` | Sprite multicolor color `2` and color `3`, shared by all multicolor sprites. |
| Per-sprite colors | `$D027-$D02E` | Sprite color `1` for each sprite, or the only visible color in hires sprite mode. |

## constraints
- X positions above `255` MUST update both the low-byte register and the matching bit in `$D010`.
- Collision latches in `$D01E` and `$D01F` MUST be saved immediately after reading, because the read clears them.
- Priority in `$D01B` affects sprite-vs-bitmap/text ordering only; it does not override the active screen border, which has higher priority.
- Multicolor sprites require the sprite's `$D01C` bit plus the shared colors in `$D025/$D026`.
- Enable bits in `$D015` SHOULD be written after pointer, position, and color setup to avoid one-frame garbage.

## links

- sprite display: [display.md](display.md)
- sprite techniques: [advanced.md](advanced.md)
- VIC hub: [../vic/INDEX.md](../vic/INDEX.md)

## sources

- sprite hub: [INDEX.md](INDEX.md)
- VIC-II register reference: [../io/vic-ii.md](../io/vic-ii.md)
- sprite display task: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- Codebase64: [Sprite Introduction](https://codebase.c64.org/doku.php?id=base:spriteintro)
