---
type: reference
domain: basic
granularity: family
summary: "BASIC-level screen, keyboard and file I/O and the KERNAL calls beneath them."
keywords: [PRINT, INPUT, GET, OPEN, file handling, BASIC I/O]
---

## facts
- BASIC screen output and keyboard input route through KERNAL `CHROUT`/`CHRIN`; `PRINT` and `INPUT` are BASIC-level wrappers.
- BASIC I/O statements operate on **logical file numbers** (`1`-`255`) bound to a **device number** (`0`-`31`) and an optional **secondary address** via `OPEN`.
- Up to **10 logical files** MAY be open concurrently; the 11th `OPEN` raises `?TOO MANY FILES`.
- Common device numbers: `0`=keyboard, `1`=tape, `2`=RS-232, `3`=screen, `4`/`5`=printers, `8`-`15`=disk drives.
- `CMD <lfn>` redirects subsequent `PRINT` output to the named file until the next `PRINT#` or a `PRINT` to the screen tears the redirection down.
- Status of the last I/O operation is exposed through reserved variable `ST` (mirrored at `$0090`).

## lookup
| statement | token | syntax | direction | notes |
|---|---:|---|---|---|
| `PRINT` | `$99` | `PRINT [expr-list][;|,]` | screen out | `;` no separator, `,` tabs to next 10-column zone, trailing `;` suppresses CR |
| `INPUT` | `$85` | `INPUT ["prompt";] var-list` | keyboard in | multi-value comma-separated; `?REDO FROM START` on type mismatch; not allowed in direct mode |
| `GET` | `$A1` | `GET var[, var]*` | keyboard in | returns immediately; empty string / `0` if no key pressed |
| `OPEN` | `$9F` | `OPEN lfn[, dev[, sa[, "name"]]]` | open lfn | `dev` defaults to `1` (tape), `sa` defaults to `0` |
| `CLOSE` | `$A0` | `CLOSE lfn` | close lfn | releases the logical file slot |
| `CMD` | `$9D` | `CMD lfn[, "header"]` | redirect out | terminate with `PRINT# lfn` before `CLOSE` |
| `PRINT#` | `$98` | `PRINT# lfn [, expr-list]` | file out | same separator rules as `PRINT` |
| `INPUT#` | `$84` | `INPUT# lfn, var-list` | file in | comma/CR delimited; strips quotes |
| `GET#` | — | `GET# lfn, var[, var]*` | file in | reads single byte; empty string / `0` at EOF |

## constraints
- `INPUT` MUST NOT be used in direct mode; doing so raises `?ILLEGAL DIRECT`.
- `OPEN` on a `lfn` that is already open raises `?FILE OPEN` (error 2); callers MUST `CLOSE` first.
- Operations on an unopened `lfn` raise `?FILE NOT OPEN` (error 3).
- `INPUT#` on a write-mode file raises `?NOT INPUT FILE` (error 6).
- `PRINT#` on a read-mode file raises `?NOT OUTPUT FILE` (error 7).
- `CMD` MUST be paired with `PRINT# lfn` before `CLOSE`, otherwise the drive's command channel MAY hold the file open.
- Device `8` secondary address `15` is the disk command channel — read it for status, write to it for disk commands.
- Programs SHOULD read `ST` immediately after each I/O statement; the variable is overwritten on the next operation.
- `INPUT#` strips surrounding quotes from string fields; CR (`$0D`) terminates each field.
- File names MUST be PETSCII strings; disk patterns MAY include `?` and `*` wildcards.

## examples
- Keyboard polling with `GET`:
  ```
  10 GET A$ : IF A$="" THEN 10
  20 PRINT "GOT ";A$
  ```
- Open a disk file for writing and log via `CMD`:
  ```
  10 OPEN 1,8,2,"LOG,S,W"
  20 CMD 1 : PRINT "HELLO" : PRINT "WORLD"
  30 PRINT#1 : CLOSE 1
  ```
- Read a line from the keyboard and echo it:
  ```
  10 INPUT "NAME";N$
  20 PRINT "HELLO, ";N$
  ```

## links

- BASIC keywords: [keywords.md](keywords.md)
- BASIC errors: [errors.md](errors.md)
- BASIC examples: [examples.md](examples.md)
- KERNAL keyboard/screen: [../kernal/keyboard-screen.md](../kernal/keyboard-screen.md)
- load/save task: [../tasks/load-save-file.md](../tasks/load-save-file.md)
- read keyboard task: [../tasks/read-keyboard.md](../tasks/read-keyboard.md)
- print to screen task: [../tasks/print-to-screen.md](../tasks/print-to-screen.md)

## sources

- local route: [../sources/INDEX.md](../sources/INDEX.md) — PRG 1982 for BASIC I/O semantics; mist64/c64ref kernal for device/file mechanics
- KERNAL file I/O: [../kernal/file-io.md](../kernal/file-io.md)
- BASIC index: [INDEX.md](INDEX.md)
