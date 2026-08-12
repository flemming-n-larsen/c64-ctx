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

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| CIA1 registers: keyboard matrix scan, joystick ports, timers, and the system IRQ. | [cia1.md](cia1.md) | CIA1, 6526, timers, keyboard scan, joystick port, TOD clock |
| CIA2 registers: VIC bank select, serial bus lines, user port, and NMI. | [cia2.md](cia2.md) | CIA2, 6526, VIC bank select, serial bus, user port, NMI |
| The 4-bit-per-cell color RAM: where it lives and what the upper nibble does. | [color-ram.md](color-ram.md) | color RAM, nibble, cell color, upper nibble garbage |
| Communication patterns layered above raw bus or controller hardware. | [data-transfer-protocols.md](data-transfer-protocols.md) | transfer protocols, handshaking, serial transfer, link protocols |
| D64, D71 and D81 image layout: tracks, sectors, BAM, and directory entries. | [disk-formats.md](disk-formats.md) | D64, D71, D81, disk image, BAM, directory entry, track sector |
| Reaching disk and tape through KERNAL channels, and the hardware underneath. | [disk-tape-io.md](disk-tape-io.md) | disk I/O, tape, datassette, IEC signaling, channel calls |
| How fast loaders replace the stock transfer protocol, and their compatibility rules. | [fast-loaders.md](fast-loaders.md) | fast loader, drive code, transfer protocol, compatibility |
| Route hub for practical device access spanning CIA, KERNAL, encodings and protocols. | [io-programming.md](io-programming.md) | I/O programming, device access, topic hub, peripherals |
| Reading joysticks as direct CIA1 port reads, including the keyboard-conflict problem. | [joystick.md](joystick.md) | joystick, control port, direction bits, fire button, port conflict |
| The three layers of keyboard and text I/O: matrix wiring, KERNAL calls, code spaces. | [keyboard-text-io.md](keyboard-text-io.md) | keyboard I/O, text I/O, input layers, screen editor |
| MIDI on the C64 requires a cartridge; the ACIA register map and interface families. | [midi.md](midi.md) | MIDI, ACIA, Passport, Syntech, cartridge interface |
| The 1351 proportional mouse: POT register decoding, buttons, sampling constraints. | [mouse-1351.md](mouse-1351.md) | 1351 mouse, proportional mode, POT registers, mouse buttons |
| Mice, paddles, light pens and trackballs, and which hardware path each uses. | [pointing-devices.md](pointing-devices.md) | pointing devices, paddles, light pen, trackball, POT lines |
| The 6510 port at $0000/$0001: banking bits, direction register, cassette lines. | [processor-port.md](processor-port.md) | processor port, banking bits, direction register, cassette lines |
| Every VIC-II register with its bit fields: raster, screen, sprites, interrupts, color. | [vic-ii.md](vic-ii.md) | VIC-II registers, bit fields, raster register, memory pointers, 6569 |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/io-area.md](../memory/io-area.md) | `$D000-$DFFF` memory window. |
| VIC | [../vic/INDEX.md](../vic/INDEX.md) | Curated VIC-II routes over the raw register pages. |
| sprites | [../sprites/INDEX.md](../sprites/INDEX.md) | Sprite-specific route for the VIC-II sprite subset and related effects. |
| IRQ | [../irq/overview.md](../irq/overview.md) | IRQ/NMI constraints and vector overview. |
| Colors | [../colors/INDEX.md](../colors/INDEX.md) | VIC-II color values. |
| Tasks | [../irq/raster-interrupt.md](../irq/raster-interrupt.md) | Canonical practical VIC-II IRQ recipe. |
