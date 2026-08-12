---
type: reference
domain: io
granularity: device
source: commodore-manual
summary: "The 1351 proportional mouse: POT register decoding, buttons, sampling constraints."
keywords: [1351 mouse, proportional mode, POT registers, mouse buttons]
---

## facts
- The Commodore 1351 connects to either control port and has proportional and joystick-compatible modes.
- At power-up, holding the right button selects joystick mode; otherwise the mouse starts in proportional mode.
- Proportional mode reports X through SID `POTX` (`$D419`) and Y through `POTY` (`$D41A`).
- Each position is a 6-bit modulo-64 counter carried in POT-register bits 6–1; bit 7 is unspecified and bit 0 is noise.
- The mouse refreshes its proportional position every 512 microseconds.
- In proportional mode, the left button maps to the selected port's joystick fire line and the right button maps to its joystick up line.

## sequence
1. Select the intended control port for the SID POT inputs using the normal paddle-selection path.
2. Read `$D419` and `$D41A` near the start of the frame.
3. Convert each sample with `(value >> 1) & $3F`.
4. Compute `delta = current - previous` modulo 64.
5. Interpret deltas `0..31` as non-negative and `32..63` as `delta - 64`.
6. Accumulate the signed delta into the application cursor position and clamp or wrap as required.
7. Read the selected CIA1 joystick port for the two active-low button signals.

## constraints
- Sampling MUST be frequent enough that movement cannot exceed 31 counts on either axis between reads; otherwise the modulo-64 direction is ambiguous.
- Software MUST ignore POT bits 7 and 0 when decoding proportional position.
- The SID POT conversion is multiplexed between control ports; code MUST select the intended port before sampling and allow the analog path to settle.
- Keyboard scanning and controller-port reads share CIA1 lines, so button handling MUST follow the same interference rules as joystick input.
- Joystick mode reports timed direction pulses rather than proportional deltas and MUST be handled as a joystick.

## links

- pointing-device route: [pointing-devices.md](pointing-devices.md)
- I/O index: [INDEX.md](INDEX.md)

## sources

- SID registers: [../sid/registers.md](../sid/registers.md)
- CIA1 registers: [cia1.md](cia1.md)
- original device manual: [Commodore 1351 Mouse User's Manual](https://www.vincenzoscarpa.it/biblioteca/manuali/eng/c64/Commodore64-1351-Mouse-Users-Guide.pdf)
