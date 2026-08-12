---
type: reference
domain: io
granularity: atomic
summary: "Route hub for practical device access spanning CIA, KERNAL, encodings and protocols."
keywords: [I/O programming, device access, topic hub, peripherals]
---

## facts
- `I/O Programming` is a route hub for practical C64 device access topics that span CIA registers, KERNAL APIs, character encoding, and external protocols.
- Local coverage is intentionally split by layer: raw register facts stay in `io/`, KERNAL entry points stay in `kernal/`, and recipe-style workflows stay in `tasks/`.
- Codebase64's `cia:io_programming` page behaves more like a topic catalog than a single technical contract, so this page routes to compact local summaries instead of mirroring long upstream link lists.

## lookup
| topic | read | notes |
|---|---|---|
| Disk and tape I/O | [disk-tape-io.md](disk-tape-io.md) | Device/file workflows, IEC routing, and tape-vs-disk scope notes. |
| Keyboard and text I/O | [keyboard-text-io.md](keyboard-text-io.md) | Separate keyboard matrix wiring, KERNAL console calls, and character-code domains. |
| Joystick input | [joystick.md](joystick.md) | CIA1 port reads, active-low bits, and keyboard-sharing constraints. |
| Pointing devices | [pointing-devices.md](pointing-devices.md) | Mice, paddles, KoalaPad, and lightgun routing; includes a dedicated 1351 implementation page. |
| MIDI I/O | [midi.md](midi.md) | Interface-specific ACIA routing, including the Passport/Syntech map and compatibility constraints. |
| Data transfer protocols | [data-transfer-protocols.md](data-transfer-protocols.md) | Stock IEC routing plus dedicated fast-loader compatibility guidance. |

## constraints
- Treat `$DC00/$DC01` controller reads as CIA1 hardware facts, not as KERNAL API behavior; use [cia1.md](cia1.md) when register ownership matters.
- Treat IEC serial signaling and device calls as layered topics: line state belongs with CIA2 and KERNAL bus/file pages, while end-user workflows belong with `tasks/` recipes.
- Keep `PETSCII`, screen codes, and keyboard matrix positions separate; use the dedicated charset and KERNAL routes instead of assuming they are interchangeable.
- When local coverage remains routing-only, use [../sources/INDEX.md](../sources/INDEX.md) to expose upstream provenance and any remaining uncertainty.

## links

- Source provenance: [../sources/INDEX.md](../sources/INDEX.md)

## sources

- I/O index: [INDEX.md](INDEX.md)
- CIA1 registers: [cia1.md](cia1.md)
- CIA2 registers: [cia2.md](cia2.md)
- KERNAL file I/O: [../kernal/file-io.md](../kernal/file-io.md)
- KERNAL keyboard and screen: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)
- KERNAL serial bus: [../kernal/serial-bus.md](../kernal/serial-bus.md)
- Keyboard task: [../tasks/read-keyboard.md](../tasks/read-keyboard.md)
