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

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [petscii.md](petscii.md) | used | PETSCII byte ranges, control codes, printable ranges, case-mode behavior. |
| [screen-codes.md](screen-codes.md) | used | Screen-code byte ranges and PETSCII conversion rules. |
| [control-codes.md](control-codes.md) | used | Full PETSCII control-code table including `$95-$9F` colors and `$85-$8C` function keys. |
| [keyboard-matrix.md](keyboard-matrix.md) | used | 8×8 matrix with row/col, scancodes, modifiers, and `GETIN` PETSCII outputs. |
| [chargen-primary.md](chargen-primary.md) | used | Primary charset glyph bytes (screen codes `$00-$FF`), ROM-sourced. |
| [chargen-alternate.md](chargen-alternate.md) | used | Alternate charset glyph bytes (screen codes `$00-$FF`), ROM-sourced. |
| [../colors/palette.md](../colors/palette.md) | planned | Color names and values when used by character/control pages. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Central upstream fallback route. |

## related
| domain | read | why |
|---|---|---|
| Concepts | [../concepts/character-sets.md](../concepts/character-sets.md) | Code-space distinctions. |
| Memory | [../memory/map.md](../memory/map.md) | Screen matrix and character ROM locations. |
| Colors | [../colors/palette.md](../colors/palette.md) | Color control codes and palette values. |
| Tasks | [../tasks/print-to-screen.md](../tasks/print-to-screen.md) | Screen output recipe. |
