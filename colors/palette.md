---
type: reference
domain: colors
granularity: lookup
---

## lookup
| index | symbol | RGB hex |
|---:|---|---:|
| `$0` | `COL_BLACK` | `#000000` |
| `$1` | `COL_WHITE` | `#FFFFFF` |
| `$2` | `COL_RED` | `#813338` |
| `$3` | `COL_CYAN` | `#75CEC8` |
| `$4` | `COL_PURPLE` | `#8E3C97` |
| `$5` | `COL_GREEN` | `#56AC4D` |
| `$6` | `COL_BLUE` | `#2E2C9B` |
| `$7` | `COL_YELLOW` | `#EDF171` |
| `$8` | `COL_ORANGE` | `#8E5029` |
| `$9` | `COL_BROWN` | `#553800` |
| `$A` | `COL_LIGHT_RED` | `#C46C71` |
| `$B` | `COL_DARK_GRAY` | `#4A4A4A` |
| `$C` | `COL_MEDIUM_GRAY` | `#7B7B7B` |
| `$D` | `COL_LIGHT_GREEN` | `#A9FF9F` |
| `$E` | `COL_LIGHT_BLUE` | `#706DEB` |
| `$F` | `COL_LIGHT_GRAY` | `#B2B2B2` |

## constraints
- Color RAM values MUST be treated as 4-bit color indices `$0-$F`.
- RGB values SHOULD be treated as palette approximations from `palette_c64.txt` (`Colodore`), not universal analog output truth.
- Color control-code examples SHOULD cite [../charset/control-codes.md](../charset/control-codes.md).

## links
- color RAM: [../io/color-ram.md](../io/color-ram.md)
- VIC-II: [../io/vic-ii.md](../io/vic-ii.md)
- control codes: [../charset/control-codes.md](../charset/control-codes.md)

## sources
- `C:\Code\c64ref\src\charset\palette_c64.txt`
- `C:\Code\c64ref\src\colors\index.html`
- `C:\Code\c64ref\src\colors\script.js`
