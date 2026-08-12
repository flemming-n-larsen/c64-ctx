---
type: reference
domain: irq
granularity: concept
source: codebase64.net
summary: "Stack-slice context switching to run several bounded tasks from one interrupt."
keywords: [cooperative threads, scheduler, context switch, stack slice]
---

## facts
- Cooperative multitasking on 6502 commonly uses the hardware stack (`$0100-$01FF`) as the saved execution context for each thread.
- In the common IRQ-driven pattern, the handler saves the current stack pointer, loads the next thread's saved stack pointer, and exits through the normal interrupt return path.
- The saved stack frame normally includes the IRQ-pushed status/PC plus software-pushed `A`, `X`, and `Y`.
- NMI can be used for the same context-switch pattern when the normal IRQ channel must remain dedicated to other services.

## lookup
| need | read | notes |
|---|---|---|
| IRQ install and coexistence | [../irq/raster-interrupt.md](../irq/raster-interrupt.md) | Same vector/acknowledge discipline applies before adding scheduling logic. |
| KERNAL IRQ ownership | [../kernal/time-irq.md](../kernal/time-irq.md) | Decide whether the switcher chains to ROM or fully replaces it. |
| Legacy thread example | [../tasks/cooperative-threads.md](../tasks/cooperative-threads.md) | Stack-slice layout and round-robin switch example. |
| Game-loop integration | [../tasks/game-loop.md](../tasks/game-loop.md) | Use when the scheduler feeds mainline/game-state work. |
| Vectors and symbols | [../memory/symbols.md](../memory/symbols.md) | `CINV`, `NMINV`, stack/IRQ vector context. |

## constraints
- The hardware stack is only 256 bytes, so thread count and call depth MUST be budgeted explicitly.
- All threads share zero page, RAM, and I/O state unless code saves and restores those resources separately.
- IRQ-driven schedulers SHOULD keep per-frame work bounded so raster, music, and timer consumers are not starved.
- NMI-based switchers MUST still account for RESTORE/NMI interactions on the C64.

## links

- interrupt hub: [INDEX.md](INDEX.md)
- raster interrupt recipe: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- memory symbols: [../memory/symbols.md](../memory/symbols.md)
- task/game-loop context: [../tasks/game-loop.md](../tasks/game-loop.md)

## sources

- legacy task route: [../tasks/cooperative-threads.md](../tasks/cooperative-threads.md)
- KERNAL coexistence: [../kernal/time-irq.md](../kernal/time-irq.md)
- codebase64.net: [Interrupts](https://codebase64.net/doku.php?id=base%3Ainterrupts) — CC BY-NC-SA 4.0; Codebase64 interrupt coverage groups cooperative threading with advanced IRQ-driven program-flow material.
