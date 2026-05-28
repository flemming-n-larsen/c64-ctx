---
type: reference
domain: basic
granularity: concept
---

## facts
- BASIC V2 provides three scalar variable types: floating point (default), integer (`%` suffix), and string (`$` suffix).
- Variable names MAY be any length but only the first 2 characters are significant; trailing characters are accepted by the tokenizer and discarded for identity.
- The first character of a name MUST be a letter `A-Z`; the second character MAY be a letter `A-Z` or digit `0-9`.
- Names MUST NOT contain a BASIC reserved keyword as a substring (e.g., `TO`, `IF`, `FN`, `OR`, `ON`); the tokenizer rewrites the embedded keyword and breaks the identifier.
- Scalar variables are stored from `VARTAB` (`$002D`) up to `ARYTAB` (`$002F`); each scalar entry occupies 7 bytes (2-byte name + 5-byte value).
- Array variables are stored from `ARYTAB` (`$002F`) up to `STREND` (`$0031`).
- Floats use a 5-byte exponent/mantissa format; integers use 2-byte big-endian storage; strings use a 3-byte descriptor (1-byte length + 2-byte text pointer).
- A name suffixed with `FN` (e.g., `FNA`) is treated as a user-defined function reference, not a scalar variable.

## lookup
| type | suffix | example names | storage | range |
|---|---|---|---|---|
| float | (none) | `X`, `AB`, `T1` | 5 bytes | approx. `±1.7E-38` to `±1.7E+38`, ~9 significant digits |
| integer | `%` | `I%`, `N1%`, `CT%` | 2 bytes | `-32768` to `+32767` |
| string | `$` | `A$`, `S2$`, `NM$` | 3-byte descriptor + variable text | 0 to 255 characters |

## constraints
- The same base name MAY be used for a float, an integer, and a string simultaneously; `A`, `A%`, and `A$` are three distinct variables.
- Integer scalars in BASIC V2 are SLOWER than floats and produce LARGER tokenized code; PRG SHOULD-uses them mainly inside arrays where the storage saving (2 vs 5 bytes per element) matters.
- Arrays MUST be `DIM`med before first reference OR are implicitly dimensioned `0..10` per dimension on first use.
- `DIM A(N)` allocates `N+1` elements indexed `A(0)..A(N)`.
- `DIM A(M,N)` allocates `(M+1)*(N+1)` elements.
- Re-dimensioning an already-dimensioned array raises `REDIM'D ARRAY` (error 19).
- String concatenation MUST produce a result of 255 bytes or fewer, otherwise `STRING TOO LONG` (error 23) is raised.
- Numeric values that exceed the float range raise `OVERFLOW` (error 15).
- Assigning a string value to a numeric variable, or vice versa, raises `TYPE MISMATCH` (error 22).
- Reserved-keyword pitfall: a name like `SCORE` contains `OR` and is tokenized as `SC` + `OR` + `E`, breaking the identifier; common workaround is to shorten to `SC`. (Some references treat this as urban legend; verify per-case against the PRG and tokenizer behavior.)
- Names beginning with `FN` are parsed as user-defined function references (e.g., `FNA(X)`), not ordinary scalars.

## examples
- Scalar assignment of all three types:
  ```
  10 A = 5 : B$ = "HI" : C% = 100
  ```
- Array declaration and population:
  ```
  10 DIM A(9), N$(5,5)
  20 FOR I=0 TO 9 : A(I) = I*I : NEXT
  ```
- Distinct variables sharing a base name:
  ```
  10 A = 1.5 : A% = 1 : A$ = "ONE"
  ```

## links
- BASIC tokens and keyword set: [keywords.md](keywords.md)
- BASIC built-in functions: [functions.md](functions.md)
- BASIC error codes: [errors.md](errors.md)
- BASIC workspace pointers: [vectors.md](vectors.md)
- Zero-page pointer addresses: [../memory/zero-page.md](../memory/zero-page.md)
- Memory layout context: [../memory/map.md](../memory/map.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md) (C64 Programmer's Reference Guide, Commodore Business Machines, 1982 — AI-summarized, no verbatim copy)
- BASIC workspace pointers: [vectors.md](vectors.md)
- zero page pointers: [../memory/zero-page.md](../memory/zero-page.md)
- BASIC index: [INDEX.md](INDEX.md)
