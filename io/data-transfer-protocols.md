---
type: reference
domain: io
granularity: atomic
---

## facts
- Data-transfer protocols in the Codebase64 `I/O Programming` topic cover communication patterns layered above raw controller or bus hardware.
- The local repository already covers the baseline KERNAL file and IEC serial routes, but it does not yet break out specific fast-loader or device-to-device protocol families into dedicated local pages.
- This page makes the topic visible from `/io` while keeping uncertain or device-specific protocol detail in provenance rather than presenting an incomplete local standard.

## lookup
| need | read | notes |
|---|---|---|
| Baseline serial-bus API layer | [../kernal/serial-bus.md](../kernal/serial-bus.md) | Existing local route for KERNAL-managed IEC transfer calls. |
| File/channel workflow context | [../kernal/file-io.md](../kernal/file-io.md) | Transfer protocols often surface through higher-level file/device operations. |
| Practical load/save sequencing | [../tasks/load-save-file.md](../tasks/load-save-file.md) | Recipe layer for common device-transfer workflows. |
| Upstream topic provenance | [../sources/INDEX.md](../sources/INDEX.md) | Use when the local repo does not yet have a dedicated protocol-specific page. |

## constraints
- Do not claim exact protocol timing, framing, or fast-loader semantics without a cited local page.
- Distinguish KERNAL-managed IEC/file calls from any protocol that bypasses or extends them.
- Keep this page route-first until the repository gains dedicated protocol summaries.

## links
- I/O programming hub: [io-programming.md](io-programming.md)
- KERNAL serial bus: [../kernal/serial-bus.md](../kernal/serial-bus.md)
- KERNAL file I/O: [../kernal/file-io.md](../kernal/file-io.md)
- Load/save task: [../tasks/load-save-file.md](../tasks/load-save-file.md)
- Provenance: [../sources/INDEX.md](../sources/INDEX.md)

## sources
- KERNAL serial bus: [../kernal/serial-bus.md](../kernal/serial-bus.md)
- KERNAL file I/O: [../kernal/file-io.md](../kernal/file-io.md)
- Load/save task: [../tasks/load-save-file.md](../tasks/load-save-file.md)
- I/O programming hub: [io-programming.md](io-programming.md)
- Provenance: [../sources/INDEX.md](../sources/INDEX.md)