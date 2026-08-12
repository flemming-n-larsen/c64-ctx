---
type: reference
domain: io
granularity: chip
summary: "Every VIC-II register with its bit fields: raster, screen, sprites, interrupts, color."
keywords: [VIC-II registers, bit fields, raster register, memory pointers, 6569]
---

## facts
- Chip: MOS 6566/6567 (NTSC) / 6569 (PAL); branded VIC-II.
- 47 registers at `$D000-$D02E`; block mirrored every `$40` bytes through `$D3FF`.
- VIC-II addresses memory in 16 KB banks; bank selected via CIA2 `$DD00` bits 1-0 (inverted: `11`=bank 0, `10`=bank 1, `01`=bank 2, `00`=bank 3).
- Default bank: 0 (`$0000-$3FFF`), `$DD00` bits 1-0 = `11`.
- Character ROM appears to VIC at `$1000-$1FFF` (bank 0) and `$9000-$9FFF` (bank 2) only.

## lookup

| address | name | bits/fields | R/W | notes |
|---:|---|---|:---:|---|
| `$D000` | sprite 0 X low | 7-0: X coordinate low byte | R/W | MSB in `$D010` bit 0 |
| `$D001` | sprite 0 Y | 7-0: Y coordinate | R/W | |
| `$D002` | sprite 1 X low | 7-0: X coordinate low byte | R/W | MSB in `$D010` bit 1 |
| `$D003` | sprite 1 Y | 7-0: Y coordinate | R/W | |
| `$D004` | sprite 2 X low | 7-0: X coordinate low byte | R/W | MSB in `$D010` bit 2 |
| `$D005` | sprite 2 Y | 7-0: Y coordinate | R/W | |
| `$D006` | sprite 3 X low | 7-0: X coordinate low byte | R/W | MSB in `$D010` bit 3 |
| `$D007` | sprite 3 Y | 7-0: Y coordinate | R/W | |
| `$D008` | sprite 4 X low | 7-0: X coordinate low byte | R/W | MSB in `$D010` bit 4 |
| `$D009` | sprite 4 Y | 7-0: Y coordinate | R/W | |
| `$D00A` | sprite 5 X low | 7-0: X coordinate low byte | R/W | MSB in `$D010` bit 5 |
| `$D00B` | sprite 5 Y | 7-0: Y coordinate | R/W | |
| `$D00C` | sprite 6 X low | 7-0: X coordinate low byte | R/W | MSB in `$D010` bit 6 |
| `$D00D` | sprite 6 Y | 7-0: Y coordinate | R/W | |
| `$D00E` | sprite 7 X low | 7-0: X coordinate low byte | R/W | MSB in `$D010` bit 7 |
| `$D00F` | sprite 7 Y | 7-0: Y coordinate | R/W | |
| `$D010` | sprite X MSB | bit n: MSB of sprite n X | R/W | set for X > 255 |
| `$D011` | control register 1 | RST8, ECM, BMM, DEN, RSEL, YSCROLL | R/W | see breakdown below |
| `$D012` | raster line | 7-0: raster low byte | R/W | read=current line; write=compare low byte |
| `$D013` | light pen X | 7-0: latched X | R | latched on LP trigger |
| `$D014` | light pen Y | 7-0: latched Y | R | |
| `$D015` | sprite enable | bit n: 1=enable sprite n | R/W | |
| `$D016` | control register 2 | MCM, CSEL, XSCROLL | R/W | bit 5 MUST be 0; see breakdown |
| `$D017` | sprite Y expand | bit n: 1=double height sprite n | R/W | |
| `$D018` | memory pointers | VM[13:10], CB[13:11] | R/W | see breakdown below |
| `$D019` | interrupt flags | IRQ, LP, IMMC, IMBC, RST | R/W | write 1 to clear; see breakdown |
| `$D01A` | interrupt enable | ELPE, EMMC, EMBC, ERST | R/W | see breakdown below |
| `$D01B` | sprite priority | bit n: 0=front, 1=behind BG | R/W | |
| `$D01C` | sprite multicolor | bit n: 1=multicolor mode sprite n | R/W | uses shared colors `$D025`/`$D026` |
| `$D01D` | sprite X expand | bit n: 1=double width sprite n | R/W | |
| `$D01E` | sprite-sprite collision | bit n: sprite n collided with another | R | cleared on read |
| `$D01F` | sprite-BG collision | bit n: sprite n hit non-transparent BG | R | cleared on read |
| `$D020` | border color | 3-0: color 0-15; 7-4: unused | R/W | |
| `$D021` | background color 0 | 3-0: color 0-15; 7-4: unused | R/W | standard background |
| `$D022` | background color 1 | 3-0: color 0-15; 7-4: unused | R/W | MCM and ECM |
| `$D023` | background color 2 | 3-0: color 0-15; 7-4: unused | R/W | MCM and ECM |
| `$D024` | background color 3 | 3-0: color 0-15; 7-4: unused | R/W | ECM only |
| `$D025` | sprite multicolor 0 | 3-0: shared color 0-15; 7-4: unused | R/W | shared across all multicolor sprites |
| `$D026` | sprite multicolor 1 | 3-0: shared color 0-15; 7-4: unused | R/W | shared across all multicolor sprites |
| `$D027` | sprite 0 color | 3-0: color 0-15; 7-4: unused | R/W | |
| `$D028` | sprite 1 color | 3-0: color 0-15; 7-4: unused | R/W | |
| `$D029` | sprite 2 color | 3-0: color 0-15; 7-4: unused | R/W | |
| `$D02A` | sprite 3 color | 3-0: color 0-15; 7-4: unused | R/W | |
| `$D02B` | sprite 4 color | 3-0: color 0-15; 7-4: unused | R/W | |
| `$D02C` | sprite 5 color | 3-0: color 0-15; 7-4: unused | R/W | |
| `$D02D` | sprite 6 color | 3-0: color 0-15; 7-4: unused | R/W | |
| `$D02E` | sprite 7 color | 3-0: color 0-15; 7-4: unused | R/W | |

