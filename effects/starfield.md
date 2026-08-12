---
type: reference
domain: effects
granularity: atomic
summary: "Depth illusion from dots moving at tiered speeds, character- or sprite-based."
keywords: [starfield, stars, parallax, depth illusion, ROL starfield]
---

## facts
- A starfield creates the illusion of depth by moving dots at different speeds: faster stars appear closer, slower ones farther away.
- Two common C64 implementations: ROL-based (shifts bit patterns across screen memory rows) and sprite-based (individual sprites or single-pixel sprite glyphs).
- ROL-based starfields are CPU-efficient but limited to one-pixel-wide stars in character cell rows. Sprite-based starfields offer more flexibility at the cost of sprite slots.

## sequence — ROL-based starfield

1. Allocate N "star rows" — one byte per row that holds the star's horizontal position as a bit.
2. Designate speed tiers: e.g., fast stars use 1 row per shifted bit per frame; slow stars shift every 2–4 frames.
3. Each frame per star row: `ROL star_byte` — the carried-out bit wraps to the other end of the byte (or chain multiple bytes for a wider track).
4. Write the star byte to the corresponding screen RAM address (translate bit position to screen code).
5. Optionally vary the star character (`.`, `·`, `*`) by speed tier for a size illusion.

## sequence — sprite-based starfield

1. Assign sprites with a single-pixel glyph (1 lit pixel in an 8×8 block; see [../tasks/sprite-display.md](../tasks/sprite-display.md)).
2. Store X position and speed for each star.
3. Each frame: subtract speed from X position; if X underflows past 0, wrap to right edge (X = 320 or 344 including border).
4. Write updated X to `$D000`/`$D002`/… and X MSB to `$D010`.
5. Use Y position variations to spread stars vertically.

## lookup
| tier | speed (pixels/frame) | illusion |
|---|---|---|
| Slow | 1 | Far, small stars |
| Medium | 2–3 | Mid-distance |
| Fast | 4–8 | Close, bright stars |

| ROL approach | value |
|---|---|
| Star byte width | 1–4 bytes (8–32 columns) |
| Carry behavior | C flag carries into next `ROL` for multi-byte chains |
| Screen RAM write | Place byte at row's screen RAM address (40 bytes/row) |

## constraints
- ROL-based stars are constrained to single-character rows and 1-bit precision; combined with color cycling they can appear richer.
- Sprite-based starfields consume sprite slots; combine with [sprite-multiplexer.md](sprite-multiplexer.md) for >8 stars using sprites.
- X position wrapping MUST account for the border region: sprite X=0 is in the left border; display area starts at X≈24.
- For sprite X ≥ 256, bit in `$D010` MUST be set; clear it when X < 256.

## links

- sprites: [../sprites/INDEX.md](../sprites/INDEX.md)
- sprite techniques: [../sprites/advanced.md](../sprites/advanced.md)
- sprite display: [../sprites/display.md](../sprites/display.md)
- effects: [sprite-multiplexer.md](sprite-multiplexer.md)
- effects: [rng.md](rng.md)
- tasks: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- concepts: [../concepts/screen-geometry.md](../concepts/screen-geometry.md)

## sources

- codebase64.net: [Demo Programming — Starfields](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
