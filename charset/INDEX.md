---
type: index
domain: charset
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| PETSCII values and aliases | [petscii.md](petscii.md) | Agents MUST distinguish PETSCII from screen codes. |
| Screen-code values | [screen-codes.md](screen-codes.md) | Use for bytes stored in screen matrix. |
| Control codes | [control-codes.md](control-codes.md) | Use for cursor movement, colors, reverse mode, and editor behavior. |
| Keyboard matrix and scan values | [keyboard-matrix.md](keyboard-matrix.md) | Use for key scanning and modifiers. |

## source-coverage
| source | status | notes |
|---|---|---|
| `C:\Code\c64ref\src\charset\keyboard_c64.txt` | planned | Keyboard layout, matrix, regular/shift/CBM/control values. |
| `C:\Code\c64ref\src\charset\control_codes_c64.txt` | planned | PETSCII control-code facts. |
| `C:\Code\c64ref\src\charset\C64IPRI.TXT` | planned | Primary character set data. |
| `C:\Code\c64ref\src\charset\C64IALT.TXT` | planned | Alternate character set data. |
| `C:\Code\c64ref\src\charset\palette_c64.txt` | planned | Color names and values when used by character/control pages. |

## related
| domain | read | why |
|---|---|---|
| Concepts | [../concepts/character-sets.md](../concepts/character-sets.md) | Code-space distinctions. |
| Memory | [../memory/map.md](../memory/map.md) | Screen matrix and character ROM locations. |
| Colors | [../colors/palette.md](../colors/palette.md) | Color control codes and palette values. |
| Tasks | [../tasks/print-to-screen.md](../tasks/print-to-screen.md) | Screen output recipe. |
