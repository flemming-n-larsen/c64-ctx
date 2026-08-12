---
type: index
domain: io
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| I/O programming topic hub | [io-programming.md](io-programming.md) | Curated route for disk/tape, keyboard/text, controllers, MIDI, and transfer protocols. |
| VIC-II discovery route | [../vic/INDEX.md](../vic/INDEX.md) | Curated hub for VIC timing, banking, modes, and cross-domain routes. |
| Sprite discovery route | [../sprites/INDEX.md](../sprites/INDEX.md) | Curated hub for sprite setup, collisions, border usage, and advanced techniques. |
| 6510 port and banking bits | [processor-port.md](processor-port.md) | `$0000-$0001`; MUST be considered before `$A000`, `$D000`, `$E000` facts. |
| VIC-II registers | [vic-ii.md](vic-ii.md) | Raster, screen, sprites, interrupts, video control. |
| SID registers | [../sid/registers.md](../sid/registers.md) | Sound chip register route — full SID domain at [../sid/INDEX.md](../sid/INDEX.md). |
| CIA1 registers | [cia1.md](cia1.md) | Keyboard, joystick, timers, IRQ. |
| CIA2 registers | [cia2.md](cia2.md) | Serial bus, VIC bank select, NMI. |
| Commodore 1351 proportional mouse | [mouse-1351.md](mouse-1351.md) | POT-register decoding, button mapping, and sampling constraints. |
| MIDI cartridge interfaces | [midi.md](midi.md) | Passport/Syntech ACIA map and interface-family compatibility constraints. |
| Fast-loader protocol families | [fast-loaders.md](fast-loaders.md) | Host/drive code split, compatibility rules, and maintained implementation routes. |
| Color RAM | [color-ram.md](color-ram.md) | `$D800-$DBFF`; 4-bit color storage. |
| D64/D71/D81 disk image format structure | [disk-formats.md](disk-formats.md) | Track/sector layout, BAM, directory entries; 1541/1571/1581. |

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/io-area.md](../memory/io-area.md) | `$D000-$DFFF` memory window. |
| VIC | [../vic/INDEX.md](../vic/INDEX.md) | Curated VIC-II routes over the raw register pages. |
| sprites | [../sprites/INDEX.md](../sprites/INDEX.md) | Sprite-specific route for the VIC-II sprite subset and related effects. |
| IRQ | [../irq/overview.md](../irq/overview.md) | IRQ/NMI constraints and vector overview. |
| Colors | [../colors/INDEX.md](../colors/INDEX.md) | VIC-II color values. |
| Tasks | [../irq/raster-interrupt.md](../irq/raster-interrupt.md) | Canonical practical VIC-II IRQ recipe. |
