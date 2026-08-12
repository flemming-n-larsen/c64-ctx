---
type: reference
domain: io
granularity: chip
summary: "CIA1 registers: keyboard matrix scan, joystick ports, timers, and the system IRQ."
keywords: [CIA1, 6526, timers, keyboard scan, joystick port, TOD clock]
---

## facts
- Chip: MOS 6526 Complex Interface Adapter; CIA1 at `$DC00-$DC0F`, mirrored through `$DCFF`.
- 16 registers; CIA1 triggers **IRQ** on the CPU /IRQ line via ICR (`$DC0D`).
- Two 16-bit timers (A: `$DC04-$DC05`, B: `$DC06-$DC07`) each with latch reload on underflow.
- Port A (`$DC00`): keyboard column strobe output; also joystick port 2 fire/directions.
- Port B (`$DC01`): keyboard row sense input; also joystick port 1 fire/directions.
- TOD clock (`$DC08-$DC0B`): 12-hour BCD real-time clock driven by AC line frequency.

## lookup

| address | register | role | bits/fields | R/W |
|---:|---|---|---|:---:|
| `$DC00` | PRA — Port A | Keyboard column output; joystick port 2 | 7-0: PA7-PA0; drive bit low to select column; joystick: bit 4=fire, 3=right, 2=left, 1=down, 0=up (active low) | R/W |
| `$DC01` | PRB — Port B | Keyboard row input; joystick port 1 | 7-0: PB7-PB0; read bit low = key pressed in that row; same joystick bit layout as PRA | R/W |
| `$DC02` | DDRA | Port A data direction | 1=output, 0=input per bit; `$FF` = all output (keyboard scan default) | R/W |
| `$DC03` | DDRB | Port B data direction | 1=output, 0=input per bit; `$00` = all input (keyboard read default) | R/W |
| `$DC04` | TALO | Timer A low | 7-0: read = current counter low; write = latch low byte | R/W |
| `$DC05` | TAHI | Timer A high | 7-0: read = current counter high; write = latch high byte | R/W |
| `$DC06` | TBLO | Timer B low | 7-0: read = current counter low; write = latch low byte | R/W |
| `$DC07` | TBHI | Timer B high | 7-0: read = current counter high; write = latch high byte | R/W |
| `$DC08` | TOD10THS | TOD tenths of seconds | 3-0: BCD tenths 0-9; 7-4: unused | R/W |
| `$DC09` | TODSEC | TOD seconds | 6-0: BCD seconds 00-59; bit 7: unused | R/W |
| `$DC0A` | TODMIN | TOD minutes | 6-0: BCD minutes 00-59; bit 7: unused | R/W |
| `$DC0B` | TODHR | TOD hours + AM/PM | 6-4: BCD tens of hours; 3-0: BCD units; bit 7: PM flag (1=PM) | R/W |
| `$DC0C` | SDR | Serial shift register | 7-0: shift data byte | R/W |
| `$DC0D` | ICR | Interrupt control | read: pending flags; write: set/clear mask; see ICR breakdown | R/W |
| `$DC0E` | CRA | Timer A control | see CRA breakdown | R/W |
| `$DC0F` | CRB | Timer B control | see CRB breakdown | R/W |

### ICR — `$DC0D` interrupt control register

| bit | name | read (interrupt flags) | write (interrupt mask) |
|:---:|---|---|---|
| 7 | IR | 1 = any unmasked interrupt is pending | not writable (determined by bits 0-4 mask state) |
| 4 | FLG | Cassette read /FLAG pin transition | bit 7=1: enable; bit 7=0: disable FLG interrupt |
| 3 | SP | Serial shift register full (input) or empty (output) | bit 7=1: enable; bit 7=0: disable SP interrupt |
| 2 | ALRM | TOD alarm match | bit 7=1: enable; bit 7=0: disable ALRM interrupt |
| 1 | TB | Timer B underflow | bit 7=1: enable; bit 7=0: disable TB interrupt |
| 0 | TA | Timer A underflow | bit 7=1: enable; bit 7=0: disable TA interrupt |

