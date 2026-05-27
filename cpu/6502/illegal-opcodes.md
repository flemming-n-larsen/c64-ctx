---
type: reference
domain: cpu/6502
granularity: atomic
---

## facts
- Local 6502 CPU pages state the baseline 6502 has `151` documented opcodes and `105` remaining opcodes with undocumented behavior.
- Undocumented opcode behavior MAY differ across CPU variants, revisions, emulators, and clones.

## constraints
- Agents MUST label undocumented opcodes as undocumented or illegal when mentioning them.
- Agents SHOULD avoid recommending illegal opcodes for portable C64 examples unless the user explicitly asks for cycle tricks or demo-style code.
- Compatibility notes MUST cite the exact CPU variant source when using non-6502 behavior.
- Agents MUST NOT import 65C02 documented instructions into C64 baseline code.

## links
- instruction set: [instruction-set.md](instruction-set.md)
- CPU index: [INDEX.md](INDEX.md)

## sources
- local route: [../../sources/INDEX.md](../../sources/INDEX.md)
- CPU index: [INDEX.md](INDEX.md)
- instruction set: [instruction-set.md](instruction-set.md)
