---
type: reference
domain: tasks
granularity: recipe
summary: "Six-step sprite setup: data alignment, pointer, position, color, enable last."
keywords: [sprite setup, sprite pointer, 64-byte alignment, enable sprite]
---

## sequence

1. **Place sprite data** — write 63 bytes of pixel data at a 64-byte-aligned address within the VIC bank (3 bytes × 21 rows; the 64th byte is unused). Avoid the character ROM holes: `$1000-$1FFF` in bank 0, `$9000-$9FFF` in bank 2.
2. **Write the sprite pointer** — store `(data_offset_in_VIC_bank ÷ 64)` at `$07F8+n` (pointer block for sprite `n`). Default screen at `$0400` puts pointers at `$07F8-$07FF`.
3. **Set X position** — write low byte of X to `$D000+2n`; if X ≥ 256, also set bit `n` in `$D010`.
4. **Set Y position** — write Y coordinate to `$D001+2n`.
5. **Set sprite color** — write color index 0-15 to `$D027+n`.
6. **Enable the sprite** — set bit `n` in `$D015`; do this last so no partial state is displayed on the first visible frame.

## lookup

| need | read | notes |
|---|---|---|
| X/Y registers `$D000-$D00F`, X MSB `$D010` | [../io/vic-ii.md](../io/vic-ii.md) | 9-bit X: low byte + bit n of `$D010` |
| Enable `$D015`, priority `$D01B`, expand `$D017`/`$D01D` | [../io/vic-ii.md](../io/vic-ii.md) | All are bitmaps: bit n controls sprite n |
| Colors `$D027-$D02E`, multicolor `$D01C`/`$D025`/`$D026` | [../io/vic-ii.md](../io/vic-ii.md) | Hi-res: one color per sprite; multicolor adds two shared colors |
| Sprite pointer base and screen RAM layout | [../memory/map.md](../memory/map.md) | Default `$07F8-$07FF`; shifts with screen relocation via `$D018` |
| VIC bank select and character ROM holes | [../io/cia2.md](../io/cia2.md) | Bank via `$DD00`; ROM visible to VIC at `$1000-$1FFF` (bank 0) and `$9000-$9FFF` (bank 2) |
| Memory pointers register `$D018` | [../io/vic-ii.md](../io/vic-ii.md) | Relocating screen RAM moves the sprite pointer block with it |

## constraints

- Sprite data MUST start at a 64-byte-aligned address within the active VIC bank; the pointer byte encodes bits 13-6 of the offset — bits 5-0 are always zero.
- Data MUST NOT be placed at the character ROM holes (`$1000-$1FFF` in bank 0, `$9000-$9FFF` in bank 2); VIC-II reads ROM there regardless of RAM content.
- The sprite pointer address `$07F8+n` is only correct when screen RAM sits at `$0400` (default); if screen RAM is relocated via `$D018`, the pointer block moves to the last 8 bytes of the new screen RAM page.
- Bit `n` of `$D015` MUST be set after all other registers are written; enabling a sprite before its data and position are ready displays garbage for one frame.
- Enabled sprites consume DMA cycles every raster line they are fetched, even when off-screen; clear `$D015` bit `n` when a sprite is not needed.
- X coordinate 24 = leftmost visible pixel; Y coordinate ≈ 50 (PAL) / 51 (NTSC) = topmost visible row; X ≥ 256 requires bit `n` of `$D010` set.
- Multicolor sprites require bit `n` of `$D01C` set; effective resolution halves to 12×21; pixel pairs use `$D027+n` (color 1), `$D025` (color 2, shared), `$D026` (color 3, shared), and transparent for `%00`.
- Sprite-background priority is controlled per sprite by `$D01B`; collision detection registers `$D01E` and `$D01F` clear on read.

## links

- sprite hub: [../sprites/INDEX.md](../sprites/INDEX.md)
- sprite registers: [../sprites/registers.md](../sprites/registers.md)
- sprite display summary: [../sprites/display.md](../sprites/display.md)
- memory map: [../memory/map.md](../memory/map.md)
- raster interrupt: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)

## sources

- task index: [INDEX.md](INDEX.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- CIA2 bank select: [../io/cia2.md](../io/cia2.md)
