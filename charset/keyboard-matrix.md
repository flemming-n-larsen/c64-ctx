---
type: reference
domain: charset
granularity: lookup
summary: "The 8x8 keyboard matrix as scanned through CIA1, with modifiers and delivered PETSCII."
keywords: [keyboard matrix, key scan, modifiers, SHIFT, matrix position]
---

## facts
- The C64 keyboard is an 8×8 matrix scanned through CIA1: drive one column low via `$DC00` (PRA, output), read pressed rows from `$DC01` (PRB, input, active low).
- Scancode = `row × 8 + col`; values `$00-$3F` are matrix positions, NOT PETSCII bytes.
- KERNAL `GETIN` (`$FFE4`) and `CHRIN` (`$FFCF`) deliver PETSCII bytes after the KERNAL IRQ-driven scan (`SCNKEY` `$FF9F`) and decode tables apply modifier state.
- `RESTORE` is wired to CIA2 `/FLAG` (NMI line), NOT the matrix; it has no scancode.
- Joystick port 2 shares CIA1 PRA bits with the column drive — keyboard scanning sees joystick port 2 directions as phantom column shorts.

## lookup — 8×8 matrix
| row | col 0 | col 1 | col 2 | col 3 | col 4 | col 5 | col 6 | col 7 |
|---:|---|---|---|---|---|---|---|---|
| `0` | `INST/DEL` | `RETURN` | `CRSR ↔` | `F7/F8` | `F1/F2` | `F3/F4` | `F5/F6` | `CRSR ↕` |
| `1` | `3 #` | `W` | `A` | `4 $` | `Z` | `S` | `E` | `L.SHIFT` |
| `2` | `5 %` | `R` | `D` | `6 &` | `C` | `F` | `T` | `X` |
| `3` | `7 '` | `Y` | `G` | `8 (` | `B` | `H` | `U` | `V` |
| `4` | `9 )` | `I` | `J` | `0` | `M` | `K` | `O` | `N` |
| `5` | `+` | `P` | `L` | `-` | `.` | `:` | `@` | `,` |
| `6` | `£` | `*` | `;` | `HOME` | `R.SHIFT` | `=` | `↑` | `/` |
| `7` | `1 !` | `←` | `CTRL` | `2 "` | `SPACE` | `C=` | `Q` | `RUN/STOP` |

## lookup — modifiers and special keys
| key | scancode | role |
|---|---:|---|
| `L.SHIFT` | `$0F` (row 1 col 7) | Modifier; not delivered as PETSCII alone. |
| `R.SHIFT` | `$34` (row 6 col 4) | Modifier; not delivered as PETSCII alone. |
| `CTRL` | `$3A` (row 7 col 2) | Modifier; with letter keys produces `$01-$1F` PETSCII control bytes. |
| `C=` | `$3D` (row 7 col 5) | Modifier; with letter keys produces graphics-block PETSCII bytes. |
| `RUN/STOP` | `$3F` (row 7 col 7) | Polled by KERNAL `STOP` (`$FFE1`); delivers PETSCII `$03` via `GETIN`. |
| `RESTORE` | (none) | Wired to CIA2 `/FLAG` → NMI; not in matrix. |
| `SHIFT LOCK` | latch over `L.SHIFT` | Mechanical lock; same matrix bit. |

## lookup — PETSCII delivered by `GETIN` for selected keys
| key | unshifted | shifted | C= | CTRL |
|---|---:|---:|---:|---:|
| `RETURN` | `$0D` | `$8D` | — | — |
| `SPACE` | `$20` | `$A0` | — | — |
| `STOP` | `$03` | — | — | — |
| `CRSR ↕` | `$11` (down) | `$91` (up) | — | — |
| `CRSR ↔` | `$1D` (right) | `$9D` (left) | — | — |
| `HOME` | `$13` | `$93` (CLR) | — | — |
| `INST/DEL` | `$14` (DEL) | `$94` (INST) | — | — |
| `F1`/`F2` | `$85` | `$89` | — | — |
| `F3`/`F4` | `$86` | `$8A` | — | — |
| `F5`/`F6` | `$87` | `$8B` | — | — |
| `F7`/`F8` | `$88` | `$8C` | — | — |
| letters `A`-`Z` | `$41-$5A` | `$C1-$DA` | `$A1-$BA` graphics | `$01-$1A` |
| digit `1` | `$31` | `$21` (`!`) | `COL_BLACK` `$90` | — |
| digit `2` | `$32` | `$22` (`"`) | `COL_WHITE` `$05` | — |
| digit `3` | `$33` | `$23` (`#`) | `COL_RED` `$1C` | — |

## constraints
- Code MUST NOT treat matrix scancodes, PETSCII output bytes, and KERNAL `GETIN` bytes as identical without a stated conversion.
- Direct matrix scans SHOULD set CIA1 DDR (`$DC02 = $FF`, `$DC03 = $00`) before reading, then drive column via `$DC00` and read row from `$DC01`.
- Code that calls `GETIN` SHOULD NOT also reprogram CIA1 DDR/ports unless the KERNAL IRQ scan is disabled.
- Joystick port 2 input MUST be considered when reading keyboard rows; a pressed joystick direction reads as a key in the same matrix position.

## links
- CIA1: [../io/cia1.md](../io/cia1.md)
- read keyboard task: [../tasks/read-keyboard.md](../tasks/read-keyboard.md)
- PETSCII: [petscii.md](petscii.md)
- control codes: [control-codes.md](control-codes.md)
- KERNAL keyboard/screen: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- charset index: [INDEX.md](INDEX.md)
- CIA1: [../io/cia1.md](../io/cia1.md)
