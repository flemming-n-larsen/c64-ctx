---
type: reference
domain: toolchains
granularity: ide
summary: "CBM prg Studio project shape and workflow assumptions."
keywords: [CBM prg Studio, Windows IDE, project setup]
---

## facts
- CBM prg Studio is a Windows IDE for BASIC and 6502 assembly development targeting Commodore 8-bit machines.
- It hosts an integrated text editor, assembler, BASIC tokenizer, sprite/character editors, and a VICE-launch button.
- Built-in assembler is CBM prg Studio's own (TASM-style syntax); projects MAY alternatively be configured to invoke an external assembler.
- Output is a `.prg` (CBM-format with 2-byte load-address header).
- VICE integration is by external launch — the IDE writes the `.prg` and shells out to a configured `x64sc` path.
- Target version: CBM prg Studio 4.x or later.

## sequence
### Build a `.prg` and run it in VICE
1. Create a project (machine = C64, language = Assembly or BASIC).
2. Add source files to the project tree.
3. For assembly: set the load address via the source's `*= $0801` (or chosen address) and include a BASIC SYS stub if autostart is wanted (see [../asm/common-patterns.md](../asm/common-patterns.md)).
4. Build (F7 by default) — produces the `.prg` in the project's output directory.
5. Run (F5) — launches the configured emulator with the `.prg` as autostart argument.

### Use sprite / character editors
1. Open the sprite or character editor from the project tree.
2. Edit graphics visually; CBM prg Studio writes the binary data back into a source-include file (`.bin` or generated assembly bytes).
3. Reference the data in source via `.incbin "<file>"`, `!binary "<file>"`, or the equivalent for the chosen assembler.

## lookup
| need | route | notes |
|---|---|---|
| Assembler syntax (built-in) | CBM prg Studio docs | TASM-style; many ACME/64tass conventions overlap. |
| External-assembler reference | [../asm/INDEX.md](../asm/INDEX.md) | When configuring ACME/KickAssembler/CA65/64tass as project assembler. |
| Sprite data placement | [../tasks/sprite-display.md](../tasks/sprite-display.md) | 64-byte alignment, VIC bank constraints. |
| Custom-character data placement | [../tasks/custom-charset.md](../tasks/custom-charset.md) | Charset RAM target via `$D018`. |
| Program-shape choice | [../tasks/program-entrypoints.md](../tasks/program-entrypoints.md) | BASIC vs SYS-stub vs standalone `.prg`. |
| VICE launch options | [vice.md](vice.md) | Emulator settings live outside the IDE. |

## constraints
- Project-file format is CBM-prg-Studio-specific; correctness of the underlying source MUST NOT depend on IDE-only project metadata.
- Source files SHOULD be plain assembly/BASIC text so that they remain buildable from the command line via the assemblers documented in [../asm/INDEX.md](../asm/INDEX.md).
- BASIC source authored in the IDE is tokenized at build time; the resulting `.prg` is the tokenized stream, not source text.
- Sprite/char editor output is binary — version-control plain-text source alongside binary assets explicitly.
- Exact CBM prg Studio behavior is outside the local source corpus and MUST be cited from CBM prg Studio's own documentation when contested.

## sources

- attribution: [../ATTRIBUTION.md](../ATTRIBUTION.md)
- upstream: CBM prg Studio documentation (Arthur Jordison), distributed with the CBM prg Studio installer.
- assembler reference: [../asm/INDEX.md](../asm/INDEX.md)
- common patterns: [../asm/common-patterns.md](../asm/common-patterns.md)
- VICE: [vice.md](vice.md)
- program entrypoints: [../tasks/program-entrypoints.md](../tasks/program-entrypoints.md)
- toolchain index: [INDEX.md](INDEX.md)
