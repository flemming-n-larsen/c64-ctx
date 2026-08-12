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
| Buddy Assembler directives, native C64 resident assembler | [buddy.md](buddy.md) | On-machine assembler; no macros, 6-char label limit. |
| MADS directives, macros, invocation | [mads.md](mads.md) | Cross-assembler (Windows/Linux/macOS); Atari-origin, 6502 output usable on C64. |
| Translate between assemblers | [rosetta.md](rosetta.md) | Side-by-side equivalence table. |
| BASIC SYS stub, `.prg` layout, KERNAL calls | [common-patterns.md](common-patterns.md) | Assembler-agnostic minimal patterns. |

## pages
<!-- GENERATED:routes -->
_Every page in this domain is reached from `## routes` above._
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| CPU | [../cpu/6502/INDEX.md](../cpu/6502/INDEX.md) | Mnemonics, addressing modes, opcode bytes. |
| Memory | [../memory/INDEX.md](../memory/INDEX.md) | Load addresses, safe code/data placement. |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Practical sequences used from assembly. |
| Toolchains | [../toolchains/INDEX.md](../toolchains/INDEX.md) | Build/run workflows for these assemblers. |
| BASIC | [../basic/machine-code-bridge.md](../basic/machine-code-bridge.md) | BASIC SYS stub and loader patterns. |
