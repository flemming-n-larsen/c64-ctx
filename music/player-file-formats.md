---
type: reference
domain: music
granularity: atomic
summary: "How tracker output packs patterns, instruments and sequences, using JCH as the worked case."
keywords: [tracker format, JCH, pattern data, sequence bytes, player layout]
---

## facts
- Tracker/editor output formats are music-layer concerns: they describe how patterns, instruments, tables, and sequence pointers are packed before a player interprets them.
- Codebase64's `JCH 20.G4` note documents fixed table locations followed by three per-voice sequence lists and sequence data blocks.
- Sequence rows are stored as byte pairs `AA`/`BB`: `AA` carries instrument/tie/supertable control, while `BB` carries note or gate-hold meaning.
- The JCH article is explicitly incomplete, so this page remains a format-specific note rather than a full converter specification.
- For a documented interchange/container format, use the PSID/RSID header reference in [sid-file-format.md](sid-file-format.md).

## JCH 20.G4 layout highlights
| data | base address | notes |
|---|---|---|
| Arpeggio tables | `$18CB` / `$19CB` | Two columns |
| Filter table | `$1ACB` | Shared modulation data |
| Pulse table | `$1BCB` | Pulse-width modulation data |
| Instrument table | `$1CCB` | Instrument definitions |
| Sequence pointer tables | `$1DCB` / `$1ECB` | Low/high bytes |
| Sequence lists for voices 0-2 | `$20CB`, `$24CB`, `$28CB` | Per-voice song order |
| Sequence data | `$2CCB` onward | Actual step data starts `+3` bytes into each block |

## sequence byte meanings
| field | value | meaning |
|---|---|---|
| `AA` | `$7F` | End of sequence |
| `AA` | `$90` | Tie note (`***`) |
| `AA` | `$A0-$BF` | Instrument `$00-$1F` |
| `AA` | `$C0-$DF` | Pointer into super table |
| `AA` | `$80` | No control change |
| `BB` | `$00` | No note / gate off |
| `BB` | `$01-...` | Note value using current instrument |
| `BB` | `$7E` | Gate-on hold (`+++`) |

## links
- music patterns: [music-patterns.md](music-patterns.md)
- hard restart: [hard-restart.md](hard-restart.md)
- SID registers: [../sid/registers.md](../sid/registers.md)
- music index: [INDEX.md](INDEX.md)
- PSID/RSID container: [sid-file-format.md](sid-file-format.md)

## sources
- codebase64.net: [JCH 20.G4 Player File Format](https://codebase64.net/doku.php?id=base:jch_20.g4_player_file_format) — CC BY-NC-SA 4.0
- PSID/RSID container: [sid-file-format.md](sid-file-format.md)
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
