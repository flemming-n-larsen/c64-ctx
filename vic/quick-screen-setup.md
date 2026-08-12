---
type: reference
domain: vic
granularity: atomic
source: codebase64.net
summary: "Compute the bank and memory-pointer register values from one screen-address constant."
keywords: [screen setup, bank calculation, bit arithmetic, alignment]
---

## facts
- `$DD00` and `$D018` can be loaded from a single screen-address constant using bit arithmetic, avoiding separate bank and offset calculations.
- The bank select value for `$DD00` is the upper two address bits of the screen address XOR-inverted: `(screenChars ^ $FFFF) >> 14`.
- The `$D018` high nibble (screen matrix base) is `(screenChars & $3FFF) >> 10`, shifted into bits `7-4`.
- The `$D018` low nibble (character or bitmap base) is `(pixelData & $3FFF) >> 11`, shifted into bits `3-1`.
- Both registers depend on VIC-bank-relative offsets, so all addresses must be masked to the 16 KB bank before calculating nibble values.

## sequence
1. Choose `screenChars` as the CPU-absolute address of the screen matrix (must be on a 1 KB boundary).
2. Choose `pixelData` as the CPU-absolute address of character data or bitmap data (must be on a 2 KB boundary).
3. Verify both addresses fall in the same 16 KB VIC bank.
4. Write bank select to `$DD00`:
   ```
   lda #((screenChars ^ $FFFF) >> 14)
   sta $DD00
   ```
5. Write combined pointer to `$D018`:
   ```
   lda #(((screenChars & $3FFF) >> 10) << 4) | (((pixelData & $3FFF) >> 11) << 1)
   sta $D018
   ```
6. Ensure `$DD02` bits `1-0` are set as outputs before step 4 (normally already output after KERNAL init).

## constraints
- The XOR-invert formula only sets `$DD00` bits `1-0`; bits `7-2` MUST be preserved with read-modify-write if serial-bus or user-port lines are in use.
- `pixelData` pointing into a character ROM window (`$1000-$1FFF` in bank 0, `$9000-$9FFF` in bank 2) selects the ROM, not RAM — this is valid for standard text mode.
- Bitmap modes ignore `$D018` bits `2-1`; only bit `3` matters for bitmap base selection.

## sources

- codebase64.net: [Quick VIC-II Screen Setup](https://codebase64.net/doku.php?id=base:quick_vicii_screen_setup) — CC BY-NC-SA 4.0
- VIC memory and banking: [memory-and-banking.md](memory-and-banking.md)
- VIC registers: [registers.md](registers.md)
- VIC hub: [INDEX.md](INDEX.md)
