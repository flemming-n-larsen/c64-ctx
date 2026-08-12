---
type: reference
domain: sprites
granularity: atomic
summary: "Getting a sprite on screen: 64-byte alignment, pointer, position, color, enable order."
keywords: [sprite setup, sprite pointer, visible range, multicolor sprite]
---

## facts
- Sprite data is 63 bytes plus 1 unused pad byte and MUST start on a 64-byte boundary inside the active VIC bank.
- The sprite pointer for sprite `n` is stored in the last 8 bytes of screen RAM; with the default screen at `$0400`, the pointer block is `$07F8-$07FF`.
- Visible placement is not anchored at coordinate zero: for a normal-height sprite, Y=`$1E` (30 decimal) first appears partially and Y=`$32` (50 decimal) first fits fully in the standard display area; the display area begins right of the left border.
- Multicolor sprites trade horizontal resolution for extra colors: the effective pixel width becomes 12×21, using one per-sprite color plus two shared multicolor values.

## sequence
1. Place sprite data at a 64-byte-aligned address inside the active VIC bank.
2. Write the sprite pointer byte for sprite `n` to the pointer block in screen RAM.
3. Set X low, X MSB, and Y position registers.
4. Set sprite color and any shared multicolor registers needed.
5. Configure priority or stretch bits if the effect needs them.
6. Enable the sprite last via `$D015`.

## lookup
| display concern | read | notes |
|---|---|---|
| Pointer math and setup order | [../tasks/sprite-display.md](../tasks/sprite-display.md) | Core recipe for placing data, writing pointers, positions, and enable bits. |
| Visible PAL coordinates | [../concepts/screen-geometry.md](../concepts/screen-geometry.md) | First visible raster, text area, and border dimensions. |
| VIC banking and `$D018` | [../vic/memory-and-banking.md](../vic/memory-and-banking.md) | Screen relocation moves the sprite pointer block; bank choice constrains sprite data placement. |
| Sprite registers and colors | [registers.md](registers.md) | Register groups for enable, priority, multicolor, and collisions. |
| Border display behavior | [../effects/open-borders.md](../effects/open-borders.md) | Sprites are naturally visible in the border; bitmap/text pixels are not. |

### Practical placement notes
| topic | value / rule | notes |
|---|---|---|
| Sprite pointer formula | `offset_in_VIC_bank / 64` | Pointer encodes VIC-bank bits `13-6` of the sprite-data offset. |
| Default pointer block | `$07F8-$07FF` | Valid only while screen RAM is at `$0400`. |
| First partially visible normal sprite Y | `$1E` | 30 decimal; the upper border still covers part of the sprite. |
| First fully visible normal sprite Y | `$32` | 50 decimal; all 21 rows fit in the standard display area. |
| Left display edge | X=`$18` | X=`$01-$17` is partially visible; X=`$00` is fully covered by the standard border. |
| Right display edge | X=`$140` | X=`$141-$157` is partially visible; set `$D010` for these positions. |

## constraints
- Sprite data MUST avoid the character-ROM holes at `$1000-$1FFF` in bank `0` and `$9000-$9FFF` in bank `2`.
- When screen RAM is relocated, the sprite pointer block also moves to the last 8 bytes of the new screen page.
- Enabled sprites consume DMA time even when off-screen; clear unused bits in `$D015`.
- Collision checks MUST account for the read-to-clear behavior of `$D01E/$D01F`.
- Border placement and visible-area coordinates in this page are PAL-oriented; NTSC users SHOULD re-check geometry and timing locally.

## links

- sprite registers: [registers.md](registers.md)
- sprite techniques: [advanced.md](advanced.md)
- runnable example: [../examples/kickassembler-sprite.md](../examples/kickassembler-sprite.md)

## sources

- sprite hub: [INDEX.md](INDEX.md)
- sprite display task: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- screen geometry: [../concepts/screen-geometry.md](../concepts/screen-geometry.md)
- VIC memory and banking: [../vic/memory-and-banking.md](../vic/memory-and-banking.md)
- open borders: [../effects/open-borders.md](../effects/open-borders.md)
