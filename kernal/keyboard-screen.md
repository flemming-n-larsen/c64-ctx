---
type: reference
domain: kernal
granularity: api-family
summary: "KERNAL character I/O calls for keyboard and screen, versus direct screen writes."
keywords: [GETIN, CHRIN, CHROUT, screen editor, character I/O]
---

## lookup
| symbol | address | category | compact contract |
|---|---:|---|---|
| `SCNKEY` | `$FF9F` | `KBD` | Scan keyboard. |
| `STOP` | `$FFE1` | `KBD` | Test stop key. |
| `GETIN` | `$FFE4` | `KBD` | Get input byte. |
| `CHRIN` | `$FFCF` | `IO` | Input byte from current input channel. |
| `CHROUT` | `$FFD2` | `IO` | Output byte from `A` to current output channel. |
| `SCREEN` | `$FFED` | `EDITOR` | Return screen size. |
| `PLOT` | `$FFF0` | `EDITOR` | Read or set cursor position. |
| `CINT` | `$FF81` | `EDITOR` | Initialize screen editor. |

## constraints
- Agents MUST distinguish KERNAL character I/O from direct screen-memory writes.
- `CHROUT` examples SHOULD use PETSCII/control codes, not screen codes, unless direct screen memory is used.
- Keyboard matrix questions SHOULD route to [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md) and [../io/cia1.md](../io/cia1.md).

## links

- charset: [../charset/INDEX.md](../charset/INDEX.md)
- print task: [../tasks/print-to-screen.md](../tasks/print-to-screen.md)
- read keyboard task: [../tasks/read-keyboard.md](../tasks/read-keyboard.md)
- screen memory: [../concepts/screen-memory.md](../concepts/screen-memory.md)

## sources

- KERNAL index: [INDEX.md](INDEX.md)
- charset controls: [../charset/control-codes.md](../charset/control-codes.md)