### $D011 — control register 1 bits

| bits | name | values |
|:---:|---|---|
| 7 | RST8 | raster line bit 8 (MSB); combined with `$D012` for raster compare >255 |
| 6 | ECM | 1 = extended color mode (bits 6-7 of char byte select `$D021-$D024`) |
| 5 | BMM | 1 = bitmap mode (320×200 hires or 160×200 multicolor) |
| 4 | DEN | 1 = display on; 0 = entire display shows border color |
| 3 | RSEL | 0 = 24 rows (border expands 4 px top/bottom), 1 = 25 rows |
| 2-0 | YSCROLL | vertical fine scroll 0-7 (default 3) |

### $D016 — control register 2 bits

| bits | name | values |
|:---:|---|---|
| 7-6 | — | unused; reads as 1, ignore on write |
| 5 | — | MUST be written as 0 |
| 4 | MCM | 1 = multicolor character or bitmap mode |
| 3 | CSEL | 0 = 38 columns (border expands 7 px left/right), 1 = 40 columns |
| 2-0 | XSCROLL | horizontal fine scroll 0-7 (default 0) |

### $D018 — memory pointers bits

| bits | name | description |
|:---:|---|---|
| 7-4 | VM13-VM10 | video matrix base offset = `(bits 7-4) × $0400` within VIC bank |
| 3-1 | CB13-CB11 | char/bitmap base offset = `(bits 3-1) × $0800` within VIC bank |
| 0 | — | unused |

- Default `$14` = `0001 0100`: VM=1 → `$0400` (screen RAM), CB=2 → `$1000` (char ROM via VIC hole in bank 0).
- Bitmap mode: only bit 3 of `$D018` selects bitmap start (`0`=`$0000`, `1`=`$2000` within bank); bits 2-1 ignored.
- VIC bank offset is added to all addresses; CIA2 `$DD00` bits 1-0 (inverted) set the bank.

### $D019 — interrupt flags bits

| bits | name | description |
|:---:|---|---|
| 7 | IRQ | 1 = any enabled interrupt is pending (read-only composite) |
| 6-4 | — | unused |
| 3 | LP | light pen triggered |
| 2 | IMMC | sprite-sprite collision detected |
| 1 | IMBC | sprite-background collision detected |
| 0 | RST | raster compare match |

Write `1` to bits 3-0 to clear (acknowledge) the corresponding flag.

### $D01A — interrupt enable bits

| bits | name | description |
|:---:|---|---|
| 7-4 | — | unused |
| 3 | ELPE | 1 = enable light pen IRQ |
| 2 | EMMC | 1 = enable sprite-sprite collision IRQ |
| 1 | EMBC | 1 = enable sprite-background collision IRQ |
| 0 | ERST | 1 = enable raster compare IRQ |

### $D020-$D02E — color register layout

All color registers share the same bit layout:

| bits | description |
|:---:|---|
| 7-4 | unused (read behavior varies by chip revision) |
| 3-0 | color value 0-15 |

## constraints
- Raster IRQ handlers MUST acknowledge by writing the flag bit back to `$D019` (write `$01` to clear RST).
- `$D011` bit 7 + `$D012` (8 bits) form the 9-bit raster compare value; both MUST be set for lines > 255.
- `$D016` bit 5 MUST be kept 0; source marks it as always written 0.
- VIC bank base (from CIA2 `$DD00`) MUST be applied to all `$D018` offset calculations.
- In bitmap mode, `$D018` bits 2-1 are ignored; only bit 3 selects bitmap base (`$0000` or `$2000` within bank).
- `$D01E` and `$D01F` collision registers are cleared on read; code MUST save the value immediately after reading.
- Sprite X coordinate > 255 requires setting the corresponding bit in `$D010` AND writing the low byte to `$D000+n×2`.

## links
- VIC hub: [../vic/INDEX.md](../vic/INDEX.md)
- VIC register summary: [../vic/registers.md](../vic/registers.md)
- VIC memory and banking: [../vic/memory-and-banking.md](../vic/memory-and-banking.md)
- VIC timing: [../vic/timing.md](../vic/timing.md)
- VIC screen modes: [../vic/screen-modes.md](../vic/screen-modes.md)
- sprite hub: [../sprites/INDEX.md](../sprites/INDEX.md)
- sprite registers: [../sprites/registers.md](../sprites/registers.md)
- sprite display: [../sprites/display.md](../sprites/display.md)
- sprite techniques: [../sprites/advanced.md](../sprites/advanced.md)
- screen modes: [../graphics/screen-modes.md](../graphics/screen-modes.md)
- VIC bank select: [cia2.md](cia2.md)
- I/O area: [../memory/io-area.md](../memory/io-area.md)
- interrupts: [../irq/overview.md](../irq/overview.md)
- screen memory: [../concepts/screen-memory.md](../concepts/screen-memory.md)
- colors: [../colors/palette.md](../colors/palette.md)
- sprite task: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- raster IRQ task: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- upstream: [mist64/c64ref src/c64io](https://github.com/mist64/c64ref/tree/master/src/c64io)
- I/O index: [INDEX.md](INDEX.md)
- memory I/O area: [../memory/io-area.md](../memory/io-area.md)
