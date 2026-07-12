---
type: reference
domain: io
granularity: atomic
---

## facts
- The C64 has no built-in MIDI controller or KERNAL MIDI API; MIDI requires an external cartridge or user-port interface.
- Common cartridge interfaces use a Motorola 6850-compatible ACIA in expansion I/O space, but their address decoding is not standardized.
- The original Passport/Syntech interface maps ACIA control/status at `$DE08` and transmit/receive data at `$DE09`.
- Passport also maps a 6840 timer at `$DE00-$DE07` and drum-sync set/clear strobes at `$DE30`/`$DE38`; these are product-specific, not generic MIDI registers.
- VICE exposes separate emulation modes for Passport/Syntech, DATEL/Siel/JMS, Namesoft, and Maplin interfaces because software written for one mapping is not automatically compatible with another.

## lookup
| need | read | notes |
|---|---|---|
| Passport/Syntech ACIA control or status | `$DE08` | Write control; read status. |
| Passport/Syntech ACIA transmit or receive data | `$DE09` | Write transmit byte; read received byte. |
| Passport 6840 timer | `$DE00-$DE07` | Interface timing hardware; consult the product manual before programming. |
| Passport drum-sync set / clear | `$DE30` / `$DE38` | Separate from MIDI byte I/O. |
| Other emulated interface families | [VICE manual](https://vice-emu.sourceforge.io/manual/vice.pdf) | Select the matching interface mode before relying on addresses or IRQ behavior. |

## sequence
1. Identify the physical interface family; do not probe by writing arbitrary control values.
2. Ensure expansion I/O is visible in the current `$0001` banking configuration.
3. Reset and configure the interface ACIA using that interface's clock and interrupt contract.
4. Poll its status register or install the documented interrupt path.
5. Read a receive byte only when receive-data-ready is asserted; write only when transmit-data-empty is asserted.
6. Parse MIDI status/data bytes in software; running status and variable-length messages are protocol-layer concerns, not ACIA behavior.

## constraints
- Code MUST name the interface family whose register map it uses.
- Passport/Syntech addresses MUST NOT be relabeled as DATEL/Siel/JMS addresses; historical secondary tables disagree about these mappings.
- ACIA control words depend on the interface clock and wiring; copy them only from the matching hardware manual.
- MIDI electrical signaling MUST go through a compliant interface; do not connect a MIDI current-loop signal directly to C64 TTL pins.
- Expansion-register access depends on I/O visibility and may conflict with other cartridges using `$DE00-$DEFF`.

## links
- I/O programming hub: [io-programming.md](io-programming.md)
- I/O banking: [../memory/io-area.md](../memory/io-area.md)
- Provenance: [../sources/INDEX.md](../sources/INDEX.md)

## sources
- I/O programming hub: [io-programming.md](io-programming.md)
- I/O banking: [../memory/io-area.md](../memory/io-area.md)
- original hardware manual: [Passport MIDI Interface User's Manual](https://mirrors.apple2.org.za/ftp.apple.asimov.net/documentation/hardware/misc/passport_midi.pdf)
- emulator implementation modes: [VICE manual](https://vice-emu.sourceforge.io/manual/vice.pdf)
- Provenance: [../sources/INDEX.md](../sources/INDEX.md)
