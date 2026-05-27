---
type: reference
domain: kernal
granularity: lookup
---

## lookup
| address | symbol | category | compact purpose |
|---:|---|---|---|
| `$FF81` | `CINT` | `EDITOR` | Initialize screen editor. |
| `$FF84` | `IOINIT` | `SYS` | Initialize I/O devices. |
| `$FF87` | `RAMTAS` | `MEM` | Initialize RAM and buffers. |
| `$FF8A` | `RESTOR` | `SYS` | Restore default vectors. |
| `$FF8D` | `VECTOR` | `SYS` | Read/set RAM vectors. |
| `$FF90` | `SETMSG` | `IO` | Control KERNAL messages. |
| `$FF93` | `SECOND` | `IEEE` | Send secondary address after `LISTEN`. |
| `$FF96` | `TKSA` | `IEEE` | Send secondary address after `TALK`. |
| `$FF99` | `MEMTOP` | `MEM` | Read/set top of memory. |
| `$FF9C` | `MEMBOT` | `MEM` | Read/set bottom of memory. |
| `$FF9F` | `SCNKEY` | `KBD` | Scan keyboard. |
| `$FFA2` | `SETTMO` | `IEEE` | Set timeout. |
| `$FFA5` | `ACPTR` | `IEEE` | Get data from serial bus. |
| `$FFA8` | `CIOUT` | `IEEE` | Send data to serial bus. |
| `$FFAB` | `UNTLK` | `IEEE` | Send untalk. |
| `$FFAE` | `UNLSN` | `IEEE` | Send unlisten. |
| `$FFB1` | `LISTEN` | `IEEE` | Command device to listen. |
| `$FFB4` | `TALK` | `IEEE` | Command device to talk. |
| `$FFB7` | `READST` | `IO` | Read status word. |
| `$FFBA` | `SETLFS` | `IO` | Set logical file, device, secondary address. |
| `$FFBD` | `SETNAM` | `IO` | Set filename. |
| `$FFC0` | `OPEN` | `IO` | Open logical file. |
| `$FFC3` | `CLOSE` | `IO` | Close logical file. |
| `$FFC6` | `CHKIN` | `IO` | Open channel for input. |
| `$FFC9` | `CHKOUT` | `IO` | Open channel for output. |
| `$FFCC` | `CLRCHN` | `IO` | Restore default I/O channels. |
| `$FFCF` | `CHRIN` | `IO` | Input character. |
| `$FFD2` | `CHROUT` | `IO` | Output character. |
| `$FFD5` | `LOAD` | `IO` | Load RAM from device. |
| `$FFD8` | `SAVE` | `IO` | Save memory to device. |
| `$FFDB` | `SETTIM` | `TIME` | Set jiffy clock. |
| `$FFDE` | `RDTIM` | `TIME` | Read jiffy clock. |
| `$FFE1` | `STOP` | `KBD` | Test stop key. |
| `$FFE4` | `GETIN` | `KBD` | Get input byte. |
| `$FFE7` | `CLALL` | `IO` | Close all files/channels. |
| `$FFEA` | `UDTIM` | `TIME` | Update clock. |
| `$FFED` | `SCREEN` | `EDITOR` | Return screen size. |
| `$FFF0` | `PLOT` | `EDITOR` | Read/set cursor position. |
| `$FFF3` | `IOBASE` | `MEM` | Return I/O base address. |

## constraints
- Callers MUST follow each routine's register contract from the local KERNAL API pages; this table is only a route table.
- Agents SHOULD use category labels from `kernal/generate.py` for grouping.
- Agents MUST NOT infer clobbers from the compact purpose column.

## links
- file I/O: [file-io.md](file-io.md)
- serial bus: [serial-bus.md](serial-bus.md)
- keyboard/screen: [keyboard-screen.md](keyboard-screen.md)
- memory calls: [memory.md](memory.md)
- time/IRQ: [time-irq.md](time-irq.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- KERNAL index: [INDEX.md](INDEX.md)
