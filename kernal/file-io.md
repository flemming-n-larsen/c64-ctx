---
type: reference
domain: kernal
granularity: api-family
---

## lookup
| symbol | address | inputs / setup | compact contract |
|---|---:|---|---|
| `SETLFS` | `$FFBA` | `A` logical file, `X` device, `Y` secondary address | Set logical file parameters. |
| `SETNAM` | `$FFBD` | `A` filename length, `X/Y` filename pointer | Set current filename. |
| `OPEN` | `$FFC0` | After `SETLFS`/`SETNAM` when needed | Open logical file. |
| `CLOSE` | `$FFC3` | `A` logical file number | Close logical file. |
| `CHKIN` | `$FFC6` | `X` logical file | Define input channel. |
| `CHKOUT` | `$FFC9` | `X` logical file | Define output channel. |
| `CLRCHN` | `$FFCC` | none | Restore default input/output channels. |
| `CHRIN` | `$FFCF` | current input channel | Read character/byte. |
| `CHROUT` | `$FFD2` | `A` byte | Write character/byte. |
| `LOAD` | `$FFD5` | `SETLFS`, `SETNAM`; `A` load/verify flag; `X/Y` address when secondary address says load to caller address | Load RAM from device. |
| `SAVE` | `$FFD8` | `SETLFS`, `SETNAM`; memory range pointer contract | Save memory to device. |
| `READST` | `$FFB7` | none | Read I/O status word. |
| `CLALL` | `$FFE7` | none | Close all files/channels. |

## sequence
1. For named device I/O, callers SHOULD call `SETLFS`.
2. Callers SHOULD call `SETNAM` when a filename is required.
3. Call `OPEN`, `LOAD`, or `SAVE` as the operation requires.
4. Use `CHKIN`/`CHKOUT` before `CHRIN`/`CHROUT` for non-default channels.
5. Call `CLRCHN` and `CLOSE`/`CLALL` to restore channels and release files.
6. Call `READST` to inspect device status when the routine reports errors through the status word.

## constraints
- Agents MUST verify exact register inputs and affected registers against the local KERNAL API pages before emitting assembly.
- Keyboard/screen default I/O MAY use `CHRIN`, `GETIN`, and `CHROUT` without `OPEN` when the default channels are active.
- File recipes SHOULD link to [../tasks/load-save-file.md](../tasks/load-save-file.md) instead of duplicating full examples here.

## links
- jump table: [jump-table.md](jump-table.md)
- serial bus: [serial-bus.md](serial-bus.md)
- load/save task: [../tasks/load-save-file.md](../tasks/load-save-file.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- KERNAL index: [INDEX.md](INDEX.md)
- jump table: [jump-table.md](jump-table.md)
