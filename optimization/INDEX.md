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
| answers | read | terms |
|---|---|---|
| Advanced cycle savers: branch cost, illegal opcodes, carry reuse, page alignment. | [advanced.md](advanced.md) | advanced optimization, cycle saving, page crossing, register conservation |
| When unrolling a loop pays for itself, and when it does not. | [loop-unrolling.md](loop-unrolling.md) | loop unrolling, unrolled loop, loop overhead, size vs speed |
| Save bytes by reusing KERNAL routines for their side effects. | [sizecoding.md](sizecoding.md) | sizecoding, byte saving, small binary, KERNAL side effects |
| Reduce rastertime: opcode cycle costs, KERNAL avoidance, call overhead. | [speed.md](speed.md) | speed optimization, rastertime, cycle counting, KERNAL avoidance |
| Generate unrolled code at runtime, and when a generator beats pre-generated code. | [speedcode.md](speedcode.md) | speedcode, runtime code generation, code generator, self-modifying |
<!-- /GENERATED:routes -->
