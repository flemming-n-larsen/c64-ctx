---
type: reference
domain: tasks
granularity: recipe
---

## sequence

1. **Choose a destination address** — a 2 KB-aligned base within the active VIC bank. Default bank 0 has free RAM at `$2000`, `$2800`, `$3000`, `$3800`. The new base MUST be encoded in `$D018` bits 3-1 as `(base ÷ $0800)`.
2. **Bank in character ROM at `$D000-$DFFF`** — clear bit 2 (`CHAREN`) of `$0001` so the CPU sees the char ROM instead of I/O. Disable interrupts with `SEI` first because the I/O area (CIA1/2, VIC-II, SID) is hidden during the copy.
3. **Copy 2 KB from `$D000` to the chosen RAM base** — 8 bytes per character × 256 characters = 2048 bytes. Use an indirect-Y or self-modifying copy loop. The uppercase/graphics set lives at `$D000-$D7FF`; the lower/upper set lives at `$D800-$DFFF`.
4. **Re-bank I/O** — set bit 2 of `$0001` (CHAREN=1) to restore I/O visibility at `$D000-$DFFF`. Then `CLI` (if it was set).
5. **Modify glyph bytes in RAM** — each character is 8 bytes, one byte per scanline, MSB = leftmost pixel. The byte address for screen code `sc` line `n` is `base + sc*8 + n`. Multicolor character mode uses pixel pairs instead — see VIC-II MCM rules.
6. **Point VIC-II at the new charset** — write `$D018` with the screen-RAM nybble preserved (bits 7-4) and the new character base in bits 3-1: `new = (existing & $F0) \| ((char_base / $0800) << 1)`.

## lookup

| need | read | notes |
|---|---|---|
| `$D018` memory pointer bit layout | [../io/vic-ii.md](../io/vic-ii.md) | VM=bits 7-4 (screen), CB=bits 3-1 (char/bitmap base) |
| `$0001` processor-port bits, CHAREN behavior | [../io/processor-port.md](../io/processor-port.md) | Bit 2 = CHAREN; 0 = char ROM visible at `$D000-$DFFF` to CPU |
| VIC bank select, ROM holes | [../io/cia2.md](../io/cia2.md) | Char ROM visible to VIC at `$1000-$1FFF` (bank 0) / `$9000-$9FFF` (bank 2) — use those addresses to keep stock charset for free |
| Screen-code byte values | [../charset/screen-codes.md](../charset/screen-codes.md) | Glyph `sc` lives at `base + sc*8` |
| Lowercase/uppercase mode switching at runtime | [../charset/petscii.md](../charset/petscii.md) | PETSCII `$0E`/`$8E` only flip the CB bits if `$D018` is set accordingly |
| Memory-banking concept | [../concepts/memory-banking.md](../concepts/memory-banking.md) | Distinguish CPU view (via `$0001`) from VIC view (via `$DD00`) |

## constraints

- Code MUST place the charset base on a 2 KB boundary inside the active VIC bank; misaligned bases are silently masked by `$D018` bits 3-1.
- Code MUST NOT place the new charset at `$1000-$1FFF` of bank 0 or `$9000-$9FFF` of bank 2 — the VIC reads char ROM there regardless of RAM content.
- The `$D000-$DFFF` CPU window MUST have CHAREN cleared during the copy; this hides CIA1/2, VIC-II, and SID. Interrupts SHOULD be disabled (`SEI`) for the duration so the IRQ handler does not touch hidden I/O.
- Code MUST restore CHAREN (bit 2 of `$0001`) and re-enable interrupts (`CLI`) immediately after the copy.
- `$D018` writes MUST preserve the screen-RAM nybble (bits 7-4) unless the screen RAM is also being relocated; clobbering bits 7-4 moves the screen and the sprite pointer block with it.
- Sprite pointers (`$07F8-$07FF` by default) MUST be re-pointed if the screen RAM moves with `$D018` bits 7-4.
- Multicolor character mode (`$D016` bit 4 = 1) re-interprets each glyph byte as 4 pixel-pairs; cells with color-RAM bit 3 set use the multicolor palette, cells without it use single-color mode.

## examples

Sequence in assembler pseudo-code, copying the lower/uppercase set from `$D800` to RAM at `$3000` and pointing VIC at it (assumes default VIC bank 0, screen at `$0400`):

```
SEI
LDA $01 : PHA            ; save processor port
AND #$FB : STA $01       ; CHAREN=0 → char ROM visible

LDY #$00
LDX #$08                 ; 8 pages
LDA #$D8 : STA $FC       ; src hi
LDA #$30 : STA $FE       ; dst hi
LDA #$00 : STA $FB : STA $FD

@copy:
  LDA ($FB),Y : STA ($FD),Y
  INY : BNE @copy
  INC $FC : INC $FE
  DEX : BNE @copy

PLA : STA $01            ; restore CHAREN (I/O visible again)
LDA $D018 : AND #$F0
ORA #$0C : STA $D018     ; CB = $3000 / $0800 = 6 → bits 3-1 = %110 → $0C
CLI
RTS
```

## links

- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- processor port: [../io/processor-port.md](../io/processor-port.md)
- CIA2 / VIC bank: [../io/cia2.md](../io/cia2.md)
- screen codes: [../charset/screen-codes.md](../charset/screen-codes.md)
- memory banking: [../concepts/memory-banking.md](../concepts/memory-banking.md)
- bank switch task: [bank-switch-rom-ram.md](bank-switch-rom-ram.md)
- task index: [INDEX.md](INDEX.md)

## sources

- local route: [../sources/INDEX.md](../sources/INDEX.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- processor port: [../io/processor-port.md](../io/processor-port.md)
- screen codes: [../charset/screen-codes.md](../charset/screen-codes.md)
- task index: [INDEX.md](INDEX.md)
