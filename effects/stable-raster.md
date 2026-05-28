---
type: reference
domain: effects
granularity: atomic
---

## facts
- 6502/6510 instructions take 2–9 cycles; a raster IRQ fires at a fixed cycle within a line but the handler's first instruction starts at a variable offset depending on what was executing.
- Without synchronization, raster effects jitter by ±1 raster line each frame.
- The double-IRQ technique eliminates jitter by detecting the current cycle position and compensating with a 1-cycle delay when needed.

## sequence — double-IRQ stable sync

1. Set up a first raster IRQ at any convenient line (e.g., line `$F9`).
2. In IRQ 1: set the target raster line in `$D012` for IRQ 2 (the line where the effect runs).
3. Acknowledge `$D019` and return from IRQ 1 with `RTI`.
4. IRQ 2 fires on the target line. At the top of IRQ 2:
   - Read `$D012` (current raster line).
   - If the line has already advanced past the trigger line, the handler started late — insert a 1-cycle `NOP` or use a `BIT $EA` (3 cycles) to realign.
   - If still on the trigger line, proceed immediately.
5. All cycle-exact register writes follow after the sync check.

## lookup
| chip | cycles per line | lines per frame | notes |
|---|---|---|---|
| VIC-II 6569 (PAL-B) | 63 | 312 | Most common European C64 |
| VIC-II 6567R8 (NTSC-M) | 65 | 263 | US C64 |
| VIC-II 6567R56A (old NTSC) | 64 | 262 | Early revision |

| register | purpose |
|---|---|
| `$D012` | Raster line counter bits 0–7 (read current line or set compare) |
| `$D011` bit 7 | Raster line bit 8 (MSB of compare value) |
| `$D019` | IRQ status — MUST write `$01` to acknowledge raster IRQ |
| `$D01A` | IRQ enable — bit 0 enables raster IRQ |

## constraints
- The sync check (`$D012` read + branch) MUST happen before any cycle-sensitive register write.
- `RTI` takes 6 cycles; account for it in cycle budgets.
- Bad lines steal 40 cycles from the CPU on lines where `YSCROLL == raster & 7`; avoid placing critical writes on bad lines or use [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md) to plan around them.
- Self-modifying code is commonly used to patch the delay instruction in/out; this MUST NOT run from ROM.
- NTSC routines MUST use 65 cycles/line in cycle tables, not 63.

## links
- tasks: [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md)
- effects: [open-borders.md](open-borders.md)
- effects: [rasterbars.md](rasterbars.md)
- effects: [dysp.md](dysp.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources
- codebase64.net: [Making Stable Raster Routines](https://codebase64.net/doku.php?id=interrupts:making_stable_raster_routines) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
