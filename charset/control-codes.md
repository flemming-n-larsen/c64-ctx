---
type: reference
domain: charset
granularity: lookup
summary: "PETSCII control bytes that move the cursor, change color, or toggle reverse and editor state."
keywords: [control codes, cursor control, color codes, reverse mode, editor state]
---

## facts
- Control codes are the PETSCII byte ranges `$00-$1F` and `$80-$9F`; they alter `CHROUT` editor state or signal input events from `GETIN`/`CHRIN`.
- Some control codes are output-only (sent to `CHROUT`), some are input-only (delivered by `GETIN` from keyboard events), and some are both.
- Color control codes change the current foreground color used when the editor stores into color RAM `$D800-$DBE7` for subsequent characters.
- Function-key bytes `$85-$8C` are delivered by `GETIN`/`CHRIN` from the keyboard; sending them to `CHROUT` has no useful effect by default.

## lookup
| code | name | family | direction |
|---:|---|---|---|
| `$03` | `STOP` | control | input (RUN/STOP) |
| `$05` | `COL_WHITE` | color | output |
| `$08` | `DIS_CASE_SWITCH` | editor | output |
| `$09` | `ENA_CASE_SWITCH` | editor | output |
| `$0D` | `RETURN` | editor | both |
| `$0E` | `LOWER_CASE` | character-set mode | output |
| `$11` | `CRSR_DOWN` | cursor | both |
| `$12` | `RVS_ON` | video mode | output |
| `$13` | `CRSR_HOME` | cursor | both |
| `$14` | `DEL` | editor | both |
| `$1C` | `COL_RED` | color | output |
| `$1D` | `CRSR_RIGHT` | cursor | both |
| `$1E` | `COL_GREEN` | color | output |
| `$1F` | `COL_BLUE` | color | output |
| `$81` | `COL_ORANGE` | color | output |
| `$85` | `KEY_F1` | function key | input |
| `$86` | `KEY_F3` | function key | input |
| `$87` | `KEY_F5` | function key | input |
| `$88` | `KEY_F7` | function key | input |
| `$89` | `KEY_F2` | function key | input |
| `$8A` | `KEY_F4` | function key | input |
| `$8B` | `KEY_F6` | function key | input |
| `$8C` | `KEY_F8` | function key | input |
| `$8D` | `SHIFT_RETURN` | editor | both |
| `$8E` | `UPPER_CASE` | character-set mode | output |
| `$90` | `COL_BLACK` | color | output |
| `$91` | `CRSR_UP` | cursor | both |
| `$92` | `RVS_OFF` | video mode | output |
| `$93` | `CLEAR` | editor | output |
| `$94` | `INST` | editor | both |
| `$95` | `COL_BROWN` | color | output |
| `$96` | `COL_LIGHT_RED` | color | output |
| `$97` | `COL_DARK_GREY` | color | output |
| `$98` | `COL_GREY` | color | output |
| `$99` | `COL_LIGHT_GREEN` | color | output |
| `$9A` | `COL_LIGHT_BLUE` | color | output |
| `$9B` | `COL_LIGHT_GREY` | color | output |
| `$9C` | `COL_PURPLE` | color | output |
| `$9D` | `CRSR_LEFT` | cursor | both |
| `$9E` | `COL_YELLOW` | color | output |
| `$9F` | `COL_CYAN` | color | output |

## constraints
- Agents MUST use control-code names only in PETSCII/KERNAL I/O context; control codes have no screen-code equivalent.
- Color control codes SHOULD link to [../colors/palette.md](../colors/palette.md) for numeric color indices and RGB approximations.
- Cursor/control examples SHOULD route to KERNAL `CHROUT` (`$FFD2`), not direct screen memory, unless explicitly converted.
- Code MUST NOT confuse function-key input bytes (`$85-$8C`) with color codes occupying the same numeric range used as output; direction context resolves the meaning.

## links
- PETSCII: [petscii.md](petscii.md)
- screen codes: [screen-codes.md](screen-codes.md)
- colors: [../colors/palette.md](../colors/palette.md)
- KERNAL screen I/O: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- charset index: [INDEX.md](INDEX.md)
- palette: [../colors/palette.md](../colors/palette.md)
