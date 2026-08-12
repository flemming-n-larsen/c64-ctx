---
type: reference
domain: examples
granularity: example
summary: "Complete BASIC program that polls the keyboard and acts on the keypress."
keywords: [BASIC example, GET keypress, keyboard polling]
---

## facts
- Complete BASIC V2 program polling the keyboard via `GET` and acting on the returned PETSCII code.
- `GET A$` returns immediately with `A$=""` when the keyboard buffer is empty.
- `ASC(A$)` returns the PETSCII code of the first character in `A$`.

## examples

### listing
```
10 PRINT CHR$(147);"PRESS Q TO QUIT, ANY OTHER KEY TO ECHO"
20 GET A$ : IF A$="" THEN 20
30 IF A$="Q" THEN PRINT "BYE" : END
40 PRINT "KEY="; A$; " PETSCII="; ASC(A$)
50 GOTO 20
```

### run
- Type `RUN`; the screen clears and the prompt appears.
- Press any key — the program prints the character and its PETSCII code.
- Press `Q` (uppercase, the default unshifted alphabetic case on power-on) to quit.

## lookup
| element | meaning | route |
|---|---|---|
| `GET A$` | Non-blocking read from keyboard buffer (`$0277-$0280`) | [../basic/io.md](../basic/io.md) |
| `ASC(A$)` | First-char PETSCII code as a number | [../basic/functions.md](../basic/functions.md) |
| `CHR$(147)` | PETSCII clear-screen control code | [../charset/control-codes.md](../charset/control-codes.md) |
| PETSCII `Q` | code `$D1` (uppercase) / `$51` (lowercase mode) | [../charset/petscii.md](../charset/petscii.md) |
| KERNAL keyboard polling under `GET` | `GETIN` at `$FFE4` | [../tasks/read-keyboard.md](../tasks/read-keyboard.md) |

## constraints
- The BASIC keyboard buffer holds at most 10 keystrokes; rapid typing while the program is busy MAY drop input.
- PETSCII case depends on the active character set (`$D018` chargen bits); unshifted alphabetics return `$C1-$DA` in default uppercase mode and `$41-$5A` in shifted (text) mode.
- `GET A$` does NOT echo the key; the program is responsible for any display.
- `GET` returns at most one PETSCII byte per call even if the buffer holds more — call `GET` in a loop to drain.

## sources

- BASIC I/O: [../basic/io.md](../basic/io.md)
- read-keyboard task: [../tasks/read-keyboard.md](../tasks/read-keyboard.md)
- PETSCII: [../charset/petscii.md](../charset/petscii.md)
- BASIC functions: [../basic/functions.md](../basic/functions.md)
- BASIC examples reference: [../basic/examples.md](../basic/examples.md)
- keyboard matrix: [../charset/keyboard-matrix.md](../charset/keyboard-matrix.md)
- control codes: [../charset/control-codes.md](../charset/control-codes.md)
- example index: [INDEX.md](INDEX.md)
