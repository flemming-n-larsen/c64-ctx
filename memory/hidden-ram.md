---
type: reference
domain: memory
source: codebase64.net
---

## facts
- On an unexpanded C64, `$00` and `$01` are the 6510 processor port direction register and data register; the CPU resolves them internally and cannot directly address the RAM cells beneath them.
- Reading the hidden RAM: the VIC-II chip can access this memory area even though the CPU cannot — use sprite collision detection to infer bit patterns.
- Writing the hidden RAM exploits the 6510's internal R/W signal: during an internal CPU write cycle, address lines are valid and point to `$00`/`$01`, and residual data from the last VIC bus read lands on the data bus and gets written.

## sequence

### Reading `$00`/`$01` hidden RAM
1. Configure a sprite using the first sprite pattern (located at the sprite set base).
2. Position the sprite over the target byte.
3. Read the sprite-to-background collision register (`$D01F`); each bit corresponds to a sprite.
4. Iterate across bit positions to reconstruct the byte.

This is indirect and slow; practical only for diagnostics or copy-protection purposes.

### Writing `$00`/`$01` hidden RAM
1. Program VIC-II to read from a known address (typically `$3FFF`).
2. Place the desired byte value at that VIC read address.
3. Trigger a raster interrupt at the bottom border.
4. The CPU performs an internal write; address lines show `$0000` or `$0001`; the data bus carries the VIC's last read value, which gets stored into the hidden RAM cell.

## constraints
- These locations are almost never useful in normal C64 programming; the processor port (`$00`/`$01`) functional values take precedence.
- Timing for the write technique is cycle-exact; incorrect timing writes to the wrong address or does nothing.
- This technique is hardware-dependent and may not work on all C64 board revisions or FPGA clones.

## links
- processor port and banking: [../tasks/bank-switch-rom-ram.md](../tasks/bank-switch-rom-ram.md)
- memory map overview: [INDEX.md](INDEX.md)
- I/O port register: [../io/INDEX.md](../io/INDEX.md)

## sources
- https://codebase64.net/doku.php?id=base:ram_beneath_00_and_01 — CC BY-NC-SA 4.0
- *c64doc* by John West and Marko Mäkelä (cited by source)
- [../sources/INDEX.md](../sources/INDEX.md)
