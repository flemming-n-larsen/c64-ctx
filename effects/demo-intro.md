---
type: reference
domain: effects
granularity: atomic
summary: "How a demo is structured: IRQ chain, frame anatomy, and the prerequisite techniques."
keywords: [demo coding, demo structure, IRQ chain, frame anatomy, intro]
---

## facts
- A C64 demo is a non-interactive program that displays real-time audio-visual effects; the three elements are graphics, sound, and code.
- The screen is redrawn 50 times per second (PAL); all effects are driven by synchronizing code execution to the raster beam via `$D012`.
- Raster interrupts are preferred over polling `$D012`; they allow multiple effects per frame at different screen positions without busy-waiting.
- Memory is managed by a packer/cruncher to fit more assets into 64 KB.

## demo structure

A standard demo part follows this flow:

1. **Init**: load/unpack data, relocate code, set up memory banks, initialize SID music player.
2. **Wait for vblank / raster**: set raster IRQ at line `$00` or use a stable-raster double-IRQ setup.
3. **IRQ chain**: each IRQ handler does one effect, then re-arms the next IRQ at the start of the next effect region.
4. **Effect regions per frame**: a typical frame chains 3–6 IRQs — border open, scroll text, rasterbars, sprite effects, SID update.
5. **Sync**: SID music player is called in one IRQ slot; animation counters advance each frame.
6. **Part end**: jump to next demo part after a set number of frames.

## effect regions (typical)

| region | raster range (PAL) | common effect |
|---|---|---|
| Top border | `$00`–`$32` | rasterbars, raster splits |
| Screen area | `$33`–`$D7` | scroll text, plasma, sprites, FLI |
| Bottom border | `$D8`–`$FF` | rasterbars, open border |

## prerequisites
- Raster IRQ setup: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- Stable raster (jitter-free): [stable-raster.md](stable-raster.md)
- Open borders: [open-borders.md](open-borders.md)
- music player integration: [../music/INDEX.md](../music/INDEX.md)
- SID chip reference: [../sid/INDEX.md](../sid/INDEX.md)

## constraints
- Bad lines steal 40 cycles per line; account for them in any cycle-exact timing; see [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md).
- Sprite data fetch steals 2 cycles per sprite per line; visible sprites reduce cycles available for raster effects.
- PAL frame budget: ~19656 cycles total; a simple 40×25 effect loop costs ~10 000 cycles leaving ~50% for other work.
- Optimization is mandatory for complex effects; see [../concepts/optimization.md](../concepts/optimization.md).

## sources

- codebase64.net: [An Introduction to Programming C-64 Demos](https://codebase64.net/doku.php?id=vic:demo:demo_coding_introduction) — CC BY-NC-SA 4.0
- effects: [stable-raster.md](stable-raster.md)
- effects: [open-borders.md](open-borders.md)
- effects: [rasterbars.md](rasterbars.md)
- effects: [scrolltext.md](scrolltext.md)
- effects: [plasma.md](plasma.md)
- music: [../music/INDEX.md](../music/INDEX.md)
- sid: [../sid/INDEX.md](../sid/INDEX.md)
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- concepts: [../concepts/vic-bad-lines.md](../concepts/vic-bad-lines.md)
- concepts: [../concepts/optimization.md](../concepts/optimization.md)
- concepts: [../concepts/screen-geometry.md](../concepts/screen-geometry.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
