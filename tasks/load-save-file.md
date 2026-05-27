---
type: reference
domain: tasks
granularity: recipe
---

## sequence
1. Call `SETLFS` at `$FFBA` to set logical file number, device number, and secondary address.
2. Call `SETNAM` at `$FFBD` when a filename is required.
3. For whole-file operations, call `LOAD` at `$FFD5` or `SAVE` at `$FFD8`.
4. For channel-style I/O, call `OPEN` at `$FFC0`, then `CHKIN`/`CHKOUT`, then `CHRIN`/`CHROUT`.
5. Call `READST` at `$FFB7` when status/error handling matters.
6. Call `CLRCHN` at `$FFCC` and `CLOSE` at `$FFC3` or `CLALL` at `$FFE7` when done.

## lookup
| task need | primary call/page | supporting page |
|---|---|---|
| Load program/data | [../kernal/file-io.md](../kernal/file-io.md) | [../memory/map.md](../memory/map.md) |
| Save memory range | [../kernal/file-io.md](../kernal/file-io.md) | [../memory/symbols.md](../memory/symbols.md) |
| Raw serial byte I/O | [../kernal/serial-bus.md](../kernal/serial-bus.md) | [../io/cia2.md](../io/cia2.md) |
| Filename/device setup | [../kernal/file-io.md](../kernal/file-io.md) | [../memory/zero-page.md](../memory/zero-page.md) |

## constraints
- Agents MUST verify exact register contracts in `kernal_prg.txt` before emitting runnable assembly.
- Recipes SHOULD prefer KERNAL file I/O over direct serial/CIA manipulation unless direct hardware access is requested.
- Code SHOULD restore default channels with `CLRCHN` after redirected I/O.

## links
- KERNAL file I/O: [../kernal/file-io.md](../kernal/file-io.md)
- KERNAL serial bus: [../kernal/serial-bus.md](../kernal/serial-bus.md)
- memory map: [../memory/map.md](../memory/map.md)
- CPU flags/registers: [../cpu/6502/registers-flags.md](../cpu/6502/registers-flags.md)

## sources
- `C:\Code\c64ref\src\kernal\kernal_prg.txt`
- `C:\Code\c64ref\src\kernal\generate.py`
- `C:\Code\c64ref\src\c64mem\symbols.txt`
