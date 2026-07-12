---
type: index
domain: colors
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| C64 color numbers and names | [palette.md](palette.md) | Use for VIC-II colors, color RAM nibbles, and control-code color selection. |
| Luma clusters and mixing-compatible color pairs | [luma-clusters.md](luma-clusters.md) | Use when selecting color pairs for ALM, DCM, or dithering. |
| VIC-II color registers | [../io/vic-ii.md](../io/vic-ii.md) | Use for border/background/sprite registers. |
| Color RAM | [../io/color-ram.md](../io/color-ram.md) | `$D800-$DBFF`; stores color nibbles for screen cells. |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [palette.md](palette.md) | used | Compact color index, luma levels, and RGB approximation coverage. |
| [luma-clusters.md](luma-clusters.md) | used | VIC-II luma cluster groupings for both chip revisions. |
| [../io/vic-ii.md](../io/vic-ii.md) | used | VIC-II color register context. |
| [../io/color-ram.md](../io/color-ram.md) | used | Color RAM nibble context. |
| [../charset/control-codes.md](../charset/control-codes.md) | used | Color control-code context. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Central upstream fallback route. |

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II and color RAM. |
| Charset | [../charset/control-codes.md](../charset/control-codes.md) | Color control codes. |
| Tasks | [../tasks/print-to-screen.md](../tasks/print-to-screen.md) | Applying colors while printing. |
