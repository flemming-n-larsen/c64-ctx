---
type: reference
domain: io
granularity: address-range
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

## links
- screen memory: [../concepts/screen-memory.md](../concepts/screen-memory.md)
- VIC-II: [vic-ii.md](vic-ii.md)
- palette: [../colors/palette.md](../colors/palette.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- I/O index: [INDEX.md](INDEX.md)
- palette: [../colors/palette.md](../colors/palette.md)
