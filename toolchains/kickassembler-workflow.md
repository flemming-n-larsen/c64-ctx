---
type: reference
domain: toolchains
granularity: workflow
summary: "Build a prg with KickAssembler on the JVM and run it in VICE."
keywords: [KickAssembler workflow, java jar, build and run]
---

## facts
- Workflow targets KickAssembler 5.x; see [../asm/kickassembler.md](../asm/kickassembler.md) for language reference.
- Requires Java (JRE 8+); KickAssembler ships as `KickAss.jar`.
- Invocation: `java -jar KickAss.jar src.asm` — by default emits `src.prg` (CBM `.prg` with 2-byte load-address header) in the source directory.
- KickAssembler emits the `.prg` directly — no linker step.
- Output filename can be overridden with `-o <file>`.

## sequence
### Source → `.prg` → VICE
1. Author source `src.asm` starting with `.pc = $0801 "basic"` (or chosen load address).
2. Include a BASIC SYS stub if loading at `$0801` and autostart is wanted (see [../asm/common-patterns.md](../asm/common-patterns.md)).
3. Assemble: `java -jar KickAss.jar src.asm`.
4. Launch: `x64sc src.prg` (see [vice.md](vice.md)).

### Iterative loop with VICE launch
1. Edit source.
2. Re-assemble.
3. KickAssembler supports `-vicesymbols` to emit a `.vs` file consumable by VICE's monitor.
4. Optional: use `-execute <cmd>` to chain emulator launch from the assembler invocation.

## lookup
| need | flag / directive | notes |
|---|---|---|
| Set output filename | `-o <file>` | Overrides default `src.prg`. |
| Output directory | `-odir <dir>` | Default is source directory. |
| Emit VICE symbol file | `-vicesymbols` | Generates `src.vs` for VICE monitor. |
| Emit listing | `-asminfo <opts>` | Listing/symbols/errors as text. |
| Execute after build | `-execute "<cmd>"` | Run emulator on success. |
| Pass `-D` symbols | `-define <sym>` | Compile-time conditional flag. |
| Set library path | `-libdir <dir>` | Additional `.import source` search. |
| Embed BASIC SYS stub | `BasicUpstart2(<addr>)` macro | Common KickAssembler convenience macro. |

## constraints
- Java MUST be on `PATH`; `java -version` reporting 8+ is REQUIRED.
- The first `.pc = <addr>` segment determines the `.prg` load address.
- `.import c64 "<file>"` strips the embedded `.prg` header; `.import binary` does not — choose deliberately.
- Output file naming follows source filename unless `-o` is given; this differs from ACME/64tass where source directives can dictate the name.
- Exact KickAssembler CLI behavior is outside the local source corpus and MUST be cited from the KickAssembler manual when contested.

## examples
Minimal end-to-end build:
```
java -jar KickAss.jar hello.asm
x64sc -warp hello.prg
```

With VICE symbols and chained launch:
```
java -jar KickAss.jar -vicesymbols -execute "x64sc -moncommands hello.vs hello.prg" hello.asm
```

Using the `BasicUpstart2` convenience macro (autostart at `$080d`):
```
BasicUpstart2(start)
* = $080d
start:
    lda #0
    sta $d020
    rts
```

## sources

- attribution: [../ATTRIBUTION.md](../ATTRIBUTION.md)
- upstream: KickAssembler reference manual (Mads Nielsen), distributed with the KickAssembler release archive.
- KickAssembler reference: [../asm/kickassembler.md](../asm/kickassembler.md)
- common patterns: [../asm/common-patterns.md](../asm/common-patterns.md)
- VICE: [vice.md](vice.md)
- toolchain index: [INDEX.md](INDEX.md)
