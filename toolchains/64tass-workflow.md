---
type: reference
domain: toolchains
granularity: workflow
summary: "Build a prg with 64tass and run it in VICE."
keywords: [64tass workflow, build and run, command line, prg header]
---

## facts
- Workflow targets 64tass 1.58+; see [../asm/64tass.md](../asm/64tass.md) for language reference.
- Single invocation; no separate linker.
- Output format is set on the CLI, not in source — default is flat binary, NOT `.prg`.
- `.prg` output REQUIRES `--cbm-prg` (short: `-b`) or `--output-format prg`.
- Invocation: `64tass -b -o out.prg src.asm`.

## sequence
### Source → `.prg` → VICE
1. Author source `src.asm` starting with `*= $0801` (or chosen load address).
2. Include a BASIC SYS stub if loading at `$0801` and autostart is wanted (see [../asm/common-patterns.md](../asm/common-patterns.md)).
3. Assemble: `64tass --cbm-prg -o out.prg src.asm`.
4. Launch: `x64sc out.prg` (see [vice.md](vice.md)).

### Flat-binary output (cartridge body, no header)
1. Use `--flat` (or `-f`) instead of `-b`.
2. Result is raw bytes only — no load-address header.

### Iterative loop
1. Edit source.
2. Re-run `64tass`.
3. Re-run VICE.

## lookup
| need | flag | notes |
|---|---|---|
| `.prg` output | `--cbm-prg` / `-b` | 2-byte load-address header. |
| Raw flat binary | `--flat` / `-f` | No header. |
| Explicit format | `--output-format <fmt>` | `prg`, `xex`, `flat`, `intel-hex`, `srec`. |
| Suppress header with `-b` | `--nostart` | Useful for chained programs. |
| Output filename | `-o <file>` | Default is `a.out`. |
| Add include path | `-I <dir>` | Multiple `-I` allowed. |
| Listing file | `-L <file>` | Symbol + listing. |
| Label dump | `-l <file>` | Label list only. |
| VICE label file | `--vice-labels` | VICE monitor symbol format. |
| ASCII source strings | `--ascii` | Default treats strings as PETSCII. |
| Quiet (no banner) | `-q` | Useful in scripts. |

## constraints
- Omitting `--cbm-prg` (and not selecting another format) produces a flat binary that VICE will NOT autostart correctly as a `.prg`.
- A `.prg` autostarted at `$0801` MUST contain a tokenized BASIC SYS stub; 64tass emits whatever the source defines.
- The first `*= <addr>` becomes the load-address header in `--cbm-prg` mode; later `*=` overrides do NOT change the header.
- Source-level encoding for `.text` strings depends on the current `.enc` directive; default is PETSCII for `--cbm-prg`.
- Exact 64tass CLI behavior is outside the local source corpus and MUST be cited from the 64tass manual when contested.

## examples
Minimal end-to-end build:
```
64tass --cbm-prg -o hello.prg hello.asm
x64sc -warp hello.prg
```

With VICE labels for monitor debugging:
```
64tass --cbm-prg --vice-labels -L hello.vs -o hello.prg hello.asm
x64sc -moncommands hello.vs hello.prg
```

Flat binary (cartridge body):
```
64tass --flat -o cart.bin cart.asm
```

## sources

- attribution: [../ATTRIBUTION.md](../ATTRIBUTION.md)
- upstream: 64tass manual (Soci/Singular), distributed with the 64tass release archive.
- 64tass reference: [../asm/64tass.md](../asm/64tass.md)
- common patterns: [../asm/common-patterns.md](../asm/common-patterns.md)
- VICE: [vice.md](vice.md)
- toolchain index: [INDEX.md](INDEX.md)
