---
type: reference
domain: tools
granularity: music-editors
---

## facts
- GoatTracker is the most widely used cross-platform SID tracker; native ports exist for multiple OSes.
- CheeseCutter is cross-platform and based on the JCH Editor engine.
- JCH Editor is considered the most-used native editor historically.
- NinjaTracker (by Cadaver) ships with a converter from GoatTracker format.
- DMC V5.0+ is an improved version of DMC V4.0 by CreaMD; both are native editors.
- ATMDS is editor-style based on the DMC series, oriented toward coders.

## lookup — cross-platform editors
| tool | author | notes |
|---|---|---|
| GoatTracker | Cadaver | Ports for Windows, macOS, Linux; exports SID player. |
| GoatTracker (Mac port) | — | Separate download from sidmusic.org. |
| CheeseCutter | Abaddon/Fairlight | Cross-platform; based on JCH editor. |
| Music Studio 2.1.0.7 | Martin Piper | — |

## lookup — native editors (run on C64)
| tool | author | CSDB ID | notes |
|---|---|---|---|
| JCH Editor | JCH | 14037 | Most-used native editor historically. |
| SDI | SHAPE | 84874 | Noted for best sound quality. |
| DMC V5.0+ | Graffity; improved by CreaMD | 22938 | — |
| DMC V4.0 | Graffity | 2596 | Original DMC release. |
| ATMDS v3.2 | St0fF/Neoplasia | 7159 | AcidTrackMusicDevelopmentSystem; coder-oriented; DMC style. |
| NinjaTracker | Cadaver | — | GoatTracker converter available. |

## constraints
- SID player code must be integrated by the caller; export format and player size differ per editor.
- PAL/NTSC playback speed differences must be handled in the IRQ player or music init code.
- GoatTracker exports use a specific player routine; its size and relocation constraints apply.

## links
- music integration: [../music/INDEX.md](../music/INDEX.md)
- SID registers and waveforms: [../sid/INDEX.md](../sid/INDEX.md)
- IRQ players: [../irq/INDEX.md](../irq/INDEX.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- GoatTracker: http://covertbitops.c64.org/
- GoatTracker (Mac): http://www.sidmusic.org/goattracker/mac/
- CheeseCutter: http://koti.kapsi.fi/~ttaipalus/ccutter/
- Music Studio 2.1.0.7: https://csdb.dk/release/?id=93693
- JCH Editor: https://csdb.dk/release/?id=14037
- SDI: https://csdb.dk/release/?id=84874
- DMC V5.0+: https://csdb.dk/release/?id=22938
- DMC V4.0: https://csdb.dk/release/?id=2596
- ATMDS v3.2: https://csdb.dk/release/?id=7159
- NinjaTracker: https://cadaver.github.io/tools.html
- codebase64.net tools page: https://codebase64.net/doku.php?id=tools:start (CC BY-NC-SA 4.0)
