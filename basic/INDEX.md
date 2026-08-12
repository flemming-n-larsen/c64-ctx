---
type: index
domain: basic
source: c64ref
---

## routes
| need | read | notes |
|---|---|---|
| Write a BASIC V2 program | [program-structure.md](program-structure.md) | Start here; then `examples.md` for runnable shapes. |
| Tiny runnable BASIC programs | [examples.md](examples.md) | Complete short programs with cross-links. |
| BASIC keywords, statements, commands | [keywords.md](keywords.md) | All non-function keywords with tokens, syntax, examples. |
| BASIC built-in functions | [functions.md](functions.md) | Numeric and string functions with return types and constraints. |
| BASIC variables, types, arrays | [variables.md](variables.md) | Naming rules, `%`/`$` suffixes, `DIM`, pitfalls. |
| Screen, keyboard, file I/O at BASIC level | [io.md](io.md) | `PRINT`, `INPUT`, `GET`, `OPEN`, `CMD`, `PRINT#`, etc. |
| Graphics and sound via POKE/PEEK | [graphics-sound.md](graphics-sound.md) | Practical addresses; routes to `io/`, `colors/`, `tasks/`. |
| Calling machine code from BASIC | [machine-code-bridge.md](machine-code-bridge.md) | `SYS`, `USR`, `DATA`/`READ` loaders. |
| BASIC error messages | [errors.md](errors.md) | All 29 numbered errors with typical conditions. |
| BASIC token values and tokenized text | [tokens.md](tokens.md) | Full token table `$80-$CB` plus `$FF`. |
| BASIC vectors and workspace pointers | [vectors.md](vectors.md) | Interpreter hooks and zero-page pointers. |
| BASIC ROM routines | [routines.md](routines.md) | Used with ROM disassembly route pages. |

## pages
<!-- GENERATED:routes -->
| answers | read | terms |
|---|---|---|
| All 29 numbered BASIC V2 errors and the conditions that raise each. | [errors.md](errors.md) | BASIC errors, error messages, SYNTAX ERROR, ILLEGAL QUANTITY |
| Complete short runnable BASIC V2 listings, as typed. | [examples.md](examples.md) | BASIC examples, runnable listings, sample programs |
| BASIC V2 built-in functions with return types and argument constraints. | [functions.md](functions.md) | BASIC functions, string functions, numeric functions, return types |
| Graphics and sound from BASIC via POKE and PEEK; BASIC V2 has no native commands. | [graphics-sound.md](graphics-sound.md) | POKE graphics, POKE sound, BASIC graphics, BASIC sound |
| BASIC-level screen, keyboard and file I/O and the KERNAL calls beneath them. | [io.md](io.md) | PRINT, INPUT, GET, OPEN, file handling, BASIC I/O |
| All 76 BASIC V2 keywords and operators with token byte, syntax and example. | [keywords.md](keywords.md) | BASIC keywords, statements, commands, reserved words |
| Call machine code from BASIC with SYS, USR, and DATA/READ loaders. | [machine-code-bridge.md](machine-code-bridge.md) | SYS, USR, DATA loader, BASIC to ML, register passing |
| How tokenized BASIC lines are stored as a linked list, and where the program starts. | [program-structure.md](program-structure.md) | program structure, line links, TXTTAB, tokenized storage |
| Route to BASIC ROM routine addresses rather than copied listings. | [routines.md](routines.md) | BASIC routines, ROM entry points, interpreter routines |
| The BASIC V2 token byte table and how tokenized text is encoded. | [tokens.md](tokens.md) | BASIC tokens, token table, tokenization, detokenize |
| BASIC V2 variable types, naming rules, arrays, and the usual pitfalls. | [variables.md](variables.md) | BASIC variables, arrays, DIM, type suffix, naming rules |
| BASIC interpreter vectors and zero-page workspace pointers. | [vectors.md](vectors.md) | BASIC vectors, interpreter hooks, workspace pointers, wedge |
<!-- /GENERATED:routes -->

## related
| domain | read | why |
|---|---|---|
| Memory | [../memory/zero-page.md](../memory/zero-page.md) | Interpreter workspace. |
| Memory map | [../memory/map.md](../memory/map.md) | Safe ML code areas referenced by `machine-code-bridge.md`. |
| I/O | [../io/INDEX.md](../io/INDEX.md) | `POKE`/`PEEK` targets for graphics and sound. |
| Colors | [../colors/INDEX.md](../colors/INDEX.md) | Color values used by `graphics-sound.md` and `examples.md`. |
| Charset | [../charset/petscii.md](../charset/petscii.md) | PETSCII vs token vs screen-code distinction. |
| KERNAL | [../kernal/INDEX.md](../kernal/INDEX.md) | BASIC relies on KERNAL services. |
| ROM | [../rom/basic-disassembly.md](../rom/basic-disassembly.md) | BASIC ROM routine addresses. |
| Tasks | [../tasks/INDEX.md](../tasks/INDEX.md) | Practical recipes referenced from BASIC pages. |
