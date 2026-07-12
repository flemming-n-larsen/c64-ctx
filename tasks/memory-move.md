---
type: reference
domain: tasks
source: 6502.org
granularity: recipe
---

## facts
- Memory move direction matters: moving to a higher address requires forward copy; moving to a lower address requires reverse copy (overlapping regions).
- All routines use ZP indirect indexed addressing: `FROM` (2 bytes) and `TO` (2 bytes) hold source/dest pointers; `SIZEL`/`SIZEH` hold byte count (low/high).
- SIZE = 0 copies nothing.
- Self-modifying variants replace indirect indexed with absolute indexed, saving 2 cycles per byte; require RAM.

## sequence

### MOVEDOWN — copy to higher address (safe for overlapping downward moves)
```asm
FROM    = $FB           ; ZP word: source address
TO      = $FD           ; ZP word: dest address
SIZEL   = $02           ; byte count low
SIZEH   = $03           ; byte count high

MOVEDOWN
    LDY #0
    LDX SIZEH
    BEQ MD2
MD1 LDA (FROM),Y        ; full-page loop
    STA (TO),Y
    INY
    BNE MD1
    INC FROM+1
    INC TO+1
    DEX
    BNE MD1
MD2 LDX SIZEL           ; remaining bytes
    BEQ MD4
MD3 LDA (FROM),Y
    STA (TO),Y
    INY
    DEX
    BNE MD3
MD4 RTS
```

### MOVEUP — copy to lower address (safe for overlapping upward moves)
Reverse copy: FROM and TO point to the *last* byte of source/dest region.
```asm
MOVEUP
    LDY #$FF
    LDX SIZEH
    BEQ MU3
MU1 DEC FROM+1
    DEC TO+1
MU2 LDA (FROM),Y
    STA (TO),Y
    DEY
    BNE MU2
    LDA (FROM),Y
    STA (TO),Y
    DEY
    DEX
    BNE MU1
MU3 LDX SIZEL
    BEQ MU5
    DEC FROM+1
    DEC TO+1
MU4 LDA (FROM),Y
    STA (TO),Y
    DEY
    DEX
    BNE MU4
MU5 RTS
```

## constraints
- Use MOVEDOWN when dest < src or regions don't overlap.
- Use MOVEUP when dest > src and regions overlap (otherwise bytes get overwritten before read).
- Self-modifying variants cannot be placed in ROM.
- Routine clobbers A, X, Y, and modifies FROM/TO ZP pointers in place.

## links
- memory clear: [memory-clear.md](memory-clear.md)
- bank switch (ROM/RAM): [bank-switch-rom-ram.md](bank-switch-rom-ram.md)
- sizecoding copy routines: [../optimization/sizecoding.md](../optimization/sizecoding.md)

## sources
- https://codebase64.net/doku.php?id=base:practical_memory_move_routines — CC BY-NC-SA 4.0 (author: Bruce Clark / 6502.org)
- [../sources/INDEX.md](../sources/INDEX.md)
