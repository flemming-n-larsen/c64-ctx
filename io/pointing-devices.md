---
type: reference
domain: io
granularity: atomic
summary: "Mice, paddles, light pens and trackballs, and which hardware path each uses."
keywords: [pointing devices, paddles, light pen, trackball, POT lines]
---

## facts
- Pointing-device coverage under `/io` spans multiple hardware paths rather than a single chip contract.
- Paddles expose analog values through SID read registers `$D419` and `$D41A`, so the existing SID register page is the local hardware anchor for analog controller input.
- The Commodore 1351 proportional mouse has a dedicated local device page grounded in its original manual.
- KoalaPad and paddle-class analog devices share the SID POT path; light pens use VIC-II latch registers and are a distinct device family.

## lookup
| device family | read | notes |
|---|---|---|
| Paddles / analog input | [../sid/registers.md](../sid/registers.md) | `$D419/$D41A` are the existing local read points for paddle values. |
| Commodore 1351 mouse | [mouse-1351.md](mouse-1351.md) | Proportional/joystick modes, modulo-64 decoding, buttons, and sampling constraints. |
| Shared CIA controller context | [cia1.md](cia1.md) | CIA1 still matters for controller-port overlap and digital input constraints. |
| KoalaPad and compatible tablets | [../sid/registers.md](../sid/registers.md) | Treat as device-specific use of the analog POT path; consult the device manual for scaling and buttons. |
| Light pen | [vic-ii.md](vic-ii.md) | VIC-II light-pen latches are separate from SID analog and CIA joystick input. |

## constraints
- Do not reuse 1351 modulo-counter semantics for paddles or KoalaPad devices; they share POT registers but not the same encoding contract.
- Keep analog SID reads separate from CIA digital port reads; they are different hardware interfaces.
- Use provenance rather than copied prose when Codebase64 acts as a catalog of device-specific articles.

## links
- I/O programming hub: [io-programming.md](io-programming.md)
- SID registers: [../sid/registers.md](../sid/registers.md)
- CIA1 registers: [cia1.md](cia1.md)
- Commodore 1351 mouse: [mouse-1351.md](mouse-1351.md)
- Provenance: [../sources/INDEX.md](../sources/INDEX.md)

## sources
- SID registers: [../sid/registers.md](../sid/registers.md)
- CIA1 registers: [cia1.md](cia1.md)
- Commodore 1351 mouse: [mouse-1351.md](mouse-1351.md)
- I/O programming hub: [io-programming.md](io-programming.md)
- Provenance: [../sources/INDEX.md](../sources/INDEX.md)