- Write bit 7=1 to set mask bits specified in bits 0-4; write bit 7=0 to clear those mask bits.
- Reading `$DC0D` clears all pending flags; the read value reflects which flags were set.
- CIA1 ICR triggers the CPU /IRQ line; MUST distinguish from CIA2 NMI (`$DD0D`).

### CRA — `$DC0E` Timer A control

| bit | name | description |
|:---:|---|---|
| 7 | TODIN | 0 = 60 Hz TOD clock input; 1 = 50 Hz TOD clock input |
| 6 | SPMODE | 0 = serial input (shift in on falling CNT); 1 = serial output (rate set by Timer A) |
| 5 | INMODE | 0 = count φ2 clock cycles; 1 = count positive CNT pin edges |
| 4 | LOAD | 1 = force latch load into counter (strobe bit; reads back as 0) |
| 3 | RUNMODE | 0 = continuous (reload latch and continue); 1 = one-shot (stop after underflow) |
| 2 | OUTMODE | 0 = pulse PB6 one cycle on underflow; 1 = toggle PB6 on underflow |
| 1 | PBON | 0 = PB6 normal port I/O; 1 = Timer A output drives PB6 |
| 0 | START | 0 = stop Timer A; 1 = start Timer A |

### CRB — `$DC0F` Timer B control

| bits | name | description |
|:---:|---|---|
| 7 | ALARM | 0 = writes to TOD registers (`$DC08-$DC0B`) set the time; 1 = writes set the alarm time |
| 6-5 | INMODE | 00 = count φ2 cycles; 01 = count CNT pin edges; 10 = count Timer A underflows; 11 = count Timer A underflows when CNT high |
| 4 | LOAD | 1 = force latch load into counter (strobe) |
| 3 | RUNMODE | 0 = continuous; 1 = one-shot |
| 2 | OUTMODE | 0 = pulse PB7 on underflow; 1 = toggle PB7 on underflow |
| 1 | PBON | 0 = PB7 normal port I/O; 1 = Timer B output drives PB7 |
| 0 | START | 0 = stop Timer B; 1 = start Timer B |

### Keyboard matrix scan pattern

1. Write `$FF` to `$DC02` (DDRA all output) and `$00` to `$DC03` (DDRB all input).
2. For each column `n` (0-7): write `$FF XOR (1 << n)` to `$DC00` — drives bit `n` low, others high.
3. Read `$DC01` (PRB): bit `r` = 0 indicates a key pressed at column `n`, row `r`.
4. Restore `$DC00` = `$FF` between scans to prevent phantom reads across matrix rows.
5. Matrix row/column position is NOT a PETSCII value — route to `charset/keyboard-matrix.md` for key identity.

Joystick port 2 shares `$DC00` bits 0-4 with keyboard column outputs; DDRA bits 0-4 must be switched to input (`$DC02` bits 0-4 = 0) to read joystick without driving the lines. The KERNAL multiplexes keyboard scan and joystick reads.

## constraints
- ICR flags MUST be read and cleared during the IRQ handler; unread flags re-assert /IRQ on return.
- CIA1 IRQ and CIA2 NMI (`$DD0D`) are separate interrupt lines; do not conflate them.
- Reading `$DC0B` (TODHR) latches all TOD registers until `$DC08` (TOD10THS) is read; MUST read TODHR first when reading consistent time.
- Writing `$DC0B` (TODHR) halts the TOD clock; writing `$DC08` (TOD10THS) restarts it.
- CRB bit 7 (ALARM) MUST be set to 1 before writing alarm values to `$DC08-$DC0B`; default 0 writes update the running time.
- Joystick port 2 (PRA bits 0-4) and keyboard column output share Port A; simultaneous use requires DDR management.

## links

- keyboard matrix: [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md)
- read-key task: [../tasks/read-keyboard.md](../tasks/read-keyboard.md)
- CIA2: [cia2.md](cia2.md)
- interrupts: [../irq/overview.md](../irq/overview.md)

## sources

- upstream: [mist64/c64ref src/c64io](https://github.com/mist64/c64ref/tree/master/src/c64io)
- I/O index: [INDEX.md](INDEX.md)
- memory I/O area: [../memory/io-area.md](../memory/io-area.md)
