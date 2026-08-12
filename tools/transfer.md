---
type: reference
domain: tools
granularity: transfer
summary: "Moving files between a PC and real C64 hardware."
keywords: [file transfer, Final Replay, Codenet, RR-net, real hardware]
---

## facts
- Final Replay and Codenet transfer files from PC to a real C64 over ethernet; requires a Retro Replay cartridge with RR-net expansion.
- "Warpcopy" is mentioned alongside Final Replay as an alternative transfer method.
- TMPView 1.3 converts native Turbo Assembler (TASM) source from a C64 disk image to PC-readable text for migration to a cross-assembler environment.

## lookup — PC → C64
| tool | author | requirement | notes |
|---|---|---|---|
| Final Replay + Codenet | Graham/Oxyron | Retro Replay cartridge + RR-net | Ethernet-based transfer. |

## lookup — C64 → PC
| tool | author | notes |
|---|---|---|
| TMPView 1.3 | Style | Converts TASM source to PC text; CSDB/Style64 release. |

## sources

- Final Replay / Codenet: http://www.oxyron.de/html/freplay.html
- TMPView 1.3: http://style64.org/release/tmpview-v1.3-style
- codebase64.net tools page: https://codebase64.net/doku.php?id=tools:start (CC BY-NC-SA 4.0)
- native assemblers: [native-tools.md](native-tools.md)
- toolchains: [../toolchains/INDEX.md](../toolchains/INDEX.md)
