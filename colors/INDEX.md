---
type: index
domain: colors
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| C64 color numbers and names | [palette.md](palette.md) | Use for VIC-II colors, color RAM nibbles, and control-code color selection. |
| VIC-II color registers | [../io/vic-ii.md](../io/vic-ii.md) | Use for border/background/sprite registers. |
| Color RAM | [../io/color-ram.md](../io/color-ram.md) | `$D800-$DBFF`; stores color nibbles for screen cells. |

## source-coverage
| source | status | notes |
|---|---|---|
| `C:\Code\c64ref\src\charset\palette_c64.txt` | planned | Compact palette source. |
| `C:\Code\c64ref\src\colors\index.html` | planned | Color reference UI source. |
| `C:\Code\c64ref\src\colors\script.js` | planned | UI data or transformation logic if needed. |

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II and color RAM. |
| Charset | [../charset/control-codes.md](../charset/control-codes.md) | Color control codes. |
| Tasks | [../tasks/print-to-screen.md](../tasks/print-to-screen.md) | Applying colors while printing. |
