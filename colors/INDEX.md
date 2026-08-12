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
| Color RAM | [../io/color-ram.md](../io/color-ram.md) | Physical window `$D800-$DBFF`; screen cells use `$D800-$DBE7`. |

## pages
<!-- GENERATED:routes -->
_Every page in this domain is reached from `## routes` above._
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| I/O | [../io/INDEX.md](../io/INDEX.md) | VIC-II and color RAM. |
| Charset | [../charset/control-codes.md](../charset/control-codes.md) | Color control codes. |
| Tasks | [../tasks/print-to-screen.md](../tasks/print-to-screen.md) | Applying colors while printing. |
