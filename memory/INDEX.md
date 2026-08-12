---
type: index
domain: memory
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| Whole-machine address overview | [map.md](map.md) | Agents SHOULD start here for unknown addresses. |
| Symbol lookup and aliases | [symbols.md](symbols.md) | Use for zero-page, vectors, and OS workspace names. |
| Zero-page workspace | [zero-page.md](zero-page.md) | Use before relying on BASIC/KERNAL zero-page storage. |
| BASIC ROM range | [basic-rom.md](basic-rom.md) | `$A000-$BFFF`; banking-dependent. |
| KERNAL ROM range | [kernal-rom.md](kernal-rom.md) | `$E000-$FFFF`; includes vectors near top of memory. |
| I/O and character ROM window | [io-area.md](io-area.md) | `$D000-$DFFF`; depends on `CHAREN` and ROM/RAM banking. |
| Hidden RAM beneath `$00`/`$01` processor port registers | [hidden-ram.md](hidden-ram.md) | Read via VIC sprite collision; write via bus residue timing technique. |

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| The BASIC ROM window and what it hides when banked in. | [basic-rom.md](basic-rom.md) | BASIC ROM, banking, LORAM, RAM under ROM |
| Reach the RAM cells beneath the processor port: read via VIC sprite, write via bus residue. | [hidden-ram.md](hidden-ram.md) | hidden RAM, RAM under I/O, bus residue, sprite read trick |
| The I/O and character ROM window, and how CHAREN/HIRAM/LORAM decide what appears there. | [io-area.md](io-area.md) | I/O area, CHAREN, character ROM, banking window |
| The KERNAL ROM window and the hardware vectors near the top of memory. | [kernal-rom.md](kernal-rom.md) | KERNAL ROM, hardware vectors, HIRAM, RAM under ROM |
| Whole-machine address map; start here when an address is unknown. | [map.md](map.md) | memory map, address ranges, ROM RAM overlay, unknown address |
| Named addresses and their aliases: processor port, BASIC and KERNAL workspace, vectors. | [symbols.md](symbols.md) | symbols, aliases, labels, workspace, vector table |
| Who owns which zero-page bytes and which are safe for user code. | [zero-page.md](zero-page.md) | zero page, free bytes, KERNAL workspace, BASIC workspace |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Concepts | [../concepts/memory-banking.md](../concepts/memory-banking.md) | Banking constraints. |
| I/O | [../io/INDEX.md](../io/INDEX.md) | Hardware registers in memory space. |
| ROM | [../rom/INDEX.md](../rom/INDEX.md) | ROM routine locations. |
| BASIC | [../basic/INDEX.md](../basic/INDEX.md) | Interpreter workspace and vectors. |
