---
type: reference
domain: vic
granularity: atomic
---

## facts
- VIC-II control state is centered in the register block at `$D000-$D02E`, mirrored every `$40` bytes through `$D3FF`.
- Core display control lives in `$D011`, `$D016`, `$D018`, `$D019`, and `$D01A`; sprite control occupies `$D000-$D01F` plus `$D025-$D02E`.
- VIC-visible addresses always combine the current CIA2 bank selection (`$DD00`) with VIC-II-local offsets such as `$D018` screen/character pointers.

## lookup
| area | registers | use |
|---|---|---|
| Raster and display window control | `$D011`, `$D012`, `$D016` | Set raster compare, display enable, row/column size, fine scroll, and multicolor mode bits. |
| Memory pointers | `$D018` with CIA2 `$DD00` | Choose screen matrix base and character/bitmap base inside the active 16 KB VIC bank. |
| Interrupts | `$D019`, `$D01A` | Read pending VIC-II interrupt sources and enable raster/light-pen/collision IRQs. |
| Sprite position and enable | `$D000-$D00F`, `$D010`, `$D015` | Set sprite X/Y coordinates, X MSBs, and sprite enable bits. |
| Sprite size and layering | `$D017`, `$D01B`, `$D01C`, `$D01D` | Control double height, foreground/background priority, multicolor mode, and double width. |
| Sprite collisions | `$D01E`, `$D01F` | Read sprite-sprite and sprite-background collision latches; both clear on read. |
| Global and sprite colors | `$D020-$D026`, `$D027-$D02E` | Border/background colors, shared multicolor sprite colors, and per-sprite colors. |
| Light pen | `$D013`, `$D014` | Read the latched light-pen coordinates when that feature is in use. |

## constraints
- Raster compare above line `$FF` MUST combine `$D012` with `$D011` bit `7`.
- `$D016` bit `5` MUST stay `0` when updating horizontal scroll or multicolor mode.
- VIC-II interrupt flags in `$D019` are acknowledged by writing `1` back to the active source bits.
- Sprite X positions beyond `255` require both the low byte in `$D000+$2*n` and the matching `$D010` bit.
- Any address derived from `$D018` MUST include the active CIA2 VIC bank from `$DD00`.

## links
- VIC hub: [INDEX.md](INDEX.md)
- authoritative register table: [../io/vic-ii.md](../io/vic-ii.md)
- memory and banking: [memory-and-banking.md](memory-and-banking.md)
- timing: [timing.md](timing.md)
- screen modes: [screen-modes.md](screen-modes.md)
- raster IRQ recipe: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- sprite setup: [../tasks/sprite-display.md](../tasks/sprite-display.md)

## sources
- VIC hub: [INDEX.md](INDEX.md)
- local register reference: [../io/vic-ii.md](../io/vic-ii.md)
- CIA2 bank select: [../io/cia2.md](../io/cia2.md)
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
