---
type: reference
domain: concepts
granularity: concept
---

## facts
- The 6510 on-chip I/O port at `$0001` controls which ROM/RAM/I/O resources are visible to the CPU.
- `LORAM` bit `0` selects BASIC ROM versus RAM at `$A000-$BFFF` in the cited memory-map source.
- `HIRAM` bit `1` selects KERNAL ROM versus RAM at `$E000-$FFFF` in the cited memory-map source.
- `CHAREN` bit `2` selects I/O devices versus character ROM in the `$D000-$DFFF` window when ROM configuration permits that window.

## lookup

### Bit functions
| bit | signal | `1` behavior | `0` behavior |
|---:|---|---|---|
| `$0001` bit `0` | `LORAM` | BASIC ROM selected at `$A000` | RAM selected at `$A000` |
| `$0001` bit `1` | `HIRAM` | KERNAL ROM selected at `$E000` | RAM selected at `$E000` |
| `$0001` bit `2` | `CHAREN` | I/O devices selected | Character ROM selected |

### All 8 configurations (bits 2-0 of `$0001`)
| bits `2-1-0` | `$A000-$BFFF` | `$D000-$DFFF` | `$E000-$FFFF` |
|:---:|---|---|---|
| `%111` | BASIC ROM | I/O | KERNAL ROM |
| `%110` | BASIC ROM | Char ROM | KERNAL ROM |
| `%101` | RAM | I/O | RAM |
| `%100` | RAM | Char ROM | RAM |
| `%011` | RAM | I/O | KERNAL ROM |
| `%010` | RAM | Char ROM | KERNAL ROM |
| `%001` | RAM | RAM | RAM |
| `%000` | RAM | RAM | RAM |

## constraints
- Agents MUST cite `$0001` state when explaining any address in `$A000-$BFFF`, `$D000-$DFFF`, or `$E000-$FFFF`.
- Code SHOULD use read-modify-write for `$0001` to avoid changing cassette control bits accidentally.
- Interrupt handlers MUST be safe for the active banking state; disabling KERNAL ROM while using KERNAL IRQ code is unsafe unless replaced intentionally.
- Code MUST NOT use `INC $01` to transition from `%111` to `%000`; that path activates the cassette tape write head and can damage tapes or cause unexpected hardware behavior. Use explicit `LDA`/`STA` with the exact target value instead.

## links
- processor port: [../io/processor-port.md](../io/processor-port.md)
- memory map: [../memory/map.md](../memory/map.md)
- bank-switch task: [../tasks/bank-switch-rom-ram.md](../tasks/bank-switch-rom-ram.md)
- cartridge modes: [cartridge-modes.md](cartridge-modes.md)

## sources
- codebase64.net: [Memory Management in Commodore 64](https://codebase64.net/doku.php?id=base:memory_management) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
- memory map: [../memory/map.md](../memory/map.md)
- processor port: [../io/processor-port.md](../io/processor-port.md)
