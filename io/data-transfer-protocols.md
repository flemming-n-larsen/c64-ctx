---
type: reference
domain: io
granularity: atomic
summary: "Communication patterns layered above raw bus or controller hardware."
keywords: [transfer protocols, handshaking, serial transfer, link protocols]
---

## facts
- Data-transfer protocols in the Codebase64 `I/O Programming` topic cover communication patterns layered above raw controller or bus hardware.
- The local repository covers baseline KERNAL/IEC transfers and now routes custom fast-loader work through a dedicated protocol-family page.
- Device-to-device and modern peripheral protocols remain implementation-specific; they must be documented against the selected hardware rather than treated as one C64 standard.

## lookup
| need | read | notes |
|---|---|---|
| Baseline serial-bus API layer | [../kernal/serial-bus.md](../kernal/serial-bus.md) | Existing local route for KERNAL-managed IEC transfer calls. |
| File/channel workflow context | [../kernal/file-io.md](../kernal/file-io.md) | Transfer protocols often surface through higher-level file/device operations. |
| Practical load/save sequencing | [../tasks/load-save-file.md](../tasks/load-save-file.md) | Recipe layer for common device-transfer workflows. |
| Fast loaders | [fast-loaders.md](fast-loaders.md) | Host/drive split, compatibility rules, and a maintained implementation route. |
| Upstream topic provenance | [../sources/INDEX.md](../sources/INDEX.md) | Use for device-specific protocols that still lack a dedicated local page. |

## constraints
- Do not claim exact protocol timing, framing, or fast-loader semantics without a cited local page.
- Distinguish KERNAL-managed IEC/file calls from any protocol that bypasses or extends them.
- Protocol-specific timing and framing MUST remain on implementation pages with direct citations.

## links
- I/O programming hub: [io-programming.md](io-programming.md)
- KERNAL serial bus: [../kernal/serial-bus.md](../kernal/serial-bus.md)
- KERNAL file I/O: [../kernal/file-io.md](../kernal/file-io.md)
- Load/save task: [../tasks/load-save-file.md](../tasks/load-save-file.md)
- Fast loaders: [fast-loaders.md](fast-loaders.md)
- Provenance: [../sources/INDEX.md](../sources/INDEX.md)

## sources
- KERNAL serial bus: [../kernal/serial-bus.md](../kernal/serial-bus.md)
- KERNAL file I/O: [../kernal/file-io.md](../kernal/file-io.md)
- Load/save task: [../tasks/load-save-file.md](../tasks/load-save-file.md)
- Fast loaders: [fast-loaders.md](fast-loaders.md)
- I/O programming hub: [io-programming.md](io-programming.md)
- Provenance: [../sources/INDEX.md](../sources/INDEX.md)
