---
type: index
domain: asm
source: assembler-docs
---

## routes
| need | read | notes |
|---|---|---|
| ACME directives, macros, output | [acme.md](acme.md) | Targeted version: ACME 0.97+. |
| KickAssembler directives, macros, scripting | [kickassembler.md](kickassembler.md) | Targeted version: KickAssembler 5.x. Requires JVM. |
| CA65 directives, segments, linker config | [ca65.md](ca65.md) | Targeted version: cc65 2.19+. Linked with `ld65`. |
| 64tass directives, output options, labels | [64tass.md](64tass.md) | Targeted version: 64tass 1.58+. |
| Translate between assemblers | [rosetta.md](rosetta.md) | Side-by-side equivalence table. |
| BASIC SYS stub, `.prg` layout, KERNAL calls | [common-patterns.md](common-patterns.md) | Assembler-agnostic minimal patterns. |

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [acme.md](acme.md) | used | Cites ACME user manual (Marco Baye). |
| [kickassembler.md](kickassembler.md) | used | Cites KickAssembler reference manual (Mads Nielsen). |
| [ca65.md](ca65.md) | used | Cites cc65 docs (`ca65`, `ld65`). |
| [64tass.md](64tass.md) | used | Cites 64tass manual (Soci/Singular). |
| [rosetta.md](rosetta.md) | used | Cross-assembler equivalence; cites the four assembler pages. |
| [common-patterns.md](common-patterns.md) | used | Assembler-neutral patterns; cites BASIC, memory, tasks. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | No mist64/c64ref upstream — each page cites its own assembler docs. |

## related
| domain | read | why |
|---|---|---|
| CPU | [../cpu/6502/INDEX.md](../cpu/6502/INDEX.md) | Mnemonics, addressing modes, opcode bytes. |
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | Load addresses, safe code/data placement. |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Practical sequences used from assembly. |
| Toolchains | [../toolchains/INDEX.md](../toolchains/INDEX.md) | Build/run workflows for these assemblers. |
| BASIC | [../basic/machine-code-bridge.md](../basic/machine-code-bridge.md) | BASIC SYS stub and loader patterns. |
