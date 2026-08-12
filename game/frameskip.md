---
type: reference
domain: game
granularity: atomic
summary: "Split IRQ work from frame logic so the game degrades gracefully under load."
keywords: [frameskip, frame update, IRQ split, variable frame rate]
---

## facts
- Raster IRQs SHOULD perform only immediate VIC register writes (screen splits, sprite multiplexing) and music/sound; movement/logic and scrolling belong in a separate frame-update layer. Lasse Öörni/Cadaver, Rant 9.
- Frameskipping: if the previous render was N frames ago, run movement/logic N times before the next render; apparent speed stays constant but motion becomes jerky. Lasse Öörni/Cadaver, Rant 9.
- Interpolation: run movement/logic every 2nd or 4th frame; interpolate sprite positions linearly in between; screen updates every frame. Lasse Öörni/Cadaver, Rant 9.
- Re-entrant frame-update IRQ: the frame-update routine runs after the low-level raster IRQ with `CLI` re-enabled, so it can itself be interrupted by the next raster event; guards against re-entrance with an execution counter. Lasse Öörni/Cadaver, Rant 9.
- All IRQs MUST save CPU registers on the stack — never to fixed zero-page addresses; fixed zeropage saves corrupt registers when IRQs nest. Lasse Öörni/Cadaver, Rant 9.

## sequence
**Three-layer architecture (re-entrant):**

1. **Low-level raster IRQ** (cannot be interrupted):
   - Write VIC split registers; update sprite multiplexer; play music/sound.
   - Acknowledge interrupt: `dec $d019`.
   - `cli` — re-open interrupt window.
   - `jmp frameupdate` — enter frame-update layer.

2. **Frame-update layer** (`frameupdate`, interruptible by next raster IRQ):
   - Guard: `inc exec_count; lda exec_count; cmp #$02; bcs skip`.
   - Interpolate sprite positions (average old and current values).
   - Shift screen memory for scroll step.
   - Sort sprites for multiplexer.
   - Write sprite X/Y to IRQ parameter table for next frame.
   - `skip: dec exec_count; pla; tay; pla; tax; pla; rti`.

3. **Main program** (runs every 2–4 frames):
   - Run full movement/logic: move characters, AI, collision detection, VM bytecode.
   - Store previous sprite positions before updating.

**Re-entrance guard (verbatim):**
```asm
frameupdate:
    inc exec_count
    lda exec_count
    cmp #$02
    bcs skip
    ; frame update code here
skip:
    dec exec_count
    pla
    tay
    pla
    tax
    pla
    rti
```

## constraints
- Movement/logic and graphics-update MUST be separate code paths to enable frameskipping and interpolation independently.
- Frame-update code MUST NOT touch VIC registers directly; write to a parameter table read by the low-level IRQ.
- Each IRQ layer MUST maintain its own sprite position copy to prevent layers from corrupting each other's data.
- 4-frame interpolation produces large per-frame motion steps; verify gameplay feel is acceptable before committing to this interval.
- `exec_count` MUST be in zero page for the compare to stay within the timing budget.

## sources

- [https://codebase64.net/doku.php?id=base:rant9](https://codebase64.net/doku.php?id=base:rant9) — Lasse Öörni/Cadaver, "Rant 9: Frameskipping, Interpolation and Re-entrant IRQ Code" — CC BY-NC-SA 4.0
- irq: [../irq/INDEX.md](../irq/INDEX.md)
- irq: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- tasks: [../tasks/game-loop.md](../tasks/game-loop.md)
- game: [scrolling.md](scrolling.md)
- sprites: [../sprites/INDEX.md](../sprites/INDEX.md)
