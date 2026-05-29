---
type: reference
domain: effects
granularity: atomic
---

## facts
- Charset blending fades one character set into another pixel by pixel; each frame, a subset of bit positions across all characters is copied from the source charset to the destination charset.
- The blend order is randomized: a 64-entry lookup table of unique bit positions (0–63) is shuffled using a PRNG seeded from CIA timer `$DC04` and `$D012`.
- The effect operates only on the first 64 characters (512 bytes); after 64 frames, all pixels have been transferred and the fade is complete.
- Color RAM fading (palette cycling) is a simpler variant: write a sequence of colors to `$D020`/`$D021`/`$D022`–`$D025` each frame via raster IRQ, cycling through a pre-built gradient table.

## sequence — charset pixel blend-in

1. Copy source charset from ROM (`$2000`–`$20FF`) to a working buffer.
2. Build a randomized list of 64 unique pixel positions (0–63):
   - Use `$DC04` (CIA timer) XORed with `$D012` as a PRNG seed.
   - Fill a 64-byte table at `$03C0`–`$03FF` with each value 0–63 exactly once (Fisher-Yates shuffle variant).
3. For `i = 0` to 63 (one step per frame):
   - `bit_pos = random_list[i]`
   - For each of the 64 characters (chars 0–63):
     - `byte_index = bit_pos / 8`; `bit_mask = 1 << (bit_pos mod 8)`.
     - Read source bit from ROM charset; if set, `OR` it into the destination charset in RAM.
4. Point VIC-II `$D018` to the destination charset location throughout.

## sequence — color RAM fade-out (palette cycle)

1. Build a 16-step gradient table in RAM (e.g., from full color to black by stepping through darker shades).
2. Each frame, write the next table entry to the relevant color register (`$D020`, `$D021`, or color RAM cells).
3. After 16 frames, the fade is complete.

## lookup

| address | purpose |
|---|---|
| `$2000`–`$20FF` | Source charset (ROM copy) |
| `$2800`–`$28FF` | Destination charset (RAM, 512 bytes for 64 chars) |
| `$03C0`–`$03FF` | Randomized pixel position list (64 bytes) |
| `$DC04` | CIA timer low byte — PRNG seed |
| `$D012` | Raster register — PRNG entropy |

| zero-page | purpose |
|---|---|
| `$57`, `$58` | Frame counter / step pointer |
| `$FA`–`$FD` | Indirect addressing pointers |

## constraints
- The blend loop processes all 64 characters per pixel step; at ~6 cycles/character × 64 = ~384 cycles per bit position per frame — well within budget.
- Source charset must be copied from ROM before the effect begins; ROM is not writable.
- VIC-II must point to the destination charset in RAM throughout the effect (`$D018` charset bits); ensure VIC bank alignment.
- For color RAM fading, writes must occur outside the display area or use raster IRQ to avoid tearing; see [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md).

## links
- effects: [rng.md](rng.md)
- effects: [plasma.md](plasma.md)
- tasks: [../tasks/custom-charset.md](../tasks/custom-charset.md)
- tasks: [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)
- colors: [../colors/INDEX.md](../colors/INDEX.md)

## sources
- codebase64.net: [Blend Charsets](https://codebase64.net/doku.php?id=base:8x8_charset_pixel-blend-in) — CC BY-NC-SA 4.0
- codebase64.net: [Demo Programming — Blending and Fading](https://codebase64.net/doku.php?id=vic:demo_programming) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
