---
type: reference
domain: io
granularity: atomic
---

## facts
- Standard C64 joystick reads are direct CIA1 port reads, not KERNAL character-input calls.
- Joystick port 2 is read through CIA1 Port A at `$DC00`; joystick port 1 is read through CIA1 Port B at `$DC01`.
- The direction and fire inputs are active low on bits `0-4`, so a cleared bit means the corresponding direction or button is pressed.
- Joystick port 2 shares CIA1 Port A lines with keyboard column output, so direct joystick reads must account for keyboard-scan DDR and strobe state.

## lookup
| need | read | notes |
|---|---|---|
| Port and bit layout | [cia1.md](cia1.md) | CIA1 documents the active-low joystick mapping on `$DC00/$DC01`. |
| Keyboard-sharing caveats | [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md) | Explains why joystick port 2 can appear as keyboard matrix activity. |
| Polling patterns that coexist with keyboard input | [../tasks/read-keyboard.md](../tasks/read-keyboard.md) | Practical input recipes route to KERNAL or direct CIA scans depending on intent. |
| Upstream topic provenance | [../sources/INDEX.md](../sources/INDEX.md) | Use when Codebase64 topic routing matters more than a single local implementation page. |

## constraints
- Do not treat joystick input as `PETSCII` or `GETIN` data; it is a hardware bitfield read from CIA1.
- When reading joystick port 2, avoid leaving CIA1 Port A configured for keyboard column output unless that interaction is intentional.
- Keep port 1 and port 2 separate in reasoning: they live on different CIA1 ports even though the bit layout matches.

## links
- I/O programming hub: [io-programming.md](io-programming.md)
- CIA1 registers: [cia1.md](cia1.md)
- Keyboard matrix: [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md)
- Read keyboard task: [../tasks/read-keyboard.md](../tasks/read-keyboard.md)
- Provenance: [../sources/INDEX.md](../sources/INDEX.md)

## sources
- CIA1 registers: [cia1.md](cia1.md)
- Keyboard matrix: [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md)
- Read keyboard task: [../tasks/read-keyboard.md](../tasks/read-keyboard.md)
- I/O programming hub: [io-programming.md](io-programming.md)
- Provenance: [../sources/INDEX.md](../sources/INDEX.md)