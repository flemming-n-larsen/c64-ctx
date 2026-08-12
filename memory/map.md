---
type: reference
domain: memory
granularity: overview
summary: "Whole-machine address map; start here when an address is unknown."
keywords: [memory map, address ranges, ROM RAM overlay, unknown address]
---

## lookup
| range | size | default visible content | banking-sensitive | read first |
|---|---:|---|---:|---|
| `$0000-$0001` | 2 | `D6510`/`R6510` 6510 on-chip I/O port | no | [../io/processor-port.md](../io/processor-port.md) |
| `$0002-$008F` | 142 | BASIC interpreter workspace (TXTTAB, VARTAB, CHRGET, TXTPTR) | no | [zero-page.md](zero-page.md) |
| `$0090-$00FF` | 112 | KERNAL workspace (STATUS, file/device, vectors) | no | [zero-page.md](zero-page.md) |
| `$0100-$01FF` | 256 | 6502 hardware stack | no | [zero-page.md](zero-page.md) |
| `$0200-$02FF` | 256 | BASIC/KERNAL input buffer, KERNAL workspace, vector aliases | no | [symbols.md](symbols.md) |
| `$0300-$03FF` | 256 | BASIC/KERNAL indirect vectors (`$0314` IRQ, `$0316` BRK, `$0318` NMI, etc.) | no | [symbols.md](symbols.md) |
| `$0400-$07E7` | 1000 | Default text screen matrix (40×25 screen codes) | yes, via VIC bank | [../concepts/screen-memory.md](../concepts/screen-memory.md) |
| `$07E8-$07FF` | 24 | Sprite data pointers (`$07F8-$07FF`) and screen tail | yes, via VIC bank | [../io/vic-ii.md](../io/vic-ii.md) |
| `$0800` | 1 | BASIC zero byte (start of program) | no | [../basic/program-structure.md](../basic/program-structure.md) |
| `$0801-$9FFF` | ~38K | Default BASIC program + variables + free RAM | no | [symbols.md](symbols.md) |
| `$A000-$BFFF` | 8K | BASIC ROM (default) or underlying RAM | yes | [basic-rom.md](basic-rom.md) |
| `$C000-$CFFF` | 4K | RAM commonly used for machine-language programs | no | [symbols.md](symbols.md) |
| `$D000-$D3FF` | 1K | VIC-II registers (mirrored every 64 bytes) | yes | [../io/vic-ii.md](../io/vic-ii.md) |
| `$D400-$D7FF` | 1K | SID registers (mirrored every 32 bytes) | yes | [../sid/registers.md](../sid/registers.md) |
| `$D800-$DBFF` | 1K | Color RAM (low nybble used; 1000 visible cells) | yes | [../io/color-ram.md](../io/color-ram.md) |
| `$DC00-$DCFF` | 256 | CIA1 (keyboard, joystick, timer A IRQ) | yes | [../io/cia1.md](../io/cia1.md) |
| `$DD00-$DDFF` | 256 | CIA2 (VIC bank select, serial, user port, NMI) | yes | [../io/cia2.md](../io/cia2.md) |
| `$DE00-$DEFF` | 256 | I/O area 1 (expansion port) | yes | [../io/INDEX.md](../io/INDEX.md) |
| `$DF00-$DFFF` | 256 | I/O area 2 (expansion port) | yes | [../io/INDEX.md](../io/INDEX.md) |
| `$D000-$DFFF` (banked) | 4K | Character ROM when CHAREN=0 with LORAM/HIRAM set | yes | [io-area.md](io-area.md) |
| `$E000-$FFF9` | ~8K | KERNAL ROM (default) or underlying RAM | yes | [kernal-rom.md](kernal-rom.md) |
| `$FFFA-$FFFB` | 2 | NMI vector (CPU hardware vector) | yes | [kernal-rom.md](kernal-rom.md) |
| `$FFFC-$FFFD` | 2 | RESET vector (CPU hardware vector) | yes | [kernal-rom.md](kernal-rom.md) |
| `$FFFE-$FFFF` | 2 | IRQ/BRK vector (CPU hardware vector) | yes | [kernal-rom.md](kernal-rom.md) |

## constraints
- Code MUST check `$0001` (processor port) before deciding whether `$A000-$BFFF`, `$D000-$DFFF`, or `$E000-$FFFF` exposes ROM, I/O, character ROM, or RAM.
- Code MAY write to RAM underneath ROM; the visible read target still depends on banking.
- Code SHOULD use [symbols.md](symbols.md) for canonical labels before inventing local names.
- Code MUST NOT assume VIC-II sees the same banked memory view as the CPU; VIC bank is selected by CIA2 `$DD00` bits 0-1 (inverted).
- CPU hardware vectors at `$FFFA-$FFFF` are only visible when KERNAL ROM is banked in; with KERNAL ROM banked out, the underlying RAM values are used by the 6510 for NMI/RESET/IRQ.

## links
- banking: [../concepts/memory-banking.md](../concepts/memory-banking.md)
- processor port: [../io/processor-port.md](../io/processor-port.md)
- ROM routes: [../rom/INDEX.md](../rom/INDEX.md)
- VIC-II bank selection: [../io/cia2.md](../io/cia2.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- memory index: [INDEX.md](INDEX.md)
- I/O context: [../io/INDEX.md](../io/INDEX.md)
- symbols: [symbols.md](symbols.md)
