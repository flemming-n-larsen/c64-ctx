---
type: reference
domain: music
granularity: atomic
summary: "Wire a compiled tune into your program: init and play entry points, banking, payload."
keywords: [tune integration, init routine, embedded tune, player entry points]
---

## facts
- A compiled C64 tune usually exposes two entry points: an init routine you call once, and a play routine you call once per frame or timer tick.
- If the player lives in ROM-shadowed space such as `$A000-$FFFF`, bank BASIC/KERNAL ROM out with `$01` before calling the routine, then restore normal banking afterwards.
- Codebase64's `$A000-$FFFF` example uses `$01 = $35` around both the init call and the per-frame play call, then restores `$01 = $37`.
- When embedding a raw `.prg` tune blob directly in assembler source, you normally strip the two-byte load address before placing the payload at its runtime address.

## sequence
1. Install the IRQ or timer wrapper that will call the music play routine.
2. Bank ROM out if the music code sits under BASIC/KERNAL.
3. Call the init routine with the desired sub-tune number in `A`.
4. Restore normal banking.
5. On every frame/tick: bank ROM out again, call the play routine, restore banking, then exit the IRQ normally.

## example
```asm
LDA #$35
STA $01
LDA #$00
JSR $A000   ; init subtune 0
LDA #$37
STA $01

; later, once per frame
LDA #$35
STA $01
JSR $A003   ; play
LDA #$37
STA $01
```

## constraints
- `$01 = $35` removes BASIC/KERNAL ROM but keeps I/O visible; this is enough for tunes placed behind ROM, but not for RAM hidden beneath `$D000-$DFFF`.
- Restore `$01` before normal KERNAL IRQ exit paths such as `JMP $EA31`, or ROM calls and vectors will misbehave.
- The actual init/play addresses depend on the tune/player; `$A000/$A003` is only the example layout from Codebase64.

## links

- IRQ music player: [irq-music-player.md](irq-music-player.md)
- memory banking for music: [music-memory-banking.md](music-memory-banking.md)
- PAL/NTSC playback: [pal-ntsc-playback.md](pal-ntsc-playback.md)
- processor port / `$01`: [../io/processor-port.md](../io/processor-port.md)
- bank-switch task: [../tasks/bank-switch-rom-ram.md](../tasks/bank-switch-rom-ram.md)
- music index: [INDEX.md](INDEX.md)

## sources

- codebase64.net: [Playing music `$A000-$FFFF`](https://codebase64.net/doku.php?id=base:playing_music_a000-_ffff) — CC BY-NC-SA 4.0
