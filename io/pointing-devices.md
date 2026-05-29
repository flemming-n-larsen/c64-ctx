---
type: reference
domain: io
granularity: atomic
---

## facts
- Pointing-device coverage under `/io` spans multiple hardware paths rather than a single chip contract.
- Paddles expose analog values through SID read registers `$D419` and `$D41A`, so the existing SID register page is the local hardware anchor for analog controller input.
- Other controller families mentioned by Codebase64, such as mice, KoalaPad, and lightgun variants, overlap CIA timing, SID analog input, or device-specific protocols and are not yet represented by a single dedicated local implementation page.
- This page is therefore a route and scope note: it points to the existing local hardware facts and keeps remaining detail in provenance rather than inventing unsupported register semantics.

## lookup
| device family | read | notes |
|---|---|---|
| Paddles / analog input | [../sid/registers.md](../sid/registers.md) | `$D419/$D41A` are the existing local read points for paddle values. |
| Shared CIA controller context | [cia1.md](cia1.md) | CIA1 still matters for controller-port overlap and digital input constraints. |
| Topic provenance for mice, KoalaPad, and lightguns | [../sources/INDEX.md](../sources/INDEX.md) | Upstream routing remains the fallback until local device-specific pages exist. |

## constraints
- Do not assign exact mouse, KoalaPad, or lightgun register semantics unless a cited local page exists.
- Keep analog SID reads separate from CIA digital port reads; they are different hardware interfaces.
- Use provenance rather than copied prose when Codebase64 acts as a catalog of device-specific articles.

## links
- I/O programming hub: [io-programming.md](io-programming.md)
- SID registers: [../sid/registers.md](../sid/registers.md)
- CIA1 registers: [cia1.md](cia1.md)
- Provenance: [../sources/INDEX.md](../sources/INDEX.md)

## sources
- SID registers: [../sid/registers.md](../sid/registers.md)
- CIA1 registers: [cia1.md](cia1.md)
- I/O programming hub: [io-programming.md](io-programming.md)
- Provenance: [../sources/INDEX.md](../sources/INDEX.md)