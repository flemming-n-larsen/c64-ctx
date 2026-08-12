---
type: index
domain: optimization
source: codebase64.net
---

## routes
| need | read | notes |
|---|---|---|
| Reduce rastertime, avoid KERNAL in loops | [speed.md](speed.md) | Opcode cycle table, loop unrolling, JSR/RTS cost, KERNAL avoidance. |
| Loop vs. unrolled code tradeoffs | [loop-unrolling.md](loop-unrolling.md) | Cycle math, self-modifying loops, when unrolling doesn't help. |
| Advanced cycle-saving tricks | [advanced.md](advanced.md) | Branch optimization, illegal opcodes, carry reuse, register conservation, page alignment. |
| Runtime code generation | [speedcode.md](speedcode.md) | Generate speedcode at runtime; generator vs. pre-generated tradeoffs. |
| Reduce binary size (sizecoding) | [sizecoding.md](sizecoding.md) | KERNAL routines for byte-saving: clears, copies, scrolls, 16-bit ops. |

## links
- root: [../INDEX.md](../INDEX.md)
- related effects: [../effects/INDEX.md](../effects/INDEX.md)
- related tasks: [../tasks/INDEX.md](../tasks/INDEX.md)
- CPU reference: [../cpu/6502/INDEX.md](../cpu/6502/INDEX.md)

## pages
<!-- GENERATED:routes -->
_Every page in this domain is reached from `## routes` above._
<!-- /GENERATED:routes -->
