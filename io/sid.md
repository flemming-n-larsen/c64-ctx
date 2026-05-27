---
type: reference
domain: io
granularity: chip
---

## facts
- `$D400-$D7FF` is the SID (`MOS 81 SOUND INTERFACE DEVICE`) range in the local I/O pages.
- `$D400` starts voice `1` frequency control low byte in the local I/O pages.
- SID register mirrors may appear across the `$D400-$D7FF` block; agents SHOULD cite exact source/register rows for detailed programming.

## lookup
| range | role | notes |
|---|---|---|
| `$D400-$D418` | Core SID voice/filter/volume register area | Use exact I/O map rows for detailed register fields. |
| `$D400-$D406` | Voice `1` | Frequency, pulse width, control, envelope route. |
| `$D407-$D40D` | Voice `2` | Same register pattern as voice `1`. |
| `$D40E-$D414` | Voice `3` | Same register pattern as voice `1`. |
| `$D415-$D418` | Filter/mode/volume | Filter cutoff/resonance/mode/volume route. |

## constraints
- Agents MUST NOT infer exact SID bit semantics from this compact page; use cited I/O sources for bit-level details.
- Sound examples SHOULD link here for address range and then cite detailed source rows where needed.

## links
- I/O area: [../memory/io-area.md](../memory/io-area.md)
- processor port: [processor-port.md](processor-port.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- I/O index: [INDEX.md](INDEX.md)
