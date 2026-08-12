---
type: index
domain: toolchains
source: tool-docs
---

## routes
| need | read | notes |
|---|---|---|
| Run/debug a `.prg` on a PC | [vice.md](vice.md) | VICE emulator; autostart, monitor, command-line launch. |
| ACME source → `.prg` → VICE | [acme-workflow.md](acme-workflow.md) | Uses `!to "out.prg", cbm`. |
| KickAssembler source → `.prg` → VICE | [kickassembler-workflow.md](kickassembler-workflow.md) | JVM required; `java -jar KickAss.jar`. |
| CA65 (cc65) source → `.prg` → VICE | [ca65-workflow.md](ca65-workflow.md) | Two-stage `ca65` + `ld65`. |
| 64tass source → `.prg` → VICE | [64tass-workflow.md](64tass-workflow.md) | Single invocation; `--cbm-prg` for header. |
| CBM Studio project shape | [cbm-studio.md](cbm-studio.md) | Project/workflow assumptions; routes to assembler reference. |

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| Build a prg with 64tass and run it in VICE. | [64tass-workflow.md](64tass-workflow.md) | 64tass workflow, build and run, command line, prg header |
| Build a prg with ACME and run it in VICE. | [acme-workflow.md](acme-workflow.md) | ACME workflow, build and run, command line, cbm output |
| Build a prg with the two-stage ca65 and ld65 flow, then run it in VICE. | [ca65-workflow.md](ca65-workflow.md) | ca65 workflow, ld65, two-stage build, build and run |
| CBM prg Studio project shape and workflow assumptions. | [cbm-studio.md](cbm-studio.md) | CBM prg Studio, Windows IDE, project setup |
| Build a prg with KickAssembler on the JVM and run it in VICE. | [kickassembler-workflow.md](kickassembler-workflow.md) | KickAssembler workflow, java jar, build and run |
| Run and debug a prg in VICE: autostart, monitor, command-line flags. | [vice.md](vice.md) | VICE, emulator workflow, autostart, monitor, debugging |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Assemblers | [../asm/INDEX.md](../asm/INDEX.md) | Source-language reference for the four supported assemblers. |
| BASIC | [../basic/INDEX.md](../basic/INDEX.md) | BASIC SYS stub and loader patterns invoked by `.prg` files. |
| Tasks | [../tasks/program-entrypoints.md](../tasks/program-entrypoints.md) | Choosing program shape before building. |
| Memory | [../memory/map.md](../memory/map.md) | Load addresses and safe code/data zones. |

## rules
- Toolchain pages MUST stay editor-neutral; correctness MUST NOT depend on editor-specific project files.
- Tool-version assumptions MUST appear in each page's `## facts` section.
- Exact tool behavior beyond the source corpus MUST route to upstream docs via [../sources/INDEX.md](../sources/INDEX.md) and [../ATTRIBUTION.md](../ATTRIBUTION.md).
