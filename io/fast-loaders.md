---
type: reference
domain: io
granularity: atomic
source: mixed
summary: "How fast loaders replace the stock transfer protocol, and their compatibility rules."
keywords: [fast loader, drive code, transfer protocol, compatibility]
---

## facts
- A fast loader replaces or extends the stock KERNAL/drive transfer protocol; it is not merely a faster call to `LOAD`.
- A 1541 is an intelligent peripheral with its own 6502, RAM, ROM, and serial-bus interface, so many fast loaders upload matching drive-side code before transferring data.
- The stock serial bus is shared and daisy-chained; a custom protocol still has to release and observe the bus lines correctly.
- Fast-loader protocols are implementation-specific. Bit width, handshakes, checksums, filenames, retry behavior, and supported drives cannot be inferred from the term “fast loader.”
- Covert Bitops LoaderSystem is one documented implementation family; its current V3 branch distinguishes real-drive transfer from a separate SD2IEC `ELoad` protocol.

## lookup
| layer | local route | responsibility |
|---|---|---|
| Stock KERNAL bus calls | [../kernal/serial-bus.md](../kernal/serial-bus.md) | `LISTEN`, `TALK`, byte transfer, and bus release. |
| File/channel setup | [../kernal/file-io.md](../kernal/file-io.md) | Logical files, device numbers, names, and status handling. |
| CIA2 bus lines | [cia2.md](cia2.md) | C64-side ATN, CLK, and DATA ownership. |
| On-disk layout | [disk-formats.md](disk-formats.md) | Track/sector, BAM, and directory structures. |
| Practical loader implementation | [Covert Bitops tools and LoaderSystem](https://cadaver.github.io/tools.html) | Maintained author documentation and downloads. |

## constraints
- A loader MUST document its supported drive/device set; real 1541, 1571/1581, SD2IEC, emulators, and modern cartridges do not automatically implement the same custom protocol.
- C64-side code and uploaded drive-side code MUST agree on timing, direction, framing, and error handling.
- Code MUST restore or explicitly replace KERNAL vectors and bus state before returning to normal KERNAL file I/O.
- Direct CIA2 access MUST preserve unrelated `$DD00` bits, including VIC-II bank selection.
- Exact cycle timing MUST come from the selected loader implementation, not from this routing page.

## sources

- CIA2 registers: [cia2.md](cia2.md)
- KERNAL serial bus: [../kernal/serial-bus.md](../kernal/serial-bus.md)
- disk formats: [disk-formats.md](disk-formats.md)
- original drive manual: [Commodore VIC-1541 Floppy Drive User's Manual](https://www.commodore.ca/wp-content/uploads/2018/11/commodore_vic_1541_floppy_drive_users_manual.pdf)
- implementation reference: [Covert Bitops tools and LoaderSystem](https://cadaver.github.io/tools.html)
- transfer-protocol route: [data-transfer-protocols.md](data-transfer-protocols.md)
- I/O index: [INDEX.md](INDEX.md)
