---
type: reference
domain: effects
granularity: atomic
summary: "Redirect stub with effect-side notes; stable timing lives in the irq domain."
keywords: [stable raster, redirect, effect timing]
---

## route
- Canonical stable timing route: [../irq/stable-timing.md](../irq/stable-timing.md)
- Canonical raster IRQ setup: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)

## effect-use
- Stable timing is the prerequisite for effect code that depends on cycle-repeatable VIC-II writes, such as rasterbars, border tricks, DYCP/DYSP, and similar scanline-split effects.
- Use the generic timing recipe in [../irq/stable-timing.md](../irq/stable-timing.md) first, then apply the effect-specific register schedule for the chosen visual routine.
- When the effect writes to `$D020`, `$D021`, `$D016`, `$D018`, or sprite registers at exact cycles, keep bad-line and PAL/NTSC differences visible in the local effect page.

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
- Use [../irq/stable-timing.md](../irq/stable-timing.md) for the generic sync method; keep this page focused on why effects need that method.
- Bad lines steal 40 cycles from the CPU on lines where `YSCROLL == raster & 7`; avoid placing critical writes on bad lines or use [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md) to plan around them.
- NTSC routines MUST use 65 cycles/line in cycle tables, not 63.

## sources

- canonical route: [../irq/stable-timing.md](../irq/stable-timing.md)
- raster setup: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- effects: [open-borders.md](open-borders.md)
- effects: [rasterbars.md](rasterbars.md)
- effects: [dysp.md](dysp.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
