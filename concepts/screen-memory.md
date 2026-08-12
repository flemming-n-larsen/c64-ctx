---
type: reference
domain: concepts
granularity: concept
summary: "How the screen matrix and color RAM relate, and where each lives."
keywords: [screen memory, screen matrix, color RAM, cell layout]
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

- VIC hub: [../vic/INDEX.md](../vic/INDEX.md)
- VIC memory and banking: [../vic/memory-and-banking.md](../vic/memory-and-banking.md)
- VIC-II: [../io/vic-ii.md](../io/vic-ii.md)
- screen codes: [../charset/screen-codes.md](../charset/screen-codes.md)
- print task: [../tasks/print-to-screen.md](../tasks/print-to-screen.md)

## sources

- memory map: [../memory/map.md](../memory/map.md)
- color RAM: [../io/color-ram.md](../io/color-ram.md)
