---
type: reference
domain: game
granularity: atomic
summary: "Compare and store a high score with multi-byte comparison."
keywords: [high score, score table, multi-byte compare, score entry]
---

## facts
- A high score is compared against the current score using multi-byte comparison: most-significant byte first; if equal, compare the next byte down. General 6502 practice.
- Zero page (`$02`–`$FF`) survives a warm reset (SYS restart) but is cleared on power cycle; suitable for session-persistent high scores. C64 memory map.
- Tape or disk persistence uses KERNAL SAVE (`$FFD8`) and LOAD (`$FFD5`) to write/read the high-score buffer as a short `.prg` file. KERNAL API.
- Displaying a high score uses the same digit-extract logic as the live score — see [scoring.md](scoring.md).

## sequence
1. After game over, compare current score to hiscore buffer (byte by byte, MSB first):
   - `lda score+2; cmp hiscore+2; bcc no_new_hi; bne new_hi` — repeat for bytes 1 and 0.
2. On new high score: copy score buffer to hiscore buffer (`LDA score+n; STA hiscore+n` for each byte).
3. Optionally read player initials: 3 keyboard characters via KERNAL `GETIN` ($FFE4); store to hiscore name buffer.
4. Display hiscore using digit-extract loop from [scoring.md](scoring.md).
5. To persist to disk: `SETNAM` + `SETLFS` + `SAVE` (KERNAL) pointing to hiscore buffer start and end address.
6. To restore: `SETNAM` + `SETLFS` + `LOAD` with secondary address 1 (load to stored address) at boot.

## lookup
| persistence method | survives warm reset | survives power cycle | implementation cost |
|---|---|---|---|
| Zero page `$02-$FF` | yes | no | trivial — just store/read bytes |
| Tape/disk KERNAL SAVE | yes | yes | requires filename, device, SETLFS/SETNAM calls |
| In-game RAM (heap) | yes | no | trivial but lost on KERNAL reinit |

## constraints
- Multi-byte comparison MUST proceed MSB-first; LSB-first comparison produces incorrect ordering for equal upper bytes.
- KERNAL LOAD with secondary address 0 loads to `$0801` regardless of stored address; use secondary address 1 to load to the original address.
- Hiscore buffer MUST be initialized on first run (cold start) — check a sentinel byte; if not set, initialize to `$00`/`$30` and set sentinel.

## links
- game: [scoring.md](scoring.md)
- kernal: [../kernal/INDEX.md](../kernal/INDEX.md)
- tasks: [../tasks/load-save-file.md](../tasks/load-save-file.md)
- charset: [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md)

## sources
- [https://codebase64.net/doku.php?id=base:game_programming](https://codebase64.net/doku.php?id=base:game_programming) — codebase64.net (hub reference; dedicated hiscore article not yet published) — CC BY-NC-SA 4.0
- [../sources/INDEX.md](../sources/INDEX.md)
