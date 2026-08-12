---
type: reference
domain: effects
granularity: atomic
summary: "Colour flashing via background register cycling, and charset page-flip animation."
keywords: [colour flashing, notewriter, cracktro, frame animation, page flipping]
---

## facts
- Colour flashing (notewriter style) cycles multiple EBC (Extended Background Color) mode color registers rapidly each frame to produce animated flashing text, as used in notewrites and cracktros.
- Frame animation displays a sequence of pre-drawn frames by updating screen RAM or `$D018` to point to successive charset or bitmap pages each frame.

## colour flashing — notewriter style

EBC mode (`$D011` bit 6 set) provides four background registers (`$D021`–`$D024`) whose high 2 bits of each character cell select which background color to use. Cycling these registers produces flashing without redrawing the screen.

### sequence

1. Set `$D011` = `$5B` to enable EBC mode.
2. Disable CIA IRQ (`$DC0D` = `$7F`); set raster IRQ at line 0 (`$D01A` = `$01`).
3. Build three 40-entry color tables for `$D022`, `$D023`, `$D024` (40 colors per register = 40-frame cycle).
4. Each raster IRQ:
   - Acknowledge `$D019` = `$01`.
   - Read `flashpt` (zero-page counter); index into the three color tables.
   - Write new values to `$D022`, `$D023`, `$D024`.
   - Increment `flashpt`; wrap at 40 (`$28`).

### lookup

| register | purpose |
|---|---|
| `$D011` | Video control — bit 6 enables EBC mode (`$5B` = EBC on, screen on) |
| `$D020` | Border color |
| `$D021` | Background 0 (base background) |
| `$D022` | Background 1 (EBC) |
| `$D023` | Background 2 (EBC) |
| `$D024` | Background 3 (EBC) |
| `$D019` | IRQ flag — clear each raster IRQ |
| `$DC0D` | CIA IRQ mask — disable with `$7F` |
| `$314`/`$315` | IRQ vector (low/high byte) |

## frame animation

### sequence

1. Pre-draw `N` animation frames into `N` charset pages (or `N` screen RAM pages).
2. Each display frame, increment the frame counter and update `$D018` to point to the next charset page (bits 3–1 of `$D018`).
3. Synchronize the `$D018` write to the VBLANK or a top-of-screen raster IRQ to avoid visual glitching.

### constraints
- EBC mode restricts character data to 64 characters (6-bit index); the upper 2 bits select the background register.
- EBC + BMM or EBC + MCM is an illegal mode and blanks the display.
- Frame animation page stride: each charset page is 2 KB; `$D018` bits 3–1 select 8 possible pages within the VIC bank.

## sources

- codebase64.net: [Colour Flashing Notewriter Style](https://codebase64.net/doku.php?id=base:colour_flashing_notewriter_style) — CC BY-NC-SA 4.0
- codebase64.net: [Demo Programming — Misc](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- effects: [plasma.md](plasma.md)
- effects: [blending.md](blending.md)
- tasks: [../irq/raster-interrupt.md](../irq/raster-interrupt.md)
- tasks: [../tasks/custom-charset.md](../tasks/custom-charset.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- colors: [../colors/INDEX.md](../colors/INDEX.md)
