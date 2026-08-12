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
| Chargen ROM glyph bytes — primary set (uppercase) | [chargen-primary.md](chargen-primary.md) | 8 bytes per screen code, ROM-sourced. |
| Chargen ROM glyph bytes — alternate set (lowercase) | [chargen-alternate.md](chargen-alternate.md) | 8 bytes per screen code, ROM-sourced. |

## related
| domain | read | why |
|---|---|---|
| Concepts | [../concepts/character-sets.md](../concepts/character-sets.md) | Code-space distinctions. |
| Memory | [../memory/map.md](../memory/map.md) | Screen matrix and character ROM locations. |
| Colors | [../colors/palette.md](../colors/palette.md) | Color control codes and palette values. |
| Tasks | [../tasks/print-to-screen.md](../tasks/print-to-screen.md) | Screen output recipe. |
