---
type: reference
domain: charset
granularity: code-space
---

## facts
- Screen codes are bytes stored in the screen matrix; they are not the same thing as PETSCII input/output bytes.
- the local primary character-set coverage maps C64 primary character-set code points to Unicode names such as `SPACE`, `LATIN CAPITAL LETTER A`, arrows, suits, and box-drawing symbols.
- Screen display also depends on selected character set, VIC-II `$D018`, and memory banking.

## lookup
| code | Unicode mapping in primary source | notes |
|---:|---|---|
| `$20` | `SPACE` | Printable space. |
| `$30-$39` | `DIGIT ZERO` through `DIGIT NINE` | Numeric glyphs. |
| `$41-$5A` | `LATIN CAPITAL LETTER A` through `Z` | Alphabetic glyphs in source map. |
| `$5C` | `POUND SIGN` | C64-specific visible glyph mapping. |
| `$5E` | `UPWARDS ARROW` | C64 keyboard/glyph convention. |
| `$5F` | `LEFTWARDS ARROW` | C64 keyboard/glyph convention. |
| `$60-$7F` | Box/suit/graphics block area | Use source map for exact glyph. |
| `$A0-$FF` | Graphics/shifted/repeated ranges | Use source map for exact glyph. |

## constraints
- Agents MUST distinguish screen-code values from PETSCII/control values.
- Direct screen writes SHOULD pair screen-code bytes with color RAM writes when foreground color matters.
- Custom character-set explanations MUST include VIC-II character base configuration.

## links
- screen memory concept: [../concepts/screen-memory.md](../concepts/screen-memory.md)
- PETSCII: [petscii.md](petscii.md)
- VIC-II: [../io/vic-ii.md](../io/vic-ii.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- charset index: [INDEX.md](INDEX.md)
- character-set concept: [../concepts/character-sets.md](../concepts/character-sets.md)
