---
type: reference
domain: io
granularity: register-pair
---

## lookup
| address | symbol | role | key bits |
|---:|---|---|---|
| `$0000` | `D6510` | 6510 on-chip I/O data direction register | Bit value `1` means output; bit value `0` means input. |
| `$0001` | `R6510` | 6510 on-chip I/O port | `LORAM`, `HIRAM`, `CHAREN`, cassette data/sense/motor. |

## bits
| `$0001` bit | signal | meaning from source |
|---:|---|---|
| `0` | `LORAM` | Selects ROM or RAM at `$A000`; `1` = BASIC, `0` = RAM. |
| `1` | `HIRAM` | Selects ROM or RAM at `$E000`; `1` = KERNAL, `0` = RAM. |
| `2` | `CHAREN` | Selects character ROM or I/O devices; `1` = I/O, `0` = character ROM. |
| `3` | cassette data output | Cassette data output line. |
| `4` | cassette switch sense | Reads cassette switch state. |
| `5` | cassette motor control | Controls cassette motor. |
| `6-7` | unused | Not connected/no defined function in cited source. |

## constraints
- Banking explanations MUST include `$0001` when discussing `$A000-$BFFF`, `$D000-$DFFF`, or `$E000-$FFFF`.
- Code SHOULD preserve unrelated port bits when changing banking: read-modify-write instead of blind stores when cassette lines matter.
- Agents MUST distinguish `$0000` direction bits from `$0001` data/output bits.

## links
- memory banking: [../concepts/memory-banking.md](../concepts/memory-banking.md)
- memory map: [../memory/map.md](../memory/map.md)
- bank-switch task: [../tasks/bank-switch-rom-ram.md](../tasks/bank-switch-rom-ram.md)

## sources
- `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt`
- `C:\Code\c64ref\src\c64io\c64io_prg.txt`
- `C:\Code\c64ref\src\c64mem\symbols.txt`
