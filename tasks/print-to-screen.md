---
type: reference
domain: tasks
granularity: recipe
---

## sequence
1. For KERNAL output, load the PETSCII/control byte into `A`.
2. Call `CHROUT` at `$FFD2`.
3. For colors through KERNAL/editor output, use PETSCII color control codes from [../charset/control-codes.md](../charset/control-codes.md).
4. For direct screen writes, write screen codes to the screen matrix and color indices to `$D800-$DBFF` color RAM.
5. Use `PLOT` at `$FFF0` or `SCREEN` at `$FFED` when cursor/screen-size KERNAL behavior is needed.

## lookup
| output method | byte space | pages |
|---|---|---|
| KERNAL `CHROUT` | PETSCII/control | [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md), [../charset/petscii.md](../charset/petscii.md) |
| Direct screen RAM | screen codes | [../concepts/screen-memory.md](../concepts/screen-memory.md), [../charset/screen-codes.md](../charset/screen-codes.md) |
| Set foreground color per cell | color RAM nybble | [../io/color-ram.md](../io/color-ram.md), [../colors/palette.md](../colors/palette.md) |
| Border/background/sprite colors | VIC-II registers | [../io/vic-ii.md](../io/vic-ii.md), [../colors/palette.md](../colors/palette.md) |

## constraints
- Agents MUST distinguish PETSCII/control bytes from screen-code bytes.
- Direct screen writes SHOULD update color RAM when color matters.
- KERNAL `CHROUT` examples SHOULD cite `CHROUT` and the relevant control-code source.

## links
- KERNAL keyboard/screen: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)
- screen memory: [../concepts/screen-memory.md](../concepts/screen-memory.md)
- PETSCII: [../charset/petscii.md](../charset/petscii.md)
- palette: [../colors/palette.md](../colors/palette.md)

## sources
- `C:\Code\c64ref\src\kernal\kernal_prg.txt`
- `C:\Code\c64ref\src\charset\control_codes_c64.txt`
- `C:\Code\c64ref\src\charset\C64IPRI.TXT`
- `C:\Code\c64ref\src\c64io\c64io_prg.txt`
