---
type: reference
domain: memory
granularity: lookup
---

## lookup — processor port and BASIC workspace
| address | symbol | owner | aliases / notes |
|---:|---|---|---|
| `$0000` | `D6510` | hardware | 6510 on-chip I/O data direction register. |
| `$0001` | `R6510` | hardware | 6510 on-chip I/O port; LORAM/HIRAM/CHAREN banking + cassette. |
| `$0003` | `ADRAY1` | BASIC | Float-to-fixed conversion vector. |
| `$0005` | `ADRAY2` | BASIC | Fixed-to-float conversion vector. |
| `$0007` | `CHARAC` | BASIC | Search character; also `INTEGR`. |
| `$002B` | `TXTTAB` | BASIC | Start of BASIC text (default `$0801`). |
| `$002D` | `VARTAB` | BASIC | Start of BASIC variables. |
| `$002F` | `ARYTAB` | BASIC | Start of BASIC arrays. |
| `$0031` | `STREND` | BASIC | End of BASIC arrays. |
| `$0033` | `FRETOP` | BASIC | Top of free string storage. |
| `$0037` | `MEMSIZ` | BASIC | Top of BASIC memory (default `$A000`). |
| `$0073` | `CHRGET` | BASIC | Get next BASIC character (RAM routine). |
| `$0079` | `CHRGOT` | BASIC | Re-get current BASIC character. |
| `$007A` | `TXTPTR` | BASIC | BASIC text pointer. |

## lookup — KERNAL zero-page workspace `$0090-$00FF`
| address | symbol | owner | aliases / notes |
|---:|---|---|---|
| `$0090` | `STATUS` | KERNAL | I/O status word (`ST`). |
| `$0091` | `STKEY` | KERNAL | RUN/STOP key column flag. |
| `$0093` | `LDTND` | KERNAL | Load/verify flag (0=load, 1=verify). |
| `$0094` | `DFLTN` | KERNAL | Default input device (0 = keyboard). |
| `$0095` | `DFLTO` | KERNAL | Default output device (3 = screen). |
| `$0099` | `MSGFLG` | KERNAL | KERNAL messages flag. |
| `$00A0` | `TIME` | KERNAL | Jiffy clock high byte (`TI`/`TI$` base). |
| `$00A1` | `TIME` | KERNAL | Jiffy clock middle byte. |
| `$00A2` | `TIME` | KERNAL | Jiffy clock low byte (incremented at 60Hz). |
| `$00B7` | `FNLEN` | KERNAL | Current filename length. |
| `$00B8` | `LA` | KERNAL | Current logical file number. |
| `$00B9` | `SA` | KERNAL | Current secondary address. |
| `$00BA` | `FA` | KERNAL | Current device number. |
| `$00BB` | `FNADR` | KERNAL | Pointer to current filename. |
| `$00C5` | `LSTX` | KERNAL | Matrix code of last key pressed (`$40` = none). |
| `$00C6` | `NDX` | KERNAL | Number of chars in keyboard buffer. |
| `$00CB` | `SFDX` | KERNAL | Matrix code of current key. |
| `$00D1` | `PNT` | screen editor | Pointer to current screen line. |
| `$00D3` | `PNTR` | screen editor | Cursor column on current line. |
| `$00D6` | `TBLX` | screen editor | Cursor row. |
| `$00F7` | `RIBUF` | KERNAL | RS-232 input buffer pointer. |
| `$00F9` | `ROBUF` | KERNAL | RS-232 output buffer pointer. |

## lookup — page-2/page-3 vectors and buffers
| address | symbol | owner | aliases / notes |
|---:|---|---|---|
| `$0200-$0258` | `BUF` | KERNAL | BASIC/KERNAL input line buffer. |
| `$0277-$0280` | `KEYD` | KERNAL | Keyboard buffer (10 bytes). |
| `$0281` | `MEMSTR` | KERNAL | Start of usable RAM low byte. |
| `$0283` | `MEMSIZ` | KERNAL | End of usable RAM low byte. |
| `$0286` | `COLOR` | screen editor | Current foreground color for editor output. |
| `$0288` | `HIBASE` | screen editor | Screen matrix base (high byte; default `$04`). |
| `$0314` | `CINV` | KERNAL | IRQ vector (RAM indirect; default `$EA31`). |
| `$0316` | `CBINV` | KERNAL | BRK vector (default `$FE66`). |
| `$0318` | `NMINV` | KERNAL | NMI vector (default `$FE47`). |
| `$031A` | `IOPEN` | KERNAL | OPEN vector. |
| `$031C` | `ICLOSE` | KERNAL | CLOSE vector. |
| `$031E` | `ICHKIN` | KERNAL | CHKIN vector. |
| `$0320` | `ICKOUT` | KERNAL | CHKOUT vector. |
| `$0322` | `ICLRCH` | KERNAL | CLRCHN vector. |
| `$0324` | `IBASIN` | KERNAL | CHRIN/BASIN vector. |
| `$0326` | `IBSOUT` | KERNAL | CHROUT/BSOUT vector. |
| `$0328` | `ISTOP` | KERNAL | STOP vector. |
| `$032A` | `IGETIN` | KERNAL | GETIN vector. |
| `$032C` | `ICLALL` | KERNAL | CLALL vector. |
| `$0330` | `ILOAD` | KERNAL | LOAD vector. |
| `$0332` | `ISAVE` | KERNAL | SAVE vector. |

## lookup — CPU hardware vectors
| address | symbol | owner | aliases / notes |
|---:|---|---|---|
| `$FFFA` | `NMIVEC` | CPU | NMI vector (16-bit, low byte first). |
| `$FFFC` | `RESVEC` | CPU | RESET vector. |
| `$FFFE` | `IRQVEC` | CPU | IRQ/BRK vector. |

## constraints
- Code MUST preserve aliases when source material lists multiple names for one address.
- Code SHOULD use page-3 RAM vectors (`$0314-$0332`) to intercept KERNAL behavior; direct ROM patching is not possible while KERNAL ROM is banked in.
- Code MUST NOT clobber `$0002-$008F` BASIC workspace when the BASIC interpreter is still active.
- Custom IRQ handlers SHOULD write `CINV` (`$0314`) atomically with interrupts disabled (`SEI`/`CLI`).

## links
- zero page: [zero-page.md](zero-page.md)
- map: [map.md](map.md)
- KERNAL file I/O: [../kernal/file-io.md](../kernal/file-io.md)
- BASIC vectors: [../basic/vectors.md](../basic/vectors.md)
- IRQ task: [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- memory index: [INDEX.md](INDEX.md)
- zero page: [zero-page.md](zero-page.md)
