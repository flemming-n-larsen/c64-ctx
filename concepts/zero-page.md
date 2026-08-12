---
type: reference
domain: concepts
granularity: concept
summary: "Why zero page matters: shorter, faster addressing and who already owns it."
keywords: [zero page, fast addressing, byte savings, ownership]
---

## facts
- Zero page is `$0000-$00FF`; many 6502 instructions have shorter/faster zero-page addressing forms.
- On the C64, zero page contains hardware registers at `$0000-$0001`, BASIC workspace, KERNAL I/O state, and aliases from the local symbol pages.
- `CHRGET`, `CHRGOT`, and `TXTPTR` are BASIC-related zero-page entries in the local symbol pages.

## constraints
- Agents MUST NOT describe C64 zero page as freely available scratch RAM.
- Machine-language routines SHOULD reserve their own zero-page bytes only with knowledge of BASIC/KERNAL ownership.
- KERNAL task recipes SHOULD mention zero-page side effects only when source call contracts or symbols justify them.

## sources

- memory zero page: [../memory/zero-page.md](../memory/zero-page.md)
- memory symbols: [../memory/symbols.md](../memory/symbols.md)
- CPU addressing: [../cpu/6502/addressing-modes.md](../cpu/6502/addressing-modes.md)
