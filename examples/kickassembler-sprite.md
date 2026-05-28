---
type: reference
domain: examples
granularity: example
---

## facts
- Minimal buildable KickAssembler 5.x program that displays sprite 0 as a solid 24×21 white block at screen position (`X=100`, `Y=100`) and loops forever.
- Loads at `$0801` with a BASIC SYS stub so `RUN` autostarts the body at `$080D`.
- Sprite data is placed at `$2000` (within VIC bank 0, no character-ROM hole), giving sprite pointer byte `$2000 / 64 = $80`.

## examples

### source — `sprite.asm`
```
.pc = $0801 "basic-stub"
        .word eob, 10
        .byte $9e
        .text "2061"
        .byte 0
eob:    .word 0

.pc = $080d "main"
        // sprite pointer for sprite 0 (screen $0400 → pointers at $07F8)
        lda #$80
        sta $07f8

        // X / Y position
        lda #100
        sta $d000           // sprite 0 X low
        sta $d001           // sprite 0 Y
        lda #0
        sta $d010           // X MSB cleared for all sprites

        // color (white)
        lda #1
        sta $d027

        // enable sprite 0
        lda #%00000001
        sta $d015

forever:
        jmp forever

// sprite shape at $2000: 63 bytes of $FF (solid block), 1 pad byte
.pc = $2000 "sprite-data"
        .fill 63, $ff
        .byte 0
```

### build and run
```
java -jar KickAss.jar sprite.asm
x64sc sprite.prg
```
Type `RUN`; a solid white sprite appears near the top-left of the screen and stays until `RESTORE` or reset.

## lookup
| element | meaning | route |
|---|---|---|
| `.pc = <addr>` | Set program counter (segment label optional) | [../asm/kickassembler.md](../asm/kickassembler.md) |
| BASIC SYS stub at `$0801` | 12-byte autostart shape | [../asm/common-patterns.md](../asm/common-patterns.md) |
| sprite pointer at `$07F8+n` | Default screen at `$0400`; pointer byte = data-addr / 64 | [../tasks/sprite-display.md](../tasks/sprite-display.md) |
| `$D000+2n`/`$D001+2n` | Sprite n X / Y position registers | [../io/vic-ii.md](../io/vic-ii.md) |
| `$D010` | Sprite X MSB bits (one per sprite) | [../io/vic-ii.md](../io/vic-ii.md) |
| `$D015` | Sprite enable bitmap | [../io/vic-ii.md](../io/vic-ii.md) |
| `$D027+n` | Sprite n color (hi-res) | [../io/vic-ii.md](../io/vic-ii.md) |
| KickAssembler → `.prg` → VICE loop | Build/run pipeline | [../toolchains/kickassembler-workflow.md](../toolchains/kickassembler-workflow.md) |

## constraints
- Sprite data MUST be at a 64-byte-aligned address inside the active VIC bank; bank 0 covers `$0000-$3FFF` by default (CIA2 `$DD00` bits 0-1 = `%11`).
- Sprite data MUST NOT overlap the character-ROM hole `$1000-$1FFF` (bank 0) or `$9000-$9FFF` (bank 2); `$2000` is safe in bank 0.
- The sprite enable bit (`$D015` bit 0) MUST be set AFTER pointer/position/color, or the first visible frame shows garbage.
- `$D018` MUST stay at its power-on value `21` so the sprite pointer block remains at `$07F8`; relocating screen RAM moves the pointer block.
- `JMP forever` MUST run with interrupts left enabled — the BASIC IRQ handler at `$EA31` keeps the keyboard/cursor live; do not `SEI` in this example.
- `java -jar KickAss.jar` requires a Java runtime (JRE 8+) on PATH; substitute `KickAss5.jar` or local install path as needed.

## links
- KickAssembler reference: [../asm/kickassembler.md](../asm/kickassembler.md)
- common ASM patterns: [../asm/common-patterns.md](../asm/common-patterns.md)
- KickAssembler workflow: [../toolchains/kickassembler-workflow.md](../toolchains/kickassembler-workflow.md)
- sprite display task: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- CIA2 / VIC bank: [../io/cia2.md](../io/cia2.md)
- memory map: [../memory/map.md](../memory/map.md)
- VICE: [../toolchains/vice.md](../toolchains/vice.md)
- example index: [INDEX.md](INDEX.md)

## sources
- KickAssembler reference: [../asm/kickassembler.md](../asm/kickassembler.md)
- KickAssembler workflow: [../toolchains/kickassembler-workflow.md](../toolchains/kickassembler-workflow.md)
- sprite display task: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- local route: [../sources/INDEX.md](../sources/INDEX.md)
