---
type: reference
domain: charset
granularity: code-space
summary: "The PETSCII encoding used by CHROUT and GETIN; not the screen-code encoding."
keywords: [PETSCII, character encoding, printable range, code space]
---

## facts
- PETSCII is the byte encoding used by KERNAL `CHROUT` (`$FFD2`) for output and `CHRIN`/`GETIN` (`$FFCF`/`$FFE4`) for input; it is NOT the screen-code encoding stored in screen matrix RAM.
- Two character-set modes are selectable at runtime via PETSCII controls `$0E` (lower/upper) and `$8E` (upper/graphics); printable letter codes map to different glyphs in each mode.
- Codes `$00-$1F` and `$80-$9F` are control ranges; `$20-$7F` and `$A0-$FF` are printable (graphics, letters, and reverse-area glyphs).
- Codes `$60-$7F` and `$E0-$FF` are unused/aliased for KERNAL output but ARE valid input bytes from `GETIN` (shifted graphics keys).
- Convert PETSCII letter to screen code: `$40-$5F` → subtract `$40`; `$60-$7F` → subtract `$20`; `$20-$3F` → unchanged; `$A0-$BF` → subtract `$40`; `$C0-$FF` → subtract `$80`.

## lookup — control codes `$00-$1F`
| code | name | use |
|---:|---|---|
| `$03` | `STOP` | RUN/STOP key signal. |
| `$05` | `COL_WHITE` | Set output color white. |
| `$08` | `DIS_CASE_SWITCH` | Disable C= + SHIFT case toggle. |
| `$09` | `ENA_CASE_SWITCH` | Enable C= + SHIFT case toggle. |
| `$0D` | `RETURN` | Carriage return / end of input. |
| `$0E` | `LOWER_CASE` | Switch to lower/upper character set. |
| `$11` | `CRSR_DOWN` | Cursor down. |
| `$12` | `RVS_ON` | Reverse video on. |
| `$13` | `CRSR_HOME` | Home cursor. |
| `$14` | `DEL` | Delete left of cursor. |
| `$1C` | `COL_RED` | Set output color red. |
| `$1D` | `CRSR_RIGHT` | Cursor right. |
| `$1E` | `COL_GREEN` | Set output color green. |
| `$1F` | `COL_BLUE` | Set output color blue. |

## lookup — printable `$20-$7F`
| code(s) | name | notes |
|---:|---|---|
| `$20` | `SPACE` | Same byte in both case modes. |
| `$21-$2F` | `!` `"` `#` `$` `%` `&` `'` `(` `)` `*` `+` `,` `-` `.` `/` | ASCII-compatible punctuation. |
| `$30-$39` | `0`-`9` | ASCII-compatible digits. |
| `$3A-$3F` | `:` `;` `<` `=` `>` `?` | ASCII-compatible punctuation. |
| `$40` | `@` | Commercial at. |
| `$41-$5A` | `A`-`Z` in upper/graphics mode; `a`-`z` in lower/upper mode | Letter codes follow case mode. |
| `$5B` | `[` | Left square bracket. |
| `$5C` | `£` | C64 pound sign (NOT ASCII backslash). |
| `$5D` | `]` | Right square bracket. |
| `$5E` | `↑` | Upwards arrow. |
| `$5F` | `←` | Leftwards arrow. |
| `$60-$7F` | graphics block | Aliases for `$A0-$BF` on output; valid as input from shifted graphics keys. |

## lookup — control codes `$80-$9F`
| code | name | use |
|---:|---|---|
| `$81` | `COL_ORANGE` | Set output color orange. |
| `$85-$8C` | `KEY_F1`-`KEY_F8` | Function-key input codes (F1, F3, F5, F7 are unshifted; F2, F4, F6, F8 are shifted). |
| `$8D` | `SHIFT_RETURN` | Shifted return (no program-line tokenization). |
| `$8E` | `UPPER_CASE` | Switch to upper/graphics character set. |
| `$90` | `COL_BLACK` | Set output color black. |
| `$91` | `CRSR_UP` | Cursor up. |
| `$92` | `RVS_OFF` | Reverse video off. |
| `$93` | `CLEAR` | Clear screen. |
| `$94` | `INST` | Insert blank (SHIFT + INST/DEL). |
| `$95` | `COL_BROWN` | Set output color brown. |
| `$96` | `COL_LIGHT_RED` | Set output color light red / pink. |
| `$97` | `COL_DARK_GREY` | Set output color dark grey. |
| `$98` | `COL_GREY` | Set output color medium grey. |
| `$99` | `COL_LIGHT_GREEN` | Set output color light green. |
| `$9A` | `COL_LIGHT_BLUE` | Set output color light blue. |
| `$9B` | `COL_LIGHT_GREY` | Set output color light grey. |
| `$9C` | `COL_PURPLE` | Set output color purple. |
| `$9D` | `CRSR_LEFT` | Cursor left. |
| `$9E` | `COL_YELLOW` | Set output color yellow. |
| `$9F` | `COL_CYAN` | Set output color cyan. |

## lookup — printable `$A0-$FF`
| code(s) | name | notes |
|---:|---|---|
| `$A0` | `SHIFT_SPACE` | Same glyph as `$20` but distinct byte. |
| `$A1-$BF` | CBM graphics block | Suits, lines, blocks, shaded patterns; see [chargen-primary.md](chargen-primary.md). |
| `$C0-$DF` | graphics / letter variants | In upper/graphics mode: graphics. In lower/upper mode: uppercase letters. |
| `$DE` | `π` | PI symbol (also reachable as `$FF`). |
| `$E0-$FE` | graphics block | Aliases of `$A0-$BE` on output; reverse-area glyphs. |
| `$FF` | `π` | Alias for `$DE`. |

## constraints
- Code MUST NOT write PETSCII bytes directly into screen RAM (`$0400-$07E7`); use screen codes or call `CHROUT` instead.
- Output examples using KERNAL `CHROUT` SHOULD use PETSCII names from this page.
- Code SHOULD route glyph/Unicode questions to [screen-codes.md](screen-codes.md) and [chargen-primary.md](chargen-primary.md).
- Code MUST NOT assume a PETSCII letter byte maps to the same glyph in both case modes; mode is selected by `$0E`/`$8E` controls or `$D018`.

## links

- screen codes: [screen-codes.md](screen-codes.md)
- keyboard matrix: [keyboard-matrix.md](keyboard-matrix.md)
- KERNAL screen I/O: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)
- colors: [../colors/palette.md](../colors/palette.md)

## sources

- charset index: [INDEX.md](INDEX.md)
- control codes: [control-codes.md](control-codes.md)
- primary chargen: [chargen-primary.md](chargen-primary.md)
