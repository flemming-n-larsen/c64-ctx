---
type: reference
domain: charset
granularity: lookup
---

## facts
- `keyboard_c64.txt` contains layout rows, key captions, modifier scancodes, and regular/shift/CBM/control output tables.
- Modifier entries include left shift `0F`, right shift `34`, `CTRL` `3A`, and Commodore key `3D`.
- `RESTORE` is listed as a key that does not produce a normal scancode in the source.

## lookup
| key / modifier | source value | notes |
|---|---:|---|
| `L.SHIFT` | `$0F` | Modifier source row labels as left shift. |
| `R.SHIFT` | `$34` | Modifier source row labels as right shift. |
| `CTRL` | `$3A` | Modifier source row. |
| `C=` | `$3D` | Commodore-key modifier source row. |
| `SPACE` | regular `$20` | Regular table maps key to space byte. |
| `RETURN` | regular `$0D` | Regular table maps key to return byte. |
| `STOP` | regular `$03` | Regular table maps key to stop byte. |
| Function keys | `$85-$8C` controls | Named in control-code source. |

## constraints
- Agents MUST NOT treat keyboard matrix positions, PETSCII output bytes, and KERNAL `GETIN` bytes as identical without a source path.
- Direct keyboard scanning SHOULD route through CIA1 hardware facts.
- KERNAL input recipes SHOULD use `GETIN`/`CHRIN` unless direct matrix scanning is requested.

## links
- CIA1: [../io/cia1.md](../io/cia1.md)
- read keyboard task: [../tasks/read-keyboard.md](../tasks/read-keyboard.md)
- PETSCII: [petscii.md](petscii.md)

## sources
- `C:\Code\c64ref\src\charset\keyboard_c64.txt`
- `C:\Code\c64ref\src\charset\control_codes_c64.txt`
