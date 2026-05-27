---
type: reference
domain: charset
granularity: code-space
---

## facts
- PETSCII/control-code handling is distinct from screen-code bytes stored in screen memory.
- the local control-code page names editor, function-key, cursor, case-switch, reverse-video, and color controls.
- KERNAL `CHROUT` expects character/control bytes for output, not direct screen-code memory bytes.

## lookup
| code | name | use |
|---:|---|---|
| `$03` | `STOP` | Stop key/control context. |
| `$05` | `COL_WHITE` | Set output color white. |
| `$0D` | `RETURN` | Return/newline behavior. |
| `$11` | `CRSR_DOWN` | Cursor down. |
| `$12` | `RVS_ON` | Reverse video on. |
| `$13` | `CRSR_HOME` | Home cursor. |
| `$14` | `DEL` | Delete. |
| `$1C` | `COL_RED` | Set output color red. |
| `$1D` | `CRSR_RIGHT` | Cursor right. |
| `$90` | `COL_BLACK` | Set output color black. |
| `$91` | `CRSR_UP` | Cursor up. |
| `$92` | `RVS_OFF` | Reverse video off. |
| `$93` | `CLEAR` | Clear screen. |
| `$9D` | `CRSR_LEFT` | Cursor left. |

## constraints
- Agents MUST NOT map PETSCII bytes directly to screen memory without a conversion rule.
- Output examples using KERNAL `CHROUT` SHOULD use PETSCII/control code names from this page.
- Agents SHOULD route glyph/Unicode questions to [screen-codes.md](screen-codes.md) and source charset maps.

## links
- screen codes: [screen-codes.md](screen-codes.md)
- control codes: [control-codes.md](control-codes.md)
- KERNAL screen I/O: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- charset index: [INDEX.md](INDEX.md)
- control codes: [control-codes.md](control-codes.md)
