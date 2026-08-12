---
type: reference
domain: basic
granularity: lookup
summary: "All 29 numbered BASIC V2 errors and the conditions that raise each."
keywords: [BASIC errors, error messages, SYNTAX ERROR, ILLEGAL QUANTITY]
---

## facts
- BASIC V2 defines 29 numbered error messages; the message table lives in BASIC ROM at `$A328`.
- The interpreter MUST report errors as `?<MESSAGE> ERROR` in direct mode and `?<MESSAGE> ERROR IN <LINE>` in program mode.
- The BASIC error vector `IERROR` at `$0300-$0301` lets ML routines intercept error printing before it reaches the screen.

## lookup
| code | message | typical conditions |
|---:|---|---|
| 1 | `TOO MANY FILES` | More than 10 logical files open simultaneously. |
| 2 | `FILE OPEN` | `OPEN` reuses a logical file number already in the file table. |
| 3 | `FILE NOT OPEN` | `CLOSE`, `PRINT#`, `INPUT#`, `GET#`, or `CMD` references an unopened logical file. |
| 4 | `FILE NOT FOUND` | Disk or tape lookup did not find the named file. |
| 5 | `DEVICE NOT PRESENT` | Addressed IEC/IEEE device did not respond on the serial bus. |
| 6 | `NOT INPUT FILE` | `INPUT#` or `GET#` issued on a file opened for output. |
| 7 | `NOT OUTPUT FILE` | `PRINT#` issued on a file opened for input. |
| 8 | `MISSING FILE NAME` | `LOAD`, `SAVE`, or `OPEN` requires a filename and none was supplied. |
| 9 | `ILLEGAL DEVICE NUMBER` | Device number is outside the accepted range for the requested operation. |
| 10 | `NEXT WITHOUT FOR` | `NEXT` executed with no matching `FOR` on the stack. |
| 11 | `SYNTAX` | Statement could not be parsed; most common runtime error. |
| 12 | `RETURN WITHOUT GOSUB` | `RETURN` executed with no matching `GOSUB` on the stack. |
| 13 | `OUT OF DATA` | `READ` advanced past the last item in all `DATA` statements. |
| 14 | `ILLEGAL QUANTITY` | Argument is out of range for the function (e.g., `CHR$(-1)`, `SQR(-1)`). |
| 15 | `OVERFLOW` | Floating-point result exceeds the BASIC magnitude limit (~`1.7E+38`). |
| 16 | `OUT OF MEMORY` | Variable, array, string, or stack allocation failed. |
| 17 | `UNDEF'D STATEMENT` | `GOTO`, `GOSUB`, `THEN <line>`, or `RUN <line>` targets a line that does not exist. |
| 18 | `BAD SUBSCRIPT` | Array index exceeds the bounds declared by `DIM`. |
| 19 | `REDIM'D ARRAY` | `DIM` issued for an array that is already dimensioned. |
| 20 | `DIVISION BY ZERO` | `/` evaluated with a zero denominator. |
| 21 | `ILLEGAL DIRECT` | Statement is valid only inside a program (e.g., `INPUT`, `GET`, `DEF FN`) but was issued in direct mode. |
| 22 | `TYPE MISMATCH` | Numeric value used where a string is required, or vice versa. |
| 23 | `STRING TOO LONG` | String concatenation or assignment produced more than 255 bytes. |
| 24 | `FILE DATA` | `INPUT#`/`GET#` read non-numeric data into a numeric variable. |
| 25 | `FORMULA TOO COMPLEX` | Expression nesting exceeded the interpreter limits (more than 10 pending string operations or excessive parenthesis depth). |
| 26 | `CAN'T CONTINUE` | `CONT` issued after a program edit, after another error, or with no halted program. |
| 27 | `UNDEF'D FUNCTION` | `FN <name>` invoked without a prior `DEF FN <name>`. |
| 28 | `VERIFY` | `VERIFY` detected a mismatch between memory and the device image. |
| 29 | `LOAD` | An I/O error occurred during `LOAD` or `VERIFY`. |

## constraints
- Error message strings MUST match the ROM table exactly (uppercase, no leading `?`, no trailing ` ERROR`) when compared against `$A328`.
- Direct-mode errors MUST be printed without `IN <LINE>`; program-mode errors MUST append ` IN <LINE>`.
- ML routines MAY redirect `IERROR` at `$0300-$0301` to capture or replace the error handler before BASIC prints the message.
- An error MUST halt program execution; `CONT` MAY resume execution only when no program text was edited between the halt and the resume.
- `SYNTAX ERROR` (code 11) MAY surface during tokenization in direct mode and during execution when an expression is malformed.

## links
- BASIC keywords: [keywords.md](keywords.md)
- BASIC functions: [functions.md](functions.md)
- BASIC I/O: [io.md](io.md)
- BASIC vectors: [vectors.md](vectors.md)
- memory symbols: [../memory/symbols.md](../memory/symbols.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- BASIC vectors: [vectors.md](vectors.md)
- BASIC index: [INDEX.md](INDEX.md)
