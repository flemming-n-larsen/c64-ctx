---
type: reference
domain: io
granularity: chip
summary: "CIA2 registers: VIC bank select, serial bus lines, user port, and NMI."
keywords: [CIA2, 6526, VIC bank select, serial bus, user port, NMI]
---

## facts
- Chip: MOS 6526 Complex Interface Adapter; CIA2 at `$DD00-$DD0F`, mirrored through `$DDFF`.
- 16 registers; CIA2 triggers **NMI** (not IRQ) on the CPU /NMI line via ICR (`$DD0D`).
- Port A (`$DD00`): serial IEC bus control lines + VIC-II bank select bits 0-1 (inverted).
- Port B (`$DD01`): user port / RS-232 data lines.
- Timer A, Timer B, TOD clock, and serial shift register: same structure as CIA1.

## lookup

| address | register | role | bits/fields | R/W |
|---:|---|---|---|:---:|
| `$DD00` | PRA — Port A | Serial IEC bus + VIC bank select | see `$DD00` breakdown | R/W |
| `$DD01` | PRB — Port B | User port / RS-232 | 7-0: PB7-PB0; routed to user port connector | R/W |
| `$DD02` | DDRA | Port A data direction | 1=output, 0=input per bit; KERNAL default `$3F` (bits 0-5 output) | R/W |
| `$DD03` | DDRB | Port B data direction | 1=output, 0=input per bit | R/W |
| `$DD04` | TALO | Timer A low | 7-0: read = current counter low; write = latch low byte | R/W |
| `$DD05` | TAHI | Timer A high | 7-0: read = current counter high; write = latch high byte | R/W |
| `$DD06` | TBLO | Timer B low | 7-0: read = current counter low; write = latch low byte | R/W |
| `$DD07` | TBHI | Timer B high | 7-0: read = current counter high; write = latch high byte | R/W |
| `$DD08` | TOD10THS | TOD tenths of seconds | 3-0: BCD tenths 0-9; 7-4: unused | R/W |
| `$DD09` | TODSEC | TOD seconds | 6-0: BCD seconds 00-59; bit 7: unused | R/W |
| `$DD0A` | TODMIN | TOD minutes | 6-0: BCD minutes 00-59; bit 7: unused | R/W |
| `$DD0B` | TODHR | TOD hours + AM/PM | 6-4: BCD tens of hours; 3-0: BCD units; bit 7: PM flag (1=PM) | R/W |
| `$DD0C` | SDR | Serial shift register | 7-0: shift data byte | R/W |
| `$DD0D` | ICR | NMI interrupt control | read: pending flags; write: set/clear mask; same bit layout as CIA1 ICR | R/W |
| `$DD0E` | CRA | Timer A control | same bit layout as CIA1 CRA (`$DC0E`) | R/W |
| `$DD0F` | CRB | Timer B control | same bit layout as CIA1 CRB (`$DC0F`) | R/W |

### `$DD00` — Port A bit breakdown

| bit | name | function |
|:---:|---|---|
| 7 | /DATA IN | Serial IEC bus DATA input (bus line inverted by hardware before reaching pin) |
| 6 | /CLK IN | Serial IEC bus CLK input (bus line inverted by hardware before reaching pin) |
| 5 | /DATA OUT | Serial IEC bus DATA output (write 0 to pull DATA low on bus) |
| 4 | /CLK OUT | Serial IEC bus CLK output (write 0 to pull CLK low on bus) |
| 3 | /ATN OUT | Serial IEC bus ATN output (write 0 to assert ATN; used by C64 as bus host) |
| 2 | — | User port line (routed to user port connector) |
| 1 | VICBANK1 | VIC-II bank select bit 1 (inverted; see bank table) |
| 0 | VICBANK0 | VIC-II bank select bit 0 (inverted; see bank table) |

### VIC-II bank selection via `$DD00` bits 1-0

| `$DD00` bits 1-0 | value | VIC bank | VIC address range |
|:---:|:---:|:---:|---|
| `%11` | `$03` | 0 | `$0000-$3FFF` — default after KERNAL init |
| `%10` | `$02` | 1 | `$4000-$7FFF` |
| `%01` | `$01` | 2 | `$8000-$BFFF` |
| `%00` | `$00` | 3 | `$C000-$FFFF` |

- Bits are inverted: `$03` (all-ones) selects bank 0 (lowest addresses); `$00` selects bank 3.
- Character ROM is visible to VIC-II only in bank 0 at `$1000-$1FFF` and bank 2 at `$9000-$9FFF`.
- Modify only bits 0-1; preserve bits 2-7 (serial bus lines) with a read-modify-write.

### ICR — `$DD0D` NMI interrupt control

Same bit layout as CIA1 ICR (`$DC0D`); CIA2 generates **NMI**, not IRQ.

| bit | name | read (NMI flags) | write (NMI mask) |
|:---:|---|---|---|
| 7 | IR | 1 = any unmasked NMI pending | not writable directly |
| 4 | FLG | /FLAG pin transition (serial IEC bus DATA input) | bit 7=1: enable; bit 7=0: disable |
| 3 | SP | Serial shift register full or empty | bit 7=1: enable; bit 7=0: disable |
| 2 | ALRM | TOD alarm match | bit 7=1: enable; bit 7=0: disable |
| 1 | TB | Timer B underflow | bit 7=1: enable; bit 7=0: disable |
| 0 | TA | Timer A underflow | bit 7=1: enable; bit 7=0: disable |

- Reading `$DD0D` clears all pending NMI flags.
- NMI is edge-triggered on the CPU /NMI pin; clearing ICR flags is required before a second NMI can fire.
- Write bit 7=1 to set mask bits in bits 0-4; write bit 7=0 to clear those mask bits.

## constraints
- `$DD02` bits 0-1 MUST be outputs (=1) before writing VIC bank select to `$DD00`; floating bits produce undefined bank state.
- `$DD00` bits 2-7 control active serial bus lines; MUST read-modify-write to change bank bits without disturbing serial signals.
- VIC bank change takes effect on the next VIC-II fetch cycle; coordinate with raster position when changing mid-frame.
- CIA2 ICR (`$DD0D`) triggers NMI; MUST NOT be mixed with CIA1 IRQ handler patterns (`$DC0D`).
- Serial IEC bus operations SHOULD use KERNAL routines (`LISTEN`, `TALK`, `ACPTR`, etc.) unless direct register-level bus programming is required.
- TOD read/write latch rules identical to CIA1: read `$DD0B` first to latch all TOD registers; read `$DD08` to release. Write `$DD0B` to halt clock; write `$DD08` to restart.

## links

- VIC-II: [vic-ii.md](vic-ii.md)
- CIA1: [cia1.md](cia1.md)
- serial KERNAL: [../kernal/serial-bus.md](../kernal/serial-bus.md)
- screen memory: [../concepts/screen-memory.md](../concepts/screen-memory.md)
- interrupts: [../irq/overview.md](../irq/overview.md)

## sources

- upstream: [mist64/c64ref src/c64io](https://github.com/mist64/c64ref/tree/master/src/c64io)
- I/O index: [INDEX.md](INDEX.md)
- memory I/O area: [../memory/io-area.md](../memory/io-area.md)
