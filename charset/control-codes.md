---
type: reference
domain: charset
granularity: lookup
---

## lookup
| code | name | family |
|---:|---|---|
| `$03` | `STOP` | control |
| `$05` | `COL_WHITE` | color |
| `$08` | `DIS_CASE_SWITCH` | editor |
| `$09` | `ENA_CASE_SWITCH` | editor |
| `$0D` | `RETURN` | editor |
| `$0E` | `LOWER_CASE` | character-set mode |
| `$11` | `CRSR_DOWN` | cursor |
| `$12` | `RVS_ON` | video mode |
| `$13` | `CRSR_HOME` | cursor |
| `$14` | `DEL` | editor |
| `$1C` | `COL_RED` | color |
| `$1D` | `CRSR_RIGHT` | cursor |
| `$1E` | `COL_GREEN` | color |
| `$1F` | `COL_BLUE` | color |
| `$81` | `COL_ORANGE` | color |
| `$85-$8C` | `KEY_F1`..`KEY_F8` | function key |
| `$8D` | `SHIFT_RETURN` | editor |
| `$8E` | `UPPER_CASE` | character-set mode |
| `$90` | `COL_BLACK` | color |
| `$91` | `CRSR_UP` | cursor |
| `$92` | `RVS_OFF` | video mode |
| `$93` | `CLEAR` | editor |
| `$94` | `INST` | editor |
| `$95-$9F` | additional colors and `CRSR_LEFT` | color/cursor |

## constraints
- Agents MUST use control-code names only in PETSCII/KERNAL I/O context unless a source says otherwise.
- Color control codes SHOULD link to [../colors/palette.md](../colors/palette.md) for numeric color indices and RGB approximations.
- Cursor/control examples SHOULD route to KERNAL `CHROUT`, not direct screen memory, unless explicitly converted.

## links
- PETSCII: [petscii.md](petscii.md)
- colors: [../colors/palette.md](../colors/palette.md)
- KERNAL screen I/O: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- charset index: [INDEX.md](INDEX.md)
- palette: [../colors/palette.md](../colors/palette.md)
