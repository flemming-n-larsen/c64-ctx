---
type: reference
domain: basic
granularity: lookup
summary: "The BASIC V2 token byte table and how tokenized text is encoded."
keywords: [BASIC tokens, token table, tokenization, detokenize]
---

## facts
- C64 BASIC V2 defines 76 keyword tokens in the range `$80-$CB`.
- Tokenized program text stores each recognized keyword as a single token byte instead of its ASCII/PETSCII letters.
- Byte values `$00-$7F` inside tokenized BASIC text are PETSCII characters or control bytes, not tokens.
- The byte `$FF` is the constant π (`{pi}`), not a function or statement.
- The range `$CC-$FE` is unused on stock C64 BASIC V2.
- Token `$00` terminates a tokenized BASIC line.

## lookup
| token | keyword | category |
|---:|---|---|
| `$80` | `END` | statement |
| `$81` | `FOR` | statement |
| `$82` | `NEXT` | statement |
| `$83` | `DATA` | statement |
| `$84` | `INPUT#` | statement |
| `$85` | `INPUT` | statement |
| `$86` | `DIM` | statement |
| `$87` | `READ` | statement |
| `$88` | `LET` | statement |
| `$89` | `GOTO` | statement |
| `$8A` | `RUN` | command |
| `$8B` | `IF` | statement |
| `$8C` | `RESTORE` | statement |
| `$8D` | `GOSUB` | statement |
| `$8E` | `RETURN` | statement |
| `$8F` | `REM` | statement |
| `$90` | `STOP` | statement |
| `$91` | `ON` | statement |
| `$92` | `WAIT` | statement |
| `$93` | `LOAD` | command |
| `$94` | `SAVE` | command |
| `$95` | `VERIFY` | command |
| `$96` | `DEF` | statement |
| `$97` | `POKE` | statement |
| `$98` | `PRINT#` | statement |
| `$99` | `PRINT` | statement |
| `$9A` | `CONT` | command |
| `$9B` | `LIST` | command |
| `$9C` | `CLR` | statement |
| `$9D` | `CMD` | statement |
| `$9E` | `SYS` | statement |
| `$9F` | `OPEN` | statement |
| `$A0` | `CLOSE` | statement |
| `$A1` | `GET` | statement |
| `$A2` | `NEW` | command |
| `$A3` | `TAB(` | clause |
| `$A4` | `TO` | clause |
| `$A5` | `FN` | clause |
| `$A6` | `SPC(` | clause |
| `$A7` | `THEN` | clause |
| `$A8` | `NOT` | operator |
| `$A9` | `STEP` | clause |
| `$AA` | `+` | operator |
| `$AB` | `-` | operator |
| `$AC` | `*` | operator |
| `$AD` | `/` | operator |
| `$AE` | `^` | operator |
| `$AF` | `AND` | operator |
| `$B0` | `OR` | operator |
| `$B1` | `>` | operator |
| `$B2` | `=` | operator |
| `$B3` | `<` | operator |
| `$B4` | `SGN` | function |
| `$B5` | `INT` | function |
| `$B6` | `ABS` | function |
| `$B7` | `USR` | function |
| `$B8` | `FRE` | function |
| `$B9` | `POS` | function |
| `$BA` | `SQR` | function |
| `$BB` | `RND` | function |
| `$BC` | `LOG` | function |
| `$BD` | `EXP` | function |
| `$BE` | `COS` | function |
| `$BF` | `SIN` | function |
| `$C0` | `TAN` | function |
| `$C1` | `ATN` | function |
| `$C2` | `PEEK` | function |
| `$C3` | `LEN` | function |
| `$C4` | `STR$` | function |
| `$C5` | `VAL` | function |
| `$C6` | `ASC` | function |
| `$C7` | `CHR$` | function |
| `$C8` | `LEFT$` | function |
| `$C9` | `RIGHT$` | function |
| `$CA` | `MID$` | function |
| `$CB` | `GO` | statement |
| `$FF` | `{pi}` | constant |

## constraints
- Tokenized BASIC bytes MUST NOT be conflated with PETSCII text bytes or screen-code bytes.
- String literals between `"` pairs in tokenized BASIC programs MUST remain PETSCII; the tokenizer MUST NOT replace keyword letters inside string literals.
- `REM` payload text MUST remain untokenized after the `$8F` token byte.
- `DATA` payload text MUST remain untokenized after the `$83` token byte, up to the next `:` or end-of-line.
- `GO TO` MUST tokenize as `$CB $A4` (`GO` + `TO`), not as the single `GOTO` token `$89`.
- `$FF` MUST be treated as the π constant token, not as a callable function.
- C64 BASIC V2 MUST leave `$CC-$FE` unused; extended BASICs (Simons' BASIC, BASIC 3.5/7.0, cartridges) MAY repurpose that range with their own keyword sets.
- The exponent operator (`^`, token `$AE`) is rendered as the up-arrow glyph in PETSCII (`{up-arrow}`); the on-screen and in-source glyph MUST NOT be confused with caret semantics from later systems.

## examples
Tokenized form of `10 PRINT "HI":GOTO 10`:

```
line-link  line#  PRINT   "  H  I   "   :  GOTO  space 1  0   end
$NN $NN    $0A 00 $99    $22 $48 $49 $22 $3A $89 $20 $31 $30 $00
```

Tokenized form of `20 GO TO 10` (note the two-token `GO` `TO` form):

```
line-link  line#  GO  space  TO   space 1  0   end
$NN $NN    $14 00 $CB $20    $A4  $20  $31 $30 $00
```

## links

- Keyword semantics and dispatch: [keywords.md](keywords.md)
- Built-in functions: [functions.md](functions.md)
- BASIC ROM tokenizer and `CHRGET`: [../rom/basic-disassembly.md](../rom/basic-disassembly.md)

## sources

- local route: [../sources/INDEX.md](../sources/INDEX.md) (upstream mist64/c64ref `src/c64disasm` for token byte values)
- BASIC index: [INDEX.md](INDEX.md)
- BASIC vectors: [vectors.md](vectors.md)
- character distinction: [../charset/petscii.md](../charset/petscii.md)
