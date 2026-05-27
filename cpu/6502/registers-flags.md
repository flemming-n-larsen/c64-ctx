---
type: reference
domain: cpu/6502
granularity: atomic
---

## registers
| register | bits | role |
|---|---:|---|
| `A` | `8` | Accumulator. |
| `X` | `8` | X index register. |
| `Y` | `8` | Y index register. |
| `S` | `8` | Stack pointer; indexes page `$0100-$01FF`. |
| `P` | `8` | Processor status flags. |
| `PC` | `16` | Program counter. |

## flags
| bit | flag | name | common use |
|---:|---|---|---|
| `7` | `N` | Negative | Mirrors bit `7` of many results. |
| `6` | `V` | Overflow | Signed arithmetic overflow / `BIT` source bit. |
| `5` | `-` | Expansion | Agents SHOULD treat as reserved in baseline facts. |
| `4` | `B` | Break command | Set by `BRK` stack status semantics. |
| `3` | `D` | Decimal | Decimal-mode arithmetic flag. |
| `2` | `I` | Interrupt disable | Masks maskable IRQ when set. |
| `1` | `Z` | Zero | Set when result is zero. |
| `0` | `C` | Carry | Carry/borrow, shifts, rotates, comparisons. |

## constraints
- Agents MUST use `A`, `X`, `Y`, `S`, `P`, and `PC` as the canonical register names from the local 6502 CPU pages.
- Interrupt code SHOULD reason about the `I` flag before changing IRQ vectors or device interrupt masks.
- Arithmetic explanations MUST distinguish `C` carry/borrow from `V` signed overflow.

## links
- instruction set: [instruction-set.md](instruction-set.md)
- addressing modes: [addressing-modes.md](addressing-modes.md)
- interrupts: [../../concepts/interrupts.md](../../concepts/interrupts.md)

## sources
- local route: [../../sources/INDEX.md](../../sources/INDEX.md)
- CPU index: [INDEX.md](INDEX.md)
