---
type: reference
domain: concepts
granularity: concept
---

## facts
- C64 character work commonly involves at least four distinct code spaces: keyboard matrix positions, PETSCII/control bytes, screen codes, and character ROM glyph data.
- the local keyboard matrix page includes keyboard layout/modifier/output tables.
- the local control-code page includes named PETSCII/editor/color controls.
- [chargen-primary.md](../charset/chargen-primary.md) and [chargen-alternate.md](../charset/chargen-alternate.md) contain the ROM glyph bytes (8 bytes per screen code) with Unicode name mappings.

## lookup
| code space | local route | MUST distinguish from |
|---|---|---|
| Keyboard matrix | [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md) | PETSCII bytes and screen codes. |
| PETSCII/control | [../charset/petscii.md](../charset/petscii.md), [../charset/control-codes.md](../charset/control-codes.md) | Screen-code bytes in screen RAM. |
| Screen codes | [../charset/screen-codes.md](../charset/screen-codes.md) | PETSCII/KERNAL I/O bytes. |
| Character glyph maps | [../charset/chargen-primary.md](../charset/chargen-primary.md), [../charset/chargen-alternate.md](../charset/chargen-alternate.md) | Keyboard scan and PETSCII control values. |

## constraints
- Agents MUST name the code space when answering character-code questions.
- Direct screen writes MUST use screen codes; KERNAL `CHROUT` examples SHOULD use PETSCII/control codes.
- Keyboard-scanning answers SHOULD link CIA1 hardware and keyboard matrix data.

## links
- charset index: [../charset/INDEX.md](../charset/INDEX.md)
- screen memory: [screen-memory.md](screen-memory.md)
- CIA1: [../io/cia1.md](../io/cia1.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- charset index: [../charset/INDEX.md](../charset/INDEX.md)
- keyboard matrix: [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md)
