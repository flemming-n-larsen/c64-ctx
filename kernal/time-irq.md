---
type: reference
domain: kernal
granularity: api-family
---

## lookup
| symbol | address | category | compact contract |
|---|---:|---|---|
| `SETTIM` | `$FFDB` | `TIME` | Set system jiffy clock. |
| `RDTIM` | `$FFDE` | `TIME` | Read system jiffy clock. |
| `UDTIM` | `$FFEA` | `TIME` | Update system clock. |
| `STOP` | `$FFE1` | `KBD` | Test stop key. |
| `RESTOR` | `$FF8A` | `SYS` | Restore vectors. |
| `VECTOR` | `$FF8D` | `SYS` | Read/set vectors. |

## constraints
- Agents MUST distinguish KERNAL time services from CIA timer hardware.
- IRQ examples SHOULD link to [../irq/overview.md](../irq/overview.md) and device pages for acknowledge rules.
- Code that replaces IRQ handling SHOULD preserve or deliberately replace KERNAL time/keyboard behavior.

## links
- interrupts: [../irq/overview.md](../irq/overview.md)
- raster task: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- CIA1: [../io/cia1.md](../io/cia1.md)
- CIA2: [../io/cia2.md](../io/cia2.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- KERNAL index: [INDEX.md](INDEX.md)
- interrupts: [../irq/overview.md](../irq/overview.md)
