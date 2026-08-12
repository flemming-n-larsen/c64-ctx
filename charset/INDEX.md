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

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| Glyph bytes for the alternate (lowercase) character ROM set, 8 bytes per screen code. | [chargen-alternate.md](chargen-alternate.md) | chargen ROM, lowercase set, glyph bytes, character bitmaps |
| Glyph bytes for the primary (uppercase/graphics) character ROM set, 8 bytes per screen code. | [chargen-primary.md](chargen-primary.md) | chargen ROM, uppercase set, glyph bytes, character bitmaps |
| PETSCII control bytes that move the cursor, change color, or toggle reverse and editor state. | [control-codes.md](control-codes.md) | control codes, cursor control, color codes, reverse mode, editor state |
| The 8x8 keyboard matrix as scanned through CIA1, with modifiers and delivered PETSCII. | [keyboard-matrix.md](keyboard-matrix.md) | keyboard matrix, key scan, modifiers, SHIFT, matrix position |
| The PETSCII encoding used by CHROUT and GETIN; not the screen-code encoding. | [petscii.md](petscii.md) | PETSCII, character encoding, printable range, code space |
| The byte values stored in screen matrix RAM, each indexing one glyph in the active set. | [screen-codes.md](screen-codes.md) | screen codes, screen matrix, reverse range, glyph index |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Concepts | [../concepts/character-sets.md](../concepts/character-sets.md) | Code-space distinctions. |
| Memory | [../memory/map.md](../memory/map.md) | Screen matrix and character ROM locations. |
| Colors | [../colors/palette.md](../colors/palette.md) | Color control codes and palette values. |
| Tasks | [../tasks/print-to-screen.md](../tasks/print-to-screen.md) | Screen output recipe. |
