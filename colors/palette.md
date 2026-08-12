---
type: reference
domain: colors
granularity: lookup
summary: "The 16 C64 color indices with names, luma level, and RGB approximation."
keywords: [color numbers, palette, RGB values, color RAM nibble]
---

## lookup
| index | symbol | luma | RGB hex |
|---:|---|:---:|---:|
| `$0` | `COL_BLACK` | 0 | `#000000` |
| `$1` | `COL_WHITE` | 32 | `#FFFFFF` |
| `$2` | `COL_RED` | 10 | `#813338` |
| `$3` | `COL_CYAN` | 20 | `#75CEC8` |
| `$4` | `COL_PURPLE` | 12 | `#8E3C97` |
| `$5` | `COL_GREEN` | 16 | `#56AC4D` |
| `$6` | `COL_BLUE` | 8 | `#2E2C9B` |
| `$7` | `COL_YELLOW` | 24 | `#EDF171` |
| `$8` | `COL_ORANGE` | 12 | `#8E5029` |
| `$9` | `COL_BROWN` | 8 | `#553800` |
| `$A` | `COL_LIGHT_RED` | 16 | `#C46C71` |
| `$B` | `COL_DARK_GRAY` | 10 | `#4A4A4A` |
| `$C` | `COL_MEDIUM_GRAY` | 15 | `#7B7B7B` |
| `$D` | `COL_LIGHT_GREEN` | 24 | `#A9FF9F` |
| `$E` | `COL_LIGHT_BLUE` | 15 | `#706DEB` |
| `$F` | `COL_LIGHT_GRAY` | 20 | `#B2B2B2` |

## constraints
- Color RAM values MUST be treated as 4-bit color indices `$0-$F`.
- RGB values SHOULD be treated as palette approximations from the local palette page (`Colodore`), not universal analog output truth.
- Luma values are from the Pepto color model (most common VIC-II revision); first-revision chips used 5 coarser luma steps — see [luma-clusters.md](luma-clusters.md).
- Color control-code examples SHOULD cite [../charset/control-codes.md](../charset/control-codes.md).

## links

- luma clusters: [luma-clusters.md](luma-clusters.md)
- color RAM: [../io/color-ram.md](../io/color-ram.md)
- VIC-II: [../io/vic-ii.md](../io/vic-ii.md)

## sources

- colors index: [INDEX.md](INDEX.md)
- charset controls: [../charset/control-codes.md](../charset/control-codes.md)
