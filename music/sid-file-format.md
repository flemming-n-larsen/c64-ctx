---
type: reference
domain: music
granularity: atomic
source: hvsc
summary: "The PSID and RSID container format: header fields, byte order, payload loading."
keywords: [SID file, PSID, RSID, HVSC, container header]
---

## facts
- `.sid` files used by HVSC are containers with a PSID or RSID header followed by C64 program data; they are not raw SID-register dumps.
- Header words and double words are stored big-endian, while an embedded C64 load address in the data payload is stored little-endian.
- PSID is the general replay container; RSID marks tunes that require a real C64-compatible execution environment and stricter header values.
- Header versions 2–4 add flags for data/player type, PAL/NTSC clock, SID model, relocation, and optional second/third SID addresses.

## lookup
| offset | size | field | notes |
|---:|---:|---|---|
| `$00` | 4 | magic ID | ASCII `PSID` or `RSID`. |
| `$04` | 2 | version | Big-endian version number. |
| `$06` | 2 | data offset | Byte offset from file start to C64 data. |
| `$08` | 2 | load address | If zero, first two data bytes carry the little-endian load address. |
| `$0A` | 2 | init address | Entry called to initialize a subtune. |
| `$0C` | 2 | play address | Replay entry; special rules apply when zero. |
| `$0E` | 2 | songs | Number of subtunes. |
| `$10` | 2 | start song | Default subtune, numbered from 1. |
| `$12` | 4 | speed | One bit per first 32 subtunes; interpretation is defined by the format version. |
| `$16` | 32 | name | Metadata string. |
| `$36` | 32 | author | Metadata string. |
| `$56` | 32 | released | Release/copyright metadata string. |
| `$76` | 2 | flags | Version 2+ player/data, clock, and SID-model fields. |
| `$78` | 1 | start page | Relocation start page. |
| `$79` | 1 | page length | Number of free relocation pages. |
| `$7A` | 1 | second SID | Encoded second-SID base for supported versions. |
| `$7B` | 1 | third SID | Encoded third-SID base for supported versions. |

## constraints
- A parser MUST use `data offset`; it MUST NOT assume every header ends at `$76` or `$7C`.
- When `load address` is zero, the two little-endian address bytes belong to the payload prefix and are not loaded into C64 memory.
- Metadata fields are fixed-width and MAY lack a terminating zero when all 32 bytes are used.
- RSID requires `load address = 0`, `play address = 0`, and `speed = 0`; players MUST provide the required C64 environment rather than calling it like a simple PSID tune.
- Clock and SID-model flags SHOULD guide playback but MAY be unknown or unspecified.
- The complete version-specific bit encoding MUST be taken from the HVSC specification when implementing a writer or validator.

## sources

- tune integration: [tune-integration.md](tune-integration.md)
- PAL/NTSC playback: [pal-ntsc-playback.md](pal-ntsc-playback.md)
- authoritative format specification: [HVSC `SID_file_format.txt`](https://www.hvsc.c64.org/download/C64Music/DOCUMENTS/SID_file_format.txt)
- tracker/player layout notes: [player-file-formats.md](player-file-formats.md)
- SID model detection: [../sid/model-detect.md](../sid/model-detect.md)
- music index: [INDEX.md](INDEX.md)
