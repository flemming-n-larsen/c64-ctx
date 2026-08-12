---
type: reference
domain: tasks
granularity: recipe
summary: "Redirect stub: cooperative threading now lives in the irq domain."
keywords: [cooperative threads, redirect, moved page]
---

## route
- Canonical advanced-flow route: [../irq/cooperative-threads.md](../irq/cooperative-threads.md)
- Canonical IRQ setup route: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)

## notes
- The generic interrupt-driven threading technique now lives in `irq/` so it can be shared by demo, game, and scheduler use cases.
- Keep task-domain guidance focused on the consumer workflow that uses the scheduler, such as game-loop or frame-budget organization.

## constraints
- Thread count and stack depth still need explicit budgeting because the 6502 hardware stack is only 256 bytes.
- Shared zero-page and I/O ownership remain local design constraints even when the generic switching recipe is centralized under `/irq`.

## links

- raster interrupt setup: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- game loop pattern: [game-loop.md](game-loop.md)
- bank switch (KERNAL on/off): [bank-switch-rom-ram.md](bank-switch-rom-ram.md)

## sources

- canonical route: [../irq/cooperative-threads.md](../irq/cooperative-threads.md)
