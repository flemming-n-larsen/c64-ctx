---
type: reference
domain: concepts
granularity: concept
source: codebase64.net
summary: "How the EXROM and GAME expansion-port lines combine with $0001 to pick a memory map."
keywords: [cartridge, EXROM, GAME, PLA, expansion port, memory config]
---

## facts
- The expansion port exposes two active-low signals, `EXROM` and `GAME`, that the PLA uses alongside `$0001` bits to determine the final memory map.
- Three cartridge configurations exist for cartridges without full Ultimax mode.
- In Ultimax mode (`GAME` low, `EXROM` high) internal RAM is visible only at `$0000-$0FFF`; all other regions are either cartridge ROM or open bus.
- VIC-II always reads character ROM from its internal copy regardless of cartridge banking state.

## lookup

### Cartridge line combinations and their effects
| `EXROM` | `GAME` | configuration | effect |
|:---:|:---:|---|---|
| low | high | ROML only | Cartridge ROM mapped at `$8000-$9FFF` before BASIC ROM; `$A000-$BFFF` still BASIC ROM or RAM per `$0001`. |
| low | low | ROML + ROMH | `$8000-$9FFF` = ROML; `$A000-$BFFF` = ROMH (replaces BASIC ROM regardless of LORAM). |
| high | low | Ultimax | Only `$0000-$0FFF` internal RAM visible; `$E000-$FFFF` = cartridge ROM; rest is open bus or I/O. |
| high | high | no cartridge | Normal `$0001`-controlled banking applies; hardware default when slot is empty. |

## constraints
- In ROML-only mode HIRAM and LORAM still govern `$E000-$FFFF` and `$A000-$BFFF` respectively, so `ROMH` does not appear unless both `EXROM` and `GAME` are low.
- Ultimax mode MUST NOT be entered unexpectedly; code at `$0000-$0FFF` must be self-sufficient as stack, zero-page, and entry point, because no other internal RAM is reachable.
- The CPU MUST NOT rely on KERNAL ROM in Ultimax mode unless the cartridge re-maps equivalent routines at `$E000-$FFFF`.

## sources

- codebase64.net: [Memory Management in Commodore 64](https://codebase64.net/doku.php?id=base:memory_management) — CC BY-NC-SA 4.0
- memory banking ($0001): [memory-banking.md](memory-banking.md)
- memory map: [../memory/map.md](../memory/map.md)
- KERNAL ROM: [../memory/kernal-rom.md](../memory/kernal-rom.md)
