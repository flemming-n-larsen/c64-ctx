---
type: index
domain: sprites
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| Sprite register families, colors, collisions, priority | [registers.md](registers.md) | Sprite-focused register route over the raw VIC-II table in [../io/vic-ii.md](../io/vic-ii.md). |
| Basic sprite setup: data, pointer, position, enable flow | [display.md](display.md) | Consolidates the setup recipe, visible-range notes, and pointer placement rules. |
| Visible ranges, borders, priority, multicolor behavior | [display.md](display.md) | Routes onward to geometry and border-technique pages when placement reaches the borders. |
| DYSP, multiplexers, sprite starfields, border usage, underlay | [advanced.md](advanced.md) | Curated route into the main sprite-heavy `effects/` and `display-modes/` pages. |
| Runnable example | [../examples/kickassembler-sprite.md](../examples/kickassembler-sprite.md) | Minimal buildable KickAssembler sprite program. |

## pages
<!-- GENERATED:routes -->
_Every page in this domain is reached from `## routes` above._
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| VIC | [../vic/INDEX.md](../vic/INDEX.md) | VIC-II-wide banking, timing, and screen-mode context that sprites depend on. |
| tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Recipe-first entry point for concrete sprite setup work. |
| effects | [../effects/INDEX.md](../effects/INDEX.md) | Named demo/game sprite techniques such as DYSP and multiplexers. |
| display-modes | [../display-modes/INDEX.md](../display-modes/INDEX.md) | Sprite-underlay picture formats. |
| examples | [../examples/INDEX.md](../examples/INDEX.md) | Buildable sprite examples. |
| sources | [../sources/INDEX.md](../sources/INDEX.md) | Provenance for `mist64/c64ref` and Codebase64-derived local routes. |
