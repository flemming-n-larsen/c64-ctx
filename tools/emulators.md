---
type: reference
domain: tools
granularity: emulators
summary: "C64 emulators for PC and which build is cycle-exact."
keywords: [emulators, VICE, x64sc, HOXS64, CCS64]
---

## facts
- VICE is the most widely used C64 emulator; cycle-exact variant is `x64sc`.
- HOXS64 targets cycle-exact emulation on Windows.
- CCS64 is a Windows-native emulator; no longer actively maintained but still used.
- VICE command-line workflow and monitor usage are documented in [../toolchains/vice.md](../toolchains/vice.md).

## lookup
| emulator | platform | notes |
|---|---|---|
| VICE (`x64sc`) | Windows, macOS, Linux | Most widely used; cycle-exact; open source. |
| HOXS64 | Windows | Aims at cycle-exact emulation. |
| CCS64 | Windows | Legacy emulator; still functional. |

## constraints
- Raster-effect and sprite/badline-sensitive code SHOULD be tested under `x64sc` (cycle-exact), not `x64` (fast).
- VICE workflow details (autostart, monitor commands, flags) are in [../toolchains/vice.md](../toolchains/vice.md).

## links

- VICE workflow: [../toolchains/vice.md](../toolchains/vice.md)
- toolchains index: [../toolchains/INDEX.md](../toolchains/INDEX.md)

## sources

- VICE: https://vice-emu.sourceforge.io/
- HOXS64: http://www.hoxs64.net/
- CCS64: http://www.ccs64.com/
- codebase64.net tools page: https://codebase64.net/doku.php?id=tools:start (CC BY-NC-SA 4.0)
