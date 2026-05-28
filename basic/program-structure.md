---
type: reference
domain: basic
granularity: concept
---

## facts
- BASIC V2 stores tokenized program lines as a singly-linked list in RAM starting at `$0801` (default; pointer held in `TXTTAB` at `$002B`).
- Each tokenized line on disk/RAM is `<2-byte next-line pointer> <2-byte line number, little-endian> <tokenized text bytes> $00`.
- Line numbers MUST lie in the range `0`-`63999`.
- Maximum input line length is 80 PETSCII characters (two 40-column screen lines).
- Multiple statements on one line MUST be separated by `:`.
- Direct (immediate) mode executes a statement the moment RETURN is pressed without a leading line number; program mode requires a line number and stores the line instead of running it.

## lookup
| element | shape | notes |
|---|---|---|
| line | `<num> <stmt> [: <stmt>]*` | `num` in `1..63999`, 80-char input limit |
| statement separator | `:` | Chains statements on one line |
| comment | `REM <text>` | Rest of line is plain text, not tokenized further |
| direct-mode entry | `<stmt>` + RETURN | No line number; executes immediately |
| program entry | `<num> <stmt>` + RETURN | Stored in linked list, not run |
| run | `RUN` or `RUN <line>` | Starts at `<line>` if given, else first line |
| list | `LIST`, `LIST <a>-<b>`, `LIST <a>-`, `LIST -<b>` | Display program text |
| clear | `NEW` vs `CLR` | `NEW` wipes program + variables; `CLR` wipes variables only |
| continue | `CONT` | Resume after `STOP`/error if no edits have occurred |
| end program | `END` vs `STOP` | `END` exits silently; `STOP` prints `BREAK IN <line>` |

## constraints
- Line numbers referenced by `GOTO`, `GOSUB`, `THEN`, and `ON` MUST match an existing stored line; a missing target raises `?UNDEF'D STATEMENT ERROR`.
- Editing or typing any line invalidates `CONT`; resuming after a change is NOT supported.
- Entering a line number with no text deletes that line from the linked list.
- `REM` consumes the rest of the input line; a subsequent `:` does NOT terminate the comment, so statements after `REM` are unreachable.
- Program text begins at `$0801` after a leading 2-byte `$00` linkage and MAY grow toward `$9FFF` minus string space and variable area.
- Lines are stored in line-number order; the linked list is rebuilt on every change.
- `NEW` resets `TXTTAB`, `VARTAB`, `ARYTAB`, `STREND`, and `FRETOP`; `CLR` resets only the variable pointers (`VARTAB`, `ARYTAB`, `STREND`, `FRETOP`).

## examples
Direct mode, single statement:
```
PRINT "HELLO"
```

Program with multiple statements per line:
```
10 FOR I=1 TO 5 : PRINT I : NEXT
20 END
```

Two-statement input loop using `IF`/`THEN`:
```
10 GET A$ : IF A$="" THEN 10
20 PRINT "GOT ";A$
```

## links
- variables: [variables.md](variables.md)
- keywords: [keywords.md](keywords.md)
- I/O statements: [io.md](io.md)
- example programs: [examples.md](examples.md)
- BASIC workspace vectors: [vectors.md](vectors.md)
- memory map: [../memory/map.md](../memory/map.md)
- zero page: [../memory/zero-page.md](../memory/zero-page.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md) (PRG 1982 — program structure)
- BASIC workspace vectors: [vectors.md](vectors.md)
- memory map: [../memory/map.md](../memory/map.md)
- BASIC index: [INDEX.md](INDEX.md)
