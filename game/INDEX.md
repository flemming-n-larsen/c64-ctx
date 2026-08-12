---
type: index
domain: game
source: codebase64.net
---

## routes
| need | read | notes |
|---|---|---|
| Tile-based map encoding, block addressing, world coordinates | [tilemaps.md](tilemaps.md) | Block structure, decode loop, coordinate methods; sourced from Cadaver Rant 4. |
| Multidirectional scrolling, fine/coarse scroll pipeline, doublebuffering | [scrolling.md](scrolling.md) | VIC-II scroll registers, IRQ-staged shifts, color-RAM update; Rant 4 + 4 Ways Scroll. |
| Frameskipping, interpolation, re-entrant IRQ architecture | [frameskip.md](frameskip.md) | Three-layer code separation: raster IRQ / frame-update / main loop; Cadaver Rant 9. |
| High score comparison, persistence, and display | [hiscore.md](hiscore.md) | Multi-byte compare, zero-page persistence, KERNAL SAVE/LOAD. |
| Scoring mechanics: BCD decimal mode, ASCII digit mode | [scoring.md](scoring.md) | Three score methods; decimal-mode IRQ caveat; digit display. |
| Game-loop skeleton (init → input → update → draw → sync) | [../tasks/game-loop.md](../tasks/game-loop.md) | Canonical frame loop recipe. |
| Starfield rendering | [../effects/starfield.md](../effects/starfield.md) | ROL-based or sprite-based; speed tiers. |
| Sprite movement, collision, projectiles | [../sprites/INDEX.md](../sprites/INDEX.md) | Sprite discovery hub: hardware setup, collisions, advanced effects. |
| PRNG / pseudo-random number generator | [../effects/rng.md](../effects/rng.md) | X-ABC PRNG; 38 cycles; 8/16-bit output. |
| Speed optimization (cycle budget, loop unrolling, speedcode) | [../optimization/INDEX.md](../optimization/INDEX.md) | Critical for game engines within rastertime budgets. |

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| Split IRQ work from frame logic so the game degrades gracefully under load. | [frameskip.md](frameskip.md) | frameskip, frame update, IRQ split, variable frame rate |
| Compare and store a high score with multi-byte comparison. | [hiscore.md](hiscore.md) | high score, score table, multi-byte compare, score entry |
| Three ways to keep score: BCD, hex with conversion, or ASCII digits. | [scoring.md](scoring.md) | scoring, BCD, decimal mode, score display, points |
| Multidirectional scrolling built on the VIC-II fine-scroll registers. | [scrolling.md](scrolling.md) | scrolling, fine scroll, smooth scroll, multidirectional, map scroll |
| Tile map data layout using 8-bit block indices, and how to draw it. | [tilemaps.md](tilemaps.md) | tile maps, tiles, block indices, level data, map drawing |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Game-loop skeleton, sprite display, keyboard input, file I/O. |
| effects | [../effects/INDEX.md](../effects/INDEX.md) | Effect techniques shared between demos and games (starfield, fire, RNG, multiplexer). |
| sprites | [../sprites/INDEX.md](../sprites/INDEX.md) | Sprite hardware, collision detection, advanced sprite effects. |
| irq | [../irq/INDEX.md](../irq/INDEX.md) | Raster interrupt setup and timing; prerequisite for frameskip architecture. |
| optimization | [../optimization/INDEX.md](../optimization/INDEX.md) | Cycle reduction, loop unrolling, speedcode — critical within game-engine rastertime budgets. |
| algorithms | [../algorithms/INDEX.md](../algorithms/INDEX.md) | Compression (level data), sorting (sprite multiplexer), 3D math. |
