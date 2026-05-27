---
type: reference
domain: basic
granularity: lookup
---

## lookup
| address | symbol | BASIC role |
|---:|---|---|
| `$002B` | `TXTTAB` | Start of BASIC text. |
| `$002D` | `VARTAB` | Start of BASIC variables. |
| `$002F` | `ARYTAB` | Start of BASIC arrays. |
| `$0031` | `STREND` | End of BASIC arrays/string descriptor area. |
| `$0033` | `FRETOP` | String storage top pointer. |
| `$0037` | `MEMSIZ` | Top of BASIC memory. |
| `$0039` | `CURLIN` | Current BASIC line. |
| `$003B` | `OLDLIN` | Previous/current line context. |
| `$003D` | `OLDTXT` | BASIC text pointer context. |
| `$0041` | `DATPTR` | DATA statement pointer. |
| `$0073` | `CHRGET` | Get next BASIC character routine. |
| `$0079` | `CHRGOT` | Get current BASIC character routine. |
| `$007A` | `TXTPTR` | BASIC text pointer. |

## constraints
- BASIC workspace answers MUST cite both symbol and address.
- Agents SHOULD verify aliases in `symbols.txt` before claiming a symbol is unique.
- Machine-language programs MUST NOT overwrite BASIC vectors/workspace unless intentionally controlling BASIC state.

## links
- memory symbols: [../memory/symbols.md](../memory/symbols.md)
- zero page: [../memory/zero-page.md](../memory/zero-page.md)
- BASIC ROM route: [../rom/basic-disassembly.md](../rom/basic-disassembly.md)

## sources
- `C:\Code\c64ref\src\c64mem\symbols.txt`
- `C:\Code\c64ref\src\c64mem\c64mem_src.txt`
- `C:\Code\c64ref\src\c64disasm\c64disasm_ms.txt`
