---
type: reference
domain: toolchains
granularity: workflow
summary: "Build a prg with ACME and run it in VICE."
keywords: [ACME workflow, build and run, command line, cbm output]
---

## facts
- Workflow targets ACME 0.97+; see [../asm/acme.md](../asm/acme.md) for language reference.
- ACME emits the final `.prg` directly — no separate linker step.
- The `!to "<file>", cbm` directive in source selects `.prg` output with a 2-byte CBM load-address header.
- Invocation: `acme -o out.prg src.a`, or rely on the `!to` directive and invoke `acme src.a`.
- Output filename precedence: `-o` command-line flag overrides the `!to` source directive.

## sequence
### Source → `.prg` → VICE
1. Author source `src.a` with `!to "out.prg", cbm` and `*= $0801` (or chosen load address).
2. Include a BASIC SYS stub if loading at `$0801` and autostart is wanted (see [../asm/common-patterns.md](../asm/common-patterns.md)).
3. Assemble: `acme src.a` (uses `!to`) or `acme -o out.prg -f cbm src.a` (CLI override).
4. Launch: `x64sc out.prg` (see [vice.md](vice.md)).

### Iterative loop
1. Edit source.
2. Re-run `acme src.a`.
3. Re-run `x64sc -warp out.prg` (warp mode for fast tests).

## lookup
| need | flag / directive | notes |
|---|---|---|
| Select output file | `-o <file>` | Overrides `!to` filename. |
| Select output format from CLI | `-f cbm` / `-f plain` / `-f apple` | Mirrors the `!to` format keyword. |
| Add include search path | `-I <dir>` | Multiple `-I` allowed. |
| Emit label list | `-l <file>` / `--labeldump` | Useful for VICE monitor symbol import. |
| Emit VICE label file | `--vicelabels <file>` | Direct VICE-monitor `ll` format. |
| Cross-reference report | `-r <file>` | Symbol/value listing. |
| Set CPU | `--cpu 6510` (or `!cpu`) | Default is `6502`. |
| Source CPU directive | `!cpu 6510` | Per-file CPU selection. |

## constraints
- The source MUST set the program counter (`*= <addr>`) before any code or data is emitted.
- A `.prg` autostarted at `$0801` MUST contain a tokenized BASIC SYS stub; otherwise `RUN` fails or jumps to garbage.
- `!to "<file>", cbm` MUST appear before code emission; ACME refuses to assemble if an output format is ambiguous.
- ACME does not implicitly link; multi-file builds use `!src "<file>"` from a single root source.
- Exact ACME CLI behavior is outside the local source corpus and MUST be cited from the ACME manual when contested.

## examples
Minimal end-to-end build:
```
acme hello.a              # uses !to in source
x64sc -warp hello.prg
```

CLI-overridden output (no `!to` in source needed):
```
acme -f cbm -o hello.prg hello.a
x64sc hello.prg
```

Emit VICE-compatible labels for monitor debugging:
```
acme --vicelabels hello.vs -o hello.prg hello.a
x64sc -moncommands hello.vs hello.prg
```

## links

- ACME reference: [../asm/acme.md](../asm/acme.md)
- common patterns: [../asm/common-patterns.md](../asm/common-patterns.md)
- VICE: [vice.md](vice.md)
- toolchain index: [INDEX.md](INDEX.md)

## sources

- attribution: [../ATTRIBUTION.md](../ATTRIBUTION.md)
- upstream: ACME user manual (Marco Baye), distributed with the ACME release archive.
