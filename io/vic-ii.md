---
type: reference
domain: io
granularity: chip
---

## lookup
| address / range | register | facts |
|---:|---|---|
| `$D000-$D02E` | `VIC-II` block | Source labels this MOS `6566` video interface controller. |
| `$D000-$D00F` | sprite coordinates | Sprite `0-7` X/Y low bytes. |
| `$D010` | sprite X MSB | Most-significant X coordinate bits for sprites `0-7`. |
| `$D011` | control register | Raster compare bit `8`, extended color mode, bitmap mode, screen blanking, row select, Y scroll. |
| `$D012` | raster | Read raster / write raster compare low byte. |
| `$D015` | sprite enable | Bit `1` enables corresponding sprite. |
| `$D016` | control register | Multicolor mode, 38/40 columns, X scroll; source says bit `5` MUST be `0`. |
| `$D018` | memory control | Video matrix base and character dot-data base inside selected VIC bank. |
| `$D019` | interrupt flags | Any enabled VIC IRQ, light pen, sprite collisions, raster compare. |

## constraints
- Raster IRQ code MUST acknowledge VIC-II interrupt flags, typically by writing the relevant flag bit back to `$D019`.
- Agents MUST treat `$D011` bit `7` plus `$D012` as the raster compare value when discussing lines beyond `255`.
- Code SHOULD keep `$D016` bit `5` clear because `c64io_prg.txt` explicitly warns it is always set to `0`.
- VIC memory-base calculations MUST account for the selected VIC bank, not only CPU addresses.

## links
- I/O area: [../memory/io-area.md](../memory/io-area.md)
- interrupts: [../concepts/interrupts.md](../concepts/interrupts.md)
- screen memory: [../concepts/screen-memory.md](../concepts/screen-memory.md)
- colors: [../colors/palette.md](../colors/palette.md)

## sources
- `C:\Code\c64ref\src\c64io\c64io_prg.txt`
- `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt`
