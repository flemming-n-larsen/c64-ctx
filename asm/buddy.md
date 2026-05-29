---
type: reference
domain: asm
granularity: assembler
---

## facts
- Buddy Assembler is a resident assembler that runs natively on the C64; source code is entered via the built-in screen editor or loaded from disk.
- Published by Soft-byte, 1983; distributed as a cartridge or `.prg` that loads into upper RAM and patches the KERNAL screen-editor vectors.
- Assembly is triggered from BASIC with `SYS <address>`; the assembler scans the screen buffer or a loaded source file and writes object code directly into a specified memory range.
- No separate linker phase; the assembled bytes land in memory immediately and can be executed at once.
- Source and object code share the same 64 KB address space, requiring the programmer to ensure they do not overlap.

## directives
| directive | purpose | example |
|---|---|---|
| `*= <addr>` | Set program counter (origin) | `*= $C000` |
| `<name> = <expr>` | Define a constant or equate | `VIC = $D020` |
| `.BY <list>` | Emit byte values | `.BY $20, $EA` |
| `.WO <list>` | Emit word (16-bit little-endian) values | `.WO $0801` |
| `.TX "<str>"` | Emit PETSCII string bytes | `.TX "HELLO"` |
| `.EN` | End of source; stop assembly | `.EN` |

## constraints
- Labels are truncated to 6 significant characters; names longer than 6 characters collide if the first 6 match.
- No macro facility; code reuse requires copy-paste or subroutine calls.
- No conditional assembly (`IF`/`ELSE`/`ENDIF` are absent).
- No local labels; all labels share a single global scope.
- The assembler passes (typically two-pass) run entirely in the C64's memory; very large sources may exhaust available RAM for both source text and symbol table.

## links
- assembler hub: [INDEX.md](INDEX.md)
- cross-assembler equivalence: [rosetta.md](rosetta.md)
- common patterns: [common-patterns.md](common-patterns.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- attribution: [../ATTRIBUTION.md](../ATTRIBUTION.md)
- upstream: c64-wiki.com — Buddy Assembler article (GFDL).
