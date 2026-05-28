---
type: reference
domain: memory
granularity: address-range
---

## facts
- `$0000` and `$0001` are 6510 on-chip I/O port registers (DDR and data), NOT ordinary RAM.
- `$0100-$01FF` is the 6502 stack page; stack pointer `S` indexes inside this page (top-down growth).
- BASIC and KERNAL together use most of `$0002-$00FF` as workspace, pointers, status, and vectors; safe scratch is rare without taking over the system.
- Machine-language programs commonly use `$00FB-$00FE` and `$0002` as the most reliably free zero-page bytes when BASIC/KERNAL stay active.

## lookup — broad allocation
| range | use | examples |
|---|---|---|
| `$0000-$0001` | 6510 port (DDR, data) | `D6510`, `R6510` — banking + cassette. |
| `$0002-$008F` | BASIC interpreter workspace | `TXTTAB`, `VARTAB`, `ARYTAB`, `STREND`, `FRETOP`, `MEMSIZ`, `CHRGET`, `TXTPTR`. |
| `$0090-$00BF` | KERNAL I/O / file / tape / serial workspace | `STATUS`, `FNLEN`, `LA`, `SA`, `FA`, `FNADR`. |
| `$00C0-$00FF` | KERNAL editor, keyboard, RS-232, screen workspace | `LSTX`, `NDX`, `PNT`, `PNTR`, `TBLX`, `RIBUF`, `ROBUF`. |
| `$0100-$01FF` | 6502 stack page | Pushed by `JSR`, `PHA`, `PHP`, IRQ/BRK/NMI. |

## lookup — KERNAL workspace `$0090-$00FF`
| address | symbol | use |
|---:|---|---|
| `$0090` | `STATUS` | I/O status word from KERNAL routines. |
| `$0091` | `STKEY` | RUN/STOP column flag. |
| `$0094` | `DFLTN` | Default input device (0 = keyboard). |
| `$0095` | `DFLTO` | Default output device (3 = screen). |
| `$00A0-$00A2` | `TIME` | Jiffy clock (60 Hz, 3-byte counter, high byte first). |
| `$00B7` | `FNLEN` | Filename length. |
| `$00B8` | `LA` | Current logical file number. |
| `$00B9` | `SA` | Current secondary address. |
| `$00BA` | `FA` | Current device number. |
| `$00BB-$00BC` | `FNADR` | Pointer to filename. |
| `$00C5` | `LSTX` | Matrix code of last key (`$40` = none). |
| `$00C6` | `NDX` | Keyboard buffer count. |
| `$00CB` | `SFDX` | Matrix code of current key. |
| `$00D1-$00D2` | `PNT` | Pointer to current screen line. |
| `$00D3` | `PNTR` | Cursor column. |
| `$00D6` | `TBLX` | Cursor row. |
| `$00F7-$00F8` | `RIBUF` | RS-232 input buffer pointer. |
| `$00F9-$00FA` | `ROBUF` | RS-232 output buffer pointer. |
| `$00FB-$00FE` | (free) | Conventionally free for user ML code. |

## constraints
- Code MUST avoid clobbering BASIC `$0002-$008F` while the BASIC interpreter is active.
- Code SHOULD prefer `$00FB-$00FE` and `$0002` for short-lived ML scratch when BASIC/KERNAL remain in use.
- Code that calls KERNAL routines SHOULD assume any KERNAL workspace zero-page field may be read or modified during the call.
- Code that disables the KERNAL IRQ scan or takes over `CINV` (`$0314`) MAY reuse keyboard/screen workspace at the cost of losing those services.

## links
- symbols: [symbols.md](symbols.md)
- map: [map.md](map.md)
- concept: [../concepts/zero-page.md](../concepts/zero-page.md)
- CPU registers: [../cpu/6502/registers-flags.md](../cpu/6502/registers-flags.md)
- processor port: [../io/processor-port.md](../io/processor-port.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- memory symbols: [symbols.md](symbols.md)
- concept: [../concepts/zero-page.md](../concepts/zero-page.md)
