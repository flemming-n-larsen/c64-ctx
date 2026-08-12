---
type: reference
domain: io
granularity: atomic
summary: "Reaching disk and tape through KERNAL channels, and the hardware underneath."
keywords: [disk I/O, tape, datassette, IEC signaling, channel calls]
---

## facts
- Disk and tape I/O on the C64 is usually reached through KERNAL file/channel calls, even though IEC signaling and cassette hardware ultimately depend on CIA-backed machine I/O.
- The local repository already keeps the stable API contracts in `kernal/` and the practical calling order in `tasks/`; this page is a route layer that keeps the hardware/API split explicit.
- IEC serial bus details belong with CIA2 and KERNAL serial routines, while high-level load/save recipes belong with task pages rather than raw register summaries.
- Codebase64 groups disk and tape material under one practical I/O topic, but the exact device-specific behavior still depends on the called KERNAL routine and attached hardware.

## lookup
| need | read | notes |
|---|---|---|
| Load or save a file | [../kernal/file-io.md](../kernal/file-io.md) | KERNAL jump-table family for `SETLFS`, `SETNAM`, `LOAD`, `SAVE`, `OPEN`, and `CLOSE`. |
| Follow the canonical call order | [../tasks/load-save-file.md](../tasks/load-save-file.md) | Recipe-oriented sequence for channels, status checks, and cleanup. |
| Inspect IEC byte-level or bus-level routines | [../kernal/serial-bus.md](../kernal/serial-bus.md) | KERNAL serial API layer over the IEC bus. |
| Check the hardware bus lines behind IEC | [cia2.md](cia2.md) | CIA2 owns the serial-bus line interface and related register context. |
| Distinguish default console I/O from file/device channels | [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md) | `CHRIN` and `CHROUT` use current channels; they are not disk-only calls. |

## constraints
- Prefer KERNAL file/device calls unless direct bus control is specifically required; local recipes assume that default path.
- Do not treat IEC bus signaling, cassette behavior, and logical-file APIs as one layer; choose the route that matches the needed abstraction.
- When emitting code, verify exact register and status semantics in the cited KERNAL pages before relying on device-specific behavior.
- Use [../sources/INDEX.md](../sources/INDEX.md) for upstream provenance when the local route is intentionally compact or when Codebase64 is acting as a topic catalog.

## sources

- I/O programming hub: [io-programming.md](io-programming.md)
- KERNAL file I/O: [../kernal/file-io.md](../kernal/file-io.md)
- KERNAL serial bus: [../kernal/serial-bus.md](../kernal/serial-bus.md)
- Load/save task: [../tasks/load-save-file.md](../tasks/load-save-file.md)
- CIA2 registers: [cia2.md](cia2.md)
