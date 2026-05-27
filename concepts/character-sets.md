---
type: reference
domain: concepts
granularity: concept
---

## facts
- C64 character work commonly involves at least four distinct code spaces: keyboard matrix positions, PETSCII/control bytes, screen codes, and character ROM glyph data.
- `keyboard_c64.txt` includes keyboard layout/modifier/output tables.
- `control_codes_c64.txt` includes named PETSCII/editor/color controls.
- `C64IPRI.TXT` and `C64IALT.TXT` map C64 character-set values to Unicode glyph names.

## lookup
| code space | local route | MUST distinguish from |
|---|---|---|
| Keyboard matrix | [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md) | PETSCII bytes and screen codes. |
| PETSCII/control | [../charset/petscii.md](../charset/petscii.md), [../charset/control-codes.md](../charset/control-codes.md) | Screen-code bytes in screen RAM. |
| Screen codes | [../charset/screen-codes.md](../charset/screen-codes.md) | PETSCII/KERNAL I/O bytes. |
| Character glyph maps | `C64IPRI.TXT`, `C64IALT.TXT` | Keyboard scan and PETSCII control values. |

## constraints
- Agents MUST name the code space when answering character-code questions.
- Direct screen writes MUST use screen codes; KERNAL `CHROUT` examples SHOULD use PETSCII/control codes.
- Keyboard-scanning answers SHOULD link CIA1 hardware and keyboard matrix data.

## links
- charset index: [../charset/INDEX.md](../charset/INDEX.md)
- screen memory: [screen-memory.md](screen-memory.md)
- CIA1: [../io/cia1.md](../io/cia1.md)

## sources
- `C:\Code\c64ref\src\charset\keyboard_c64.txt`
- `C:\Code\c64ref\src\charset\control_codes_c64.txt`
- `C:\Code\c64ref\src\charset\C64IPRI.TXT`
- `C:\Code\c64ref\src\charset\C64IALT.TXT`
