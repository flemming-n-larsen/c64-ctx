---
type: reference
domain: tasks
granularity: recipe
---

## sequence
1. For normal KERNAL polling, call `GETIN` at `$FFE4`.
2. For channel-based input, use `CHRIN` at `$FFCF` after setting input channel when needed.
3. For explicit keyboard scan state, use `SCNKEY` at `$FF9F` or direct CIA1/key-matrix references.
4. For direct matrix scanning, read [../io/cia1.md](../io/cia1.md) and [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md) first.

## lookup
| need | read | notes |
|---|---|---|
| Get buffered key byte | [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md) | `GETIN` is KERNAL-level. |
| Read from current input channel | [../kernal/file-io.md](../kernal/file-io.md) | `CHRIN` uses current input channel. |
| Understand key layout/modifiers | [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md) | Matrix/source output tables. |
| Direct hardware scan | [../io/cia1.md](../io/cia1.md) | CIA1 ports and keyboard/joystick context. |

## constraints
- Agents MUST NOT conflate keyboard matrix positions, PETSCII/control bytes, and screen codes.
- KERNAL input SHOULD be preferred for ordinary text/key reads.
- Direct matrix-scanning examples MUST include CIA1 direction/output/input behavior or cite source rows.

## links
- KERNAL keyboard/screen: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)
- keyboard matrix: [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md)
- CIA1: [../io/cia1.md](../io/cia1.md)
- character-set concept: [../concepts/character-sets.md](../concepts/character-sets.md)

## sources
- `C:\Code\c64ref\src\kernal\kernal_prg.txt`
- `C:\Code\c64ref\src\charset\keyboard_c64.txt`
- `C:\Code\c64ref\src\c64io\c64io_prg.txt`
