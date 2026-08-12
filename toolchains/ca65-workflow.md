---
type: reference
domain: toolchains
granularity: workflow
summary: "Build a prg with the two-stage ca65 and ld65 flow, then run it in VICE."
keywords: [ca65 workflow, ld65, two-stage build, build and run]
---

## facts
- Workflow targets cc65 2.19+; see [../asm/ca65.md](../asm/ca65.md) for language reference.
- Build is two-stage: `ca65` assembles each source to a `.o` object; `ld65` links objects + libs into the final `.prg`.
- `ld65 -t c64` selects the bundled C64 target — it pulls in `c64.cfg` (memory map) and `c64.lib` (runtime including BASIC SYS stub at `$0801`).
- Custom layouts (no cc65 runtime, alternative load address) require a hand-written `.cfg` linker script.
- Output is a real `.prg` with 2-byte CBM load-address header.

## sequence
### Standard `.prg` via `-t c64`
1. Author source `src.s` using cc65 runtime conventions (export `_main` for the C runtime, or supply an `EXEHDR` segment in a custom config).
2. Assemble: `ca65 -t c64 src.s -o src.o`.
3. Link: `ld65 -t c64 -o out.prg src.o c64.lib`.
4. Launch: `x64sc out.prg` (see [vice.md](vice.md)).

### Custom layout (no cc65 runtime)
1. Write `custom.cfg` with `MEMORY {}` and `SEGMENTS {}` (see [../asm/ca65.md](../asm/ca65.md)).
2. Author source emitting the BASIC SYS stub explicitly into the `STARTUP`/`EXEHDR` segment.
3. Assemble: `ca65 src.s -o src.o`.
4. Link: `ld65 -C custom.cfg -o out.prg src.o`.
5. Launch: `x64sc out.prg`.

### Iterative loop
1. Edit source.
2. Re-run `ca65` + `ld65`.
3. Re-run VICE.

## lookup
| need | flag | tool | notes |
|---|---|---|---|
| Set CPU | `--cpu 6502` | `ca65` | Default for `-t c64`. |
| Add include path | `-I <dir>` | `ca65` | Multiple `-I` allowed. |
| Emit debug info | `-g` | `ca65` | For `ld65 --dbgfile`. |
| Listing file | `-l <file>` | `ca65` | Per-source listing. |
| Select target | `-t c64` | `ld65` | Uses `c64.cfg` + `c64.lib`. |
| Custom config | `-C <file>` | `ld65` | Replaces `-t` behavior. |
| Output file | `-o <file>` | `ld65` | Output `.prg`. |
| Emit map file | `-m <file>` | `ld65` | Segment/symbol map. |
| VICE label file | `-Ln <file>` | `ld65` | VICE monitor symbol format. |
| Library search path | `--lib-path <dir>` | `ld65` | Where `c64.lib` is found. |

## constraints
- `-t c64` linker target REQUIRES `c64.lib` on the linker search path; standard cc65 installs handle this automatically.
- A source built with `-t c64` does NOT need a hand-rolled BASIC SYS stub — the runtime emits it.
- A source built with a custom `.cfg` MUST emit its own SYS stub if it loads at `$0801`.
- Object format is cc65-proprietary; do NOT mix `.o` files from incompatible cc65 versions.
- Exact `ca65`/`ld65` CLI behavior is outside the local source corpus and MUST be cited from cc65 docs when contested.

## examples
Minimal `-t c64` build:
```
ca65 -t c64 hello.s -o hello.o
ld65 -t c64 -o hello.prg hello.o c64.lib
x64sc hello.prg
```

Custom-config build (hand-rolled SYS stub):
```
ca65 hello.s -o hello.o
ld65 -C custom.cfg -o hello.prg hello.o
x64sc hello.prg
```

With VICE labels:
```
ld65 -t c64 -Ln hello.vs -o hello.prg hello.o c64.lib
x64sc -moncommands hello.vs hello.prg
```

## sources

- attribution: [../ATTRIBUTION.md](../ATTRIBUTION.md)
- upstream: cc65 documentation (https://cc65.github.io/), `ca65.html` and `ld65.html`.
- CA65 reference: [../asm/ca65.md](../asm/ca65.md)
- common patterns: [../asm/common-patterns.md](../asm/common-patterns.md)
- VICE: [vice.md](vice.md)
- toolchain index: [INDEX.md](INDEX.md)
