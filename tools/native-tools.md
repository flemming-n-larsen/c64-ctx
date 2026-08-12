---
type: reference
domain: tools
granularity: native-tools
summary: "Assemblers, packers and linkers that run on the C64 itself."
keywords: [native tools, Turbo Assembler, TMPx, on-machine development]
---

## facts
- Native tools run on the C64 itself; development happens directly on the machine.
- Turbo Assembler (TASM) is maintained by Style; the Style64 page also hosts Turbo Macro Pro (TMP), a cross-compatible variant.
- TMPx (cross) is source-compatible with Turbo Macro Pro, allowing native source to be assembled on PC.
- Most native packers/linkers are by Zagon; Sledgehammer is a packer+linker combined.

## lookup — native assemblers
| tool | author | notes |
|---|---|---|
| Turbo Assembler (TASM) | various; maintained by Style | Most-used historical native assembler; Style64 distributes current build. |
| Ass Blaster V3.2 | Mr. Lee/Cascade | CSDB release 99889. |

## lookup — native packers and linkers
| tool | author | CSDB ID | notes |
|---|---|---|---|
| Sledgehammer V2.1+ | Trap/Bonzai; improved by Atis/Cross | 27574 | Combined packer + linker. |
| Lightimizer Packer V6.0 | Zagon/Light | 20847 | — |
| Visiomizer Packer V6.3 | Zagon/Vision | 47784 | — |
| Zipper V5.0 | Zagon/Vision | 97926 | — |
| BYG Compactor V1.0 | Naf/Babygang | 10712 | — |

## lookup — cross-assembler with native source compatibility
| tool | author | notes |
|---|---|---|
| TMPx | Style | Source-compatible with Turbo Macro Pro; cross-assembler for PC. |

## constraints
- Native source files use PETSCII encoding; conversion to ASCII is needed before use in a cross-assembler (see TMPView in [transfer.md](transfer.md)).
- TMPx accepts TMP-dialect source directly on PC without encoding conversion.

## links
- cross-assembler syntax: [../asm/INDEX.md](../asm/INDEX.md)
- transfer tools (TASM → PC): [transfer.md](transfer.md)
- crunchers (native): [crunchers.md](crunchers.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- Turbo Assembler (Style64): http://turbo.style64.org/
- Ass Blaster V3.2: https://csdb.dk/release/?id=99889
- TMPx: http://style64.org/release/tmpx-v1.0-style
- Sledgehammer V2.1+: https://csdb.dk/release/?id=27574
- Lightimizer Packer V6.0: https://csdb.dk/release/?id=20847
- Visiomizer Packer V6.3: https://csdb.dk/release/?id=47784
- Zipper V5.0: https://csdb.dk/release/?id=97926
- BYG Compactor V1.0: https://csdb.dk/release/?id=10712
- codebase64.net tools page: https://codebase64.net/doku.php?id=tools:start (CC BY-NC-SA 4.0)
