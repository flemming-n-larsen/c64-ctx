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

## source-coverage
| local coverage | status | notes |
|---|---|---|
| [program-structure.md](program-structure.md) | used | Line-numbered program shape, immediate vs program mode. |
| [examples.md](examples.md) | used | Tiny complete runnable BASIC V2 programs. |
| [keywords.md](keywords.md) | used | All BASIC V2 statements, commands, operators, clauses. |
| [functions.md](functions.md) | used | All built-in numeric and string functions. |
| [variables.md](variables.md) | used | Types, suffixes, arrays, naming limits, pitfalls. |
| [io.md](io.md) | used | BASIC-level screen, keyboard, and file I/O. |
| [graphics-sound.md](graphics-sound.md) | used | Practical `POKE`/`PEEK` route map. |
| [machine-code-bridge.md](machine-code-bridge.md) | used | `SYS`, `USR`, loader patterns. |
| [errors.md](errors.md) | used | All 29 numbered errors. |
| [tokens.md](tokens.md) | used | Full BASIC V2 token table. |
| [vectors.md](vectors.md) | used | BASIC workspace labels, pointers, and aliases. |
| [routines.md](routines.md) | used | BASIC ROM routine route coverage. |
| [../rom/basic-disassembly.md](../rom/basic-disassembly.md) | used | BASIC ROM route companion. |
| [../sources/INDEX.md](../sources/INDEX.md) | provenance | Central upstream fallback route. |

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
