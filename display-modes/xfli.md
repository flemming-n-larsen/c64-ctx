---
type: reference
domain: display-modes
granularity: atomic
summary: "Extended FLI: FLI plus per-line background register writes for a wider per-line palette."
keywords: [XFLI, XIFLI, extended FLI, per-line background]
---

## facts
- XFLI (eXtended FLI) combines the FLI per-line `$D018` trick with per-line writes to the background color registers (`$D021`–`$D024`) to expand the per-line color palette beyond what FLI alone achieves.
- In standard FLI the `$D021` background (color `00`) is shared across all lines unless explicitly changed; XFLI changes `$D021` (and optionally `$D022`–`$D024`) each raster line alongside the `$D018` write.
- This gives a third independently changeable color per raster line (FLI provides 2 via screen RAM; XFLI adds the background register).
- XIFLI = XFLI + IFLI frame alternation for even more perceived colors.
- Introduced August 2002.

## sequence

1. Complete FLI setup as per [fli.md](fli.md) (multicolor bitmap mode recommended).
2. Allocate a `$D021` color table: 200-byte array with one background color per raster line.
3. In the per-line FLI loop (inside the raster IRQ or polling loop):
   - Write `$D018` = `fli_table[line mod 8]` (screen RAM block cycling, as in FLI).
   - Write `$D011` bits 2-0 = `line mod 8` (bad-line every line).
   - Write `$D021` = `bg_table[line]` (per-line background color).
   - Optionally write `$D022`/`$D023` for MCBM color pairs `01`/`10` if additional registers are available.
4. For XIFLI: apply IFLI frame alternation on top, maintaining two `$D021` table arrays (one per frame).

## lookup

### Per-line color sources (XFLI MCBM)

| pixel bits | source | changeable per line? |
|---|---|---|
| `00` | `$D021` | yes — XFLI writes this each line |
| `01` | screen RAM high nibble | yes — FLI cycling |
| `10` | screen RAM low nibble | yes — FLI cycling |
| `11` | color RAM | no (static) |

### Registers written per raster line

| register | content | timing |
|---|---|---|
| `$D018` | screen RAM block index | must precede bad-line fetch |
| `$D011` bits 2-0 | YSCROLL = line mod 8 | must precede bad-line fetch |
| `$D021` | bg color from table | any point within line before pixels |

## constraints
- Each additional register write per line costs 4–6 CPU cycles on top of the base FLI budget (23 nominal bus-free cycles per PAL bad line, with possible BA lead-in stall); XFLI is very tight.
- `$D021` write can be placed anywhere in the visible portion of the raster line as it takes effect on the current line's background.
- XIFLI requires two `$D021` tables (frame A and B), doubling the artwork color data.

## links

- effects: [fli.md](fli.md)
- effects: [ifli.md](ifli.md)
- effects: [nufli.md](nufli.md)
- concepts: [../concepts/color-mixing.md](../concepts/color-mixing.md)
- io: [../io/vic-ii.md](../io/vic-ii.md)

## sources

- c64-wiki.com: [Graphics Modes](https://www.c64-wiki.com/wiki/Graphics_Modes) — GFDL
