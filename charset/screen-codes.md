---
type: reference
domain: charset
granularity: code-space
summary: "The byte values stored in screen matrix RAM, each indexing one glyph in the active set."
keywords: [screen codes, screen matrix, reverse range, glyph index]
---

## facts
- Screen codes are the byte values stored in the screen matrix (default `$0400-$07E7`); each byte indexes one 8×8 glyph in the active character set.
- Screen codes are NOT PETSCII; PETSCII bytes written via KERNAL `CHROUT` are translated to screen codes by the editor ROM.
- The selected character set (upper/graphics vs lower/upper) is chosen by VIC-II `$D018` character base bits; the same screen code shows a different glyph in each set.
- Screen codes `$80-$FF` are the reverse-video versions of `$00-$7F`; bit 7 of the matrix byte selects reverse display.
- Convert PETSCII to screen code: `$20-$3F` → unchanged; `$40-$5F` → subtract `$40`; `$60-$7F` → subtract `$20`; `$A0-$BF` → subtract `$40`; `$C0-$FE` → subtract `$80`. PETSCII control codes (`$00-$1F`, `$80-$9F`) have NO screen-code equivalent.

## lookup — primary set `$00-$7F`
| sc | glyph | PETSCII equiv | notes |
|---:|---|---:|---|
| `$00` | `@` | `$40` | Commercial at. |
| `$01-$1A` | `A`-`Z` | `$41-$5A` | Uppercase letters (primary set) / lowercase (alternate set). |
| `$1B` | `[` | `$5B` | Left square bracket. |
| `$1C` | `£` | `$5C` | Pound sign. |
| `$1D` | `]` | `$5D` | Right square bracket. |
| `$1E` | `↑` | `$5E` | Upwards arrow. |
| `$1F` | `←` | `$5F` | Leftwards arrow. |
| `$20` | space | `$20` | Blank cell. |
| `$21-$2F` | `!` `"` `#` `$` `%` `&` `'` `(` `)` `*` `+` `,` `-` `.` `/` | `$21-$2F` | Punctuation. |
| `$30-$39` | `0`-`9` | `$30-$39` | Digits. |
| `$3A-$3F` | `:` `;` `<` `=` `>` `?` | `$3A-$3F` | Punctuation. |
| `$40-$5F` | CBM graphics block A | `$A0-$BF` | Suits, lines, blocks; see [chargen-primary.md](chargen-primary.md). |
| `$60-$7F` | CBM graphics block B | `$C0-$DF` | Continuation of graphics; includes `$7E` = `π`. |

## lookup — reverse range `$80-$FF`
| sc | meaning | notes |
|---:|---|---|
| `$80-$FF` | reverse-video form of `$00-$7F` | `sc XOR $80` selects the reverse glyph of base sc; bit 7 = reverse on. |

## constraints
- Code MUST distinguish screen-code values from PETSCII/control values; the same byte means different things in screen RAM vs `CHROUT` arguments.
- Direct screen writes SHOULD pair screen-code bytes (`$0400+`) with color-RAM writes (`$D800+`) when foreground color matters.
- Custom character-set explanations MUST include VIC-II `$D018` character base configuration and bank-relative addressing.
- Code MUST NOT assume the same glyph for a given screen code across both character sets; the set is selected by `$D018` bit 1.

## links
- screen memory concept: [../concepts/screen-memory.md](../concepts/screen-memory.md)
- PETSCII: [petscii.md](petscii.md)
- primary charset bytes: [chargen-primary.md](chargen-primary.md)
- alternate charset bytes: [chargen-alternate.md](chargen-alternate.md)
- VIC-II: [../io/vic-ii.md](../io/vic-ii.md)
- color RAM: [../io/color-ram.md](../io/color-ram.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- charset index: [INDEX.md](INDEX.md)
- character-set concept: [../concepts/character-sets.md](../concepts/character-sets.md)
- primary chargen: [chargen-primary.md](chargen-primary.md)
