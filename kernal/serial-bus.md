---
type: reference
domain: kernal
granularity: api-family
summary: "Low-level IEC serial bus calls for talking to drives and printers directly."
keywords: [serial bus, IEC, LISTEN, TALK, ACPTR, CIOUT]
---

## lookup
| symbol | address | purpose | setup / follow-up |
|---|---:|---|---|
| `LISTEN` | `$FFB1` | Command serial device to listen | Device number in `A` per source contract. |
| `SECOND` | `$FF93` | Send secondary address after `LISTEN` | Used before data output where needed. |
| `CIOUT` | `$FFA8` | Send byte on serial bus | Usually after `LISTEN`/`SECOND`. |
| `UNLSN` | `$FFAE` | Send unlisten | Terminates listener state. |
| `TALK` | `$FFB4` | Command serial device to talk | Device number in `A` per source contract. |
| `TKSA` | `$FF96` | Send secondary address after `TALK` | Used before `ACPTR` where needed. |
| `ACPTR` | `$FFA5` | Get byte from serial bus | Preparatory routines: `TALK`, `TKSA`; returns byte in `A`; affects `A`, `X` in shown source. |
| `UNTLK` | `$FFAB` | Send untalk | Terminates talker state. |
| `READST` | `$FFB7` | Read status word | Use after I/O operations. |

## constraints
- Agents MUST distinguish low-level serial bus calls from higher-level `LOAD`, `SAVE`, `OPEN`, and channel calls.
- `ACPTR` callers SHOULD prepare the device with `TALK` and `TKSA` when applicable.
- Serial routines SHOULD check `READST` when error handling matters.

## links
- jump table: [jump-table.md](jump-table.md)
- file I/O: [file-io.md](file-io.md)
- CIA2 hardware: [../io/cia2.md](../io/cia2.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- KERNAL index: [INDEX.md](INDEX.md)
- jump table: [jump-table.md](jump-table.md)
