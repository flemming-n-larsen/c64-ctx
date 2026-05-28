---
type: index
domain: examples
source: cross-domain
---

## routes
| need | read | notes |
|---|---|---|
| BASIC program changing border + background colors | [basic-border-background.md](basic-border-background.md) | Cites [../basic/graphics-sound.md](../basic/graphics-sound.md), [../colors/INDEX.md](../colors/INDEX.md), [../io/vic-ii.md](../io/vic-ii.md). |
| BASIC program reading a keypress | [basic-read-key.md](basic-read-key.md) | Cites [../basic/io.md](../basic/io.md), [../tasks/read-keyboard.md](../tasks/read-keyboard.md), [../charset/petscii.md](../charset/petscii.md). |
| BASIC `DATA`+`POKE`+`SYS` loader for ML | [basic-sys-loader.md](basic-sys-loader.md) | Cites [../basic/machine-code-bridge.md](../basic/machine-code-bridge.md), [../tasks/program-entrypoints.md](../tasks/program-entrypoints.md), [../memory/map.md](../memory/map.md). |
| Minimal ACME `.prg` with SYS stub | [acme-hello.md](acme-hello.md) | Cites [../asm/acme.md](../asm/acme.md), [../asm/common-patterns.md](../asm/common-patterns.md), [../toolchains/acme-workflow.md](../toolchains/acme-workflow.md). |
| Minimal KickAssembler sprite program | [kickassembler-sprite.md](kickassembler-sprite.md) | Cites [../asm/kickassembler.md](../asm/kickassembler.md), [../tasks/sprite-display.md](../tasks/sprite-display.md), [../toolchains/kickassembler-workflow.md](../toolchains/kickassembler-workflow.md). |
| Minimal `ca65`/`ld65` C64 `.prg` | [ca65-minimal-prg.md](ca65-minimal-prg.md) | Cites [../asm/ca65.md](../asm/ca65.md), [../asm/common-patterns.md](../asm/common-patterns.md), [../toolchains/ca65-workflow.md](../toolchains/ca65-workflow.md). |
| Minimal `64tass` `.prg` with SYS stub | [64tass-hello.md](64tass-hello.md) | Cites [../asm/64tass.md](../asm/64tass.md), [../asm/common-patterns.md](../asm/common-patterns.md), [../toolchains/64tass-workflow.md](../toolchains/64tass-workflow.md). |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [basic-border-background.md](basic-border-background.md) | used | Complete BASIC V2 listing. |
| [basic-read-key.md](basic-read-key.md) | used | Complete BASIC V2 listing. |
| [basic-sys-loader.md](basic-sys-loader.md) | used | BASIC + machine code via `DATA`/`SYS`. |
| [acme-hello.md](acme-hello.md) | used | Buildable ACME source + invocation. |
| [kickassembler-sprite.md](kickassembler-sprite.md) | used | Buildable KickAssembler source + invocation. |
| [ca65-minimal-prg.md](ca65-minimal-prg.md) | used | Buildable `ca65`/`ld65` source + invocation. |
| [64tass-hello.md](64tass-hello.md) | used | Buildable `64tass` source + invocation. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Examples cite local reference pages; upstream provenance routes through cited domains. |

## related
| domain | read | why |
|---|---|---|
| BASIC | [../basic/INDEX.md](../basic/INDEX.md) | Language reference for BASIC examples. |
| Assemblers | [../asm/INDEX.md](../asm/INDEX.md) | Per-assembler syntax for ASM examples. |
| Toolchains | [../toolchains/INDEX.md](../toolchains/INDEX.md) | Source → `.prg` → VICE workflows. |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Recipe pages underlying example listings. |
| I/O | [../io/INDEX.md](../io/INDEX.md) | Register facts cited by examples. |
| Memory | [../memory/map.md](../memory/map.md) | Load addresses and safe code/data zones. |
| Charset | [../charset/INDEX.md](../charset/INDEX.md) | PETSCII / screen code / keyboard facts. |
| Colors | [../colors/INDEX.md](../colors/INDEX.md) | Palette indices used by examples. |

## rules
- Each example MUST link back to the cited `basic/`, `asm/`, `tasks/`, `io/`, `memory/`, `charset/`, `colors/`, and `toolchains/` pages that ground its facts.
- Examples MUST NOT duplicate hardware register tables — cite the relevant `io/` page instead.
- Examples MUST be runnable as written, with build/run invocation included for non-BASIC listings.
- Examples MUST state the assembler version assumption for ASM listings via the cited `asm/` page.
