---
type: reference
domain: io
granularity: atomic
summary: "The three layers of keyboard and text I/O: matrix wiring, KERNAL calls, code spaces."
keywords: [keyboard I/O, text I/O, input layers, screen editor]
---

## facts
- Keyboard and text I/O spans three different layers: CIA1 matrix wiring, KERNAL keyboard/screen calls, and character-code spaces such as `PETSCII` and screen codes.
- Direct matrix reads belong with CIA1 register usage and keyboard matrix lookup tables; buffered character input/output belongs with KERNAL editor and console routines.
- The same physical key can map to a matrix position, a KERNAL-delivered `PETSCII` byte, or a screen-code glyph path depending on how input/output is performed.
- Codebase64 groups these topics together for practical I/O discovery, but local pages keep the distinctions explicit to avoid code-space confusion.

## lookup
| need | read | notes |
|---|---|---|
| Understand CIA1 keyboard wiring | [cia1.md](cia1.md) | CIA1 owns `$DC00-$DC03` keyboard and joystick port context. |
| Look up matrix positions and `GETIN` output distinctions | [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md) | Keeps scancodes, `PETSCII`, and joystick-port overlap separate. |
| Use KERNAL keyboard/screen calls | [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md) | Routes `SCNKEY`, `GETIN`, `CHRIN`, `CHROUT`, and editor helpers. |
| Follow a practical keyboard-input recipe | [../tasks/read-keyboard.md](../tasks/read-keyboard.md) | Shows common patterns for direct scan vs KERNAL polling. |
| Resolve character-code meaning | [../charset/petscii.md](../charset/petscii.md) | `CHROUT` and `GETIN` operate on `PETSCII`, not screen codes. |

## constraints
- Do not conflate keyboard matrix positions, `PETSCII` bytes, and screen codes; pick the page that matches the representation in use.
- If KERNAL IRQ-driven keyboard scanning remains active, avoid reprogramming CIA1 keyboard DDR/port state without understanding the interaction.
- Treat joystick port 2 interference as a CIA1 hardware constraint when reading the keyboard matrix directly.
- Use [../sources/INDEX.md](../sources/INDEX.md) when the local route intentionally summarizes Codebase64 topic grouping rather than reproducing full upstream detail.

## sources

- I/O programming hub: [io-programming.md](io-programming.md)
- CIA1 registers: [cia1.md](cia1.md)
- Keyboard matrix: [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md)
- KERNAL keyboard/screen: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)
- Read keyboard task: [../tasks/read-keyboard.md](../tasks/read-keyboard.md)
- PETSCII: [../charset/petscii.md](../charset/petscii.md)
