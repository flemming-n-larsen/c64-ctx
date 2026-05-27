---
type: reference
domain: io
granularity: chip
---

## facts
- `$DC00-$DCFF` is a `MOS 6526 Complex Interface Adapter` block in the local I/O pages.
- `$DC00` is data port `A` for keyboard, joystick, and related I/O in the local I/O pages.
- CIA1 is the default route for keyboard matrix and joystick port facts in this index.

## lookup
| range / register | role | route |
|---|---|---|
| `$DC00-$DCFF` | CIA1 block | Keyboard, joystick, timers, IRQ. |
| `$DC00` | Port `A` | Keyboard/joystick data port. |
| `$DC01` | Port `B` | Keyboard/joystick data port counterpart. |
| CIA timers | Timer `A`, timer `B` | Use source rows for exact register addresses. |
| CIA IRQ control | Interrupt flags/mask | Use with [../concepts/interrupts.md](../concepts/interrupts.md). |

## constraints
- Keyboard scanning MUST coordinate CIA1 port direction/output and input reads; do not treat key values as PETSCII directly.
- Agents SHOULD route character-result questions to [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md) after CIA1 hardware facts.
- IRQ code MUST distinguish CIA1 IRQ from CIA2 NMI behavior.

## links
- keyboard matrix: [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md)
- read-key task: [../tasks/read-keyboard.md](../tasks/read-keyboard.md)
- interrupts: [../concepts/interrupts.md](../concepts/interrupts.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- I/O index: [INDEX.md](INDEX.md)
- keyboard matrix: [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md)
