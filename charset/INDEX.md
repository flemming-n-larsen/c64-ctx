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
| local coverage | status | notes |
|---|---|---|
| [petscii.md](petscii.md) | planned | PETSCII values and aliases. |
| [screen-codes.md](screen-codes.md) | planned | Screen-code values and matrix byte distinctions. |
| [control-codes.md](control-codes.md) | planned | PETSCII control-code facts. |
| [keyboard-matrix.md](keyboard-matrix.md) | planned | Keyboard layout, matrix, and modifier values. |
| [../colors/palette.md](../colors/palette.md) | planned | Color names and values when used by character/control pages. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Central upstream fallback route. |

## related
| domain | read | why |
|---|---|---|
| Concepts | [../concepts/character-sets.md](../concepts/character-sets.md) | Code-space distinctions. |
| Memory | [../memory/map.md](../memory/map.md) | Screen matrix and character ROM locations. |
| Colors | [../colors/palette.md](../colors/palette.md) | Color control codes and palette values. |
| Tasks | [../tasks/print-to-screen.md](../tasks/print-to-screen.md) | Screen output recipe. |
