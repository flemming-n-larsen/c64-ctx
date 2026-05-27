---
type: reference
domain: concepts
granularity: concept
---

## facts
- Zero page is `$0000-$00FF`; many 6502 instructions have shorter/faster zero-page addressing forms.
- On the C64, zero page contains hardware registers at `$0000-$0001`, BASIC workspace, KERNAL I/O state, and aliases from `symbols.txt`.
- `CHRGET`, `CHRGOT`, and `TXTPTR` are BASIC-related zero-page entries in `symbols.txt`.

## constraints
- Agents MUST NOT describe C64 zero page as freely available scratch RAM.
- Machine-language routines SHOULD reserve their own zero-page bytes only with knowledge of BASIC/KERNAL ownership.
- KERNAL task recipes SHOULD mention zero-page side effects only when source call contracts or symbols justify them.

## links
- memory zero page: [../memory/zero-page.md](../memory/zero-page.md)
- symbols: [../memory/symbols.md](../memory/symbols.md)
- CPU addressing: [../cpu/6502/addressing-modes.md](../cpu/6502/addressing-modes.md)

## sources
- `C:\Code\c64ref\src\c64mem\symbols.txt`
- `C:\Code\c64ref\src\c64mem\c64mem_mapc64.txt`
- `C:\Code\c64ref\src\6502\cpu_6502.txt`
