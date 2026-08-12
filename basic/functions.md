---
type: reference
domain: basic
granularity: family
summary: "BASIC V2 built-in functions with return types and argument constraints."
keywords: [BASIC functions, string functions, numeric functions, return types]
---

## facts
- BASIC V2 built-in functions return either a numeric value (`float`) or a string; string-returning function names MUST end in `$`.
- Function tokens occupy the range `$B4-$CA`; `TAB(` is token `$A3` and `SPC(` is token `$A6` (statement-context tokens used as print-position functions).
- All function arguments are parenthesized; the opening `(` is part of the token for `TAB(` and `SPC(` but is a separate character for `$B4-$CA` functions.
- `INT(X)` truncates toward negative infinity (`INT(-1.5) = -2`), not toward zero.
- `RND(0)` draws a seed derived from the CIA timer; `RND(X<0)` reseeds the generator; `RND(X>0)` advances the current sequence.
- `PEEK(A)` reads one memory byte under the current `$0001` banking and returns an integer in `0-255`.
- `USR(X)` calls a user-supplied machine-code routine through the vector at `$0311-$0312` (low/high); the argument `X` is passed in the floating-point accumulator (`FAC1`) at `$61-$66`.
- `FRE(0)` returns the number of BASIC bytes free; the result is interpreted as a signed float, so values `≥ 32768` appear negative — add `65536` to recover the unsigned count.

## lookup
| function | token | syntax | return | arg type | notes |
|---|---:|---|---|---|---|
| `SGN` | `$B4` | `SGN(X)` | float | numeric | `-1`, `0`, or `+1` per sign of `X`. |
| `INT` | `$B5` | `INT(X)` | float | numeric | Floor: largest integer `≤ X`. |
| `ABS` | `$B6` | `ABS(X)` | float | numeric | Absolute value `|X|`. |
| `USR` | `$B7` | `USR(X)` | float | numeric | Calls ML routine via `($0311)`; arg in `FAC1` (`$61-$66`). |
| `FRE` | `$B8` | `FRE(X)` | float | numeric | Free BASIC bytes; argument value ignored. Signed-wrap above 32 K. |
| `POS` | `$B9` | `POS(X)` | float | numeric | Current cursor column `0-39`; argument ignored. |
| `SQR` | `$BA` | `SQR(X)` | float | numeric `≥ 0` | Square root. |
| `RND` | `$BB` | `RND(X)` | float | numeric | Returns value in `[0,1)`. See seeding rules. |
| `LOG` | `$BC` | `LOG(X)` | float | numeric `> 0` | Natural logarithm (base `e`). |
| `EXP` | `$BD` | `EXP(X)` | float | numeric | `e^X`. |
| `COS` | `$BE` | `COS(X)` | float | numeric (radians) | Cosine. |
| `SIN` | `$BF` | `SIN(X)` | float | numeric (radians) | Sine. |
| `TAN` | `$C0` | `TAN(X)` | float | numeric (radians) | Tangent. |
| `ATN` | `$C1` | `ATN(X)` | float | numeric | Arctangent (result in radians). |
| `PEEK` | `$C2` | `PEEK(A)` | int (`0-255`) | numeric `0-65535` | Byte at address `A` under current banking. |
| `LEN` | `$C3` | `LEN(S$)` | float | string | Length in bytes `0-255`. |
| `STR$` | `$C4` | `STR$(X)` | string | numeric | Numeric-to-string; non-negative results have a leading space. |
| `VAL` | `$C5` | `VAL(S$)` | float | string | Parses leading numeric literal; returns `0` if no digits. |
| `ASC` | `$C6` | `ASC(S$)` | float | non-empty string | PETSCII code of first character. |
| `CHR$` | `$C7` | `CHR$(X)` | string | numeric `0-255` | One-character string with PETSCII code `X`. |
| `LEFT$` | `$C8` | `LEFT$(S$,N)` | string | string, numeric `0-255` | Leftmost `N` characters. |
| `RIGHT$` | `$C9` | `RIGHT$(S$,N)` | string | string, numeric `0-255` | Rightmost `N` characters. |
| `MID$` | `$CA` | `MID$(S$,P[,N])` | string | string, numeric, numeric | Substring starting at position `P` (1-based) for `N` characters; `N` optional. |
| `TAB(` | `$A3` | `TAB(X)` | — | numeric | Print-position only: advances to column `X`. |
| `SPC(` | `$A6` | `SPC(X)` | — | numeric | Print-position only: emits `X` spaces. |

## constraints
- `STR$(X)` MUST prepend a leading space character for non-negative `X`; negative `X` produces a leading `-`.
- `CHR$(X)` MUST receive `0 ≤ X ≤ 255`; out-of-range values raise `?ILLEGAL QUANTITY ERROR`.
- `ASC(S$)` MUST receive a non-empty string; empty strings raise `?ILLEGAL QUANTITY ERROR`.
- `LOG(X)` MUST receive `X > 0`; zero or negative values raise `?ILLEGAL QUANTITY ERROR`.
- `SQR(X)` MUST receive `X ≥ 0`; negative values raise `?ILLEGAL QUANTITY ERROR`.
- `RND(0)` returns a time-based pseudo-random draw using the CIA timer; `RND(X<0)` reseeds the generator from `X`; `RND(X>0)` advances the current sequence.
- `PEEK(A)` MUST receive `0 ≤ A ≤ 65535`; the read reflects the current `$0001` memory configuration (RAM, I/O, KERNAL, or character ROM as banked).
- `POS(X)` returns the current physical cursor column in `0-39`; the argument is ignored but MUST be present.
- `LEN(S$)` returns `0-255`; string concatenation results MUST NOT exceed 255 bytes or `?STRING TOO LONG ERROR` is raised.
- `LEFT$`, `RIGHT$`, and `MID$` size arguments MUST be in `0-255`; values outside this range raise `?ILLEGAL QUANTITY ERROR`.
- `MID$(S$,P,N)` uses 1-based position `P`; `P > LEN(S$)` returns the empty string; if `N` is omitted, the result runs to the end of `S$`.
- `VAL(S$)` parses the leading numeric literal of `S$`; if no digits lead the string, the result is `0`.
- `USR(X)` MUST first have the vector at `$0311-$0312` (low/high) pointing to a valid machine-code entry; the argument arrives in `FAC1` at `$61-$66`, and the routine SHOULD leave the return value in `FAC1` before `RTS`.
- `TAB(X)` and `SPC(X)` MUST appear only inside `PRINT` or `PRINT#` argument lists; use outside these statements raises `?SYNTAX ERROR`.

## links
- tokens: [tokens.md](tokens.md)
- keywords: [keywords.md](keywords.md)
- variables and types: [variables.md](variables.md)
- machine-code bridge: [machine-code-bridge.md](machine-code-bridge.md)
- BASIC errors: [errors.md](errors.md)
- zero page (FAC and USR vector): [../memory/zero-page.md](../memory/zero-page.md)
- PETSCII code space (`CHR$` / `ASC`): [../charset/petscii.md](../charset/petscii.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- BASIC index: [INDEX.md](INDEX.md)
- token bytes: [tokens.md](tokens.md)
