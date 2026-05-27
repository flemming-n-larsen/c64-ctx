---
type: reference
domain: memory
granularity: lookup
---

## lookup
| address | symbol | aliases / notes |
|---:|---|---|
| `$0000` | `D6510` | 6510 on-chip I/O data direction register. |
| `$0001` | `R6510` | 6510 on-chip I/O port; controls banking and cassette lines. |
| `$0003` | `ADRAY1` | BASIC workspace pointer. |
| `$0005` | `ADRAY2` | BASIC workspace pointer. |
| `$0007` | `CHARAC` | Also `INTEGR` in `symbols.txt`. |
| `$0013` | `CHANNL` | Source notes unnamed in Programmer's Reference Manual. |
| `$002B` | `TXTTAB` | Start of BASIC text. |
| `$002D` | `VARTAB` | Start of BASIC variables. |
| `$002F` | `ARYTAB` | Start of BASIC arrays. |
| `$0031` | `STREND` | End of BASIC arrays/string descriptor area. |
| `$0033` | `FRETOP` | Top of string storage. |
| `$0037` | `MEMSIZ` | Top of BASIC memory. |
| `$0073` | `CHRGET` | BASIC character-get routine in zero page. |
| `$0079` | `CHRGOT` | BASIC character-reget routine. |
| `$007A` | `TXTPTR` | BASIC text pointer. |
| `$0090` | `STATUS` | KERNAL I/O status word. |
| `$00A0` | `TIME` | Jiffy clock bytes. |
| `$00B7` | `FNLEN` | Current filename length. |
| `$00B8` | `LA` | Current logical file address. |
| `$00B9` | `SA` | Current secondary address. |
| `$00BA` | `FA` | Current device number. |
| `$00BB` | `FNADR` | Current filename address pointer. |

## constraints
- Agents MUST preserve aliases when `symbols.txt` lists multiple names for one address.
- Agents SHOULD treat source comments such as `unnamed in Programmer's Reference Manual` as provenance caveats.
- Agents MUST NOT use this seed table as a complete symbol list; inspect `symbols.txt` for exhaustive lookup.

## links
- zero page: [zero-page.md](zero-page.md)
- KERNAL file I/O: [../kernal/file-io.md](../kernal/file-io.md)
- BASIC vectors: [../basic/vectors.md](../basic/vectors.md)

## sources
- `C:\Code\c64ref\src\c64mem\symbols.txt`
