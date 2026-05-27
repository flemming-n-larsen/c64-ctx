---
type: reference
domain: concepts
granularity: concept
---

## facts
- The default C64 text screen matrix is commonly routed at `$0400` in C64 memory references.
- Color RAM is `$D800-$DBFF` and stores color nybbles corresponding to screen cells.
- VIC-II register `$D018` selects video matrix base and character dot-data base inside the selected VIC memory bank.

## lookup
| component | default / route | constraints |
|---|---|---|
| Screen matrix | `$0400-$07E7` default text cells | Stores screen codes, not PETSCII. |
| Color RAM | `$D800-$DBFF` | Stores low-nybble color values. |
| Character data | selected by `$D018` and banking | MUST distinguish character ROM/RAM from screen matrix bytes. |
| VIC bank | CIA2-related selection | CPU address and VIC-visible address MAY differ by bank configuration. |

## constraints
- Agents MUST distinguish PETSCII input/output bytes from screen codes stored in screen memory.
- Code that writes directly to screen RAM SHOULD write matching color RAM when foreground color matters.
- Explanations of custom screen or charset locations MUST include VIC-II `$D018` and VIC bank context.

## links
- VIC-II: [../io/vic-ii.md](../io/vic-ii.md)
- color RAM: [../io/color-ram.md](../io/color-ram.md)
- screen codes: [../charset/screen-codes.md](../charset/screen-codes.md)
- print task: [../tasks/print-to-screen.md](../tasks/print-to-screen.md)

## sources
- `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt`
- `C:\Code\c64ref\src\c64io\c64io_prg.txt`
- `C:\Code\c64ref\src\charset\keyboard_c64.txt`