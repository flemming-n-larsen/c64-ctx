---
type: reference
domain: io
granularity: address-range
summary: "The 4-bit-per-cell color RAM: where it lives and what the upper nibble does."
keywords: [color RAM, nibble, cell color, upper nibble garbage]
---

## facts
- `$D800-$DBFF` is `Color RAM (Nybbles)` in the local I/O pages.
- Color RAM corresponds to text screen cells when standard text display conventions are used.
- Only the low `4` bits carry the color value for each cell.

## lookup
| range | role | companion |
|---|---|---|
| `$D800-$DBFF` | Color RAM nybbles | Default screen matrix `$0400-$07E7`. |
| color value `$0-$F` | Cell foreground color index | [../colors/palette.md](../colors/palette.md). |

## constraints
- Agents MUST describe color RAM as nybble storage, not full byte color storage.
- Code SHOULD mask color values to `$0F` before storing when upper bits are not meaningful.
- Screen-memory explanations SHOULD link both color RAM and VIC-II memory-control facts.

## sources

- I/O index: [INDEX.md](INDEX.md)
- palette: [../colors/palette.md](../colors/palette.md)
- screen memory: [../concepts/screen-memory.md](../concepts/screen-memory.md)
- VIC-II: [vic-ii.md](vic-ii.md)
