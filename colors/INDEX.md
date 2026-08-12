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

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| Which VIC-II color pairs share a luma step and therefore mix without visible banding. | [luma-clusters.md](luma-clusters.md) | luma clusters, banding, dithering, ALM, DCM, color mixing |
| The 16 C64 color indices with names, luma level, and RGB approximation. | [palette.md](palette.md) | color numbers, palette, RGB values, color RAM nibble |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II and color RAM. |
| Charset | [../charset/control-codes.md](../charset/control-codes.md) | Color control codes. |
| Tasks | [../tasks/print-to-screen.md](../tasks/print-to-screen.md) | Applying colors while printing. |
