---
type: reference
domain: memory
granularity: address-range
---

## facts
- `$0000` and `$0001` are hardware registers, not ordinary RAM.
- `$0100-$01FF` is the 6502 stack page; stack pointer `S` indexes inside this page.
- BASIC and KERNAL use many `$0002-$00FF` locations as workspace, pointers, status, and vectors.

## lookup
| range | use | examples |
|---|---|---|
| `$0000-$0001` | 6510 port | `D6510`, `R6510` |
| `$0002-$008A` | BASIC interpreter workspace | `TXTTAB`, `VARTAB`, `CHRGET`, `TXTPTR` |
| `$0090-$00BF` | KERNAL I/O and tape/serial workspace | `STATUS`, `FNLEN`, `LA`, `SA`, `FA`, `FNADR` |
| `$00C0-$00FF` | System/editor/vector workspace | Use `symbols.txt` for exact labels. |

## constraints
- Machine-language routines MUST avoid clobbering zero-page locations owned by BASIC/KERNAL unless they save and restore or intentionally take over the system.
- Agents SHOULD cite symbol names and addresses together because aliases are common.
- Code that calls KERNAL routines SHOULD assume relevant zero-page I/O fields may be read or modified by the ROM.

## links
- symbols: [symbols.md](symbols.md)
- concept: [../concepts/zero-page.md](../concepts/zero-page.md)
- CPU registers: [../cpu/6502/registers-flags.md](../cpu/6502/registers-flags.md)

## sources
- `C:\Code\c64ref\src\c64mem\symbols.txt`
- `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt`
